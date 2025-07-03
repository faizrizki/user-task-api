<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\TaskController;
use App\Http\Controllers\LogController;


Route::post('/login', [AuthController::class, 'login']);
Route::middleware(['auth:sanctum', 'checkUserStatus'])->group(function () {

    Route::get('/users', [UserController::class, 'index']);
    Route::post('/users', [UserController::class, 'store']);

    Route::get('/tasks', [TaskController::class, 'index']);
    Route::post('/tasks', [TaskController::class, 'store']);
    Route::put('/tasks/{id}', [TaskController::class, 'update']);
    Route::delete('/tasks/{id}', [TaskController::class, 'destroy']);

    Route::get('/logs', [LogController::class, 'index']);
});
