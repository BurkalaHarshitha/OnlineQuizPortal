
package com.quizportal;

public class DuplicateAttemptException extends Exception {

    private static final long serialVersionUID = 1L;

    public DuplicateAttemptException(String message) {
        super(message);
    }
}
