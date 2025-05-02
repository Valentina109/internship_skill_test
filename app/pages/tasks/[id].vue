<template>
    <div class="max-w-xl mx-auto p-4">
      <button @click="navigateTo('/')">← Back</button>
  
      <div v-if="task" class="mt-6 bg-white p-4 rounded shadow space-y-2">
        <div v-if="!editMode">
          <h2 class="text-xl font-bold">{{ task.title }}</h2>
          <p v-if="task.description">{{ task.description }}</p>
          <p>Status: {{ task.status }} | Priority: {{ task.priority }}</p>
          <p>Due: {{ formatDate(task.due_date) || 'Not set' }}</p>
          <p>Created: {{ formatDate(task.created_at) }}</p>
          <p v-if="task.updated_at !== task.created_at">Updated: {{ formatDate(task.updated_at) }}</p>
  
          <div class="flex gap-2 mt-4">
            <button @click="editMode = true">Edit</button>
            <button @click="confirmDelete" class="text-red-500">Delete</button>
          </div>
        </div>
  
        <div v-else>
          <input v-model="editTask.title" class="border rounded px-2 py-1 w-full" />
          <textarea v-model="editTask.description" class="border rounded px-2 py-1 w-full mt-2" />
          <div class="mt-2 space-y-2">
            <select v-model="editTask.status" class="w-full border rounded px-2 py-1">
              <option value="not_started">Not Started</option>
              <option value="in_progress">In Progress</option>
              <option value="completed">Completed</option>
            </select>
            <select v-model="editTask.priority" class="w-full border rounded px-2 py-1">
              <option value="low">Low</option>
              <option value="medium">Medium</option>
              <option value="high">High</option>
            </select>
            <input type="date" v-model="editTask.due_date" class="w-full border rounded px-2 py-1" />
          </div>
  
          <div class="flex gap-2 mt-4">
            <button @click="submitEdit">Save</button>
            <button @click="editMode = false">Cancel</button>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  const route = useRoute()
  const task = ref(null)
  const editTask = ref({})
  const editMode = ref(false)
  const supabase = useSupabaseClient()
  
  const fetchTask = async () => {
    const { data, error } = await supabase.from('tasks').select('*').eq('id', route.params.id).single()
    if (error) return showError({ statusCode: 404, message: 'Task not found' })
    task.value = data
    editTask.value = { ...data }
  }
  await fetchTask()
  
  const formatDate = (date) => date && new Date(date).toLocaleDateString()
  
  const confirmDelete = async () => {
    if (confirm('Are you sure you want to delete this task?')) {
      await supabase.from('tasks').delete().eq('id', route.params.id)
      navigateTo('/')
    }
  }
  
  const submitEdit = async () => {
    const { data, error } = await supabase
      .from('tasks')
      .update({ ...editTask.value, updated_at: new Date().toISOString() })
      .eq('id', route.params.id)
      .select()
      .single()
    if (!error) {
      task.value = data
      editMode.value = false
    }
  }
  </script>
  