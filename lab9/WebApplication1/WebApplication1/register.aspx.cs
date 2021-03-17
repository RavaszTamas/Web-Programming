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
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] != null)
            {
                Response.Redirect("mainPage.aspx");
            }

        }

        protected void submitButton_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {

                if (Page.IsValid)
                {

                    User theUser=registerUser(usernameBox.Text, passwordBox.Text, repeatPasswordBox.Text);
                    if(theUser != null)
                    {
                        Session["user"] = theUser;
                        Response.Redirect("mainPage.aspx");
                    }
                    else
                    {
                        errorMessagelabel.Text = "Registration failed! Maybe use a different username!";
                    }
                   
                }
            }
        }

        private User registerUser(string username, string password, string repeatedPassword)
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=;database=web_lab7_books;";
            User theUser = null;

            byte[] data = System.Text.Encoding.ASCII.GetBytes(password);
            data = new System.Security.Cryptography.SHA256Managed().ComputeHash(data);
            password = System.Text.Encoding.ASCII.GetString(data);

            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();


                using (MySqlCommand cmd = new MySqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandType = System.Data.CommandType.Text;
                    cmd.CommandText = "INSERT INTO users (`username`,`password`) VALUES (@param1,@param2)";
                    cmd.Parameters.AddWithValue("@param1", username);
                    cmd.Parameters.AddWithValue("@param2", password);

                    try
                    {
                        cmd.ExecuteNonQuery();
                        cmd.CommandText = "select * from users where username = '" + username + "' AND password = '" + password + "'";
                        MySqlDataReader myreader = cmd.ExecuteReader();

                        if (myreader.Read())
                        {
                            int userID = myreader.GetInt32(0);
                            string inputUsername = myreader.GetString(1);
                            string inputPassword = myreader.GetString(2);
                            theUser = new User();
                            theUser.userID = userID;
                            theUser.username = inputUsername;
                            theUser.password = inputPassword;

                        }

                        myreader.Close();


                    }
                    catch (MySqlException ex)
                    {
                        theUser = null;
                    }
                    

                }


            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {

                theUser = null;

            }
            return theUser;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("index.aspx");
        }
    }
}