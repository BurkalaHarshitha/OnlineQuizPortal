
package com.quizportal;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class QuestionBank {

    private static final Map<String, List<Question>> QUESTIONS =
            new LinkedHashMap<String, List<Question>>();

    static {
        // ==================== JAVA (10) ====================

        add("J01", "Java", "Which keyword inherits a class?",
                new String[]{"implements", "extends", "inherits", "super"}, 1,
                "The extends keyword inherits a class.");

        add("J02", "Java", "Which collection stores unique elements?",
                new String[]{"ArrayList", "LinkedList", "HashSet", "Vector"}, 2,
                "HashSet stores unique elements.");

        add("J03", "Java", "Which is the standard entry point of a Java application?",
                new String[]{"start()", "run()", "main()", "init()"}, 2,
                "The main method is the standard entry point.");

        add("J04", "Java", "Which keyword prevents a class from being inherited?",
                new String[]{"static", "final", "private", "abstract"}, 1,
                "A final class cannot be extended.");

        add("J05", "Java", "Which interface represents an ordered collection?",
                new String[]{"List", "Runnable", "Serializable", "Comparable"}, 0,
                "List represents an ordered sequence of elements.");

        add("J06", "Java", "Which keyword creates an object?",
                new String[]{"this", "new", "class", "void"}, 1,
                "The new operator creates objects.");

        add("J07", "Java", "Which block handles an exception?",
                new String[]{"try", "catch", "throw", "import"}, 1,
                "A catch block handles matching exceptions.");

        add("J08", "Java", "Which type stores true or false?",
                new String[]{"int", "char", "boolean", "String"}, 2,
                "boolean represents true or false.");

        add("J09", "Java", "Which keyword refers to the current object?",
                new String[]{"super", "this", "self", "current"}, 1,
                "this refers to the current object.");

        add("J10", "Java", "Which Java feature allows one method name with different parameter lists?",
                new String[]{"Overriding", "Overloading", "Inheritance", "Encapsulation"}, 1,
                "Method overloading uses different parameter lists.");

        // ==================== WEB DEVELOPMENT (10) ====================

        add("W01", "Web Development", "Which language structures web page content?",
                new String[]{"CSS", "HTML", "SQL", "JDBC"}, 1,
                "HTML defines web page structure.");

        add("W02", "Web Development", "Which technology styles web pages?",
                new String[]{"JDBC", "Servlet", "CSS", "JSP"}, 2,
                "CSS controls presentation and layout.");

        add("W03", "Web Development", "What does HTTP stand for?",
                new String[]{"HyperText Transfer Protocol", "HighText Transfer Program",
                        "Hyper Transfer Text Process", "Host Transfer Protocol"}, 0,
                "HTTP stands for HyperText Transfer Protocol.");

        add("W04", "Web Development", "Which HTML tag creates a hyperlink?",
                new String[]{"<link>", "<a>", "<href>", "<url>"}, 1,
                "The a tag creates a hyperlink.");

        add("W05", "Web Development", "Which HTML tag creates the largest standard heading?",
                new String[]{"<h6>", "<head>", "<h1>", "<title>"}, 2,
                "h1 is the largest heading level.");

        add("W06", "Web Development", "Which Java technology processes HTTP requests on the server?",
                new String[]{"Servlet", "CSS", "HTML", "JSON"}, 0,
                "Servlets handle server-side requests.");

        add("W07", "Web Development", "What does JSP stand for?",
                new String[]{"Java Server Pages", "Java Service Protocol",
                        "Java Standard Program", "Java Servlet Process"}, 0,
                "JSP stands for JavaServer Pages.");

        add("W08", "Web Development", "Which HTTP method is commonly used to retrieve data?",
                new String[]{"POST", "DELETE", "GET", "PATCH"}, 2,
                "GET is used to retrieve a resource.");

        add("W09", "Web Development", "Which format is commonly used for structured API data?",
                new String[]{"JPEG", "JSON", "MP3", "EXE"}, 1,
                "JSON represents structured data.");

        add("W10", "Web Development", "Which attribute provides alternative text for an image?",
                new String[]{"src", "href", "alt", "target"}, 2,
                "The alt attribute provides alternative text.");

        // ==================== DATABASE (10) ====================

        add("D01", "Database", "Which SQL command retrieves records?",
                new String[]{"INSERT", "UPDATE", "SELECT", "DELETE"}, 2,
                "SELECT retrieves data.");

        add("D02", "Database", "Which key uniquely identifies a row?",
                new String[]{"Foreign key", "Primary key", "Duplicate key", "Nullable key"}, 1,
                "A primary key uniquely identifies a row.");

        add("D03", "Database", "Which SQL command adds a new row?",
                new String[]{"INSERT", "ALTER", "DROP", "SELECT"}, 0,
                "INSERT adds rows.");

        add("D04", "Database", "Which SQL command changes existing records?",
                new String[]{"CREATE", "UPDATE", "SELECT", "GRANT"}, 1,
                "UPDATE modifies existing records.");

        add("D05", "Database", "Which clause filters rows?",
                new String[]{"ORDER BY", "GROUP BY", "WHERE", "JOIN"}, 2,
                "WHERE filters rows by a condition.");

        add("D06", "Database", "Which command removes a table definition?",
                new String[]{"DELETE", "DROP", "UPDATE", "SELECT"}, 1,
                "DROP removes a database object.");

        add("D07", "Database", "Which key references a key in another table?",
                new String[]{"Primary key", "Foreign key", "Super key", "Sort key"}, 1,
                "A foreign key establishes a relationship between tables.");

        add("D08", "Database", "Which function counts rows?",
                new String[]{"SUM()", "COUNT()", "AVG()", "ROUND()"}, 1,
                "COUNT() counts rows or non-null values, depending on its argument.");

        add("D09", "Database", "Which clause sorts query results?",
                new String[]{"WHERE", "ORDER BY", "HAVING", "VALUES"}, 1,
                "ORDER BY sorts the result set.");

        add("D10", "Database", "What is the main purpose of database normalization?",
                new String[]{"Increase duplication", "Reduce redundancy",
                        "Remove all keys", "Prevent all queries"}, 1,
                "Normalization reduces unnecessary data redundancy.");

        // ==================== DATA STRUCTURES & ALGORITHMS (10) ====================

        add("A01", "Data Structures & Algorithms", "Which data structure follows LIFO?",
                new String[]{"Queue", "Stack", "Tree", "Graph"}, 1,
                "A stack follows Last In, First Out.");

        add("A02", "Data Structures & Algorithms", "Which data structure follows FIFO?",
                new String[]{"Stack", "Heap", "Queue", "Graph"}, 2,
                "A queue follows First In, First Out.");

        add("A03", "Data Structures & Algorithms", "What is the time complexity of binary search on a sorted array?",
                new String[]{"O(n)", "O(log n)", "O(n²)", "O(1) always"}, 1,
                "Binary search halves the search interval each step.");

        add("A04", "Data Structures & Algorithms", "Which structure organizes data in parent-child relationships?",
                new String[]{"Tree", "Stack", "Queue", "Array"}, 0,
                "Trees represent hierarchical relationships.");

        add("A05", "Data Structures & Algorithms", "Which structure consists of vertices and edges?",
                new String[]{"Array", "Graph", "Stack", "Hash table"}, 1,
                "Graphs consist of vertices connected by edges.");

        add("A06", "Data Structures & Algorithms", "Which sorting algorithm repeatedly swaps adjacent out-of-order elements?",
                new String[]{"Merge sort", "Quick sort", "Bubble sort", "Counting sort"}, 2,
                "Bubble sort compares and swaps adjacent elements.");

        add("A07", "Data Structures & Algorithms", "Which data structure provides average O(1) key lookup under typical hashing assumptions?",
                new String[]{"Hash table", "Linked list", "Unsorted array", "Binary tree without balancing"}, 0,
                "Hash tables provide average constant-time lookup under typical assumptions.");

        add("A08", "Data Structures & Algorithms", "Which traversal explores a graph level by level?",
                new String[]{"DFS", "BFS", "Inorder", "Postorder"}, 1,
                "Breadth-first search explores vertices level by level.");

        add("A09", "Data Structures & Algorithms", "Which notation describes an algorithm's asymptotic upper bound?",
                new String[]{"Big O", "Big Omega only", "Little omega only", "Sigma notation"}, 0,
                "Big O describes an asymptotic upper bound.");

        add("A10", "Data Structures & Algorithms", "Which structure is commonly used to implement recursion?",
                new String[]{"Queue", "Stack", "Graph", "Hash table"}, 1,
                "Function calls use a call stack.");

        // ==================== PYTHON (10) ====================

        add("P01", "Python", "Which symbol starts a single-line comment?",
                new String[]{"//", "#", "/*", "--"}, 1,
                "Python uses # for single-line comments.");

        add("P02", "Python", "Which type stores key-value pairs?",
                new String[]{"list", "tuple", "dict", "set"}, 2,
                "A dictionary stores key-value pairs.");

        add("P03", "Python", "Which keyword defines a function?",
                new String[]{"function", "func", "def", "method"}, 2,
                "The def keyword defines a function.");

        add("P04", "Python", "Which collection is immutable?",
                new String[]{"list", "dict", "set", "tuple"}, 3,
                "Tuples are immutable sequences.");

        add("P05", "Python", "Which built-in function returns the length of a sequence?",
                new String[]{"count()", "size()", "len()", "length()"}, 2,
                "len() returns the number of items.");

        add("P06", "Python", "Which keyword begins a conditional branch?",
                new String[]{"when", "if", "case", "check"}, 1,
                "The if keyword begins a conditional statement.");

        add("P07", "Python", "Which operator performs exponentiation?",
                new String[]{"^", "**", "//", "%"}, 1,
                "** performs exponentiation.");

        add("P08", "Python", "Which statement imports a module?",
                new String[]{"include math", "using math", "import math", "load math"}, 2,
                "The import statement makes a module available.");

        add("P09", "Python", "What is the result of len([4, 5, 6])?",
                new String[]{"2", "3", "4", "6"}, 1,
                "The list contains three elements.");

        add("P10", "Python", "Which value represents the absence of a value in Python?",
                new String[]{"undefined", "NULL", "None", "void"}, 2,
                "None represents the absence of a value.");
    }

    private QuestionBank() {
        // Utility class.
    }

    private static void add(String id, String topic, String text,
                            String[] options, int correctIndex,
                            String explanation) {
        List<Question> list = QUESTIONS.get(topic);

        if (list == null) {
            list = new ArrayList<Question>();
            QUESTIONS.put(topic, list);
        }

        list.add(new Question(
                id, topic, text, options, correctIndex, explanation));
    }

    public static List<String> getTopics() {
        return new ArrayList<String>(QUESTIONS.keySet());
    }

    public static List<Question> getQuestions(String topic) {
        List<Question> list = QUESTIONS.get(topic);

        if (list == null) {
            return Collections.emptyList();
        }

        return new ArrayList<Question>(list);
    }

    public static Question getQuestionById(String questionId) {
        for (List<Question> list : QUESTIONS.values()) {
            for (Question question : list) {
                if (question.getId().equals(questionId)) {
                    return question;
                }
            }
        }

        return null;
    }
}
