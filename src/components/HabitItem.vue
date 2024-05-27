
<template>
  <li class="flex items-center justify-between mb-2">
    <span class="text-lg" :class="{ 'line-through': habit.completed }" @click="toggleComplete">{{ habit.name }}</span>
    <div class="pl-5">
      <button @click="remove" class="text-red-500 hover:text-red-700">Remove</button>
    </div>
  </li>
</template>

<script>
import { defineComponent, ref } from 'vue';

export default defineComponent({
  props: ['habit', 'index'],
  setup(props, { emit }) {
    const toggleComplete = () => {
      emit('toggle-complete', props.index);
    };

    const remove = () => {
      emit('remove', props.index);
    };

    return {
      toggleComplete,
      remove
    };
  }
});
</script>

<style scoped>
.completed {
    text-decoration: line-through;
}
</style>