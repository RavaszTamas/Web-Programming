using System;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using lab9.Models;
using MySql.Data.MySqlClient;

namespace lab9.DataAbstractionLayer
{
    public class DAL
    {
        public List<Book> GetBooksFormGroup(int page_count)
        {
            MySql.Data.MySqlClient.MySqlConnection conn;

            string myConnectionString;

            myConnectionString = "server=localhost;uid=ubbstudent;pwd=forclasspurposes;database=web_lab7_books";
            List<Book> booklist = new List<Book>();

            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select * from books where pages=" + page_count;
                MySqlDataReader myreader = cmd.ExecuteReader();

                while (myreader.Read())
                {
                    Book book = new Book();
                    book.ID = myreader.GetInt32("ID");
                    book.author = myreader.GetString("author");
                    book.title = myreader.GetString("title");
                    book.genre = myreader.GetString("genre");
                    book.pages = myreader.GetInt32("pages");

                    booklist.Add(book);
                }
                myreader.Close();


            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);

            }

            return booklist;

        }
    }
}