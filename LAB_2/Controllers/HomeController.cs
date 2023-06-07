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
        MainContext mainContext = new MainContext();
        MainContext MainContext;
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ShowOrders(string startDate, string endDate) {


           // string startDate = "2019-01-01";
           // string endDate = "2022-02-02";
            System.Data.SqlClient.SqlParameter startDateParam = new System.Data.SqlClient.SqlParameter("@sqlStartDateParam", startDate);
            System.Data.SqlClient.SqlParameter endDateParam = new System.Data.SqlClient.SqlParameter("@sqlEndDateParam", endDate);
            List<Orders> orders = new List<Orders>();
            orders = mainContext.Orders.SqlQuery("Select * from Orders Where orderDate between @sqlStartDateParam and @sqlEndDateParam ", startDateParam, endDateParam).ToList();
            return View(orders);
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