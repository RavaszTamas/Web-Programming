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
    <title>Your profile detail</title>
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
    <main id="profile-managment-container" class="container">

        <form style="margin-left: 15px; margin-top: 20px;" method="post" action="/UpdateProfile" enctype="multipart/form-data">
            <label for="imageInput">Image: </label>
            <img id="image-of-user">
            <input type="file"
                   id="imageInput" name="imageInput"
                   accept="image/png, image/jpeg">
            <br/>
            <label for="nameInput">Name: </label>
            <label id="currentName"></label>
            <input type="text" name="nameInput" id="nameInput"/>
            <br/>
            <label for="emailAddress">Email: </label>
            <label id="currentEmail"></label>
            <input type="text" name="emailAddress" id="emailAddress"/>
            <br/>
            <label for="ageInput">Age: </label>
            <label id="currentAge"></label>
            <input id="ageInput"  name="ageInput" type="number" pattern="\d*">
            <br/>
            <label for="homeTown">Home town: </label>
            <label id="currentHomeTown"></label>
            <input type="text" name="homeTown" id="homeTown"/>
            <input type="submit" value="Update profile with entered data">
        </form>
        <%
            String errorMessage = request.getParameter("errorString");
            if(errorMessage != null){
        %>
            <br>
            <span style="color:red"><%out.print(errorMessage);%></span>
        <%

            }
        %>


        <%
            String successMessage = request.getParameter("successMessage");
            if(successMessage != null){
        %>
        <br>
        <span><%out.print(successMessage);%></span>
        <br>
        <%

            }
        %>
        <button class="btn btn-danger" onclick="location.href='/components/mainPage.jsp'" type="button">
            Return to main page!</button>

    </main>



    <script>
        $(document).ready(function (){
            console.log("ready");
            getUserProfile(<%out.print("\'"+user.getId().toString()+"\'");%>);
        });
    </script>

<%
    }
%>

</body>
</html>
