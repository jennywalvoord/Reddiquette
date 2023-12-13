<template>

    <v-main class="bg-grey-lighten-4">
        <v-container>
            <v-row>
                <v-col>
                    <v-sheet 
                    min-height="90vh"
                    rounded="lg"
                    class="ma-4 pa-4"
                    >
                    <post-section v-bind:post="findPost"/>

                    </v-sheet>
                </v-col>git 
            </v-row>
        </v-container>
    </v-main>
    <side-bar v-bind:forums="forums" />
    
        <v-sheet class="flex-1-1-100 ma-2 pa-2">
        </v-sheet>
</template>

<script>

import SideBar from '../components/SideBar.vue';
import PostSection from '../components/PostSection.vue';
import ForumService from '../services/ForumService';
import PostService from '../services/PostService';
import CommentService from '../services/CommentService';

export default {
    components: {
        SideBar,
        PostSection,
    },
    created() {
    ForumService.getForums().then(response => {
    this.$store.commit("SET_FORUMS", response.data);
    }  
    );
    PostService.getPosts().then(response =>{
    this.$store.commit("SET_POSTS", response.data);
    }  
    );
    CommentService.getComments().then(response =>{
    this.$store.commit("SET_COMMENTS", response.data);
    }  
    );
  },
    computed: {
        findPost() {
            let postId = this.$route.params.id;  
            let post = this.$store.state.posts.find((p) => p.postID == postId);
            return post;
        },
    //     findReply() {
    //         let replyId = this.$route.params.id;  
    //         let reply = this.$store.state.Reply.filter((p) => p.id == replyId);
    //         return reply;
    //     },
    },
}
</script>
