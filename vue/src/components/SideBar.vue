<template>
  <v-content >
      <div >
        <login-bar />
          <v-list-item
          lines="two"
          prepend-avatar="https://randomuser.me/api/portraits/women/81.jpg"
          title="Anonymous"
        >
        <router-link to="/login" class="text-subtitle-2">Logged in</router-link>
      </v-list-item>
      <v-divider></v-divider>

        <v-list-item>
          <h3 class="content-title">Active Forums</h3>

        </v-list-item>

        <v-list-item>
          <forum v-for="forum in activeForums" v-bind:forums="forum" v-bind:key="forum.id" />

        </v-list-item>
  </div>
  </v-content>
  
  
</template>
<script>
import Forum from '../components/Forum.vue';

export default {
    props: ['forums'],
    components: {
        Forum,
    },
    computed:
    {
        activeForums() {
            const allForums = this.$store.state.forums;
            const allPosts = this.$store.state.posts;
            const forumIdsWithRecentPosts = Array.from(new Set(allPosts.map(post => post.forumId)));
            const activeForums = allForums
                .filter(forum => forumIdsWithRecentPosts.includes(forum.id))
                .sort((a, b) => {
                    const recentPostA = allPosts
                        .filter(post => post.forumId === a.id)
                        .sort((x, y) => new Date(y.dateCreated) - new Date(x.dateCreated))[0];

                    const recentPostB = allPosts
                        .filter(post => post.forumId === b.id)
                        .sort((x, y) => new Date(y.dateCreated) - new Date(x.dateCreated))[0];


                    return new Date(recentPostB.dateCreated) - new Date(recentPostA.dateCreated);
                })
                .slice(0, 5);
            return activeForums;
        }
    }
}
</script>
<style>
.content-title {
  margin-top: 50px;
}
</style>