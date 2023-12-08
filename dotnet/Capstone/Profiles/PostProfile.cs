using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Capstone.Models;
using Capstone.DTO;

namespace Capstone.Profiles
{
    public class PostProfile : Profile
    {
        // Initializes a new instance of the PostProfile class.
        public PostProfile()
        {
            // Maps Post and PostDto classes.
            CreateMap<Post, PostDto>().ReverseMap();
        }
    }
}