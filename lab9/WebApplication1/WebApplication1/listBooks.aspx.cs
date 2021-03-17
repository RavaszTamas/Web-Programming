using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.Models;

namespace WebApplication1
{
    public partial class listStudents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["user"] = new User(1,"testUser","testPassword");
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=;database=web_lab7_books;";

            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select * from books";
                MySqlDataReader myreader = cmd.ExecuteReader();

                
                
                tablediv.InnerHtml = "<table id=\"mainTableBooks\" class=\"table table-bordered table-striped mb-0\"><thead><tr><th style=\"width: 25% \" >author</th><th style=\"width: 25% \">title</th><th style=\"width: 20% \">genre</th><th style=\"width: 20% \" >pages</th><th style=\"width: 5% \" ></th><th style=\"width: 5% \" ></th></tr></thead><tbody>";
                int row = 0;
                while (myreader.Read())
                {
                    tablediv.InnerHtml += "<tr id=\'row-" + row + "\'>" + 
                        "<td>" + myreader.GetString(1) + "</td>" + 
                        "<td>" + myreader.GetString(2) + "</td>" + 
                        "<td>" + myreader.GetString(3) + "</td>" + 
                        "<td>" + myreader.GetInt32(4) + "</td>"+ 
                        "<td>"+
                        "<input type=\"button\" class=\"btn btn-success\" value=\"Delete\" onclick=\"deleteBook("+ myreader.GetInt32(0)+ ",\'row-" + row + "\')\"/>"+
                        "</td>" +
                        "<td>" + "<a class=\"btn btn-success\" href=\"BookDetail.aspx?bookID=" + myreader.GetInt32(0) + "\">Details</a>" + "</td>" +
                        "</tr>";
                    row++;
                }
                tablediv.InnerHtml += "</tbody></table>";
               
                myreader.Close();
                
            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {

                Response.Write(ex.Message);

            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("index.aspx");
        }
    }
}