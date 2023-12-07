using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Capstone.Models;
using Capstone.DTO;

namespace Capstone.Profiles
{
    public class ForumProfile : Profile
    {
        public ForumProfile()
        {
            CreateMap<Post, PostDto>().ReverseMap();
        }
    }
}