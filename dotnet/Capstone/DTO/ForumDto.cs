using System;
using System.Collections.Generic;
using System.Linq;


namespace Capstone.DTO
{
    public class ForumDto
    {
        // Forum identifier
        public int ForumId { get; set; }

        // Forum title
        public string ForumTitle { get; set; }

        // Forum description
        public string ForumDescription { get; set; }

        // Image path
        public string ImagePath { get; set; }

        // Date created
        public DateTime DateCreated { get; set; }
    }
}