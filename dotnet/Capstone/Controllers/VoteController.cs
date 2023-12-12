using Microsoft.AspNetCore.Mvc;

namespace Capstone.Controllers
{
    public class VoteController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
