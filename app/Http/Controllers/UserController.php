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
        // Cek permission view-users
        if (!Gate::allows('view-users')) {
            \Log::warning('Unauthorized user list access by user: ' . auth()->id());
            return response()->json(['message' => 'Forbidden'], 403);
        }

        // Return semua user
        return response()->json(User::all());
    }

    public function store(Request $request)
    {
        // Cek permission manage-users
        if (!Gate::allows('manage-users')) {
            \Log::warning('Unauthorized user create attempt by user: ' . auth()->id());
            return response()->json(['message' => 'Forbidden'], 403);
        }

        // Validasi input user baru
        $validated = $request->validate([
            'name' => 'required',
            'email' => 'required|email|unique:users',
            'password' => 'required',
            'role' => 'required|in:admin,manager,staff',
        ]);

        $validated['password'] = Hash::make($validated['password']); // Hash password
        $validated['id'] = (string) Str::uuid(); // Generate UUID untuk id user
        $validated['status'] = true; // Set status user aktif

        // Buat user baru
        $user = User::create($validated);

        return response()->json($user);
    }
}
