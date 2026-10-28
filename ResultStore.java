
package com.quizportal;

import java.io.EOFException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.List;

public class ResultStore {

    private static final String DATA_DIRECTORY = "data";
    private static final String DATA_FILE = "quiz-results.dat";

    private final File storageFile;

    public ResultStore() {
        String configuredDirectory =
                System.getProperty("quizportal.data.dir");

        File directory;

        if (configuredDirectory != null
                && !configuredDirectory.trim().isEmpty()) {
            directory = new File(configuredDirectory);
        } else {
            directory = new File(
                    System.getProperty("user.home"),
                    DATA_DIRECTORY + File.separator + "OnlineQuizPortal");
        }

        if (!directory.exists() && !directory.mkdirs()) {
            throw new IllegalStateException(
                    "Could not create result storage directory: "
                    + directory.getAbsolutePath());
        }

        storageFile = new File(directory, DATA_FILE);
    }

    public synchronized List<QuizResult> loadResults()
            throws IOException, ClassNotFoundException {

        List<QuizResult> results = new ArrayList<QuizResult>();

        if (!storageFile.exists() || storageFile.length() == 0) {
            return results;
        }

        try (ObjectInputStream input = new ObjectInputStream(
                new FileInputStream(storageFile))) {

            Object storedObject = input.readObject();

            if (!(storedObject instanceof List<?>)) {
                throw new IOException("Invalid result file format.");
            }

            for (Object item : (List<?>) storedObject) {
                if (!(item instanceof QuizResult)) {
                    throw new IOException(
                            "Unexpected data in result file.");
                }

                results.add((QuizResult) item);
            }

        } catch (EOFException exception) {
            return results;
        }

        return results;
    }

    public synchronized void saveResults(List<QuizResult> results)
            throws IOException {

        if (results == null) {
            throw new IllegalArgumentException(
                    "Results list cannot be null.");
        }

        File parent = storageFile.getParentFile();

        if (parent != null && !parent.exists() && !parent.mkdirs()) {
            throw new IOException(
                    "Could not create result storage directory.");
        }

        File temporaryFile = new File(
                storageFile.getParentFile(),
                DATA_FILE + ".tmp");

        try (ObjectOutputStream output = new ObjectOutputStream(
                new FileOutputStream(temporaryFile))) {

            output.writeObject(new ArrayList<QuizResult>(results));
            output.flush();
        }

        try {
            java.nio.file.Files.move(
                    temporaryFile.toPath(),
                    storageFile.toPath(),
                    java.nio.file.StandardCopyOption.REPLACE_EXISTING,
                    java.nio.file.StandardCopyOption.ATOMIC_MOVE);
        } catch (IOException moveException) {
            java.nio.file.Files.move(
                    temporaryFile.toPath(),
                    storageFile.toPath(),
                    java.nio.file.StandardCopyOption.REPLACE_EXISTING);
        }
    }

    public File getStorageFile() {
        return storageFile;
    }
}
