<template>
    <v-content>
      <div class="postDetails">
            <v-container class="my-5">
            <div>
                <v-img :width="300" :height="200" aspect-ratio="16/9" cover v-bind:src="post.image"></v-img>
               <h3>{{ post.title}}</h3>
                <p>{{ post.body }} </p>  
            </div>
            <div>
                <v-chip-group class="ma-2">
        <v-chip class="green" label size="small" @click="upVote">
          <i class="fa-solid fa-up-long pr-2"></i>Upvote
        </v-chip>

        <v-chip class="red" label size="small" @click="downVote">
          <i class="fa-solid fa-down-long pr-2"></i>Downvote
        </v-chip>

        <v-chip class="grey" label size="small" @click=null>
          <i class="fa-regular fa-comment pr-2"></i>Comment
        </v-chip>
        <textarea id="textArea" name="story" rows="5" cols="33">
        </textarea>
      </v-chip-group>
            </div>
            
          </v-container>
        </div>
    
    </v-content>
    
        
    </template>
    
    <script>
    import { storeKey } from 'vuex';
    
    export default {
      props: ["post"],
      components: {
      },
      computed: {
        getForum() {
          let forumId = this.post.forumId;
        let posts = this.$store.state.forum.find((p) => p.forumId === forumId);
    
        return posts;
        }
      }
    }
    
    </script>
    
<style>

.postDetails{
    margin-top: 100px;
}

#textArea{
    background-color: rgb(222, 222, 222);
}

</style>