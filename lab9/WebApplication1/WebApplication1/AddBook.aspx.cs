using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class AddBook : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void submitButton_Click(object sender, EventArgs e)
        {
            if (IsPostBack && IsValid)
            {
                this.performAddBook();
            }
        }

        private void performAddBook()
        {
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

                cmd.CommandText = "INSERT INTO `books` (`author`, `title`, `genre`, `pages`) VALUES (@authorParam, @titleParam, @genreParam, @pages)";
                cmd.Parameters.AddWithValue("@authorParam", authorBox.Text);
                cmd.Parameters.AddWithValue("@titleParam", titleBox.Text);
                cmd.Parameters.AddWithValue("@genreParam", genreBox.Text);
                cmd.Parameters.AddWithValue("@pages", int.Parse(pagesBox.Text));


                cmd.ExecuteNonQuery();
                errorMessagelabel.Text = "Addition successfull";
                errorMessagelabel.ForeColor = System.Drawing.Color.White;
                errorMessagelabel.BackColor = System.Drawing.Color.Green;
            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                errorMessagelabel.Text = "Addition failed: Reason:" + ex.Message;
                errorMessagelabel.ForeColor = System.Drawing.Color.White;
                errorMessagelabel.BackColor = System.Drawing.Color.Red;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("mainPage.aspx");
        }
    }
}