<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\Task;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Str;
use Tests\TestCase;

class UserTaskApiTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();

        // Buat user admin, manager, staff default untuk testing
        $this->admin = User::factory()->create([
            'role' => 'admin',
            'password' => bcrypt('password')
        ]);

        $this->manager = User::factory()->create([
            'role' => 'manager',
            'password' => bcrypt('password')
        ]);

        $this->staff = User::factory()->create([
            'role' => 'staff',
            'password' => bcrypt('password')
        ]);
    }

    /** @test */
    public function admin_can_login_and_receive_token()
    {
        // Test login API untuk admin
        $response = $this->postJson('/api/login', [
            'email' => $this->admin->email,
            'password' => 'password'
        ]);

        $response->assertStatus(200)
                 ->assertJsonStructure(['token']);
    }

    /** @test */
    public function admin_can_create_user()
    {
        // Test create user oleh admin
        $token = $this->admin->createToken('api_token')->plainTextToken;

        $response = $this->postJson('/api/users', [
            'name' => 'Test User',
            'email' => 'testuser@example.com',
            'password' => 'password',
            'role' => 'staff'
        ], [
            'Authorization' => "Bearer $token"
        ]);

        $response->assertStatus(200);
        $this->assertDatabaseHas('users', ['email' => 'testuser@example.com']);
    }

    /** @test */
    public function manager_can_create_task_for_staff()
    {
        // Test manager create task untuk staff
        $token = $this->manager->createToken('api_token')->plainTextToken;

        $response = $this->postJson('/api/tasks', [
            'title' => 'Manager Task',
            'description' => 'Desc',
            'assigned_to' => $this->staff->id,
            'due_date' => now()->addDays(2)->toDateString(),
        ], [
            'Authorization' => "Bearer $token"
        ]);

        $response->assertStatus(200);
        $this->assertDatabaseHas('tasks', ['title' => 'Manager Task']);
    }

    /** @test */
    public function staff_can_update_own_task_status()
    {
        // Test staff update status task sendiri
        $task = Task::create([
            'id' => (string) Str::uuid(),
            'title' => 'Test Task',
            'description' => 'Task Desc',
            'assigned_to' => $this->staff->id,
            'status' => 'pending',
            'due_date' => now()->addDay(),
            'created_by' => $this->manager->id,
        ]);

        $token = $this->staff->createToken('api_token')->plainTextToken;

        $response = $this->putJson("/api/tasks/{$task->id}", [
            'status' => 'in_progress',
        ], [
            'Authorization' => "Bearer $token"
        ]);

        $response->assertStatus(200);
        $this->assertDatabaseHas('tasks', ['id' => $task->id, 'status' => 'in_progress']);
    }

    /** @test */
    public function admin_can_delete_task()
    {
        // Test admin delete task
        $task = Task::create([
            'id' => (string) Str::uuid(),
            'title' => 'Task Delete',
            'description' => 'Desc',
            'assigned_to' => $this->staff->id,
            'status' => 'pending',
            'due_date' => now()->addDay(),
            'created_by' => $this->admin->id,
        ]);

        $token = $this->admin->createToken('api_token')->plainTextToken;

        $response = $this->deleteJson("/api/tasks/{$task->id}", [], [
            'Authorization' => "Bearer $token"
        ]);

        $response->assertStatus(200);
        $this->assertDatabaseMissing('tasks', ['id' => $task->id]);
    }
}
