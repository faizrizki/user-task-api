<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        // Validasi input email dan password
        $credentials = $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        // Cek kredensial, jika salah return 401
        if (!Auth::attempt($credentials)) {
            return response()->json(['message' => 'Invalid credentials'], 401);
        }

        $user = Auth::user();

        // Jika akun user tidak aktif, return 403
        if (!$user->status) {
            return response()->json(['message' => 'Your account is inactive'], 403);
        }

        // Buat token API untuk user yang login
        $token = $user->createToken('api_token')->plainTextToken;

        // Return response login sukses beserta token dan data user
        return response()->json([
            'message' => 'Login successful',
            'token' => $token,
            'user' => $user,
        ]);
    }
}
