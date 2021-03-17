using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication1.Models;

namespace WebApplication1
{
    public partial class login : System.Web.UI.Page
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
            System.Diagnostics.Debug.WriteLine("Clicked submit login");

            if (IsPostBack)
            {
                System.Diagnostics.Debug.WriteLine("Entered login logic");
                if (Page.IsValid)
                {
                    //Do next necessary steps.
                    string errorMessage = this.validateInput(usernameBox.Text, passwordBox.Text);
                    System.Diagnostics.Debug.WriteLine("Login validation finished");

                    if (errorMessage.Length > 0)
                    {
                        errorMessagelabel.Text = errorMessage;
                        
                    }
                    else
                    {
                        User theUser = performLogin(usernameBox.Text, passwordBox.Text);
                        if (theUser != null)
                        {
                            Session["user"] = theUser;
                            Response.Redirect("mainPage.aspx");
                        }
                        else
                        {
                            errorMessagelabel.Text = "Login failed, maybe use a different username and/or password";

                        }
                    }
                }
            }
        }


        protected User performLogin(string username, string password)
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


                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;

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
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                theUser = null;
            }
            return theUser;

        }
        protected string validateInput(string username, string password)
        {
            string errorMessage = "";

            if (string.IsNullOrEmpty(username))
            {
                errorMessage += "Username must have a value. ";
            }
            else {
                Regex regex = new Regex(@"^[a-zA-Z0-9]*$");
                Match match = regex.Match(username);
                if (!match.Success)
                {
                    errorMessage += "Username must use valid characters";
                }
            }

            if (string.IsNullOrEmpty(password))
            {
                errorMessage += "Password must have a value. ";
            }
            else {
                Regex regex = new Regex(@"^[a-zA-Z0-9]*$");
                Match match = regex.Match(password);
                if (!match.Success)
                {
                    errorMessage += "Password must use valid characters";
                }
            }
            /*
            if (string.IsNullOrEmpty(passwordRepeat))
            {
                errorMessage += "Password must have a value. ";
            }
            else {
                Regex regex = new Regex(@"^[a-zA-Z0-9]*$");
                Match match = regex.Match(passwordRepeat);
                if (!match.Success)
                {
                    errorMessage += "Password must use valid characters";
                }
            }
            */


            return errorMessage;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("index.aspx");

        }
    }
}