<template>
    <div class="well">
        <div>
            <img v-bind:src="post.image" >
        </div>
        <div>
            <h3>{{post.title}}</h3>
            <p>{{post.body.substring(0,250)}}...</p>
            <p>DATE POSTED: {{post.dateCreated}}</p>
            <p>CLOUT: {{ post.clout }}</p>
            <div>
                <div class="vote">
                    <a v-on:click="upVote">Upvote</a>
                    <p class="clout">{{ post.clout }}</p>
                    <a href=""><i>downvote{{  }}</i></a>
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
      this.$store.upvoted = !this.$store.upvoted;
      this.$store.downvoted = false;
    },
    downVote() {
      this.$store.downvoted = !this.$store.downvoted;
      this.$store.upvoted = false;
    },

  },
  computed: {
    upVotes() {

      if (this.$store.upvoted) {
        return this.$store.post.clout + 1;
      }
      else {
        return this.$store.post.clout;
      }

    },
    downVotes(){
      if(this.$store.downvoted){
        return this.$store.post.clout -1;
      }
      else{
        return this.$store.post.clout;
      }
    }

  },
    // computed: {
    // upvoteCount() {
    //     return -1;
    // },
    // commentVote() {
    //     return -1;
    // }
   
 
}

</script>