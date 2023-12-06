<template>
    <v-content >
        <div >
            <v-list-item
            lines="two"
            prepend-avatar="https://randomuser.me/api/portraits/women/81.jpg"
            title="Jane Smith"
            subtitle="Logged in"
          ></v-list-item>
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
        Forum
    },
    computed:{
    activeForums() {
            return this.$store.state.forums;
        }
    }
}
</script>
<style>
.content-title {
    margin-top: 50px;
}
</style>