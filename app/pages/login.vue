<template>
    <div class="py-20 flex items-center justify-center bg-surface-50 dark:bg-surface-950 min-h-screen">
        <div class="max-w-xl w-full flex flex-col items-center gap-8 bg-surface-0 dark:bg-surface-900 pt-12 pb-6 px-6 rounded-3xl shadow-[0px_24px_48px_0px_rgba(0,0,0,0.04)]">
            <h1 class="text-center text-3xl font-medium text-surface-900 dark:text-surface-0">Welcome Back</h1>
            <div class="flex flex-col gap-6 w-full">
                <div class="flex flex-col gap-2">
                    <label for="email">Email</label>
                    <InputText id="email" v-model="email" placeholder="Email Address" class="dark:!bg-surface-900" />
                </div>
                <div class="flex flex-col gap-2">
                    <label for="password">Password</label>
                    <InputText id="password" v-model="password" placeholder="Password" class="dark:!bg-surface-900" />
                </div>
            </div>
            <div class="flex items-center justify-between w-full">
                <div class="flex items-center">
                    <Checkbox v-model="remember" input-id="remember_me" name="pizza" value="Cheese" />
                    <label for="remember_me" class="ml-2 text-surface-700 dark:text-surface-300"> Remember me </label>
                </div>
                <a href="#" class="font-medium text-primary hover:text-primary-emphasis transition-all">Forgot your password?</a>
            </div>
            <Button label="Sign In" class="w-full" @click ="handleLogin"/>
            <p v-if="errorMessage" class="text-red-500">{{ errorMessage }}</p>

        </div>
    </div>
</template>
<script setup>
definePageMeta({
    layout: 'blank'
});

const email = ref('');
const password = ref('');
const remember = ref(false);

//TODO: add login logic
const errorMessage = ref('');
const supabase = useSupabaseClient();

const handleLogin = async () => {
  errorMessage.value = '';

  const { error } = await supabase.auth.signInWithPassword({
    email: email.value,
    password: password.value
  });

  if (error) {
    errorMessage.value = error.message;
  } else {
    navigateTo('/');
  }
};
const user = useSupabaseUser();
watchEffect(() => {
  if (user.value) {
    navigateTo('/');
  }
});
    </script>