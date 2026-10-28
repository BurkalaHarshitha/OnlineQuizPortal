# Online Quiz Portal

A Java Servlet and JSP-based web application where users can take timed multiple-choice quizzes, view their scores, and check the leaderboard.

## Project Overview

The Online Quiz Portal allows users to select a topic, answer multiple-choice questions within a time limit, submit their answers, and view their results. It also maintains a leaderboard and stores quiz results using Java serialization.

## Technologies Used

- Java 8+
- Java Servlets
- JSP (JavaServer Pages)
- Apache Tomcat 9
- Maven
- HTML and CSS
- Java Collections Framework
- Java Streams API
- Object Serialization

## Key Features

- Topic-based multiple-choice quizzes
- Timed quiz attempts
- Automatic score calculation
- Leaderboard displaying top results
- Attempt history for players
- Custom exceptions for invalid and duplicate attempts
- Persistent quiz results using Java serialization

## Java Concepts Implemented

| Concept | Usage |
|---|---|
| `Map<String, List<Question>>` | Organizes questions by topic |
| `List` | Stores questions and quiz results |
| Custom exceptions | Handles invalid and duplicate attempts |
| `Comparator` | Sorts leaderboard results |
| Java Streams | Filters, sorts, and limits leaderboard results |
| Serialization | Saves quiz results to a file |

## Project Structure

```text
OnlineQuizPortal/
├── src/
│   └── main/
│       ├── java/
│       └── webapp/
├── pom.xml
├── start-quizportal.ps1
└── README.md
```

*The structure above is illustrative; the actual files may vary.*

## Prerequisites

- JDK 8 or later
- Apache Tomcat 9
- Maven
- A web browser

## How to Run

1. Open the project in VS Code or another Java IDE.
2. Configure the Java and Maven environments.
3. Build the project:

   ```bash
   mvn clean package
   ```

4. Copy the generated WAR file from `target/` into Tomcat's `webapps/` directory.
5. Start Apache Tomcat.
6. Open the application in your browser:

   `http://localhost:8080/OnlineQuizPortal/`

## Application Pages

- **Quiz Portal:** Select a topic and start a quiz.
- **Results:** View the score after submission.
- **Leaderboard:** View top quiz results.
- **Attempts:** View a player's attempt history.

## Data Storage

Quiz results are persisted using Java object serialization. The application uses a file-based storage mechanism rather than requiring a database.

## Author

Developed as a Java Web Development project to demonstrate Servlets, JSP, Collections, exception handling, Streams, Comparators, and serialization.
