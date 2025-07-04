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
            // Staff: hanya lihat task assigned ke dirinya
            $tasks = Task::where('assigned_to', $user->id)->get();
        }
        elseif ($user->role === 'manager') {
            $tasks = Task::where('created_by', $user->id)
                ->orWhereIn('assigned_to', function($query) {
                    $query->select('id')
                        ->from('users')
                        ->where('role', 'staff');
                })
                ->get();
        }

        else {
            // Admin: lihat semua
            $tasks = Task::all();
        }

        \Log::info('Task index accessed by: '.auth()->user()->role);
        \Log::info('User '.$user->id.' role '.$user->role.' fetching tasks.');
        \Log::info('Tasks fetched: ', $tasks->toArray()); 
          
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
        \Log::info('Updating task id: '.$id.' by user: '.Auth::id(), $request->all());

        $task = Task::findOrFail($id);
        $user = Auth::user();

        // Staff: hanya bisa update status jika task diassign ke dia
        if ($user->role === 'staff') {
            if ($task->assigned_to !== $user->id) {
                \Log::warning('Unauthorized staff update attempt by user: '.$user->id);
                return response()->json(['message' => 'Forbidden'], 403);
            }

            $validated = $request->validate([
                'status' => 'required|in:pending,in_progress,done',
            ]);
        }
        // Manager & Admin
        else {
            // Only admin or creator can update
            if ($user->id !== $task->created_by && $user->role !== 'admin') {
                \Log::warning('Unauthorized update attempt by user: '.$user->id);
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

        // Only admin or creator can delete
        if ($user->id !== $task->created_by && $user->role !== 'admin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $task->delete();

        return response()->json(['message' => 'Task deleted']);
    }
}
