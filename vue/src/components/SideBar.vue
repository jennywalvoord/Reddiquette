<template>
    <div>
        <button class="login"><i class="fa-solid fa-right-to-bracket"></i></button>
        <h3 class="content-title">Active Forums</h3>
        <forum v-for="forum in activeForums" v-bind:forums="forum" v-bind:key="forum.id" />
    </div>
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