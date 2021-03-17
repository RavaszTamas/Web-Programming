<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="mainPage.aspx.cs" Inherits="WebApplication1.mainPage" %>
<%@ Import Namespace="WebApplication1.Models" %>  

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Main page</title>
    <link href="Content/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/lab9.js"></script>

</head>
<body>
    <% if (Session["user"] != null)
        { %>

    <header class="page-header">
        <div class="container">
        <%
    User theUser = (User)Session["user"];
    Response.Write("<label class=\"label label-default\">Welcome " + theUser.username + "!</label>");
             %>
        </div>
    </header>
    <main class="container">
        <label>Menu:</label>
        <form action="listBooks.aspx" method="post">
            <input type="submit" class="btn btn-success" value="List all books"/>
        </form>
        <br />
        <form action="AddBook.aspx" method="post">
            <input type="submit" class="btn btn-danger" value="Add new book"/>
        </form>
        <br />
        <form action="MakeRental.aspx" method="post">
            <input type="submit" class="btn btn-success" value="Rent a book"/>
        </form>

        <br />
        <form action="logout.aspx" method="post">
            <input type="submit" class="btn btn-danger" value="Logout"/>
        </form>

    </main>
        <%}
    else { %>
    <main class="container has-error alert">
        <p>
            Invalid session, terminating.
        </p>
    </main>
    <%} %>

</body>
</html>
