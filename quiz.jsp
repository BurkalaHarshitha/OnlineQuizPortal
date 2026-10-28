<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.quizportal.Question" %>

<%
    String playerName = (String) session.getAttribute("playerName");
    String topic = (String) request.getAttribute("topic");

    List<Question> questions =
            (List<Question>) request.getAttribute("questions");

    if (playerName == null || topic == null
            || questions == null || questions.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }

    int durationSeconds = 300;

    Object duration = request.getAttribute("durationSeconds");
    if (duration instanceof Integer) {
        durationSeconds = (Integer) duration;
    }

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title><%= topic %> Quiz | Online Quiz Portal</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f3f6fc;
            color: #18233b;
        }

        header {
            background: #172554;
            color: white;
            padding: 18px 7%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
        }

        header a {
            color: white;
            text-decoration: none;
        }

        .container {
            max-width: 850px;
            margin: 28px auto;
            padding: 0 16px;
        }

        .summary,
        .question-card {
            background: white;
            border-radius: 14px;
            padding: 22px;
            margin-bottom: 18px;
            box-shadow: 0 5px 20px rgba(20, 35, 70, .06);
        }

        .summary {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }

        .timer {
            font-size: 20px;
            font-weight: bold;
            color: #166534;
        }

        .timer.warning {
            color: #b91c1c;
        }

        .progress-track {
            height: 8px;
            background: #e5e7eb;
            border-radius: 8px;
            overflow: hidden;
            margin-top: 12px;
        }

        .progress-bar {
            height: 100%;
            width: 0;
            background: #2563eb;
            transition: width .2s;
        }

        .question-title {
            margin-top: 0;
            line-height: 1.5;
        }

        .option {
            display: block;
            padding: 13px 15px;
            margin: 10px 0;
            border: 1px solid #dbe2ef;
            border-radius: 9px;
            cursor: pointer;
        }

        .option:hover {
            background: #eff6ff;
            border-color: #93c5fd;
        }

        .option input {
            margin-right: 10px;
        }

        .submit-button {
            width: 100%;
            padding: 15px;
            border: 0;
            border-radius: 10px;
            background: #2563eb;
            color: white;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
        }

        .submit-button:hover {
            background: #1d4ed8;
        }

        .submit-button:disabled {
            opacity: .6;
            cursor: wait;
        }

        .note {
            color: #64748b;
            font-size: 14px;
        }

        @media (max-width: 550px) {
            header {
                padding: 16px;
            }

            .summary,
            .question-card {
                padding: 17px;
            }
        }
    </style>
</head>

<body>

<header>
    <strong>Online Quiz Portal</strong>
    <a href="<%= contextPath %>/leaderboard">Leaderboard</a>
</header>

<main class="container">

    <div class="summary">
        <div>
            <h2 style="margin:0 0 6px;"><%= topic %></h2>

            <div>
                Player: <strong><%= playerName %></strong>
            </div>

            <div class="note">
                <%= questions.size() %> questions · 5 minutes
            </div>
        </div>

        <div>
            <div id="timer" class="timer">05:00</div>
            <div class="note">Time remaining</div>
        </div>
    </div>

    <div class="summary">
        <div style="width:100%;">
            <strong>
                Quiz progress:
                <span id="answeredCount">0</span>
                / <%= questions.size() %> answered
            </strong>

            <div class="progress-track">
                <div id="progressBar" class="progress-bar"></div>
            </div>
        </div>
    </div>

    <form id="quizForm"
          action="<%= contextPath %>/submit-quiz"
          method="post">

        <!-- FIX: Send the player name to SubmitQuizServlet -->
        <input type="hidden"
               name="playerName"
               value="<%= playerName %>">

        <% for (int i = 0; i < questions.size(); i++) {
               Question question = questions.get(i);
               String[] options = question.getOptions();
        %>

        <section class="question-card">

            <h3 class="question-title">
                Question <%= i + 1 %> of <%= questions.size() %>:
                <%= question.getQuestionText() %>
            </h3>

            <% for (int j = 0; j < options.length; j++) { %>

                <label class="option">
                    <input
                        type="radio"
                        name="answer_<%= question.getId() %>"
                        value="<%= j %>">

                    <%= options[j] %>
                </label>

            <% } %>

        </section>

        <% } %>

        <p class="note">
            Once submitted, your answers cannot be changed.
            Unanswered questions receive zero points.
        </p>

        <button id="submitButton"
                class="submit-button"
                type="submit">
            Submit Quiz
        </button>

    </form>

</main>

<script>
(function () {
    var remaining = <%= durationSeconds %>;
    var timer = document.getElementById("timer");
    var form = document.getElementById("quizForm");
    var submitButton = document.getElementById("submitButton");
    var answeredCount = document.getElementById("answeredCount");
    var progressBar = document.getElementById("progressBar");
    var totalQuestions = <%= questions.size() %>;
    var finished = false;

    function updateProgress() {
        var groups = {};
        var checked = form.querySelectorAll(
            'input[type="radio"]:checked'
        );

        checked.forEach(function (input) {
            groups[input.name] = true;
        });

        var count = Object.keys(groups).length;

        answeredCount.textContent = count;

        progressBar.style.width =
            (totalQuestions ? count * 100 / totalQuestions : 0) + "%";
    }

    function formatTime(seconds) {
        var minutes = Math.floor(seconds / 60);
        var secs = seconds % 60;

        return String(minutes).padStart(2, "0") + ":" +
               String(secs).padStart(2, "0");
    }

    form.addEventListener("change", updateProgress);

    form.addEventListener("submit", function () {
        if (finished) {
            return;
        }

        finished = true;
        submitButton.disabled = true;
        submitButton.textContent = "Submitting...";
    });

    timer.textContent = formatTime(remaining);

    var countdown = setInterval(function () {
        if (finished) {
            clearInterval(countdown);
            return;
        }

        remaining--;

        timer.textContent = formatTime(Math.max(remaining, 0));

        if (remaining <= 60) {
            timer.classList.add("warning");
        }

        if (remaining <= 0) {
            clearInterval(countdown);
            finished = true;
            submitButton.disabled = true;
            submitButton.textContent = "Time is up — submitting...";

            form.submit();
        }
    }, 1000);

    updateProgress();
})();
</script>

</body>
</html>