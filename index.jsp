<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.quizportal.QuestionBank" %>
<%
    List<String> topics = QuestionBank.getTopics();
    String errorMessage = (String) request.getAttribute("errorMessage");
    String errorCode = request.getParameter("error");
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Portal | Test Your Knowledge</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: #f4f6fb;
            color: #172033;
        }

        header {
            background: #171c3b;
            color: white;
            padding: 22px 8%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }

        header h2 {
            margin: 0;
        }

        header span {
            color: #b9c5ff;
        }

        nav {
            display: flex;
            gap: 16px;
            flex-wrap: wrap;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-weight: 600;
        }

        nav a:hover {
            text-decoration: underline;
        }

        .hero {
            padding: 45px 8% 30px;
            background: linear-gradient(120deg, #252c60, #6555ce);
            color: white;
        }

        .hero h1 {
            font-size: 36px;
            margin: 0 0 12px;
        }

        .hero p {
            color: #e0e4ff;
            font-size: 17px;
            line-height: 1.6;
        }

        main {
            padding: 30px 8%;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 18px;
            margin-bottom: 28px;
        }

        .card,
        .panel {
            background: white;
            padding: 22px;
            border-radius: 14px;
            box-shadow: 0 5px 20px #20294a0d;
            min-width: 0;
        }

        .stat-number {
            font-size: 28px;
            font-weight: bold;
            color: #5145cd;
        }

        .muted {
            color: #69738b;
        }

        .layout {
            display: grid;
            grid-template-columns: minmax(0, 1.5fr) minmax(260px, 1fr);
            gap: 22px;
        }

        h2 {
            margin-top: 0;
        }

        label {
            display: block;
            margin: 18px 0 8px;
            font-weight: 600;
        }

        input,
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #d8dceb;
            border-radius: 8px;
            font-size: 15px;
            background: white;
        }

        button,
        .button {
            display: inline-block;
            border: 0;
            border-radius: 8px;
            padding: 12px 18px;
            background: #5145cd;
            color: white;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            margin-top: 18px;
            text-decoration: none;
        }

        button:hover,
        .button:hover {
            background: #3d33a7;
        }

        .message {
            padding: 12px;
            margin: 16px 0;
            border-radius: 8px;
            background: #f1f0ff;
            color: #4135ae;
        }

        .error {
            background: #fff0f0;
            color: #a52626;
        }

        .topic-list {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: 14px;
        }

        .topic-chip {
            background: #f1f0ff;
            color: #4135ae;
            padding: 7px 10px;
            border-radius: 20px;
            font-size: 13px;
        }

        .panel p {
            line-height: 1.6;
        }

        footer {
            text-align: center;
            padding: 25px;
            color: #69738b;
        }

        @media (max-width: 700px) {
            .layout {
                grid-template-columns: 1fr;
            }

            .hero h1 {
                font-size: 29px;
            }

            main {
                padding: 22px 5%;
            }

            header {
                padding: 20px 5%;
            }
        }
    </style>
</head>

<body>

<header>
    <h2>Quiz<span>Portal</span></h2>

    <nav aria-label="Main navigation">
        <a href="<%= contextPath %>/index.jsp">Home</a>
        <a href="<%= contextPath %>/leaderboard">Leaderboard</a>
        <a href="<%= contextPath %>/attempts">Attempt History</a>
    </nav>
</header>

<section class="hero">
    <h1>Knowledge is your superpower.</h1>
    <p>
        Challenge yourself with timed quizzes, review your results,
        and compete on the leaderboard.
    </p>
</section>

<main>

    <% if (errorMessage != null && !errorMessage.trim().isEmpty()) { %>
        <div class="message error" role="alert">
            <%= errorMessage %>
        </div>
    <% } %>

    <% if ("expired".equals(errorCode)) { %>
        <div class="message error" role="alert">
            Your five-minute quiz time expired. Please start a new quiz.
        </div>
    <% } %>

    <section class="stats">

        <div class="card">
            <div class="muted">Available Topics</div>
            <div class="stat-number"><%= topics.size() %></div>
        </div>

        <div class="card">
            <div class="muted">Questions Per Topic</div>
            <div class="stat-number">10</div>
        </div>

        <div class="card">
            <div class="muted">Quiz Duration</div>
            <div class="stat-number">5 min</div>
        </div>

    </section>

    <div class="layout">

        <section class="panel">

            <h2>Start a Quiz</h2>

            <p class="muted">
                Enter your name, choose a topic, and answer the
                multiple-choice questions within five minutes.
            </p>

            <form action="<%= contextPath %>/questions" method="get">

                <label for="playerName">Your name</label>

                <input
                    id="playerName"
                    name="playerName"
                    type="text"
                    maxlength="60"
                    placeholder="Enter your name"
                    autocomplete="name"
                    required>

                <label for="topic">Choose a topic</label>

                <select id="topic" name="topic" required>
                    <% for (String topic : topics) { %>
                        <option value="<%= topic %>"><%= topic %></option>
                    <% } %>
                </select>

                <button type="submit">Start Quiz</button>

            </form>

            <h3>Available Topics</h3>

            <div class="topic-list">
                <% for (String topic : topics) { %>
                    <span class="topic-chip"><%= topic %></span>
                <% } %>
            </div>

        </section>

        <aside class="panel">

            <h2>Track Your Progress</h2>

            <p class="muted">
                Review the top ten scores or look up previous attempts
                using the same player name you used for a quiz.
            </p>

            <p>
                <strong>Leaderboard</strong><br>
                Compare scores across all topics or filter by topic.
            </p>

            <a class="button"
               href="<%= contextPath %>/leaderboard">
                View Leaderboard
            </a>

            <hr style="border:0; border-top:1px solid #edf0f6; margin:24px 0;">

            <h3>Find Your Attempts</h3>

            <form action="<%= contextPath %>/attempts" method="get">

                <label for="historyPlayerName">Player name</label>

                <input
                    id="historyPlayerName"
                    name="playerName"
                    type="text"
                    maxlength="60"
                    placeholder="Enter the name used in the quiz"
                    required>

                <button type="submit">View Attempts</button>

            </form>

        </aside>

    </div>

</main>

<footer>
    QuizPortal · Keep learning, keep growing.
</footer>

</body>
</html>