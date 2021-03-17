using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication1.Models
{
    public class Book
    {
        public int ID { get; set; }
        public string author { get; set; }
        public string genre { get; set; }
        public string title { get; set; }
        public int pages { get; set; }


        public Book(int ID, string author, string genre, string title, int pages)
        {
            this.ID = ID;
            this.author = author;
            this.genre = genre;
            this.title = title;
            this.pages = pages;

        }
        public Book()
        {
            this.ID = -1;
            this.author = "";
            this.genre = "";
            this.title = "";
            this.pages = -1;
        }

    }
}