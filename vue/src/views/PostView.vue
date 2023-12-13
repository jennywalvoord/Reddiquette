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
                    <post-section :reply="findReply" :post="findPost"  />

                    </v-sheet>
                </v-col>
            </v-row>
        </v-container>
    </v-main>
    <side-bar v-bind:forums="forums" />
    
        <!-- <v-navigation-drawer fixed permanent location="right">
            <div class="ma-24 pa-24">
                <side-bar v-bind:forums="forums" />
            </div>
        </v-navigation-drawer> -->
        <v-sheet class="flex-1-1-100 ma-2 pa-2">
        </v-sheet>
</template>

<script>

import SideBar from '../components/SideBar.vue';
import PostSection from '../components/PostSection.vue';

export default {
    components: {
        SideBar,
        PostSection,
    },
    computed: {
        findPost() {
            let postId = this.$route.params.id;  
            let post = this.$store.state.posts.find((p) => p.id == postId);
            return post;
        },
        findReply() {
            let replyId = this.$route.params.id;  
            let reply = this.$store.state.Reply.filter((p) => p.id == replyId);
            return reply;
        },
    },
}
</script>