
package com.quizportal;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

public class LeaderboardService {

    private final ResultStore resultStore;

    public LeaderboardService() {
        this.resultStore = new ResultStore();
    }

    public LeaderboardService(ResultStore resultStore) {
        if (resultStore == null) {
            throw new IllegalArgumentException(
                    "ResultStore cannot be null.");
        }

        this.resultStore = resultStore;
    }

    // Global leaderboard: top 10 unique players.
    public List<QuizResult> getTopTen() throws IOException {
        return getTopTenByTopic(null);
    }

    // Topic leaderboard: top 10 unique players for one topic.
    public List<QuizResult> getTopTenByTopic(String topic)
            throws IOException {

        List<QuizResult> results = loadAllResults();

        return results.stream()
                .filter(result -> topic == null
                        || topic.trim().isEmpty()
                        || result.getTopic().equalsIgnoreCase(
                                topic.trim()))
                // Group attempts by normalized player name.
                .collect(Collectors.toMap(
                        result -> normalize(result.getPlayerName()),
                        result -> result,
                        (first, second) -> {
                            // Keep each player's best percentage.
                            if (second.getPercentage()
                                    > first.getPercentage()) {
                                return second;
                            }

                            if (second.getPercentage()
                                    < first.getPercentage()) {
                                return first;
                            }

                            // For equal scores, keep the earlier attempt.
                            return first.getAttemptedAt().isBefore(
                                    second.getAttemptedAt())
                                    ? first : second;
                        }
                ))
                .values()
                .stream()
                // Highest percentage first.
                .sorted(
                        Comparator.comparingDouble(
                                QuizResult::getPercentage)
                                .reversed()
                                .thenComparing(
                                        QuizResult::getAttemptedAt)
                                .thenComparing(
                                        QuizResult::getPlayerName,
                                        String.CASE_INSENSITIVE_ORDER)
                )
                // Required: at most 10 unique players.
                .limit(10)
                .collect(Collectors.toList());
    }

    // Return all saved quiz results.
    public List<QuizResult> getAllResults() throws IOException {
        return loadAllResults();
    }

    // Return all attempts for a particular player.
    public List<QuizResult> getPlayerAttempts(String playerName)
            throws IOException {

        if (playerName == null || playerName.trim().isEmpty()) {
            return new ArrayList<QuizResult>();
        }

        String normalizedName = normalize(playerName);

        return loadAllResults().stream()
                .filter(result -> normalize(result.getPlayerName())
                        .equals(normalizedName))
                .sorted(
                        Comparator.comparing(
                                QuizResult::getAttemptedAt)
                                .reversed()
                )
                .collect(Collectors.toList());
    }

    // Submit one result, rejecting repeat attempts for the same topic.
    public synchronized QuizResult submitResult(QuizResult newResult)
            throws IOException, InvalidAttemptException,
            DuplicateAttemptException {

        if (newResult == null) {
            throw new InvalidAttemptException(
                    "Quiz result cannot be null.");
        }

        String playerName = normalize(newResult.getPlayerName());
        String topic = normalize(newResult.getTopic());

        if (playerName.isEmpty() || topic.isEmpty()) {
            throw new InvalidAttemptException(
                    "Player name and topic are required.");
        }

        if (newResult.getTotalQuestions() <= 0
                || newResult.getScore() < 0
                || newResult.getScore() > newResult.getTotalQuestions()) {
            throw new InvalidAttemptException(
                    "The submitted score is invalid.");
        }

        List<QuizResult> results = loadAllResults();

        boolean duplicate = results.stream().anyMatch(existing ->
                normalize(existing.getPlayerName()).equals(playerName)
                && normalize(existing.getTopic()).equals(topic)
        );

        if (duplicate) {
            throw new DuplicateAttemptException(
                    "You have already attempted this topic with this name. "
                    + "Duplicate attempts are not allowed.");
        }

        results.add(newResult);
        resultStore.saveResults(results);

        return newResult;
    }

    // Normalize names and topics so capitalization and outer spaces
    // do not allow duplicate submissions.
    private String normalize(String value) {
        if (value == null) {
            return "";
        }

        return value.trim().toLowerCase(Locale.ROOT);
    }

    // Load saved results and translate deserialization errors to IOException.
    private List<QuizResult> loadAllResults() throws IOException {
        try {
            return resultStore.loadResults();
        } catch (ClassNotFoundException exception) {
            throw new IOException(
                    "Could not read saved quiz results.",
                    exception);
        }
    }
}
