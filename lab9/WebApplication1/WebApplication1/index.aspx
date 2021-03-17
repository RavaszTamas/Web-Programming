<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="WebApplication1.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Book manager</title>
    <link href="Content/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/lab9.js"></script>

</head>
<body>
    <%if (Session["user"] == null)
            { %>
    <div class="container">
        <form action="login.aspx">
            <input class="btn btn-success" type="submit" value="Login"/>
        </form>
        <form action="register.aspx">
            <input class="btn btn-success" type="submit" value="Register new user"/>
        </form>
    </div>
   <% }
        else {
           Response.Redirect("mainPage.aspx");
        } %>

</body>
</html>
