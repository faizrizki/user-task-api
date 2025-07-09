<?php

namespace App\Providers;

use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Gate;

class AuthServiceProvider extends ServiceProvider
{
    protected $policies = [
        // 'App\Models\Model' => 'App\Policies\ModelPolicy',
    ];

    public function boot()
    {
        $this->registerPolicies();

        // Gate untuk manage users: hanya admin & manager
        Gate::define('manage-users', function ($user) {
            return in_array($user->role, ['admin', 'manager']);
        });

        // Gate untuk view users: hanya admin & manager
        Gate::define('view-users', function ($user) {
            return in_array($user->role, ['admin', 'manager']);
        });

        // Gate untuk view logs: hanya admin
        Gate::define('view-logs', function ($user) {
            return $user->role === 'admin';
        });

        // Gate untuk manage tasks: admin, manager, staff
        Gate::define('manage-tasks', function ($user) {
            return in_array($user->role, ['admin', 'manager', 'staff']);
        });

        // Gate untuk assign task: hanya manager
        Gate::define('assign-task', function ($user) {
            return $user->role === 'manager';
        });
    }
}
