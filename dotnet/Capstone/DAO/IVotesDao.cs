using Capstone.Models;
using System.Collections.Generic;

namespace Capstone.DAO
{
    public interface IVotesDao
    {
        ReturnVotes GetAllPostVotesById(int targetId);
        Vote GetPostVoteById(int userId, int postId);
        ReturnVotes GetAllCommentVotesById(int targetID);
        Vote GetCommentVoteById(int userId, int commentId);
        Vote CreatePostVote(int userId, int targetID, int increment);
        Vote CreateCommentVote(int userId, int targetID, int increment);
        Vote UpdateCommentVote(int userId, int commentId, int increment);
        Vote UpdatePostVote(int userId, int targetID, int increment);
        Vote DeletePostVote(int userId, int targetId);
        Vote DeleteCommentVote(int userId, int targetId);

    }
}
