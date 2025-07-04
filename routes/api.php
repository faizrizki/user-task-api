<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\TaskController;
use App\Http\Controllers\LogController;
use Illuminate\Support\Facades\Route;

Route::post('/login', [AuthController::class, 'login']);

Route::middleware(['auth:sanctum', 'checkUserStatus'])->group(function () {

    // USER routes, hanya admin
    Route::get('/users', [UserController::class, 'index'])
        ->middleware('can:view-users');
    Route::post('/users', [UserController::class, 'store'])
        ->middleware('can:manage-users');

    // TASK routes, admin, manager, staff
    Route::get('/tasks', [TaskController::class, 'index'])
        ->middleware('can:manage-tasks');
    Route::post('/tasks', [TaskController::class, 'store'])
        ->middleware('can:manage-tasks');
    Route::put('/tasks/{id}', [TaskController::class, 'update'])
        ->middleware('can:manage-tasks');
    Route::delete('/tasks/{id}', [TaskController::class, 'destroy'])
        ->middleware('can:manage-tasks');

    // LOG routes, hanya admin
    Route::get('/logs', [LogController::class, 'index'])
        ->middleware('can:view-logs');
});
