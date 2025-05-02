<template>
    <div>
        <div class="flex md:items-center md:justify-between flex-col md:flex-row pb-6 border-b border-surface">
            <div class="flex items-center">
                <i class="pi pi-inbox !text-2xl !leading-normal mr-4 text-surface-500 dark:text-surface-300" />
                <span class="text-3xl font-medium text-surface-900 dark:text-surface-0">My Tasks</span>
            </div>
            <div class="mt-4 md:mt-0">
                <Button label="Settings" class="mr-4" outlined icon="pi pi-cog" />
                <Button label="Create" icon="pi pi-plus" @click="showCreateForm = true" />
                <div v-if="showCreateForm" class="mt-4">
                    <input v-model="newTask.title" placeholder="Title" class="input mb-2" />
                    <textarea v-model="newTask.description" placeholder="Description" class="input mb-2"></textarea>
                    <button @click="createTask" class="bg-blue-600 text-white px-3 py-1 rounded">Save</button>
                </div>
            </div>
        </div>
        <h1> 
            My Tasks
        </h1>
        <!-- TODO: Implement task management tool here -->
        <div class="mt-6 space-y-4">
            <div v-for="task in tasks" :key="task.title" class="p-4 rounded shadow bg-white dark:bg-gray-800">
                <h2 class="text-xl font-semibold">{{ task.title }}</h2>
                <p v-if="task.description" class="text-gray-600 dark:text-gray-300">{{ task.description }}</p>
                <p class="text-sm">Due: {{ task.dueDate }} | Priority: {{ task.priority }} | Status: {{ task.status }}</p>
                <p class="text-xs text-gray-500">Created: {{ task.createdAt }} | Updated: {{ task.updatedAt }}</p>
                <div class="mt-2 flex gap-2">
                    <button label ="Edit"icon="pi pi-plus" @click="editTask(task)"/>
                    <button label ="Delete"icon="pi pi-plus" @click="deleteTask(task)"/>
                </div>
            </div>
        </div>
        <div class="flex flex-wrap gap-4 mb-4">
      <div>
        <label class="block text-sm mb-1">Filter by Status</label>
        <select v-model="filterStatus" class="input">
          <option value="">All</option>
          <option value="not started">Not Started</option>
          <option value="in progress">In Progress</option>
          <option value="completed">Completed</option>
        </select>
      </div>
      <div>
        <label class="block text-sm mb-1">Filter by Priority</label>
        <select v-model="filterPriority" class="input">
          <option value="">All</option>
          <option value="low">Low</option>
          <option value="medium">Medium</option>
          <option value="high">High</option>
        </select>
      </div>
      <div>
        <label class="block text-sm mb-1">Sort by</label>
        <select v-model="sortBy" class="input">
          <option value="">None</option>
          <option value="due_date">Due Date</option>
          <option value="created_at">Created Date</option>
          <option value="priority">Priority</option>
        </select>
      </div>
      </div>
      </div>   
    </div>
</template>
<script setup>
definePageMeta({
    layout: 'default'
});
const supabase = useSupabaseClient();
const tasks = ref([]);
const showCreateForm = ref(false);
const editTask = ref(false);
const filterStatus = ref('');
const filterPriority = ref('');
const sortBy = ref('');
const tasks = ref([
  {
    title: '',
    description: '',
    dueDate: '',
    priority: "high",
    status: "in progress",
    createdAt: "2025-04-28",
    updatedAt: "2025-04-29"
  },
])
const fetchTasks = async() => {
    const {data} = await supabase.from('tasks').select('*')
        .order ('created_at',{ascending:false});
    tasks.value = data || [];
    
};
const createTask = async () => {
  if (!newTask.value.title) return;
  const { error } = await supabase
    .from('tasks')
    .insert(newTask.value);
  
  if (!error) {
    showCreateForm.value = false;
    newTask.value = { title: '', description: '' };
    await fetchTasks(); 
  }
};
const deleteTask = async (id) => {
    await supabase.from('tasks').delete().eq('id', id);
    loadTasks();
};
const filteredSortedTasks = computed(() => {
  let result = [...tasks.value];

  if (filterStatus.value) {
    result = result.filter(t => t.status === filterStatus.value);
  }

  if (filterPriority.value) {
    result = result.filter(t => t.priority === filterPriority.value);
  }
  return result;
});
const taskStore = useTaskStore()
const themeStore = useThemeStore()

onMounted(() => {
  taskStore.fetchTasks()
  themeStore.initializeTheme()
})
</script>