<template>
    <editor-content :editor="editor"/>
    <!-- <div>
        <button onclick="editor.chain().focus().toggleBold().run()">
        <v-icon icon="mdi-format-bold"></v-icon>
        </button>
        <button @click="editor.chain().focus().toggleItalic().run()" :disabled="!editor.can().chain().focus().toggleItalic().run()" :class="{ 'is-active': editor.isActive('italic') }">
            <v-icon icon="mdi-format-italic"></v-icon>
        </button>
        <button @click="editor.chain().focus().toggleStrike().run()" :disabled="!editor.can().chain().focus().toggleStrike().run()" :class="{ 'is-active': editor.isActive('strike') }">
            <v-icon icon="mdi-format-strikethrough"></v-icon>
        </button>
        <button @click="editor.chain().focus().setParagraph().run()" :class="{ 'is-active': editor.isActive('paragraph') }">
            <v-icon icon="mdi-format-paragraph"></v-icon>
        </button>
        <button @click="editor.chain().focus().toggleHeading({ level: 1 }).run()" :class="{ 'is-active': editor.isActive('heading', { level: 1 }) }">
            <v-icon icon="mdi-format-paragraph"></v-icon>

        </button>
        <button @click="editor.chain().focus().toggleHeading({ level: 2 }).run()" :class="{ 'is-active': editor.isActive('heading', { level: 2 }) }">
            <v-icon icon="mdi-format-paragraph"></v-icon>

        </button>
        <button @click="editor.chain().focus().toggleHeading({ level: 3 }).run()" :class="{ 'is-active': editor.isActive('heading', { level: 3 }) }">
        h3
        </button>
        <button @click="editor.chain().focus().toggleHeading({ level: 4 }).run()" :class="{ 'is-active': editor.isActive('heading', { level: 4 }) }">
        h4
        </button>
    </div> -->
  </template>
  
  <script>
  import { Editor, EditorContent } from '@tiptap/vue-3'
  import StarterKit from '@tiptap/starter-kit'
  
  export default {
    components: {
      EditorContent,
    },
  
    data() {
      return {
        editor: null,
      }
    },
  
    mounted() {
      this.editor = new Editor({
        content: '<p>I’m running Tiptap with Vue.js. 🎉</p>',
        extensions: [
          StarterKit,
        ],
        injectCSS: false,

      })
    },
  
    beforeUnmount() {
      this.editor.destroy()
    },
  }
  </script>

  <style>
/* Scoped to the editor */
.tiptap p {
  margin: 1em 0;
}
</style>

