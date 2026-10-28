
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.quizportal.QuizResult" %>
<%@ page import="com.quizportal.QuestionBank" %>
<%
    List<QuizResult> leaderboard =
            (List<QuizResult>) request.getAttribute("leaderboard");

    String selectedTopic = (String) request.getAttribute("selectedTopic");
    if (selectedTopic == null) selectedTopic = "";

    String contextPath = request.getContextPath();

    String[] topics = QuestionBank.getTopics().toArray(new String[0]);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leaderboard | Online Quiz Portal</title>
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
        main { max-width: 1050px; margin: 30px auto; padding: 0 16px; }
        .card {
            background: white;
            border-radius: 14px;
            padding: 24px;
            margin-bottom: 20px;
            box-shadow: 0 5px 20px rgba(20, 35, 70, .06);
        }
        .filters {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 10px;
        }
        select, button {
            padding: 11px 13px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 15px;
        }
        button {
            background: #2563eb;
            color: white;
            border: none;
            cursor: pointer;
        }
        .table-wrap { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; }
        th, td {
            text-align: left;
            padding: 14px 12px;
            border-bottom: 1px solid #e2e8f0;
            white-space: nowrap;
        }
        th { background: #eff6ff; }
        .rank { font-weight: bold; }
        .percentage { color: #166534; font-weight: bold; }
        .empty { padding: 25px; text-align: center; color: #64748b; }
        .button {
            display: inline-block;
            text-decoration: none;
            padding: 11px 16px;
            border-radius: 8px;
            background: #334155;
            color: white;
        }
    </style>
</head>
<body>
<header>
    <strong>Online Quiz Portal</strong>
    <a href="<%= contextPath %>/index.jsp">Home</a>
</header>

<main>
    <section class="card">
        <h1>🏆 Leaderboard</h1>
        <p>See the highest-performing players across quiz topics.</p>

        <form class="filters" action="<%= contextPath %>/leaderboard" method="get">
            <label for="topic">Filter by topic:</label>
            <select id="topic" name="topic">
                <option value="">All Topics</option>
                <% for (String topic : topics) { %>
                    <option value="<%= topic %>"
                        <%= topic.equalsIgnoreCase(selectedTopic)
                                ? "selected" : "" %>>
                        <%= topic %>
                    </option>
                <% } %>
            </select>
            <button type="submit">Apply Filter</button>
            <a class="button" href="<%= contextPath %>/leaderboard">
                Reset
            </a>
        </form>
    </section>

    <section class="card">
        <h2>
            <%= selectedTopic.isEmpty()
                    ? "Top 10 Players — All Topics"
                    : "Top 10 Players — " + selectedTopic %>
        </h2>

        <% if (leaderboard == null || leaderboard.isEmpty()) { %>
            <div class="empty">
                No results yet. Complete a quiz to appear here!
            </div>
        <% } else { %>
            <div class="table-wrap">
                <table>
                    <thead>
                    <tr>
                        <th>Rank</th>
                        <th>Player</th>
                        <th>Topic</th>
                        <th>Score</th>
                        <th>Percentage</th>
                        <th>Attempted At</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (int i = 0; i < leaderboard.size(); i++) {
                           QuizResult result = leaderboard.get(i);
                    %>
                    <tr>
                        <td class="rank">
                            <%= i == 0 ? "🥇" :
                                i == 1 ? "🥈" :
                                i == 2 ? "🥉" : (i + 1) %>
                        </td>
                        <td><%= result.getPlayerName() %></td>
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

    <section class="card">
        <a class="button" href="<%= contextPath %>/index.jsp">
            Take a Quiz
        </a>
    </section>
</main>
</body>
</html>
