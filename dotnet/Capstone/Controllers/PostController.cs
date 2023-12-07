using Microsoft.AspNetCore.Mvc;
using Capstone.DAO;
using Capstone.Exceptions;
using Capstone.Models;
using Capstone.Security;
using Microsoft.AspNetCore.Authorization;


namespace Capstone.Controllers
{
    [Route("api/post")]
    [ApiController]

    public class PostController : ControllerBase
    {
        private readonly IPostDao postDao;

        public PostController(IPostDao postDao)
        {
            this.postDao = postDao;
        }

        [HttpGet]
        public IActionResult GetAllPosts()
        {
            try
            {
                var posts = postDao.GetAllPosts();
                return Ok(posts);
            }
            catch (DaoException e)
            {
                return StatusCode(500, $"Failed to retrieve posts: {e.Message}");
            }
        }

        [HttpGet("{id}")]
        public IActionResult GetPostById(int id)
        {
            try
            {
                var post = postDao.GetPostById(id);
                if (post == null)
                {
                    return NotFound($"No post found with ID {id}.");
                }
                return Ok(post);
            }
            catch (DaoException e)
            {
                return StatusCode(500, $"Failed to find post by ID {id}: {e.Message}");
            }
        }

        [HttpGet("forum/{id}")]
        public IActionResult GetPostsByForumId(int id)
        {
            try
            {
                var posts = postDao.GetPostsByForumId(id);
                if (posts == null)
                {
                    return NotFound($"No posts found with Forum ID {id}.");
                }
                return Ok(posts);
            }
            catch (DaoException e)
            {
                return StatusCode(500, $"Failed to retrieve posts with Forum ID {id}: {e.Message}");
            }
        }

        [HttpPost]
        [Authorize(Roles = "Admin, Moderator, User")]
        public IActionResult CreatePost(Post post)
        {
            try
            {
                var createdPost = postDao.CreatePost(post);
                return CreatedAtAction(nameof(GetPostById), new { id = createdPost.PostID }, createdPost);
            }
            catch (DaoException e)
            {
                return StatusCode(500, $"Failed to create post: {e.Message}");
            }
        }

        [HttpPut("{id}")]
        [Authorize(Roles = "Admin, Moderator, User")]
        public IActionResult UpdatePost(int id, Post post)
        {
            if (id != post.PostID)
            {
                return BadRequest("Post ID mismatch");
            }
            try
            {
                var updatedPost = postDao.UpdatePost(post);
                if (updatedPost == null)
                {
                    return NotFound();
                }
                return Ok(updatedPost);
            }
            catch (DaoException e)
            {
                return StatusCode(500, $"Failed to update post: {e.Message}");
            }
        }

        [HttpDelete("{id}")]
        [Authorize(Roles = "Admin, Moderator")]
        public IActionResult DeletePost(int id)
        {
            try
            {
                var deletedPost = postDao.DeletePost(id);
                if (deletedPost == null)
                {
                    return NotFound();
                }
                return Ok(deletedPost);
            }
            catch (DaoException e)
            {
                return StatusCode(500, $"Failed to delete post: {e.Message}");
            }
        }
    }
}