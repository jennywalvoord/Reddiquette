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
}

</script>