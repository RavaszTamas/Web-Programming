using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class filter : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {            
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;
            string response = "";

            myConnectionString = "server=localhost;uid=root;pwd=;database=web_lab7_books;";
            try
            {
                string parameterGenre = Request.QueryString["stringToFilterBy"];
                parameterGenre = parameterGenre.Trim();
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                if(parameterGenre == "")
                    cmd.CommandText = "select * from books";
                else
                    cmd.CommandText = "SELECT * FROM `books` where genre LIKE '%" + parameterGenre + "%'";
                MySqlDataReader myreader = cmd.ExecuteReader();
                response += "<table id=\"mainTableBooks\" class=\"table table-bordered table-striped mb-0\"><thead><tr><th style=\"width: 25% \" >author</th><th style=\"width: 25% \">title</th><th style=\"width: 20% \">genre</th><th style=\"width: 20% \" >pages</th><th style=\"width: 5% \" ></th><th style=\"width: 5% \" ></th></tr></thead><tbody>";
                int row = 0;

                while (myreader.Read())
                {
                    response += "<tr id=\'row-"+row + "\'>" + 
                        "<td>" + myreader.GetString(1) + "</td>" + 
                        "<td>" + myreader.GetString(2) + "</td>" + 
                        "<td>" + myreader.GetString(3) + "</td>" + 
                        "<td>" + myreader.GetInt32(4) + "</td>" +
                        "<td>"+
                        "<input type=\"button\" class=\"btn btn-success\" value=\"Delete\" onclick=\"deleteBook(" + myreader.GetInt32(0) + ",\'row-" + row + "\')\"/>"+ 
                        "</td>" +
                        "<td>" + "<a class=\"btn btn-success\" href=\"BookDetail.aspx?bookID="+myreader.GetInt32(0)+"\">Details</a>" + "</td>"
                        +"</tr>";
                    row++;

                }
                response += "</tbody><table>";
                myreader.Close();
            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {

                response = "<table class=\"table\"><thead><tr><th>No results</th></tr></thead><tbody></tbody><table>";
                //Response.Write(ex.Message);

            }
            Response.Write(response);
            Response.Flush();

        }
    }
}