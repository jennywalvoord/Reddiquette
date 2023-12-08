using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Capstone.Models;
using Capstone.DTO;

namespace Capstone.Profiles
{
    public class CommentProfile : Profile
    {
        // Initializes a new instance of the CommentProfile class.
        public CommentProfile()
        {
            // Maps Comment and CommentDto classes.
            CreateMap<Comment, CommentDto>().ReverseMap();
        }
    }
}