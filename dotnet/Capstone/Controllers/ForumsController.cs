using Microsoft.AspNetCore.Mvc;
using Capstone.DAO;
using Capstone.Exceptions;
using Capstone.Models;
using Capstone.Security;

namespace Capstone.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ForumsController : ControllerBase
    {
        private readonly IForumDao forumDao;

        public ForumsController(IForumDao forumDao)
        {
            this.forumDao = forumDao;
        }
        [HttpGet]
        public IActionResult GetAllForums()
        {
            try
            {
                var forums = forumDao.GetAllForums();
                return Ok(forums);
            }
            catch (DaoException e)
            {
                return StatusCode(500, $"Failed to retrieve forums: {e.Message}");
            }

        }
        [HttpGet("{id}")]
        public IActionResult GetForumById(int id)
        {
            try
            {
                var forum = forumDao.FindForumByID(id);
                if (forum == null)
                {
                    return NotFound($"No forum found with ID {id}.");
                }
                return Ok(forum);
            }
            catch (DaoException e)
            {
                return StatusCode(500, $"Failed to find forum by ID {id}: {e.Message}");
            }
        }
        [HttpPost]
        public IActionResult CreateForum(Forum forum)
        {
            try
            {
                var createdForum = forumDao.CreateForum(forum);
                return CreatedAtAction(nameof(GetForumById), new { id = createdForum.ForumId }, createdForum);
            }
            catch (DaoException e)
            {
                return StatusCode(500, $"Failed to create forum: {e.Message}");
            }
        }
        [HttpPut("{id}")]
        public IActionResult UpdateForum(int id, Forum forum)
        {
            if (id != forum.ForumId)
            {
                return BadRequest("Forum ID mismatch");
            }
            try
            {
                var updatedForum = forumDao.UpdateForum(forum);
                if (updatedForum == null)
                {
                    return NotFound();
                }
                return Ok(updatedForum);
            }
            catch (DaoException e)
            {
                return StatusCode(500, $"Failed to update forum: {e.Message}");
            }
        }
        [HttpDelete("{id}")]
        public IActionResult DeleteForum(int id)
        {
            try
            {
                var deletedForum = forumDao.DeleteForum(id);
                if (deletedForum == null)
                {
                    return NotFound();
                }
                return Ok(deletedForum);
            }
            catch (DaoException e)
            {
                return StatusCode(500, $"Failed to delete forum: {e.Message}");
            }
        }
    }
}