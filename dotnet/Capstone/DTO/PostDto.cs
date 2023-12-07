using System;
using System.Collections.Generic;
using System.Linq;


namespace Capstone.DTO
{
    public class PostDto
    {

        public int PostID { get; set; }

        public string Title { get; set; }

        public string Content { get; set; }

        public int UpVotes { get; set; }

        public int DownVotes { get; set; }

        public DateTime DatePosted { get; set; }

        public string ImagePath { get; set; }

        public int ForumId { get; set; }
        
        public string ForumTitle { get; set; }
    }
}