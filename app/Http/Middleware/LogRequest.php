<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class LogRequest
{
    public function handle(Request $request, Closure $next)
    {
        Log::channel('api_activity')->info($request->method().' '.$request->fullUrl());
        return $next($request);
    }
}
