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
                    <post-section v-bind:post="this.post" v-if="post"/>

                    </v-sheet>
                </v-col> 
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
    data() {
        return {
            post: null
        }
    },
    created() {
    ForumService.getForums().then(response => {
    this.$store.commit("SET_FORUMS", response.data);
    }  
    );
    PostService.getPost(this.$route.params.id).then(response =>{
    this.post = response.data;
    }  
    );
    CommentService.getComments().then(response =>{
    this.$store.commit("SET_COMMENTS", response.data);
    }  
    );
  },
    computed: {
    //     findReply() {
    //         let replyId = this.$route.params.id;  
    //         let reply = this.$store.state.Reply.filter((p) => p.id == replyId);
    //         return reply;
    //     },
    },
}
</script>
