
package com.quizportal;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

public class QuizResult implements Serializable {

    private static final long serialVersionUID = 1L;

    private final String attemptId;
    private final String playerName;
    private final String topic;
    private final int score;
    private final int totalQuestions;
    private final LocalDateTime attemptedAt;

    public QuizResult(String playerName, String topic,
                      int score, int totalQuestions) {

        if (playerName == null || playerName.trim().isEmpty()) {
            throw new IllegalArgumentException("Player name is required.");
        }

        if (topic == null || topic.trim().isEmpty()) {
            throw new IllegalArgumentException("Topic is required.");
        }

        if (totalQuestions <= 0) {
            throw new IllegalArgumentException(
                    "Total questions must be greater than zero.");
        }

        if (score < 0 || score > totalQuestions) {
            throw new IllegalArgumentException(
                    "Score must be between zero and total questions.");
        }

        this.attemptId = UUID.randomUUID().toString();
        this.playerName = playerName.trim();
        this.topic = topic;
        this.score = score;
        this.totalQuestions = totalQuestions;
        this.attemptedAt = LocalDateTime.now();
    }

    public String getAttemptId() {
        return attemptId;
    }

    public String getPlayerName() {
        return playerName;
    }

    public String getTopic() {
        return topic;
    }

    public int getScore() {
        return score;
    }

    public int getTotalQuestions() {
        return totalQuestions;
    }

    public double getPercentage() {
        return (score * 100.0) / totalQuestions;
    }

    public LocalDateTime getAttemptedAt() {
        return attemptedAt;
    }

    public String getFormattedAttemptTime() {
        DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");

        return attemptedAt.format(formatter);
    }
}
