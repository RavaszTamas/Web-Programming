<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MakeRental.aspx.cs" Inherits="WebApplication1.MakeRental" %>
<%@ Import Namespace="WebApplication1.Models" %>  

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Make a new rental</title>
    <link href="Content/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/lab9.js"></script>
    <script>
        function deleteRow(rowID) {
            var table = document.getElementById("mainTable");
            var row = document.getElementById(row);
            table.deleteRow(row.rowIndex);

        }
    </script>
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

    <form id="form1" runat="server">
    <div class="container">
        <asp:button id="btnCancel" runat="server" CssClass="btn btn-danger" text="Go back" OnClick="btnCancel_Click" /> 

        <table class="table" id="mainTable">
            <tr>
                <th>Author</th>
                <th>Title</th>
                <th>Genre</th>
                <th>Pages</th>
                <th></th>
            </tr>
            <asp:Repeater ID="RowRepeater" runat="server">
                <ItemTemplate>
                        <tr>
                            <td><%#Eval("author")%></td>
                            <td><%#Eval("title")%></td>
                            <td><%#Eval("genre")%></td>
                            <td><%#Eval("pages")%></td>
                            <td> <asp:Button runat="server" ID="rentBookButton"  CommandArgument='<%#Eval("ID")%>' Text="Rent" CssClass="btn btn-success" OnCommand="rentBookButton_Command"/></td>
                        </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </div>
    </form>
    <%}
        else {
            Response.Redirect("index.aspx");
        } %>
</body>
</html>
