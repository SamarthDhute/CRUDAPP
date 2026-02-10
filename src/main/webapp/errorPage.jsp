<%@ page contentType="text/html;charset=UTF-8"  %>
<head>
    <title>ERROR PAGE</title>
</head>
<body>
    <h1>ERROR OCCOURED</h1>
    <hr>
    <p> <%= request.getAttribute("ERROR MESSAGE")%></p>

  <%
      Throwable errorCause = (Throwable) request.getAttribute("ERROR CAUSE");
      Throwable exception = (Throwable) request.getAttribute("javax.servlet.error.exception");
  %>
  <% if(errorCause != null) { %>
      <p><strong>Root Cause</strong></p>
      <pre><%= errorCause %></pre>
  <% } else if(exception != null) { %>
      <p><strong>Main Exception</strong></p>
      <pre><%= exception %></pre>
  <% } else { %>
      <p>No Technical Error Found</p>
  <% } %>




</body>
</html>