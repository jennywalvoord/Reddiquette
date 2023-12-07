using System;
using System.Collections.Generic;
using System.Linq;


namespace Capstone.DTO
{
    public class ForumDto
    {
        public int ForumId { get; set; }

        public string ForumTitle { get; set; }

        public string ForumDescription { get; set; }

        public string ImagePath { get; set; }

        public DateTime DateCreated { get; set; }
    }
}