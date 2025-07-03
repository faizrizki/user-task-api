<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Gate;

class UserController extends Controller
{
    public function index()
    {
        if (!Gate::allows('view-users')) {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $users = User::all();
        return response()->json($users);
    }

    public function store(Request $request)
    {
        if (!Gate::allows('manage-users')) {
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
