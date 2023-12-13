using System;
using System.ComponentModel.DataAnnotations;
using System.Runtime.InteropServices;

namespace Capstone.Models
{
    public class Comment
    {
        // Primary key of comment
        public int CommentID { get; set; }

        // ID of the user who posted the comment
        [Required(ErrorMessage = "User ID is required")]
        public int UserID { get; set; }

        // ID of the post to which the comment belongs
        [Required(ErrorMessage = "Post ID is required")]
        public int PostID { get; set; }

        // Content of the comment, should be maximum 10 words
        [Required(ErrorMessage ="Comment Content is Required")]
        public string CommentContent { get; set; }

        // Date and time when the comment was created
        [Required(ErrorMessage ="Time Created is required")]
        public DateTime DateCreated { get; set; }

        // ID of the forum where the post belongs
        [Required(ErrorMessage ="Forum Id is required")]
        public int ForumID { get; set; }
        // ID of the comment being replied to
        public int? ParentID { get; set; }
    }
}