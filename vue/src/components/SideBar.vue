<template>
    <div>
        <button class="login"></button>

        <h3>Active Forums</h3>
        <forum v-for="forum in activeForums" v-bind:forums="forum" v-bind:key="forum.id" />

    </div>
</template>

<script>
import Forum from '../components/Forum.vue';
export default {
    props: ['forums'],
<<<<<<< HEAD
=======
    components: {
        Forum
    },
    computed:{
    activeForums() {
            return this.$store.state.forums;
            
        }
    }
   

>>>>>>> 81e5bdf55aa80bb56bd1f9d5366e1308e2c8e3fa

}

</script>