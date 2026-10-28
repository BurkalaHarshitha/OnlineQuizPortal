
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.quizportal.QuizResult" %>
<%@ page import="com.quizportal.Question" %>
<%@ page import="java.util.List" %>
<%
    QuizResult result = (QuizResult) request.getAttribute("result");
    List<Question> questions =
            (List<Question>) request.getAttribute("questions");
    Object elapsedValue = request.getAttribute("elapsedSeconds");
    long elapsedSeconds = elapsedValue instanceof Number
            ? ((Number) elapsedValue).longValue() : 0;

    if (result == null || questions == null) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }

    String contextPath = request.getContextPath();
    double percentage = result.getPercentage();
    int minutes = (int) (elapsedSeconds / 60);
    int seconds = (int) (elapsedSeconds % 60);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Results | Online Quiz Portal</title>
    <style>
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f3f6fc;
            color: #172554;
        }
        header {
            padding: 18px 7%;
            background: #172554;
            color: white;
        }
        main { max-width: 850px; margin: 30px auto; padding: 0 16px; }
        .card {
            background: white;
            padding: 24px;
            border-radius: 14px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(20, 35, 70, .06);
        }
        .score { text-align: center; }
        .percentage { font-size: 42px; font-weight: bold; color: #2563eb; }
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
            gap: 12px;
            margin-top: 22px;
        }
        .stat {
            background: #eff6ff;
            padding: 16px;
            border-radius: 10px;
            text-align: center;
        }
        .stat strong { display: block; font-size: 23px; margin-bottom: 6px; }
        .review {
            padding: 16px 0;
            border-bottom: 1px solid #e2e8f0;
            line-height: 1.6;
        }
        .review:last-child { border-bottom: 0; }
        .correct { color: #15803d; font-weight: bold; }
        .incorrect { color: #b91c1c; font-weight: bold; }
        .button {
            display: inline-block;
            text-decoration: none;
            padding: 12px 18px;
            margin: 5px 5px 5px 0;
            border-radius: 8px;
            background: #2563eb;
            color: white;
        }
        .secondary { background: #334155; }
    </style>
</head>
<body>
<header><strong>Online Quiz Portal — Results</strong></header>

<main>
    <section class="card score">
        <h1>Quiz Completed!</h1>
        <p>
            Well done, <strong><%= result.getPlayerName() %></strong>.
            You completed the <strong><%= result.getTopic() %></strong> quiz.
        </p>

        <div class="percentage">
            <%= String.format(java.util.Locale.ROOT, "%.1f", percentage) %>%
        </div>
        <p>Your final score</p>

        <div class="stats">
            <div class="stat">
                <strong><%= result.getScore() %> / <%= result.getTotalQuestions() %></strong>
                Correct answers
            </div>
            <div class="stat">
                <strong><%= minutes %>:<%= String.format("%02d", seconds) %></strong>
                Time taken
            </div>
            <div class="stat">
                <strong><%= result.getTopic() %></strong>
                Topic
            </div>
        </div>
    </section>

    <section class="card">
        <h2>Answer Review</h2>
        <p>Correct answers are shown below for learning and revision.</p>

        <% for (int i = 0; i < questions.size(); i++) {
               Question question = questions.get(i);
               String[] options = question.getOptions();
        %>
        <div class="review">
            <strong>Q<%= i + 1 %>. <%= question.getQuestionText() %></strong>
            <p>
                <span class="correct">Correct answer:</span>
                <%= options[question.getCorrectOptionIndex()] %>
            </p>
            <p><%= question.getExplanation() %></p>
        </div>
        <% } %>
    </section>

    <section class="card">
        <h2>What's next?</h2>
        <a class="button" href="<%= contextPath %>/leaderboard">
            View Leaderboard
        </a>
        <a class="button secondary"
           href="<%= contextPath %>/attempts?playerName=<%= java.net.URLEncoder.encode(result.getPlayerName(), "UTF-8") %>">
            View My Attempts
        </a>
        <a class="button secondary" href="<%= contextPath %>/index.jsp">
            Home
        </a>
    </section>
</main>
</body>
</html>
