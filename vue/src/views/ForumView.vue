<template>
    <v-app-bar id="inspire">
        <v-app-bar-nav-icon>
            <v-icon @click="drawer = !drawer" icon="$vuetify"></v-icon>
        </v-app-bar-nav-icon>

        <v-app-bar-title class="text-uppercase">Rediquette</v-app-bar-title>
        <router-link v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
        <router-link v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
        <v-btn flat color="grey">
            <span>Sign Out</span>
            <v-icon icon="$vuetify"></v-icon>
        </v-btn>
    </v-app-bar>
    <v-sheet class="d-flex flex-wrap bg-surface-variant">
        <v-sheet class="flex-1-0 ma-24 pa-24">
            <forum-section v-bind:forum="findForum" />

        </v-sheet>

        <v-sheet class="ma-2 pa-2">
            <side-bar v-bind:forums="forums" />

        </v-sheet>

        <v-sheet class="flex-1-1-100 ma-2 pa-2">
        </v-sheet>
    </v-sheet>
</template>

<script>
import ForumSection from '../components/ForumSection.vue';
import SideBar from '../components/SideBar.vue';

export default {
    components: {
        SideBar,
        ForumSection,
    },
    computed: {
        findForum() {
            let forumId = this.$route.params.id;  
            let forum = this.$store.state.forums.find((p) => p.id == forumId);
            return forum;
        }
    },
}


</script>