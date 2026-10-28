
package com.quizportal;

public class InvalidAttemptException extends Exception {

    private static final long serialVersionUID = 1L;

    public InvalidAttemptException(String message) {
        super(message);
    }
}
