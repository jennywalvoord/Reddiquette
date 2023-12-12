<template>
  <v-content>
    <v-navigation-drawer app permanent location="right" >

      <v-divider></v-divider>

      <v-list-item>
          <h3>Active Forums</h3>
      </v-list-item>
      <v-list>
        <v-list-item
          v-for="forum in activeForums"
          :key="forum.id"
          v-bind:forums="forum"
          link
        ><router-link :to="{ name: 'forum-view', params: { id: forum.id } }">
          <v-list-item-content>
            <v-list-item-title>{{ forum.title }}</v-list-item-title>
          </v-list-item-content>
        </router-link></v-list-item>
        
      </v-list>
       
    </v-navigation-drawer>
  </v-content>
  

  <v-content >
      <div >
        
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
    },
  }
}
</script>
<style>
.content-title {
  margin-top: 50px;
}

a {
  text-decoration: none;
}
</style>