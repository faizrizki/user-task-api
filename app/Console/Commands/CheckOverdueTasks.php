<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Task;
use App\Models\ActivityLog;
use Illuminate\Support\Str;

class CheckOverdueTasks extends Command
{
    protected $signature = 'check:overdue-tasks';
    protected $description = 'Check for overdue tasks and log them';

    public function handle()
    {
    try {
        // Ambil semua task yang sudah lewat due_date dan belum selesai
        $tasks = Task::where('due_date', '<', now())
                     ->where('status', '!=', 'done')
                     ->get();

        foreach ($tasks as $task) {
            // Buat activity log untuk task yang overdue
            ActivityLog::create([
                'id' => (string) Str::uuid(),
                'user_id' => $task->assigned_to,
                'action' => 'task_overdue',
                'description' => 'Task overdue: ' . $task->id,
                'logged_at' => now(),
            ]);
        }

        $this->info('Checked and logged overdue tasks successfully.');
        } catch (\Exception $e) {
            $this->error('Failed to check overdue tasks: ' . $e->getMessage());
        }
    }
}
