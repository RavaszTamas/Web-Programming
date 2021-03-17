<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WebApplication1.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login user</title>
    <link href="Content/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/lab9.js"></script>

</head>
<body>
    <form class="container" id="form1" runat="server">
        <div class ="form-group">
            <asp:Label ID="UsernameLabel" Text="Username:" AssociatedControlID="usernameBox" runat="server"></asp:Label>
            <asp:TextBox ID="usernameBox" runat="server" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="usernameReqValidator" ValidationGroup="loginParameters" ControlToValidate="usernameBox" ErrorMessage="<br/> Please enter a username"  Display="Dynamic" ForeColor="Red" runat="server"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="usernameRegexValidator" ValidationExpression="^[a-zA-Z0-9]*$" ValidationGroup="loginParameters" ControlToValidate="usernameBox" ErrorMessage="<br/> The username must use valid characters" Display="Dynamic" ForeColor="Red" runat="server"></asp:RegularExpressionValidator>
        </div>
        <div class="form-group">
            <asp:Label ID="passwordLabel" Text="Password:" AssociatedControlID="passwordBox" runat="server"></asp:Label>
            <asp:TextBox ID="passwordBox" runat="server" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="passwordReqValidator" ValidationGroup="loginParameters" ControlToValidate="passwordBox" ErrorMessage="<br/> Please enter a password"  Display="Dynamic" ForeColor="Red" runat="server"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="passwordRegexValidator" ValidationExpression="^[a-zA-Z0-9]*$" ValidationGroup="loginParameters" ControlToValidate="passwordBox" ErrorMessage="<br/> The password must use valid characters" Display="Dynamic" ForeColor="Red" runat="server"></asp:RegularExpressionValidator>
        </div>
        
        <asp:Button ID="submitButton" runat="server" ValidationGroup="loginParameters" CausesValidation="true" CssClass="btn btn-success" Text="Login user" OnClick="submitButton_Click" />
        <asp:button id="btnCancel" runat="server" CssClass="btn btn-danger" text="Go back" OnClick="btnCancel_Click" /> 
        <br />
        <asp:Label ID="errorMessagelabel" CssClass="label label-danger" runat="server" ForeColor="White" BackColor="Red"></asp:Label>
    </form>
</body>
</html>

