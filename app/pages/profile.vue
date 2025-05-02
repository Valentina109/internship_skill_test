<template>
    <div class="max-w-md mx-auto px-4 py-8">
      <h1 class="text-2xl font-semibold mb-6">My Profile</h1>
  
      <div class="bg-white dark:bg-gray-800 p-6 rounded-lg shadow">
        <div class="flex flex-col items-center space-y-4">
          <div class="w-full space-y-4">
            <div>
              <label class="block text-sm font-medium mb-1">Name</label>
              <input 
                v-model="userName" 
                class="w-full px-3 py-2 border rounded dark:bg-gray-700 dark:border-gray-600"
                placeholder="Your name"
              />
            </div>
          </div>
        </div>
      </div>
  
      <div class="mt-8 text-center">
        <button 
          @click="logout"
          class="text-red-600 hover:text-red-800 dark:text-red-400 dark:hover:text-red-300 transition"
        >
          Sign Out
        </button>
      </div>
    </div>
  </template>
  
  <script setup>
  const supabase = useSupabaseClient()
  const user = useSupabaseUser()
  const router = useRouter()
  const userName = ref('')
  
  onMounted(async () => {
    if (user.value) {
      const { data: profile } = await supabase
        .from('profiles')
        .select('name')
        .eq('id', user.value.id)
        .single()
      
      userName.value = profile?.name || user.value.email.split('@')[0]
    }
  })
  
  const logout = async () => {
    await supabase.auth.signOut()
    router.push('/login')
  }
  </script>