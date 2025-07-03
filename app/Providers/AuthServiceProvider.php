<?php

namespace App\Providers;

use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Gate; // ✅ Import Gate

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The model to policy mappings for the application.
     *
     * @var array<class-string, class-string>
     */
    protected $policies = [
        // 'App\Models\Model' => 'App\Policies\ModelPolicy',
    ];

    /**
     * Register any authentication / authorization services.
     *
     * @return void
     */
    public function boot()
    {
        $this->registerPolicies();

        // Gate role permission

        Gate::define('manage-users', function ($user) {
            return $user->role === 'admin';
        });

        Gate::define('view-users', function ($user) {
            return in_array($user->role, ['admin', 'manager']);
        });

        Gate::define('view-logs', function ($user) {
            return $user->role === 'admin';
        });

        Gate::define('manage-tasks', function ($user) {
            return in_array($user->role, ['admin', 'manager', 'staff']);
        });

        // Contoh tambahan: only manager can assign task to staff
        Gate::define('assign-task', function ($user) {
            return $user->role === 'manager';
        });
    }
}
