using System;
using System.ComponentModel.DataAnnotations;

namespace Capstone.Models
{
    public class Post
    {
        // Primary key of post
        public int PostID { get; set; }

        public int UserID { get; set; }

        // Required post content
        [Required(ErrorMessage = "Post content is required.")]
        public string PostContent { get; set; }

        // Up votes of post
        public int UpVotes { get; set; }

        // Down votes of post
        public int DownVotes { get; set; }

        // Required date posted
        [Required(ErrorMessage = "Date created is required.")]
        public DateTime DateCreated { get; set; }

        // Path to image related to post
        //public string ImagePath { get; set; }

        // ID of the forum the post belongs to
        public int ForumId { get; set; }

        // Title of the forum the post belongs to
        //public string ForumId { get; set; }

        public string PostTitle { get; set; }
    }
}