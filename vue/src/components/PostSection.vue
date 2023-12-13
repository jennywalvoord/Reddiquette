<template>

  <v-content class="post-section">
    <v-sheet class="citation">
      <h3>{{ getForumTitle(post.forumId) }}</h3>
      <v-row class="d-flex ">
        <v-col>
          <h6>Posted by: {{ getUserName(post.userID) }}</h6>
        </v-col>
        <v-col>
          <h6>Posted about  {{ timePassed }}</h6>
        </v-col>
        <v-col>
          <h6>Accumulated Clout: {{ this.clout }}</h6>
        </v-col>
      </v-row>
    </v-sheet>
    <v-card class="postDetails">
      <v-container>
        <div class="d-flex flex-column">
          <v-card-title class="d-flex justify-center">{{ post.postTitle }}</v-card-title>
          <div class="d-flex">
            <v-img class="float-left" :width="300" :height="200" aspect-ratio="16/9" cover :src="post.imagePath"></v-img>
            <v-card-text class="d-flex w-66 ">{{ post.postContent }} </v-card-text>
          </div>
        </div>
        <div class="comments-section">
<<<<<<< HEAD
          <v-chip-group class="ma-2">
            <v-chip class="green" label size="small" @click="upVote">
              <i class="fa-solid fa-up-long pr-2"></i>{{ this.upvotes }} Upvotes
            </v-chip>

            <v-chip class="red" label size="small" @click="downVote">
              <i class="fa-solid fa-down-long pr-2"></i>{{ this.downvotes }} Downvotes
            </v-chip>
=======
          <!-- <v-chip-group class="ma-2">  -->
            <!-- <v-chip class="green" label size="small" @click="upVote">
              <i class="fa-solid fa-up-long pr-2"></i>{{ post.upVote }} Upvotes
             </v-chip>

            <v-chip class="red" label size="small" @click="downVote"> -->
              <!-- <i class="fa-solid fa-down-long pr-2"></i>{{ post.downVote }} Downvotes -->
            <!-- </v-chip> --> 
>>>>>>> 499327df49fff7856fd5b1972a7c431ce1e42d59
            <!--wondering about the function of this 'comment' chip...if a user wants to comment, they would click into the RTE and click the button to post the comment.
            Seems that we should make this chip only visible on homeview-->
            <!-- <v-chip class="grey" label size="small" @click=null>
              <i class="fa-regular fa-comment pr-2"></i>Comment
            </v-chip> -->
            
            

          <!-- </v-chip-group>
          <div class="replies">
              < <p>
               {{ getReply(post.postID) }}
              </p> -->
            <!-- </div> -->
        </div>
      </v-container>
    </v-card>
    <tiptap v-model="commentText" :enableEditing="true" />
    <!-- <v-divider :thickness="4" color="info"></v-divider> -->
    <div class="d-flex w-66 pa-5 ml-10 comment-button ">
      <v-btn @click="postComment" block size="x-large">Make a Comment</v-btn>
    </div>
</v-content>
</template>
    
<script>
import Tiptap from '../components/Tiptap.vue'
import { storeKey } from 'vuex';
import VoteService from '../services/VoteService';

export default {
  props: ["post", "reply"],
  components: {
    Tiptap
  },
  data() {
    return {
      commentText: '',
      isUpvoted: false,
      isDownvoted: false,
      upvotes: null,
      downvotes: null,
    };
  },
  methods: {
    async postComment() {
      const comment = {
        postId: this.post.postID,
        body: this.commentText,
    }
  },
    getForumTitle(forumId) {
      const forum = this.$store.state.forums.find((forum) => forum.forumId === forumId);
      return forum ? forum.title : 'Forum Not Found';
    },
    getUserName(userId) {
      const user = this.$store.state.postedUsers.find((user) => user.userId === userId);
      return user ? user.userName : 'User Name Not Found';
    },
    // getReply(postId){
    //   const reply = this.$store.state.Reply.find((reply) => reply.postId === postId);
    //   return reply ? reply.body : 'No Comments Yet!';
    },
<<<<<<< HEAD
    updateVotes() {
      VoteService.GetAllPostVotesbyId(this.$route.params.id)
      .then(response => {
        this.upvotes = response.data.Upvotes;
        this.downvotes = response.data.Downvotes
    });
    },
    async upVote() {
      if (this.isUpvoted) {
        const response = await VoteService.DeletePostVote(this.$route.params.id, this.$store.user.userId,)
        if (response.status >= 200 && response.status < 300)
        {
          this.updateVotes();
          this.isUpvoted = false;
        }
      }
      else if (this.isDownvoted) {
        const response = await VoteService.UpdatePostVote(this.$store.user.userId, this.$route.params.id, 1)
        if (response.status >= 200 && response.status < 300)
        {
          this.updateVotes();
          this.isDownvoted = false;
          this.isUpvoted = true;
        }
      }
      else {
        const response = await VoteService.CreatePostVote(this.$store.user.userId, this.$route.params.id, 1)
        if (response.status >= 200 && response.status < 300)
        {
          this.updateVotes();
          this.isUpvoted = true;
        }
        //TODO: write catch eventually
      }
    },
    async downVote() {
      if (this.isDownvoted) {
        const response = await VoteService.DeletePostVote(this.$route.params.id, this.$store.user.userId,)
        if (response.status >= 200 && response.status < 300)
        {
          this.updateVotes();
          this.isUpvoted = false;
        }
      }
      else if (this.isUpvoted) {
        const response = await VoteService.UpdatePostVote(this.$store.user.userId, this.$route.params.id, 1)
        if (response.status >= 200 && response.status < 300)
        {
          this.updateVotes();
          this.isDownvoted = true;
          this.isUpvoted = false;
        }
      }
      else {
        const response = await VoteService.CreatePostVote(this.$store.user.userId, this.$route.params.id, 1)
        if (response.status >= 200 && response.status < 300)
        {
          this.updateVotes();
          this.isDownvoted = true;
        }
        //TODO: write catch eventually
      }
    },
  },
=======
    // upVote() {
    //   if (!this.isUpvoted) {
    //     this.$store.dispatch('upVotePost', this.post.id);
    //     this.isUpvoted = true;
    //     this.updateClout();
    //     this.updateLocalStorage();
    //   }
    // },
    // downVote() {
    //   if (!this.isDownvoted) {
    //     this.$store.dispatch('downVotePost', this.post.id);
    //     this.isDownvoted = true;
    //     this.updateClout();
    //     this.updateLocalStorage();
    //   }
    // },
  // },
>>>>>>> 499327df49fff7856fd5b1972a7c431ce1e42d59
  computed: {
    clout: (this.upvotes - this.downvotes),
    timePassed() {
      const postedTime = new Date(this.post.dateCreated);
      let currentTime = new Date();
      let differenceInTime = (currentTime - postedTime)/1000;
      if (Math.round(differenceInTime) === 1) {return "1 second ago"}
      else if (Math.round(differenceInTime/60) < 1) {return `${differenceInTime} seconds ago`}
      else if (Math.round(differenceInTime/60) == 1) {return "1 minute ago"}
      else if (Math.round(differenceInTime/60) < 60) {return `${Math.round(differenceInTime/60)} minutes ago`}
      else if (Math.round(differenceInTime/(60*60)) == 1) {return "1 hour ago"}
      else if (Math.round(differenceInTime/(60*60)) < 24) {return `${Math.round(differenceInTime/(3600))} hours ago`}
      else if (Math.round(differenceInTime/(60*60*24)) == 1) {return "1 day ago"}
      else if (Math.round(differenceInTime/(60*60*24) < 30)) {return `${Math.round(differenceInTime/(60*60*24))} days ago`}
      else if (Math.round(differenceInTime/(60*60*24*30) == 1)) {return "1 month ago"}
      else if (Math.round(differenceInTime/(60*60*24*30) < 12)) {return `${Math.round(differenceInTime/(60*60*24*30))} months ago`}
      else if (Math.round(differenceInTime/(60*60*24*365) == 1)) {return "1 year ago"}
      else  return `${Math.round(differenceInTime/(60*60*24*365))} years ago`

    },
  },
  mounted() {
    VoteService.GetAllPostVotesbyId(this.$route.params.id)
      .then(response => {
        this.upvotes = response.data.Upvotes;
        this.downvotes = response.data.Downvotes
    });
    if (this.$store.state.isAuthenticated) {
      VoteService.GetPostVoteByID(this.$route.params.id, this.$store.state.user.userId)
        .then(response => {
          if (response.data.Increment === 1) {this.isUpvoted = true;}
          else if (response.data.Increment === -1) {this.isDownvoted = true;}
        })
    }
  },
  // created() {
  //   VoteService.GetAllPostVotesbyId(this.$route.params.id)
  //     .then(response => {
  //       this.upvotes = response.data.Upvotes;
  //       this.downvotes = response.data.Downvotes
  //   });
  //   if (this.$store.state.isAuthenticated) {
  //     VoteService.GetPostVoteByID(this.$route.params.id, this.$store.state.user.userId)
  //       .then(response => {
  //         if (response.data.Increment === 1) {this.isUpvoted = true;}
  //         else if (response.data.Increment === -1) {this.isDownvoted = true;}
  //       })
  //   }
  // },
  actions: {
    upVotePost () {
      this.upVote();
    },
    downVotePost() {
      this.downVote();
    }
  },
}

</script>
    
<style>
.comments-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  margin-top: 20px; /* Adjust as needed */
}
/* .citation {
  margin: 2.5% auto auto auto;
  padding-left: 2%;
  padding-right: 33%;
}
.postDetails {
  margin-top: 2.5%;
}
#textArea {
  background-color: rgb(222, 222, 222);
} */
</style>