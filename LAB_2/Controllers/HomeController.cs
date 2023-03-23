using LAB_2.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace LAB_2.Controllers
{
    public class HomeController : Controller
    {
        MainContext MainContext;
        public ActionResult Index()
        {
/*            List<Goods> goodsList = new List<Goods>();
            using (MainContext = new MainContext())
            {
                //List<Goods> goodsList = new List<Goods>();
                goodsList = MainContext.Goods.ToList();
            }*/
            return View(/*goodsList*/);
        }


        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}