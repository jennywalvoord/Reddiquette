using Capstone.DAO;
using Capstone.Exceptions;
using Capstone.Models;
using Microsoft.AspNetCore.Mvc;

namespace Capstone.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class VoteController : Controller
    {
        private readonly IVotesDao votesDao;

        [HttpGet("/post/{id}")]
        public IActionResult GetAllPostVotesById(int id)
        {
            try
            {
                var votes = votesDao.GetAllPostVotesById(id);
                return Ok(votes);
            }
            catch(DaoException e)
            {
                return StatusCode(404, $"Failed to retrieve votes: {e.Message}");
            }
        }
        [HttpGet("/comment/{id}")]
        public IActionResult GetAllCommentVotesById(int id)
        {
            try
            {
                var votes = votesDao.GetAllCommentVotesById(id);
                return Ok(votes);
            }
            catch (DaoException e)
            {
                return StatusCode(404, $"Failed to retrieve votes: {e.Message}");
            }
        }
        [HttpPost("/post")]
        public Vote CreatePostVote(int userId, int targetID, int increment)
        {
                var createdVote = votesDao.CreatePostVote(userId, targetID, increment);
                return createdVote;
        }
        [HttpPost("/comment")]
        public Vote CreateCommentVote(int userId, int targetID, int increment)
        {
            var createdVote = votesDao.CreateCommentVote(userId, targetID, increment);
            return createdVote;
        }
        [HttpPut("/comment/{id}")]
        public Vote UpdateCommentVote(int userId, int targetID, int increment)
        {
            var updatedVote = votesDao.UpdateCommentVote(userId,targetID, increment);
            return updatedVote;
        }
        [HttpPut("/post/{id}")]
        public Vote UpdatePostVote(int userId, int targetID, int increment)
        {
            var updatedVote = votesDao.UpdatePostVote(userId, targetID, increment);
            return updatedVote;
        }
    }

}
