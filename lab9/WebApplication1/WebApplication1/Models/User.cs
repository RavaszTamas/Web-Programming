using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication1.Models
{
    public class User
    {
        public int userID { get; set; }
        public string username { get; set; }
        public string password { get; set; }

        public User(int userID, string username, string password)
        {
            this.userID = userID;
            this.username = username;
            this.password = password;

        }

        public User()
        {
        }

    }
}