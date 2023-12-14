using Capstone.DAO;
using Capstone.Exceptions;
using Capstone.Models;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using Microsoft.AspNetCore.Authorization;



namespace Capstone.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class VoteController : ControllerBase
    {
        private readonly IVotesDao votesDao;
        public VoteController(IVotesDao votesDao)
        {
            this.votesDao = votesDao;
        }
        /// <summary>
        /// Takes in a post id and returns an object containing the upvotes and downvotes
        /// </summary>
        /// <param name="targetId">postID</param>
        /// <returns></returns>
        [HttpGet("/vote/post/{targetID}")]
        public IActionResult GetAllPostVotesById(int targetId)
        {
            try
            {
                var votes = votesDao.GetAllPostVotesById(targetId);
                if (votes == null)
                {
                    return NotFound($"No forum found with ID {targetId}.");
                }
                return Ok(votes);
            }
            catch(DaoException e)
            {
                return StatusCode(404, $"Failed to retrieve votes: {e.Message}");
            }
        }
        /// <summary>
        /// Takes in a comment id and returns an object containing the upvotes and downvotes
        /// </summary>
        /// <param name="targetId">commentID</param>
        /// <returns></returns>
        [HttpGet("/vote/comment/{targetID}")]
        public IActionResult GetAllCommentVotesById(int targetID)
        {
            try
            {
                var votes = votesDao.GetAllCommentVotesById(targetID);
                if (votes == null)
                {
                    return NotFound($"No forum found with ID {targetID}.");
                }
                return Ok(votes);
            }
            catch (DaoException e)
            {
                return StatusCode(404, $"Failed to retrieve votes: {e.Message}");
            }
        }

        [HttpGet("/vote/post/{postId}/user/{userId}")]
        public Vote GetPostVoteByID(int postId, int userId)
        {
            var voteHistory = votesDao.GetPostVoteById(postId, userId);
            return voteHistory;
        }

        [HttpGet("/vote/comment/{commentId}/user/{userId}")]
        public Vote GetCommentVoteByID(int userId, int commentId)
        {
            var voteHistory = votesDao.GetCommentVoteById(userId, commentId);
            return voteHistory;
        }

        [HttpPost("/vote/post")]
        public Vote CreatePostVote(Vote vote)
        {
            var userId = vote.UserID;
            var targetID = vote.TargetID;
            var increment = vote.Increment;
            var createdVote = votesDao.CreatePostVote(userId, targetID, increment);
            return createdVote;
        }

        [HttpPost("/vote/comment")]
        public Vote CreateCommentVote(Vote vote)
        {
            var userId = vote.UserID;
            var targetID = vote.TargetID;
            var increment = vote.Increment;
            var createdVote = votesDao.CreateCommentVote(userId, targetID, increment);
            return createdVote;
        }

        [HttpPut("/vote/comment/{targetID}")]
        public Vote UpdateCommentVote(Vote vote)
        {
            var userId = vote.UserID;
            var targetID = vote.TargetID;
            var increment = vote.Increment;
            var updatedVote = votesDao.UpdateCommentVote(userId,targetID, increment);
            return updatedVote;
        }

        [HttpPut("/vote/post/{targetID}")]
        public Vote UpdatePostVote(Vote vote)
        {
            var userId = vote.UserID;
            var targetID = vote.TargetID;
            var increment = vote.Increment;
            var updatedVote = votesDao.UpdatePostVote(userId, targetID, increment);
            return updatedVote;
        }

        [HttpDelete("/vote/post/{targetID}/user/{userID}")]
        public Vote DeletePostVote(int targetID, int userID)
        {
            var deletedVote = votesDao.DeletePostVote(userID, targetID);
            return deletedVote;

        }

        [HttpDelete("/vote/comment/{targetID}/user/{userID}")]
        public Vote DeleteCommentVote(int targetID, int userID)
        {
            var deletedVote = votesDao.DeleteCommentVote(userID, targetID);
            return deletedVote;

        }
    }

}
