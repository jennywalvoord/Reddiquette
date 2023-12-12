using Capstone.Models;

namespace Capstone.DAO
{
    public interface IVotesDao
    {
        ReturnVotes GetPostVotesById(int targetID);
        Vote GetPostVoteById(int userId, int postId);
        ReturnVotes GetCommentVotesById(int targetID);
        Vote GetCommentVoteById(int userId, int commentId);
        Vote CreatePostVote(int userId, int targetID, int increment);
        Vote CreateCommentVote(int userId, int targetID, int increment);
    }
}
