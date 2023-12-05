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
        <a @click="upVote">Upvote <i class="fa-solid fa-arrow-up"></i></a>
        <!-- <p class="upvote">Upvote / Downvote</p> -->
        <a @click="downVote">Downvote <i class="fa-solid fa-arrow-down"></i></a>
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
  methods: {
    upVote() {
    this.$store.dispatch('upVotePost', this.post.id);
  },
  downVote() {
    this.$store.dispatch('downVotePost', this.post.id);
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