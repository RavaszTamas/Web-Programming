<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookDetail.aspx.cs" Inherits="WebApplication1.BookDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Book details</title>
    <link href="Content/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/lab9.js"></script>

</head>
<body>
<% 
    if (Session["user"] != null && selectedBook != null)
    {  %>

    <form id="form1" class="container" runat="server">
    <div>
        <div class="form-group">
            <label> Author:</label>
            <asp:Label runat="server" ID="AuthorLabel" Text='<%#selectedBook.author%>'></asp:Label>
            <asp:TextBox ID="authorBox" Text='<%#selectedBook.author%>' runat="server" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="authorReqValidator" ValidationGroup="updateParameters" ControlToValidate="authorBox" ErrorMessage="<br/> Please enter an author"  Display="Dynamic" ForeColor="Red" runat="server"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="authorRegexValidator" ValidationExpression="^[a-zA-Z0-9 ]*$" ValidationGroup="updateParameters" ControlToValidate="authorBox" ErrorMessage="<br/> The author must use valid characters" Display="Dynamic" ForeColor="Red" runat="server"></asp:RegularExpressionValidator>
        </div>
        <div class ="form-group">
            <label> Title:</label>
            <asp:Label runat="server" ID="TitleLabel" Text='<%#selectedBook.title%>'></asp:Label>
            <asp:TextBox ID="titleBox" Text='<%#selectedBook.title%>' runat="server" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="titleReqValidator" ValidationGroup="updateParameters" ControlToValidate="titleBox" ErrorMessage="<br/> Please enter a title"  Display="Dynamic" ForeColor="Red" runat="server"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="titleRegexValidator" ValidationExpression="^[a-zA-Z0-9 ]*$" ValidationGroup="updateParameters" ControlToValidate="titleBox" ErrorMessage="<br/> The title must use valid characters" Display="Dynamic" ForeColor="Red" runat="server"></asp:RegularExpressionValidator>

        </div>
        <div class ="form-group">
            <label> Genre:</label>
            <asp:Label runat="server" ID="GenreLabel" Text='<%#selectedBook.genre%>'></asp:Label>
            <asp:TextBox ID="genreBox" Text='<%#selectedBook.genre%>' runat="server" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="genreReqValidator" ValidationGroup="updateParameters" ControlToValidate="genreBox" ErrorMessage="<br/> Please enter a genre"  Display="Dynamic" ForeColor="Red" runat="server"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="genreRegexValidator" ValidationExpression="^[a-zA-Z0-9 ]*$" ValidationGroup="updateParameters" ControlToValidate="genreBox" ErrorMessage="<br/> The genre must use valid characters" Display="Dynamic" ForeColor="Red" runat="server"></asp:RegularExpressionValidator>

        </div>
        <div class ="form-group">
            <label> Pages:</label>
            <asp:Label runat="server" ID="PagesLabel" Text='<%#selectedBook.pages%>'></asp:Label>
            <asp:TextBox ID="pagesBox" Text='<%#selectedBook.pages%>' type="number" runat="server" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="pagesReqValidator" ValidationGroup="updateParameters" ControlToValidate="pagesBox" ErrorMessage="<br/> Please enter a page number"  Display="Dynamic" ForeColor="Red" runat="server"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="pagesRegexValidator" ValidationExpression="^[0-9]*$" ValidationGroup="updateParameters" ControlToValidate="pagesBox" ErrorMessage="<br/> The page number must be a positive integer" Display="Dynamic" ForeColor="Red" runat="server"></asp:RegularExpressionValidator>

        </div>
        <asp:Button ID="submitButton" runat="server" ValidationGroup="updateParameters" CausesValidation="true" CssClass="btn btn-success" Text="Update book" OnClick="submitButton_Click" />
        <asp:button id="btnCancel" runat="server" CssClass="btn btn-danger" text="Go back" OnClick="btnCancel_Click" /> 
        <asp:Label ID="errorMessagelabel" runat="server"></asp:Label>

    </div>
    </form>
    <%}
        else {
            Response.Redirect("index.aspx");
        } %>
</body>
</html>
