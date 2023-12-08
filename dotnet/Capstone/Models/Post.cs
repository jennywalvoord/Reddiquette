using System;
using System.ComponentModel.DataAnnotations;

namespace Capstone.Models
{
    public class Post
    {
        // Primary key of post
        public int PostID { get; set; }

        // Required post title
        [Required(ErrorMessage = "Post title is required.")]
        public string Title { get; set; }

        // Required post content
        [Required(ErrorMessage = "Post content is required.")]
        public string Content { get; set; }

        // Up votes of post
        public int UpVotes { get; set; }

        // Down votes of post
        public int DownVotes { get; set; }

        // Required date posted
        [Required(ErrorMessage = "Date created is required.")]
        public DateTime DateCreated { get; set; }

        // Path to image related to post
        public string ImagePath { get; set; }

        // ID of the forum the post belongs to
        public int ForumID { get; set; }

        // Title of the forum the post belongs to
        public string ForumTitle { get; set; }
    }
}