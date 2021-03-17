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
    public partial class MakeRental : System.Web.UI.Page
    {
        public List<Book> booksList;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.readBooks();
            }


        }

        private void readBooks()
        {
            //Session["user"] = new User(1,"testUser","testPassword");
            booksList = new List<Book>();
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
                cmd.CommandText = "SELECT * FROM `books` WHERE `books`.`ID` NOT IN ( SELECT `books`.`ID` FROM `books` INNER JOIN `user_rentals` WHERE `user_rentals`.`book_id`=`books`.`ID` AND `user_rentals`.`date_due` > DATE(NOW()) )";
                MySqlDataReader myreader = cmd.ExecuteReader();



                int row = 0;
                while (myreader.Read())
                {
                    booksList.Add(new Book(myreader.GetInt32(0), myreader.GetString(1), myreader.GetString(2), myreader.GetString(3), myreader.GetInt32(4)));
                }

                myreader.Close();

            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {

                Response.Write(ex.Message);

            }
            RowRepeater.DataSource = booksList;
            RowRepeater.DataBind();
        }

        protected void RowRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            /*
            RepeaterItem item = e.Item;
            if((item.ItemType == ListItemType.Item) || (item.ItemType == ListItemType.AlternatingItem))
            {
                Repeater repeater = e.Item.FindControl
            }
            */
        }

        protected void rentBookButton_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandArgument != null)
            {
                this.AddRental(int.Parse(e.CommandArgument.ToString()));
            }
        }

        private void AddRental(int bookID)
        {
            User theUser = (User)Session["user"];

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
                cmd.CommandText = "INSERT INTO `user_rentals` VALUES (@paramUserID,@paramBookID,@paramDateRented,@paramDueDate)";
                cmd.Parameters.AddWithValue("@paramUserID", theUser.userID);
                cmd.Parameters.AddWithValue("@paramBookID", bookID);
                cmd.Parameters.AddWithValue("@paramDateRented", DateTime.Now.ToString("yyyy-MM-dd"));
                DateTime nextWeek = DateTime.Now;
                nextWeek = nextWeek.AddDays(7);
                cmd.Parameters.AddWithValue("@paramDueDate", nextWeek.ToString("yyyy-MM-dd"));

                cmd.ExecuteNonQuery();

            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {

                Response.Write(ex.Message);

            }
            this.readBooks();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("index.aspx");
        }
    }
}