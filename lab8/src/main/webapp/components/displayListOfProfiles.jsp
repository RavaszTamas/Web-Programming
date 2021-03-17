<%@ page import="Domain.User" %><%--
  Created by IntelliJ IDEA.
  User: tamas
  Date: 09.05.2020
  Time: 20:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="../js/ajax-utils.js"></script>
    <script src="../js/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/css/lab8.css" type="text/css">

</head>

<body>
<%! User user; %>
<%  user = (User) session.getAttribute("user");
    if (user != null) {
        out.println("Welcome "+user.getUsername());
%>
<main class="container">
    <section><table id="profile-table" class="table"></table></section>
    <div id="search-bar" class="d-flex justify-content-around flex-nowrap">
<%--        <label>Image name:</label> <input id="image-search" type='text' onkeyup='getProfiles(populateProfilesTable)'>--%>
        <div class="form-group">
            <label>Name:</label> <input id="name-search" type='text' onkeyup='getProfiles(populateProfilesTable)'>
        </div>
        <div class="form-group">
            <label>Email address:</label> <input id="email-search" type='text' onkeyup='getProfiles(populateProfilesTable)'>
        </div>
        <div class="form-group">
            <label>Age:</label> <input id="age-search" type="text" pattern="\d*" onkeyup='getProfiles(populateProfilesTable)'>
        </div>
        <div class="form-group">
            <label>Home town:</label> <input id="home-town-search" type='text' onkeyup='getProfiles(populateProfilesTable)'>
        </div>
    </div>
    <br>
    <button class="btn btn-danger" onclick="location.href='/components/mainPage.jsp'" type="button">
        Return to main page!</button>
</main>
<script>
    $(document).ready(function (){
        console.log("ready");
        getProfiles(populateProfilesTable);
    });
</script>
<%
    }
%>
</body>

</html>
