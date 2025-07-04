<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Gate;

class UserController extends Controller
{
    public function index()
    {
        if (!Gate::allows('view-users')) {
            \Log::warning('Unauthorized user list access by user: ' . auth()->id());
            return response()->json(['message' => 'Forbidden'], 403);
        }

        return response()->json(User::all());
    }

    public function store(Request $request)
    {
        if (!Gate::allows('manage-users')) {
            \Log::warning('Unauthorized user create attempt by user: ' . auth()->id());
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $validated = $request->validate([
            'name' => 'required',
            'email' => 'required|email|unique:users',
            'password' => 'required',
            'role' => 'required|in:admin,manager,staff',
        ]);

        $validated['password'] = Hash::make($validated['password']);
        $validated['id'] = (string) Str::uuid();
        $validated['status'] = true;

        $user = User::create($validated);

        return response()->json($user);
    }
}
