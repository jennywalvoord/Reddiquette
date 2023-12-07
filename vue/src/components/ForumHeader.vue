<template>
    <div class="well">
        <div>

        </div>
        <div>
            <h3 v-bind:to="{ name: 'forum-view', params: { id: forums.id } }">
                {{ forums.title }}
                <!-- //<router-link  v-bind:to="{ name: 'forum-view', params: {id: forums.id}}">{{forums.title}}</router-link> -->
            </h3>
            <p v-bind:to="{ name: 'forum-view', params: { id: forums.id } }">{{ forums.description }}</p>


        </div>
    </div>
</template>
<script>

export default {
    props: ['forums']
   
}

</script>