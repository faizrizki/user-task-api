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

        // Only admin can manage users
        Gate::define('manage-users', function ($user) {
             return in_array($user->role, ['admin', 'manager']);
        });

        // Only admin and manager can view users
        Gate::define('view-users', function ($user) {
            return in_array($user->role, ['admin', 'manager']);
        });


        Gate::define('view-logs', function ($user) {
            return $user->role === 'admin';
        });

        Gate::define('manage-tasks', function ($user) {
            return in_array($user->role, ['admin', 'manager', 'staff']);
        });

        Gate::define('assign-task', function ($user) {
            return $user->role === 'manager';
        });
    }
}
