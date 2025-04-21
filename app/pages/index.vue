<template>
    <div>
        <div class="flex md:items-center md:justify-between flex-col md:flex-row pb-6 border-b border-surface">
            <div class="flex items-center">
                <i class="pi pi-inbox !text-2xl !leading-normal mr-4 text-surface-500 dark:text-surface-300" />
                <span class="text-3xl font-medium text-surface-900 dark:text-surface-0">My Tasks</span>
            </div>
            <div class="mt-4 md:mt-0">
                <Button label="Settings" class="mr-4" outlined icon="pi pi-cog" />
                <Button label="Create" icon="pi pi-plus" />
            </div>
        </div>
        <h1>
            My Tasks
        </h1>
        <!-- TODO: Implement task management tool here -->
    </div>
</template>
<script setup>
definePageMeta({
    layout: 'default'
});
</script>