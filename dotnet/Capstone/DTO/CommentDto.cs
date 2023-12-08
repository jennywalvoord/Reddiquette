using System;
using System.Collections.Generic;
using System.Linq;


namespace Capstone.DTO
{

    public class CommentDto
    {
        // Unique identifier for a comment
        public int CommentID { get; set; }

        // Unique identifier for a post
        public int PostID { get; set; }

        // Unique identifier for a user
        public int UserID { get; set; }

        // Content of the comment
        public string CommentContent { get; set; }

        // Number of upvotes for the comment
        public int UpVotes { get; set; }

        // Number of downvotes for the comment
        public int DownVotes { get; set; }

        // Date when the comment was created
        public DateTime DateCreated { get; set; }

        // Unique identifier for the forum
        public int ForumID { get; set; }

        // Unique identifier of the comment being replied to
        public int ParentID { get; set; }
    }
}