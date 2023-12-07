using Microsoft.AspNetCore.Mvc;
using Capstone.DAO;
using Capstone.Exceptions;
using Capstone.Models;
using Capstone.Security;
using Microsoft.AspNetCore.Authorization;
using System.Collections.Generic;
using AutoMapper;
using Capstone.DTO;

namespace Capstone.Controllers
{
    [Route("api/forum")]
    [ApiController]
    public class ForumController : ControllerBase
    {
        private readonly IForumDao forumDao;
        private readonly IMapper mapper;


        public ForumController(IForumDao forumDao, IMapper mapper)
        {
            this.forumDao = forumDao;
            this.mapper = mapper;
        }

        [HttpGet]
        public IActionResult GetAllForums()
        {
            try
            {
                var forums = forumDao.GetAllForums();
                var forumDtos = mapper.Map<List<ForumDto>>(forums);

                return Ok(forumDtos);
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
                var forumDto = mapper.Map<ForumDto>(forum);
                
                return Ok(forumDto);
            }
            catch (DaoException e)
            {
                return StatusCode(500, $"Failed to find forum by ID {id}: {e.Message}");
            }
        }

        [HttpPost]
        [Authorize(Roles = "Admin, Moderator, User")]
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
        [Authorize(Roles = "Admin, Moderator, User")]
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
        [Authorize(Roles = "Admin, Moderator")]
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