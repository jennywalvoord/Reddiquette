using Capstone.Models;

namespace Capstone.DAO
{
    public interface IVotesDao
    {
        ReturnVotes GetPostVotesById(int targetID);
        ReturnVotes GetCommentVoteById(int targetID);
        Vote CreatePostVote(int userId, int targetID, int increment);
        Vote CreateCommentVote(int userId, int targetID, int increment);
    }
}
