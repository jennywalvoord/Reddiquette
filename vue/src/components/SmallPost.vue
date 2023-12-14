<template>
  <v-container>
    <v-row align="center" justify="center">
      <v-col cols="auto">
        <router-link v-bind:to="{ name: 'post-view', params: { id: post.postID } }">
          <v-card 
            class="mx-auto" 
            max-width="280"
            link 
            >
          <v-card-item>
            <div>
              <div class="text-overline mb-1" style="color: #ff4500;">
                {{ getForumTitle(post.forumId) }}
              </div>
              <v-img :width="280" :height="120" cover v-bind:src="post.imagePath"></v-img>

              <div class="text-h6 my-1 post-title">
                {{ post.postTitle }}
              </div>
              <p class="text-subtitle-2 mb-2"><span class="font-weight-bold">Date posted: </span>{{ timePassed }}</p>
              <p class="text-subtitle-2">
                <!-- <span class="font-weight-bold" :class="{ 'text-positive': post.clout > 0, 'text-negative': post.clout < 0 }"> -->
                <!-- Clout:
                  </span> -->
                <!-- {{ post.clout }} -->
              </p>
              <v-card value="rounded" color="grey-lighten-4" flat height="150" class="overflow-hidden">
                <v-card-text>
                  {{ truncateText(post.postContent, 150) }}
                </v-card-text>
              </v-card>
              <hr style="border-top: 1px solid #ff4500; margin: 16px 0 16px 0">

              <v-chip-group v-model="selection" selected-class="text-deep-orange-accent-4">
                <v-chip class="green" label size="x-small" @click="upVote">
                  <i class="fa-solid fa-up-long pr-2"></i>{{ this.storedUpvotes }} Upvote
                </v-chip>

                <v-chip class="red" label size="x-small" @click="downVote">
                  <i class="fa-solid fa-down-long pr-2"></i>{{ this.storedDownvotes }} Downvote
                </v-chip>
              </v-chip-group>
            </div>
          </v-card-item>

         
        </v-card>
        </router-link>
        
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
    timePassed() {
      const postedTime = new Date(this.post.dateCreated);
      let currentTime = new Date();
      let differenceInTime = (currentTime - postedTime) / 1000;
      if (Math.round(differenceInTime) === 1) { return "1 second ago" }
      else if (Math.round(differenceInTime / 60) < 1) { return `${differenceInTime} seconds ago` }
      else if (Math.round(differenceInTime / 60) == 1) { return "1 minute ago" }
      else if (Math.round(differenceInTime / 60) < 60) { return `${Math.round(differenceInTime / 60)} minutes ago` }
      else if (Math.round(differenceInTime / (60 * 60)) == 1) { return "1 hour ago" }
      else if (Math.round(differenceInTime / (60 * 60)) < 24) { return `${Math.round(differenceInTime / (3600))} hours ago` }
      else if (Math.round(differenceInTime / (60 * 60 * 24)) == 1) { return "1 day ago" }
      else if (Math.round(differenceInTime / (60 * 60 * 24) < 30)) { return `${Math.round(differenceInTime / (60 * 60 * 24))} days ago` }
      else if (Math.round(differenceInTime / (60 * 60 * 24 * 30) == 1)) { return "1 month ago" }
      else if (Math.round(differenceInTime / (60 * 60 * 24 * 30) < 12)) { return `${Math.round(differenceInTime / (60 * 60 * 24 * 30))} months ago` }
      else if (Math.round(differenceInTime / (60 * 60 * 24 * 365) == 1)) { return "1 year ago" }
      else return `${Math.round(differenceInTime / (60 * 60 * 24 * 365))} years ago`
    },
    getUpvotes(){
      return this.storedUpvotes;
    },
    getDownvotes(){
      return this.storedDownvotes;
    },
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
        const response = await VoteService.UpdatePostVote(this.$store.user.userId, this.post.postID, 1)
        if (response.status >= 200 && response.status < 300)
        {
          this.updateVotes();
          this.isDownvoted = false;
          this.isUpvoted = true;
        }
      }
      else {
        const response = await VoteService.CreatePostVote(this.$store.user.userId, this.post.postID, 1)
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
        const response = await VoteService.UpdatePostVote(this.$store.user.userId, this.post.postID, 1)
        if (response.status >= 200 && response.status < 300)
        {
          this.updateVotes();
          this.isDownvoted = true;
          this.isUpvoted = false;
        }
      }
      else {
        const response = await VoteService.CreatePostVote(this.$store.user.userId, this.post.postID, 1)
        if (response.status >= 200 && response.status < 300)
        {
          this.updateVotes();
          this.isDownvoted = true;
        }
        //TODO: write catch eventually
      }
    },
    updateVotes() {
      VoteService.GetAllPostVotesbyId(this.post.postID)
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
    VoteService.GetAllPostVotesbyId(this.post.postID)
      .then(response => {
        this.storedUpvotes = response.data.upvotes;
        this.storedDownvotes = response.data.downvotes
    });
    if (this.$store.state.isAuthenticated) {
      VoteService.GetPostVoteByID(this.post.postID, this.$store.state.user.userId)
        .then(response => {
          if (response.data.Increment === 1) {this.isUpvoted = true;}
          else if (response.data.Increment === -1) {this.isDownvoted = true;}
        })
    }
  },
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

.post-title {
  height: 60px;
}
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