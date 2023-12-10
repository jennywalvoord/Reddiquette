using System.Collections.Generic;
using Capstone.Models;

namespace Capstone.DAO
{
    public interface IPostDao
    {
        List<Post> GetAllPosts();

        Post GetPostByID(int id);

        List<Post> GetPostsByForumID(int id);

        Post CreatePost(Post post);

        Post UpdatePost(Post post);
        
        Post DeletePost(int id);
    }
}