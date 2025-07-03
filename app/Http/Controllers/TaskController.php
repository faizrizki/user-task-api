<?php

namespace App\Http\Controllers;

use App\Models\Task;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Str;

class TaskController extends Controller
{
    public function index()
    {
        $user = Auth::user();

        // Staff: hanya lihat task assigned ke dirinya
        if ($user->role === 'staff') {
            $tasks = Task::where('assigned_to', $user->id)->get();
        }
        // Manager: lihat task yang dibuatnya atau timnya
        elseif ($user->role === 'manager') {
            $tasks = Task::where('created_by', $user->id)->get();
        }
        // Admin: lihat semua
        else {
            $tasks = Task::all();
        }

        return response()->json($tasks);
    }

    public function store(Request $request)
    {
        $user = Auth::user();

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
        $validated['id'] = (string) Str::uuid();

        $task = Task::create($validated);

        return response()->json($task);
    }

    public function update(Request $request, $id)
    {
        $task = Task::findOrFail($id);
        $user = Auth::user();

        // Only admin or creator can update
        if ($user->id !== $task->created_by && $user->role !== 'admin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $validated = $request->validate([
            'title' => 'required',
            'description' => 'required',
            'status' => 'required|in:pending,in_progress,done',
            'due_date' => 'required|date',
        ]);

        $task->update($validated);

        return response()->json($task);
    }

    public function destroy($id)
    {
        $task = Task::findOrFail($id);
        $user = Auth::user();

        // Only admin or creator can delete
        if ($user->id !== $task->created_by && $user->role !== 'admin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $task->delete();

        return response()->json(['message' => 'Task deleted']);
    }
}
