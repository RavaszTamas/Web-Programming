<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="WebApplication1.register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register new user</title>
    <link href="Content/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/lab9.js"></script>


</head>
<body>
    <form id="form1" class="container" runat="server">
    <div>
        <div class ="form-group">
            <asp:Label ID="UsernameLabel" Text="Username:" AssociatedControlID="usernameBox" runat="server"></asp:Label>
            <asp:TextBox ID="usernameBox" runat="server" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="usernameReqValidator" ValidationGroup="registerParameters" ControlToValidate="usernameBox" ErrorMessage="<br/> Please enter a username"  Display="Dynamic" ForeColor="Red" runat="server"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="usernameRegexValidator" ValidationExpression="^[a-zA-Z0-9]*$" ValidationGroup="registerParameters" ControlToValidate="usernameBox" ErrorMessage="<br/> The username must use valid characters" Display="Dynamic" ForeColor="Red" runat="server"></asp:RegularExpressionValidator>
        </div>
        <div class="form-group">
            <asp:Label ID="passwordLabel" Text="Password:" AssociatedControlID="passwordBox" runat="server"></asp:Label>
            <asp:TextBox ID="passwordBox" runat="server" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="passwordReqValidator" ValidationGroup="registerParameters" ControlToValidate="passwordBox" ErrorMessage="<br/> Please enter a password"  Display="Dynamic" ForeColor="Red" runat="server"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="passwordRegexValidator" ValidationExpression="^[a-zA-Z0-9]*$" ValidationGroup="registerParameters" ControlToValidate="passwordBox" ErrorMessage="<br/> The password must use valid characters" Display="Dynamic" ForeColor="Red" runat="server"></asp:RegularExpressionValidator>
        </div>   
        <div class="form-group">
            <asp:Label ID="repeatPasswordLabel" Text="Repeat password:" AssociatedControlID="repeatPasswordBox" runat="server"></asp:Label>
            <asp:TextBox ID="repeatPasswordBox" runat="server" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="repeatPasswordReqValidator" ValidationGroup="registerParameters" ControlToValidate="repeatPasswordBox" ErrorMessage="<br/> Please enter a password"  Display="Dynamic" ForeColor="Red" runat="server"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="repeatPasswordRegexValidator" ValidationExpression="^[a-zA-Z0-9]*$" ValidationGroup="registerParameters" ControlToValidate="repeatPasswordBox" ErrorMessage="<br/> The password must use valid characters" Display="Dynamic" ForeColor="Red" runat="server"></asp:RegularExpressionValidator>
            <asp:CompareValidator ID="repeatPasswordCompareVlidator" ValidationGroup="registerParameters" ControlToCompare="passwordBox" ControlToValidate="repeatPasswordBox" ErrorMessage="<br/> The must be the same as the password" Display="Dynamic" ForeColor="Red" runat="server"></asp:CompareValidator>
        </div>   

        <asp:Button ID="submitButton" runat="server" ValidationGroup="registerParameters" CausesValidation="true" CssClass="btn btn-success" Text="Register the user" OnClick="submitButton_Click"/>
        <asp:button id="btnCancel" runat="server" CssClass="btn btn-danger" text="Go back" OnClick="btnCancel_Click" /> 
        <br />
        <asp:Label ID="errorMessagelabel" CssClass="label label-danger" runat="server" ForeColor="White" BackColor="Red"></asp:Label>

    </div>
    </form>
</body>
</html>
