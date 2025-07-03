<?php

namespace App\Http\Controllers;

use App\Models\ActivityLog;
use Illuminate\Support\Facades\Gate;

class LogController extends Controller
{
    public function index()
    {
        if (!Gate::allows('view-logs')) {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $logs = ActivityLog::all();
        return response()->json($logs);
    }
}
