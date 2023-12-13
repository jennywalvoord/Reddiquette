<template>
     <div v-if="editor">
      <div class="icon-row">
        <button class="item" @click="editor.chain().focus().toggleBold().run()" :disabled="!editor.can().chain().focus().toggleBold().run()" :class="{ 'is-active': editor.isActive('bold') }">
            <v-icon icon="mdi-format-bold"></v-icon>
            </button>
            
            <button class="item" @click="editor.chain().focus().toggleItalic().run()" :disabled="!editor.can().chain().focus().toggleItalic().run()" :class="{ 'is-active': editor.isActive('italic') }">
              <v-icon icon="mdi-format-italic"></v-icon>
            </button>
            
            <button class="item" @click="editor.chain().focus().toggleStrike().run()" :disabled="!editor.can().chain().focus().toggleStrike().run()" :class="{ 'is-active': editor.isActive('strike') }">
              <v-icon icon="mdi-format-strikethrough"></v-icon>
            </button>
            
            <button class="item" @click="editor.chain().focus().toggleCode().run()" :disabled="!editor.can().chain().focus().toggleCode().run()" :class="{ 'is-active': editor.isActive('code') }">
              <v-icon icon="mdi-code-block-tags"></v-icon>
            </button>
            
            <button class="item" @click="editor.chain().focus().unsetAllMarks().run()">
              <v-icon icon="mdi-format-clear"></v-icon>
            </button>
            
            <button class="item" @click="editor.chain().focus().setParagraph().run()" :class="{ 'is-active': editor.isActive('paragraph') }">
              <v-icon icon="mdi-format-paragraph"></v-icon>
            </button>
            
            <button class="item" @click="editor.chain().focus().toggleHeading({ level: 1 }).run()" :class="{ 'is-active': editor.isActive('heading', { level: 1 }) }">
              <v-icon icon="mdi-format-header-1"></v-icon>
            </button>
            
            <button class="item" @click="editor.chain().focus().toggleHeading({ level: 2 }).run()" :class="{ 'is-active': editor.isActive('heading', { level: 2 }) }">
              <v-icon icon="mdi-format-header-2"></v-icon>
            </button>
            
            <button class="item" @click="editor.chain().focus().toggleHeading({ level: 3 }).run()" :class="{ 'is-active': editor.isActive('heading', { level: 3 }) }">
              <v-icon icon="mdi-format-header-3"></v-icon>
            </button>
            
            <button class="item" @click="editor.chain().focus().toggleHeading({ level: 4 }).run()" :class="{ 'is-active': editor.isActive('heading', { level: 4 }) }">
              <v-icon icon="mdi-format-header-4"></v-icon>
            </button>
            
            <button class="item" @click="editor.chain().focus().toggleHeading({ level: 5 }).run()" :class="{ 'is-active': editor.isActive('heading', { level: 5 }) }">
              <v-icon icon="mdi-format-header-5"></v-icon>
            </button>
            
            <button class="item" @click="editor.chain().focus().toggleHeading({ level: 6 }).run()" :class="{ 'is-active': editor.isActive('heading', { level: 6 }) }">
              <v-icon icon="mdi-format-header-6"></v-icon>
            </button>
            
            <button class="item" @click="editor.chain().focus().toggleBulletList().run()" :class="{ 'is-active': editor.isActive('bulletList') }">
              <v-icon icon="mdi-format-list-bulleted"></v-icon>
            </button>
            
            <button class="item" @click="editor.chain().focus().toggleOrderedList().run()" :class="{ 'is-active': editor.isActive('orderedList') }">
              <v-icon icon="mdi-format-list-numbered"></v-icon>
            </button>
            
            <button class="item" @click="editor.chain().focus().toggleBlockquote().run()" :class="{ 'is-active': editor.isActive('blockquote') }">
              <v-icon icon="mdi-format-quote-close"></v-icon>
            </button>
          
            <button class="item" @click="editor.chain().focus().undo().run()" :disabled="!editor.can().chain().focus().undo().run()">
              <v-icon icon="mdi-undo"></v-icon>
            </button>
           
            <button class="item" @click="editor.chain().focus().redo().run()" :disabled="!editor.can().chain().focus().redo().run()">
              <v-icon icon="mdi-redo"></v-icon>
            </button>
      </div>
           
  </div>
  
  <editor-content :editor="editor" />
    <editor-content :editor="editor" />
  </template>
  
  <script>
  import { Editor, EditorContent } from '@tiptap/vue-3'
  import StarterKit from '@tiptap/starter-kit'
  
  export default {
    components: {
      EditorContent,
    },
    props: {
    modelValue: {
      type: String,
      default: '',
    },
    enableEditing: {
      type: Boolean,
      default: true,
    },
  },
  emits: ['update:modelValue'],
    data() {
      return {
        editor: null,
      }
    },
    watch: {
    modelValue(value) {
      // HTML
      // const isSame = this.editor.getHTML() === value
      if (this.editor.getHTML() === value) {
        return
      }
      this.editor.commands.setContent(value, false)
    },
      // JSON
      // const isSame = JSON.stringify(this.editor.getJSON()) === JSON.stringify(value)

    //   if (isSame) {
    //     return
    //   }

    //   this.editor.commands.setContent(value, false)
    // },
  },

  mounted() {
    if (this.enableEditing) {
      this.initializeEditor()
    }
  },
  methods: {
    initializeEditor() {
      this.editor = new Editor({
        extensions: [StarterKit],
        content: this.modelValue,
        onUpdate: () => {
          this.$emit('update:modelValue', this.editor.getHTML())
        },
      })
    },
  },
  //   this.editor = new Editor({
  //     extensions: [
  //       StarterKit,
  //     ],
  //     content: this.modelValue,
  //     onUpdate: () => {
  //       // HTML
  //       this.$emit('update:modelValue', this.editor.getHTML())

  //       // JSON
  //       // this.$emit('update:modelValue', this.editor.getJSON())
  //     },
  //   })
  // },

  beforeUnmount() {
    if (this.editor) {
      this.editor.destroy()

    }
  },
}
</script>

<style>
.icon-row {
display: flex;
flex-wrap: wrap;
margin: 16px 16px 2px 16px;
}
.item {
  margin-right: 8px;
}
</style>