import { defineStore } from 'pinia'

export const useTaskStore = defineStore('tasks', {
  state: () => ({
    tasks: [] as any[],
    loading: false
  }),
  actions: {
    async fetchTasks(supabase: any) {
      this.loading = true
      const { data, error } = await supabase.from('tasks').select('*').order('created_at', { ascending: false })
      if (!error) this.tasks = data
      this.loading = false
    },
    addTask(task: any) {
      this.tasks.unshift(task)
    },
    removeTask(id: string) {
      this.tasks = this.tasks.filter(task => task.id !== id)
    },
    updateTask(updated: any) {
      this.tasks = this.tasks.map(task => task.id === updated.id ? updated : task)
    }
  }
})
