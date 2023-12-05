<template>
  <div class="well">
    <div>
      <img v-bind:src="post.image">
    </div>
    <div>
      <h3>{{ post.title }}</h3>
      <p>{{ post.body.substring(0, 250) }}...</p>
      <p>DATE POSTED: {{ post.dateCreated }}</p>
      <p>CLOUT: {{ post.clout }}</p>
      <div>
        <div class="vote">
      <a @click="upVote">Upvote</a>
      <p class="clout">{{ $store.clout }}</p>
      <a @click="downVote">Downvote</a>
    </div>
        <div class="comment">
          <a href=""><i>comment</i></a>
          <p class="upvote">comment</p>
        </div>
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