using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace lab9.Models
{
    public class Book
    {
        public int ID { get; set; }
        public string author { get; set; }
        public string title { get; set; }
        public string genre { get; set; }
        public int pages { get; set; }

    }
}