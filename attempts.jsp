
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.quizportal.QuizResult" %>
<%
    String playerName = (String) request.getAttribute("playerName");
    String errorMessage = (String) request.getAttribute("errorMessage");
    List<QuizResult> attempts =
            (List<QuizResult>) request.getAttribute("attempts");

    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Attempts | Online Quiz Portal</title>
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
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        header a { color: white; text-decoration: none; }
        main { max-width: 1000px; margin: 30px auto; padding: 0 16px; }
        .card {
            background: white;
            padding: 24px;
            border-radius: 14px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(20, 35, 70, .06);
        }
        form { display: flex; flex-wrap: wrap; gap: 10px; }
        input {
            flex: 1;
            min-width: 200px;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 15px;
        }
        button, .button {
            padding: 12px 17px;
            border: none;
            border-radius: 8px;
            background: #2563eb;
            color: white;
            cursor: pointer;
            font-size: 15px;
            text-decoration: none;
            display: inline-block;
        }
        .table-wrap { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; }
        th, td {
            text-align: left;
            padding: 13px 12px;
            border-bottom: 1px solid #e2e8f0;
            white-space: nowrap;
        }
        th { background: #eff6ff; }
        .percentage { font-weight: bold; color: #166534; }
        .error { color: #b91c1c; margin-bottom: 15px; }
        .empty { color: #64748b; padding: 20px 0; }
    </style>
</head>
<body>
<header>
    <strong>Online Quiz Portal</strong>
    <a href="<%= contextPath %>/index.jsp">Home</a>
</header>

<main>
    <section class="card">
        <h1>My Quiz Attempts</h1>
        <p>Enter the same player name you used when taking your quiz.</p>

        <% if (errorMessage != null) { %>
            <p class="error"><%= errorMessage %></p>
        <% } %>

        <form action="<%= contextPath %>/attempts" method="get">
            <input
                type="text"
                name="playerName"
                maxlength="60"
                required
                placeholder="Enter your player name"
                value="<%= playerName == null ? "" :
                    playerName.replace("&", "&amp;")
                              .replace("<", "&lt;")
                              .replace(">", "&gt;")
                              .replace("\"", "&quot;") %>">

            <button type="submit">View Attempts</button>
        </form>
    </section>

    <% if (playerName != null && attempts != null) { %>
    <section class="card">
        <h2>
            History for
            <%= playerName.replace("&", "&amp;")
                          .replace("<", "&lt;")
                          .replace(">", "&gt;")
                          .replace("\"", "&quot;") %>
        </h2>

        <% if (attempts.isEmpty()) { %>
            <p class="empty">
                No quiz attempts found for this player name.
            </p>
        <% } else { %>
            <div class="table-wrap">
                <table>
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Topic</th>
                        <th>Score</th>
                        <th>Percentage</th>
                        <th>Attempted At</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (int i = 0; i < attempts.size(); i++) {
                           QuizResult result = attempts.get(i);
                    %>
                    <tr>
                        <td><%= i + 1 %></td>
                        <td><%= result.getTopic() %></td>
                        <td>
                            <%= result.getScore() %> /
                            <%= result.getTotalQuestions() %>
                        </td>
                        <td class="percentage">
                            <%= String.format(java.util.Locale.ROOT,
                                    "%.1f%%", result.getPercentage()) %>
                        </td>
                        <td><%= result.getFormattedAttemptTime() %></td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
    </section>
    <% } %>

    <section class="card">
        <a class="button" href="<%= contextPath %>/leaderboard">
            View Leaderboard
        </a>
    </section>
</main>
</body>
</html>
