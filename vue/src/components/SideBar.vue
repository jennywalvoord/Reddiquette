<template>
    <div>
        <button class="login"></button>
        <h3>Active Forums</h3>
        <ul v-for="forum in forums" v-bind:key="forum.id">
            <li v-bind:forums="this.$store.state.forums">{{ forums.title }}</li>
        </ul>
    </div>
</template>

<script>

export default {
    props: ['forums'],
    computed: {
        activeForums() {
            const forumsFilter = this.$store.state.filter;
            
        }
    }


}

</script>