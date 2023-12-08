using System.Collections.Generic;
using Capstone.Models;

namespace Capstone.DAO
{
    public interface ICommentDao
    {
        List<Comment> GetAllComments();

        Comment GetCommentById(int id);

        List<Comment> GetCommentsByPostId(int id);

        Comment CreateComment(Comment comment);

        Comment UpdateComment(Comment comment);

        Comment DeleteComment(int id);

    }
}