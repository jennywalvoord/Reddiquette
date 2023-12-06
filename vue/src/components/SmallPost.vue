<template>
  <div class="card pb-6">
    <div class="well">
    <div>
      <img v-bind:src="post.image">
    </div>
    <div>
      <h3>{{ post.title }}</h3>
      <p>{{ post.body.substring(0, 250) }}...</p>
      <p>DATE POSTED: {{ post.dateCreated }}</p>
      <p>CLOUT: {{ post.clout }}</p>
    </div>
  </div>

  <div class="social">
    <div class="vote">
      <a @click="upVote" v-if="!isUpvoted">Upvote <i class="fa-solid fa-arrow-up"></i></a>
      <span v-else>Upvoted <i class="fa-solid fa-arrow-up"></i></span>
        <!-- <p class="upvote">Upvote / Downvote</p> -->
        <a @click="downVote" v-if="!isDownvoted">Downvote <i class="fa-solid fa-arrow-down"></i></a>
    <span v-else>Downvoted <i class="fa-solid fa-arrow-down"></i></span>
    </div>
    <div class="comment">
        <a href=""><i class="fa-regular fa-comment"></i></a>
        <p class="upvote">comment</p>
    </div>
    <div class="reply">
        <a href=""><i class="fa-regular fa-comments"></i></a>
        <p class="upvote">reply</p>
    </div>
</div>

  </div>
  
</template>

<script>
export default {
  props: ['post'],
  data() {
    //Upvote and Downvote work but they do not actually affect the clout in the store.  Logic needs to be fixed.
    return {
      isUpvoted: false,
      isDownvoted: false
    };
  },
  methods: {
    upVote() {
      if (!this.isUpvoted) {
        this.$store.dispatch('upVotePost', this.post.id);

        this.isUpvoted = true;
      }
    },
    downVote() {
      if (!this.isDownvoted) {
        this.$store.dispatch('downVotePost', this.post.id);

        this.isDownvoted = true;
      }
    },
    updateClout() {
      this.$store.clout = this.$store.upVote - this.$store.downVote;
    },
  },
};
</script>

<style>
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
</style>