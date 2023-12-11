using System;
using System.Collections.Generic;
using System.Linq;


namespace Capstone.DTO
{
    public class PostDto
    {
        // Unique identifier for a post
        public int PostID { get; set; }

        public string UserID { get; set; }

        // Content of the post
        public string PostContent { get; set; }

        // Number of up votes for the post
        public int UpVotes { get; set; }

        // Number of down votes for the post
        public int DownVotes { get; set; }

        // Date when the post was created
        public DateTime DateCreated { get; set; }

        // Path to the image related to the post
        //public string ImagePath { get; set; }

        // Unique identifier for the forum
        public int ForumID { get; set; }

        // Title of the forum
        public string ForumTitle { get; set; }
    }
}