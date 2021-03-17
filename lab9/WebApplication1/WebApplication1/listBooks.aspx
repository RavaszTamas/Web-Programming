<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="listBooks.aspx.cs" Inherits="WebApplication1.listStudents" %>
<%@ Import Namespace="WebApplication1.Models" %>  

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="head1" runat="server">
    <title>Book list</title>

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
        <form runat="server">
            <asp:button id="btnCancel" runat="server" CssClass="btn btn-danger" text="Go back" OnClick="btnCancel_Click" /> 
        </form>
        <form>
            Genre: <input type="text" onkeyup="getGenres(this.value)"/>
        </form>

        <div id="tablediv" class="container" runat="server"></div>
    </main>
    <% }
        else {%>
     <main class="container has-error alert">
         <p>
             Invalid session, terminating.
         </p>
     </main>
    <%  Response.Redirect("index.aspx");
        } %>
</body>
</html>
