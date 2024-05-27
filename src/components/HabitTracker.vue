<template>
  <div class="h-screen w-full flex flex-col justify-center items-center">
    <h1 class="text-3xl font-bold mb-4">Habit Tracker</h1>
    <input v-model="newHabit" placeholder="Enter new habit" @keyup.enter="addHabit"
      :class="`rounded-lg border-gray-300 border p-2 mb-4 ${darkMode ? 'inputDark' : ''}`">
    <ul>
      <habit-item v-for="(habit, index) in habits" :key="index" :habit="habit" :index="index"
        @toggle-complete="toggleHabitComplete" @remove="removeHabit"  />
    </ul>
    <div class="mt-4">
      <p class="text-lg font-semibold">Total days: {{ totalDays }}</p>
    </div>
  </div>
</template>

<script lang="ts">
import { ref, onMounted, computed, defineComponent } from 'vue';
import HabitItem from './HabitItem.vue';

interface Habit {
  name: string;
  completed: boolean;
  date: string; // For tracking habit completion date
}

export default defineComponent({
  name: 'HabitTracker',
  props: ['darkMode'],
  components: {
    HabitItem
  },
  setup() {
    const newHabit = ref('');
    const habits = ref<Habit[]>([]);

    const loadHabits = () => {
      const savedHabits = localStorage.getItem('habits');
      if (savedHabits) {
        habits.value = JSON.parse(savedHabits) as Habit[];
      }
    };

    const saveHabits = () => {
      localStorage.setItem('habits', JSON.stringify(habits.value));
    };

    onMounted(loadHabits);

    const addHabit = () => {
      if (newHabit.value.trim() !== '') {
        habits.value.push({ name: newHabit.value, completed: false, date: new Date().toISOString() });
        newHabit.value = '';
        saveHabits();
      }
    };

    const removeHabit = (index: number) => {
      habits.value.splice(index, 1);
      saveHabits();
    };

    const toggleHabitComplete = (index: number) => {
      habits.value[index].completed = !habits.value[index].completed;
      saveHabits();
    };

    const totalDays = computed(() => {
      const dates = habits.value.map(habit => new Date(habit.date).toLocaleDateString());
      const uniqueDates = [...new Set(dates)];
      return uniqueDates.length;
    });

    return {
      newHabit,
      habits,
      addHabit,
      removeHabit,
      toggleHabitComplete,
      totalDays
    };
  }
});
</script>

<style scoped>
.inputDark {
  color: gray
}
</style>