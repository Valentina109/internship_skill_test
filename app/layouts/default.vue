<template>
    <div class="relative flex gap-2 h-screen bg-surface-50 dark:bg-surface-900 p-2">
        <div id="app-sidebar-15" class="h-full hidden lg:block lg:static absolute left-0 top-0 py-4 pl-4 lg:p-0 z-50">
            <div class="w-[18rem] h-full flex flex-col bg-surface-50 dark:bg-surface-900 rounded-2xl border lg:border-0 border-surface-100 dark:border-surface-800">
                <a class="inline-flex items-center gap-3 px-6 pt-5 pb-6 cursor-pointer">
                    <span class="font-semibold text-surface-900 dark:text-surface-0">Skills Test</span>
                </a>
                <div class="w-[calc(100%-3rem)] mx-auto h-px bg-surface-200 dark:bg-surface-700 px-6" />
                <div class="px-4 py-6 flex-1">
                    <ul class="flex flex-col gap-2 overflow-hidden">
                        <template v-for="(item, index) of navs" :key="index">
                            <li>
                                <button
                                    :class="
                                        selectedNav === item.label
                                            ? 'bg-surface-0 dark:bg-surface-950 text-surface-900 dark:text-surface-0 border-surface shadow-[0px_-1px_3px_0px_rgba(0,0,0,0.12)_inset]'
                                            : 'border-transparent hover:border-surface-200 dark:hover:border-surface-800 hover:bg-surface-0 dark:hover:bg-surface-950 text-surface-600 dark:text-surface-400'
                                    "
                                    class="z-30 text-left w-full relative flex items-center gap-2 pl-3 pr-2 py-2 rounded-lg cursor-pointer transition-all border"
                                    @click="selectedNav = item.label"
                                >
                                    <i :class="item.icon" class="!text-xl !leading-none" />
                                    <span class="flex-1 font-medium">{{ item.label }}</span>
                                </button>
                            </li>
                        </template>
                    </ul>
                </div>
                <ul class="flex flex-col gap-2 px-4 py-3">
                    <template v-for="(item, index) of bottomNavs" :key="index">
                        <li>
                            <button
                                :class="
                                    selectedNav === item.label
                                        ? 'bg-surface-0 dark:bg-surface-950 text-surface-900 dark:text-surface-0 border-surface shadow-[0px_-1px_3px_0px_rgba(0,0,0,0.12)_inset]'
                                        : 'border-transparent hover:border-surface-200 dark:hover:border-surface-800 hover:bg-surface-0 dark:hover:bg-surface-950 text-surface-600 dark:text-surface-400'
                                "
                                class="z-30 text-left w-full relative flex items-center gap-2 pl-3 pr-2 py-2 rounded-lg cursor-pointer transition-all border"
                                @click="selectedNav = item.label"
                            >
                                <i :class="item.icon" class="!text-xl !leading-none" />
                                <span class="flex-1 font-medium">{{ item.label }}</span>
                            </button>
                        </li>
                    </template>
                    //logout button
                    <li v-if="user">
                        <button
                            @click="logout"
                            class="z-30 text-left w-full relative flex items-center gap-2 pl-3 pr-2 py-2 rounded-lg cursor-pointer transition-all border border-transparent hover:border-surface-200 dark:hover:border-surface-800 hover:bg-surface-0 dark:hover:bg-surface-950 text-surface-600 dark:text-surface-400"
                        >
                            <i class="pi pi-sign-out !text-xl !leading-none" />
                            <span class="flex-1 font-medium">Sign Out</span>
                        </button>
                    </li>

                </ul>
            </div>
        </div>

        <div class="flex-1 flex flex-col gap-6 p-4 rounded-2xl border border-surface bg-surface-0 dark:bg-surface-950">
            <div class="flex sm:items-center flex-wrap sm:flex-row flex-col pb-4 justify-between border-b border-dashed border-surface gap-4">
                <div class="flex items-center gap-2">
                    <a
                        v-styleclass="{
                            selector: '#app-sidebar-15',
                            enterFromClass: 'hidden',
                            enterActiveClass: 'animate-fadeinleft',
                            leaveToClass: 'hidden',
                            leaveActiveClass: 'animate-fadeoutleft',
                            hideOnOutsideClick: true
                        }"
                        class="cursor-pointer block lg:hidden text-surface-700 dark:text-surface-100 mr-2"
                    >
                        <i class="pi pi-bars !text-2xl" />
                    </a>
                </div>
                <div class="flex items-center gap-2">
                    <Button icon="pi pi-bell" outlined severity="secondary" />
                    <Avatar image="https://fqjltiegiezfetthbags.supabase.co/storage/v1/render/image/public/block.images/blocks/avatars/circle/avatar-f-1.png" size="large" shape="square" class="!w-9 !h-9" />
                </div>
            </div>
            <div class="flex-1 px-12">
                <slot />
            </div>
        </div>
    </div>
</template>

<script setup>
const search = ref();
const selectedNav = ref('Dashboard');
const bottomNavs = ref([
    {
        icon: 'pi pi-question-circle',
        label: 'Help'
    },
    {
        icon: 'pi pi-cog',
        label: 'Settings'
    }
]);
const navs = ref([
    {
        icon: 'pi pi-home',
        label: 'Dashboard'
    },
]);
const supabase = useSupabaseClient();
const logout = async () => {
  await supabase.auth.signOut();
  await navigateTo('/login');
};
</script>
