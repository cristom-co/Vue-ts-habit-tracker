
<template>
  <li class="flex items-center justify-between mb-2">
    <span class="text-lg" :class="{ 'line-through': habit.completed }" @click="toggleComplete">{{ habit.name }}</span>
    <div class="pl-5">
      <button @click="remove" class="text-red-500 hover:text-red-700">Remove</button>
    </div>
  </li>
</template>

<script setup lang="ts">
import {ref} from "vue"

const props =  defineProps<{habit: {name: string, completed: boolean}, index: number}>()
const emit = defineEmits(['toggle-complete', 'remove']);

function toggleComplete(){
  emit('toggle-complete', props.index);
}

function remove(){
  emit('remove', props.index);
}
</script>

<style scoped>
.completed {
    text-decoration: line-through;
}
</style>