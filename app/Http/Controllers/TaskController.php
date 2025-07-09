<?php

namespace App\Http\Controllers;

use App\Models\Task;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;

class TaskController extends Controller
{
    public function index()
    {
        $user = Auth::user();

        if ($user->role === 'staff') {
            // Staff: lihat hanya task yang diassign ke dia
            $tasks = Task::with(['assignedUser', 'creator'])
                        ->where('assigned_to', $user->id)
                        ->get();
        }
        elseif ($user->role === 'manager') {
            // Manager: lihat task yang dibuat dia atau assigned ke staff
            $tasks = Task::with(['assignedUser', 'creator'])
                        ->where('created_by', $user->id)
                        ->orWhereIn('assigned_to', function($query) {
                            $query->select('id')
                                ->from('users')
                                ->where('role', 'staff');
                        })
                        ->get();
        }
        else {
            // Admin: lihat semua task
            $tasks = Task::with(['assignedUser', 'creator'])->get();
        }

        \Log::info('Tasks fetched by user role: ' . $user->role);

        return response()->json($tasks);
    }

    public function store(Request $request)
    {
        $user = Auth::user();

        // Validasi input task baru
        $validated = $request->validate([
            'title' => 'required',
            'description' => 'required',
            'assigned_to' => 'required|exists:users,id',
            'due_date' => 'required|date',
        ]);

        // Manager hanya bisa assign ke staff
        if ($user->role === 'manager') {
            $assignedUser = User::find($validated['assigned_to']);
            if ($assignedUser->role !== 'staff') {
                return response()->json(['message' => 'Manager can only assign tasks to staff'], 403);
            }
        }

        $validated['created_by'] = $user->id;
        $validated['id'] = (string) Str::uuid(); // Generate UUID untuk id task

        $task = Task::create($validated);

        return response()->json($task);
    }

    public function update(Request $request, $id)
    {
        \Log::info('Updating task id: '.$id);

        $task = Task::findOrFail($id);
        $user = Auth::user();

        if ($user->role === 'staff') {
            // Staff hanya bisa update status task yang diassign ke dia
            if ($task->assigned_to !== $user->id) {
                return response()->json(['message' => 'Forbidden'], 403);
            }

            $validated = $request->validate([
                'status' => 'required|in:pending,in_progress,done',
            ]);
        }
        else {
            // Manager & Admin: bisa update task
            if (!in_array($user->role, ['admin', 'manager']) && $user->id !== $task->created_by) {
                return response()->json(['message' => 'Forbidden'], 403);
            }

            $validated = $request->validate([
                'title' => 'required',
                'description' => 'required',
                'status' => 'required|in:pending,in_progress,done',
                'due_date' => 'required|date',
            ]);
        }

        $task->update($validated);

        \Log::info('Task updated successfully.');

        return response()->json($task);
    }

    public function destroy($id)
    {
        $task = Task::findOrFail($id);
        $user = Auth::user();

        // Hanya admin atau creator yang bisa delete
        if ($user->id !== $task->created_by && $user->role !== 'admin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $task->delete();

        return response()->json(['message' => 'Task deleted']);
    }
}
