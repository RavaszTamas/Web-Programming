using lab9.DataAbstractionLayer;
using lab9.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace lab9.Controllers
{
    public class BooksController : Controller
    {
        // GET: Books
        public ActionResult Index()
        {
            // return View();
            return View("FilterBooks");

        }

        public string Test()
        {
            return "It's working";
        }

        public string GetBooksFormGroup()
        {
            int pageCount = int.Parse(Request.Params["pages_count"]);
            DAL dal = new DAL();

            List<Book> booksList = dal.GetBooksFormGroup(pageCount);

            ViewData["booksList"] = booksList;

            string result = "<table class=\"table\" ><thead><th>ID</th><th>Author</th><th>Title</th><th>Genre</th><th>Pages</th></thead><tbody>";

            foreach( Book book in booksList)
            {
                result += "<tr><td>" + book.ID + "</td><td>" + book.author + "</td><td>" + book.title + "</td><td>" + book.genre + "</td><td>" + book.pages + "</td>";
            }

            result += "</tbody></table>";
            return result;

        }

    }
}