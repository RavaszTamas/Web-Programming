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
    public partial class BookDetail : System.Web.UI.Page
    {
        public Book selectedBook;
        public string asd = "1";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                int dummy;
                if (Request.QueryString["bookID"] != null && int.TryParse(Request.QueryString["bookID"], out dummy))
                {
                    int bookID = int.Parse(Request.QueryString["bookID"]);
                    this.selectedBook = loadBook(bookID);
                    Session["selectedBook"] = this.selectedBook;
                    DataBind();
                }
            }
        }

        private void updateBook()
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

                cmd.CommandText = "UPDATE books SET author=@authorParam, title=@titleParam, genre=@genreParam, pages=@pages WHERE ID=@paramId";
                cmd.Parameters.AddWithValue("@authorParam", authorBox.Text);
                cmd.Parameters.AddWithValue("@titleParam", titleBox.Text);
                cmd.Parameters.AddWithValue("@genreParam", genreBox.Text);
                cmd.Parameters.AddWithValue("@pages", int.Parse(pagesBox.Text));
                cmd.Parameters.AddWithValue("@paramId", selectedBook.ID);


                cmd.ExecuteNonQuery();
                errorMessagelabel.Text = "Update successfull";
                AuthorLabel.Text = authorBox.Text;
                TitleLabel.Text = titleBox.Text;
                GenreLabel.Text = genreBox.Text;
                PagesLabel.Text = pagesBox.Text;


            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                errorMessagelabel.Text = "Update failed: Reason:" + ex.Message;
            }
        }

        private Book loadBook(int bookID)
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=;database=web_lab7_books;";
            Book theBook = new Book();
            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();


                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;

                cmd.CommandText = "select * from books where ID =" + bookID;
                MySqlDataReader myreader = cmd.ExecuteReader();

                if (myreader.Read())
                {
                    int ID = myreader.GetInt32(0);
                    string author = myreader.GetString(1);
                    string genre = myreader.GetString(2);
                    string title = myreader.GetString(3);
                    int pages = myreader.GetInt32(4);

                    theBook = new Book();
                    theBook.ID = ID;
                    theBook.author = author;
                    theBook.genre = genre;
                    theBook.title = title;
                    theBook.pages = pages;

                }

                myreader.Close();

            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                theBook = new Book();
            }
            return theBook;
        }

        protected void submitButton_Click(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("Clicked submit login");

            if (IsPostBack)
            {
                System.Diagnostics.Debug.WriteLine("Entered login logic");
                if (Page.IsValid)
                {
                    System.Diagnostics.Debug.WriteLine("Login validation finished");
                    if (Session["selectedBook"] != null)
                    {
                        this.selectedBook = (Book)Session["selectedBook"];
                        this.updateBook();
                    }
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Session["selectedBook"] = null;
            Response.Redirect("listBooks.aspx");
        }
    }
}