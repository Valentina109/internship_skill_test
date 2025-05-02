# Nuxt Minimal Starter

Look at the [Nuxt documentation](https://nuxt.com/docs/getting-started/introduction) to learn more.

## Setup

Make sure to install dependencies:

```bash
# npm
npm install

# pnpm
pnpm install

# yarn
yarn install

# bun
bun install
```

## Development Server

Start the development server on `http://localhost:3000`:

```bash
# npm
npm run dev

# pnpm
pnpm dev

# yarn
yarn dev

# bun
bun run dev
```

## Production

Build the application for production:

```bash
# npm
npm run build

# pnpm
pnpm build

# yarn
yarn build

# bun
bun run build
```

Locally preview production build:

```bash
# npm
npm run preview

# pnpm
pnpm preview

# yarn
yarn preview

# bun
bun run preview
```

Check out the [deployment documentation](https://nuxt.com/docs/getting-started/deployment) for more information.
# Task Management Application

A full-featured task management application built with Nuxt 3, Supabase, and Pinia, featuring authentication, CRUD operations, and dark/light mode toggle.
## Features Implemented
Authentication & User Management
Task Management
User Interface
State Management
Key Libraries
`@supabase/supabase-js` 
`date-fns`
`@pinia/nuxt`
## Challenges & Solutions
Challenge:
Initially struggled with whether to combine task list and detail views in index.vue or separate them across multiple components while keeping user profile distinct.

Solution:
Implemented a clear three-view separation:

index.vue - Dedicated to task listing with filtering/sorting
tasks.vue - Handles single task display and editing
profile.vue - Pure user management 
