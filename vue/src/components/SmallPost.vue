<template>
    <div class="well">
        <div>
            <img v-bind:src="post.image" >
        </div>
        <div>
            <h3>{{post.title}}</h3>
            <p>{{post.body}}</p>
            <div>
                <div class="vote">
                    <a href=""><i>upvote</i></a>
                    <p class="upvote">number</p>
                    <a href=""><i>downvote</i></a>
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

  },
    computed: {
    upvoteCount() {
        return -1;
    },
    commentVote() {
        return -1;
    }
  }
}

</script>