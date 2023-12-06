using System;
using System.ComponentModel.DataAnnotations;

namespace Capstone.Models
{
    public class Post
    {
        public int PostID { get; set; }

        [Required(ErrorMessage = "Post title is required.")]
        public string Title { get; set; }

        [Required(ErrorMessage = "Post content is required.")]
        public string Content { get; set; }

        public int UpVotes { get; set; }

        public int DownVotes { get; set; }

        [Required(ErrorMessage = "Date created is required.")]
        public DateTime DatePosted { get; set; }

        public string ImagePath { get; set; }

        //TODO: complete Post Model
    }
}