<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddBook.aspx.cs" Inherits="WebApplication1.AddBook" %>
<%@ Import Namespace="WebApplication1.Models" %>  

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add new book</title>
    <link href="Content/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/lab9.js"></script>


</head>
<body>
     <%if (Session["user"] != null)
         { %>
    <header class="page-header">
        <div class="container">
        <%
            User theUser = (User)Session["user"];
            Response.Write("<label class=\"label label-default\">Welcome " + theUser.username + "!</label>");
             %>
        </div>
    </header>

    <form id="form1" class="container" runat="server">
    <div>
        <div class="form-group">
            <label> Author:</label>
            <asp:TextBox ID="authorBox" runat="server" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="authorReqValidator" ValidationGroup="addParameters" ControlToValidate="authorBox" ErrorMessage="<br/> Please enter an author"  Display="Dynamic" ForeColor="Red" runat="server"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="authorRegexValidator" ValidationExpression="^[a-zA-Z0-9 ]*$" ValidationGroup="addParameters" ControlToValidate="authorBox" ErrorMessage="<br/> The author must use valid characters" Display="Dynamic" ForeColor="Red" runat="server"></asp:RegularExpressionValidator>
        </div>
        <div class ="form-group">
            <label> Title:</label>
            <asp:TextBox ID="titleBox" runat="server" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="titleReqValidator" ValidationGroup="addParameters" ControlToValidate="titleBox" ErrorMessage="<br/> Please enter a title"  Display="Dynamic" ForeColor="Red" runat="server"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="titleRegexValidator" ValidationExpression="^[a-zA-Z0-9 ]*$" ValidationGroup="addParameters" ControlToValidate="titleBox" ErrorMessage="<br/> The title must use valid characters" Display="Dynamic" ForeColor="Red" runat="server"></asp:RegularExpressionValidator>

        </div>
        <div class ="form-group">
            <label> Genre:</label>
            <asp:TextBox ID="genreBox"  runat="server" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="genreReqValidator" ValidationGroup="addParameters" ControlToValidate="genreBox" ErrorMessage="<br/> Please enter a genre"  Display="Dynamic" ForeColor="Red" runat="server"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="genreRegexValidator" ValidationExpression="^[a-zA-Z0-9 ]*$" ValidationGroup="addParameters" ControlToValidate="genreBox" ErrorMessage="<br/> The genre must use valid characters" Display="Dynamic" ForeColor="Red" runat="server"></asp:RegularExpressionValidator>

        </div>
        <div class ="form-group">
            <label> Pages:</label>
            <asp:TextBox ID="pagesBox" type="number" runat="server" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="pagesReqValidator" ValidationGroup="addParameters" ControlToValidate="pagesBox" ErrorMessage="<br/> Please enter a page number"  Display="Dynamic" ForeColor="Red" runat="server"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="pagesRegexValidator" ValidationExpression="^[0-9]*$" ValidationGroup="addParameters" ControlToValidate="pagesBox" ErrorMessage="<br/> The page number must be a positive integer" Display="Dynamic" ForeColor="Red" runat="server"></asp:RegularExpressionValidator>

        </div>
        <asp:Button ID="submitButton" runat="server" ValidationGroup="addParameters" CausesValidation="true" CssClass="btn btn-success" Text="Add book" OnClick="submitButton_Click" />
        <asp:button id="btnCancel" runat="server" CssClass="btn btn-danger" text="Go back" OnClick="btnCancel_Click" /> 
        <asp:Label ID="errorMessagelabel" runat="server"></asp:Label>

    </div>
    </form>    <%} %>
</body>
</html>
