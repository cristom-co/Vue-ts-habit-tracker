<template>
  <div :class="{ 'dark': darkMode }">
    <HabitTracker :darkMode="darkMode" />
    <button @click="toggleDarkMode"
      class="fixed bottom-4 right-4 bg-gray-300 dark:bg-gray-800 rounded-full w-12 h-12 flex items-center justify-center">
      <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-gray-800 dark:text-gray-300" fill="none"
        viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6a6 6 0 100 12 6 6 0 000-12z" />
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
          d="M12 4v.01M12 8v.01M12 12v.01M12 16v.01M6 12h.01M8 12h.01M16 12h.01M18 12h.01" />
      </svg>
    </button>
  </div>
</template>

<script>
import { defineComponent, ref, onMounted } from 'vue';
import HabitTracker from './components/HabitTracker.vue';

export default defineComponent({
  name: 'App',
  components: {
    HabitTracker
  },
  setup() {
    const darkMode = ref(false);

    const toggleDarkMode = () => {
      darkMode.value = !darkMode.value;
      localStorage.setItem('darkMode', darkMode.value.toString());
    };

    onMounted(() => {
      const darkModeSetting = localStorage.getItem('darkMode');
      if (darkModeSetting !== null) {
        darkMode.value = darkModeSetting === 'true';
      }
    });

    return {
      darkMode,
      toggleDarkMode
    };
  }
});
</script>

<style>
/* Estilos generales de la aplicación */
.dark {
  background-color: #1f2937;
  color: #f9fafb;
}

</style>