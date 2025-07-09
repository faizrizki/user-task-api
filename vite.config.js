import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
  plugins: [
    laravel({
      input: [
        'resources/frontend/js/login.js',
        'resources/frontend/js/dashboard.js',
        'resources/frontend/css/style.css',
        'resources/frontend/js/admin.js',
        'resources/frontend/js/edit_task.js',
        'resources/frontend/admin.html',
        'resources/frontend/edit_task.html',
        'resources/frontend/index.html',
        'resources/frontend/login.html',
      ],
      refresh: true,
    }),
  ],
  build: {
    outDir: 'public/build', 
    rollupOptions: {
      input: {
        login: 'resources/frontend/js/login.js',
        dashboard: 'resources/frontend/js/dashboard.js',
        style: 'resources/frontend/css/style.css',
        admin: 'resources/frontend/js/admin.js',
        editTask: 'resources/frontend/js/edit_task.js',
        adminHtml: 'resources/frontend/admin.html',
        editTaskHtml: 'resources/frontend/edit_task.html',
        indexHtml: 'resources/frontend/index.html',
        loginHtml: 'resources/frontend/login.html',
      },
    },
  },
});
