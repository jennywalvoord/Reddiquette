<template>
  <v-container>
    <v-row align="center" justify="center">
      <v-col cols="auto">
        <v-card class="mx-auto" max-width="280">
          <v-card-item>
            <div>
              <div class="text-overline mb-1">
                {{ getForumTitle(post.forumId) }}
              </div>
              <v-img :width="280" :height="120" cover v-bind:src="post.imagePath"></v-img>
              
              <div class="text-h6 my-1">
                {{ post.postTitle }}
              </div>
              <p class="text-subtitle-2"><span class="font-weight-bold">Date posted: </span>{{ post.dateCreated }}</p>
                <p class="text-subtitle-2">
                  <!-- <span class="font-weight-bold" :class="{ 'text-positive': post.clout > 0, 'text-negative': post.clout < 0 }"> -->
                    <!-- Clout:
                  </span> -->
                  <!-- {{ post.clout }} -->
                </p>
              <v-card value="rounded" color="grey-lighten-3" flat height="150" class="overflow-hidden">
                <v-card-text>
                  {{ truncateText(post.postContent, 150) }}
                </v-card-text>
              </v-card>
              <v-divider class="ma-4"></v-divider>
              <v-chip-group v-model="selection" selected-class="text-deep-orange-accent-4">
                <v-chip class="green" label size="x-small" @click="upVote">
                  <i class="fa-solid fa-up-long pr-2"></i>Upvote
                </v-chip>

                <v-chip class="red" label size="x-small" @click="downVote">
                  <i class="fa-solid fa-down-long pr-2"></i>Downvote
                </v-chip>

                <v-chip class="grey" label size="x-small" @click=null>
                  <i class="fa-regular fa-comment pr-2"></i>Comment
                </v-chip>
              </v-chip-group>
            </div>
          </v-card-item>

          <v-card-actions>
            <v-btn  block>
            <router-link v-bind:to="{ name: 'post-view', params: { id: post.postID } }">
              
              View Post Details
            </router-link>
          </v-btn>
            
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { storeKey } from 'vuex';
import PostService from '../services/PostService';
import VoteService from '../services/VoteService';

export default {
  props: ['post', 'forum'],
  data() {
    return {
      isUpvoted: false,
      isDownvoted: false,
      storedUpvotes: 0,
      storedDownvotes: 0,
    };
  },
  computed: {
    //clout computation goes here?
  },
  methods: {
    truncateText(text, limit) {
      if (text.length > limit) {
        return text.substring(0, limit) + "...";
      } else {
        return text;
      }
    },
    async upVote() {
      if (this.isUpvoted) {
        const response = await VoteService.DeletePostVote(this.post.id, this.$store.user.userId,)
        if (response.status >= 200 && response.status < 300)
        {
          this.updateVotes();
          this.isUpvoted = false;
        }
      }
      else if (this.isDownvoted) {
        const response = await VoteService.UpdatePostVote(this.$store.user.userId, this.post.id, 1)
        if (response.status >= 200 && response.status < 300)
        {
          this.updateVotes();
          this.isDownvoted = false;
          this.isUpvoted = true;
        }
      }
      else {
        const response = await VoteService.CreatePostVote(this.$store.user.userId, this.post.id, 1)
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
        const response = await VoteService.DeletePostVote(this.post.id, this.$store.user.userId,)
        if (response.status >= 200 && response.status < 300)
        {
          this.updateVotes();
          this.isUpvoted = false;
        }
      }
      else if (this.isUpvoted) {
        const response = await VoteService.UpdatePostVote(this.$store.user.userId, this.post.id, 1)
        if (response.status >= 200 && response.status < 300)
        {
          this.updateVotes();
          this.isDownvoted = true;
          this.isUpvoted = false;
        }
      }
      else {
        const response = await VoteService.CreatePostVote(this.$store.user.userId, this.post.id, 1)
        if (response.status >= 200 && response.status < 300)
        {
          this.updateVotes();
          this.isDownvoted = true;
        }
        //TODO: write catch eventually
      }
    },
    updateVotes() {
      VoteService.GetAllPostVotesbyId(this.post.id)
      .then(response => {
        this.storedUpvotes = response.data.upvotes;
        this.storedDownvotes = response.data.downvotes
    });
    },
    getForumTitle(forumId) {
      const forum = this.$store.state.forums.find((forum) => forum.forumId === forumId);
      return forum ? forum.forumTitle : 'Forum Not Found';
    },
  },
  mounted() {
    VoteService.GetAllPostVotesbyId(this.post.id)
      .then(response => {
        this.storedUpvotes = response.data.upvotes;
        this.storedDownvotes = response.data.downvotes;
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
  //   VoteService.GetAllPostVotesbyId(this.post.id)
  //     .then(response => {
  //       this.upvotes = response.data.upvotes;
  //       this.downvotes = response.data.downvotes
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
};
</script>

<style>
.text-positive {
  color: green;
}
.text-negative {
  color: red;
}
.small-post a {
  text-decoration: none;
}
</style>

<!-- <style>
.card {
  max-width: 600px;
 

}
img {
  border-radius: 8px;
  height: 200px;
}
.well {
    display: flex;
    gap: 24px;
}
.social {
    display: flex;
    align-items: center;
}
.vote,
.comment,
.reply {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin: 10px 20px;
}
.arrow {
    font-size: 20px;
    margin-right: 5px;
}
.comment-icon {
    font-size: 20px;
    margin-right: 5px;
}
.vote a,
.comment a,
.reply a {
    text-decoration: none;
    color: #333;
}
.vote p,
.comment p,
.reply p {
    margin: 0;
    padding: 0;
}
</style> -->