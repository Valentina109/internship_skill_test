<template>
    <div class="py-20 flex items-center justify-center bg-surface-50 dark:bg-surface-950 min-h-screen">
      <div class="max-w-xl w-full flex flex-col items-center gap-8 bg-surface-0 dark:bg-surface-900 pt-12 pb-6 px-6 rounded-3xl shadow-[0px_24px_48px_0px_rgba(0,0,0,0.04)]">
        <h1 class="text-center text-3xl font-medium text-surface-900 dark:text-surface-0">Create Account</h1>
        <form @submit.prevent="handleRegister" class="flex flex-col gap-6 w-full">
          <div class="flex flex-col gap-2">
            <label for="name">Name</label>
            <InputText id="name" v-model="name" placeholder="Your Name" class="dark:!bg-surface-900" />
          </div>
          <div class="flex flex-col gap-2">
            <label for="email">Email</label>
            <InputText id="email" v-model="email" placeholder="Email Address" class="dark:!bg-surface-900" />
          </div>
          <div class="flex flex-col gap-2">
            <label for="password">Password</label>
            <InputText id="password" type="password" v-model="password" placeholder="Password" class="dark:!bg-surface-900" />
          </div>
          <Button label="Register" class="w-full" type="submit" />
          <p v-if="errorMessage" class="text-red-500 text-sm mt-2 text-center">{{ errorMessage }}</p>
          <p v-if="successMessage" class="text-green-500 text-sm mt-2 text-center">{{ successMessage }}</p>
        </form>
      </div>
    </div>
  </template>
  <script setup>
  definePageMeta({
      layout: 'blank'
  });
const name = ref('');
const email = ref('');
const password = ref('');
const errorMessage = ref('');
const successMessage = ref('');

const supabase = useSupabaseClient();
const handleRegister = async () => {
  errorMessage.value = '';
  successMessage.value = '';

  if (!email.value || !password.value) {
    errorMessage.value = 'Email and password are required.';
    return;
  }
  const { data, error } = await supabase.auth.signUp({
    email: email.value,
    password: password.value,
    options: {
      data: {
        name: name.value,
      }
    }
  });
  if (error) {
    errorMessage.value = error.message;
  } else {
    successMessage.value = 'Registration successful!';
  }
};
const user = useSupabaseUser();

onMounted(() => {
  if (user.value) {
    navigateTo('/');
  }
});
  </script>