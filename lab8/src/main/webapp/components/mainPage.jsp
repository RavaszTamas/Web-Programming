<%@ page import="Domain.User" %>
<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: tamas
  Date: 09.05.2020
  Time: 12:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile viewer</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>


</head>
<body>

<% User user;
    user = (User)session.getAttribute("user");
    if(user !=null){
%>
<main class="container">
    <%out.println("Welcome " + user.getUsername() + "!");%>
    <br/>
    <span color="red">Successful login!</span>
    <form action="${pageContext.request.contextPath}/components/displayListOfProfiles.jsp" method="post">
        <button type="submit" class="btn btn-success">Search among other profiles!</button>
    </form>
    <form action="${pageContext.request.contextPath}/components/profileDetail.jsp" method="post">
        <button type="submit" class="btn btn-success">Change your profile data!</button>
    </form>

    <form action="${pageContext.request.contextPath}/LogoutServlet" method="post">
        <button type="submit" class="btn btn-danger">Log out</button>
    </form>

</main>
<%
    }
    else {

%>
    <br/>
    Invalid user session!
<%

    }
%>
</body>
</html>
