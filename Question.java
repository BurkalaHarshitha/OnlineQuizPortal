
package com.quizportal;

import java.io.Serializable;
import java.util.Arrays;

public class Question implements Serializable {

    private static final long serialVersionUID = 1L;

    private final String id;
    private final String topic;
    private final String questionText;
    private final String[] options;
    private final int correctOptionIndex;
    private final String explanation;

    public Question(String id, String topic, String questionText,
                    String[] options, int correctOptionIndex,
                    String explanation) {

        if (id == null || id.trim().isEmpty()) {
            throw new IllegalArgumentException("Question ID is required.");
        }

        if (topic == null || topic.trim().isEmpty()) {
            throw new IllegalArgumentException("Topic is required.");
        }

        if (questionText == null || questionText.trim().isEmpty()) {
            throw new IllegalArgumentException("Question text is required.");
        }

        if (options == null || options.length < 2) {
            throw new IllegalArgumentException(
                    "At least two options are required.");
        }

        if (correctOptionIndex < 0
                || correctOptionIndex >= options.length) {
            throw new IllegalArgumentException(
                    "Correct option index is invalid.");
        }

        for (String option : options) {
            if (option == null || option.trim().isEmpty()) {
                throw new IllegalArgumentException(
                        "Options cannot be empty.");
            }
        }

        this.id = id;
        this.topic = topic;
        this.questionText = questionText;
        this.options = Arrays.copyOf(options, options.length);
        this.correctOptionIndex = correctOptionIndex;
        this.explanation = explanation == null ? "" : explanation;
    }

    public String getId() {
        return id;
    }

    public String getTopic() {
        return topic;
    }

    public String getQuestionText() {
        return questionText;
    }

    public String[] getOptions() {
        return Arrays.copyOf(options, options.length);
    }

    public int getCorrectOptionIndex() {
        return correctOptionIndex;
    }

    public String getExplanation() {
        return explanation;
    }

    public boolean isCorrect(int selectedOptionIndex) {
        return selectedOptionIndex == correctOptionIndex;
    }
}
