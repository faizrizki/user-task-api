const token = localStorage.getItem('token');
const role = localStorage.getItem('role');
const currentUserId = localStorage.getItem('user_id'); // Pastikan sudah diset saat login

if (!token) {
  window.location.href = 'login.html';
}

console.log('Using token:', token);

async function fetchTasks() {
  const response = await fetch('http://127.0.0.1:8000/api/tasks', {
    headers: { 
      'Authorization': 'Bearer ' + token, 
      'Accept': 'application/json' }
  });

  const createuser = document.getElementById('createuser');
  createuser.innerHTML = '';
  if (role === 'admin') {
    createuser.innerHTML = '<a class="btn btn-outline-info btn-sm" href="admin.html">Create User</a>';
  }

  const tasks = await response.json();
  const taskList = document.getElementById('taskList');
  taskList.innerHTML = '';

  tasks.forEach(task => {
    const badgeColor = task.status === 'done' ? 'success' :
                       task.status === 'in_progress' ? 'warning' :
                       task.status === 'overdue' ? 'danger' : 'secondary';

    taskList.innerHTML += `
      <div class="col-md-4">
        <div class="card mb-3">
          <div class="card-body">
            <h5 class="card-title">${task.title}</h5>
            <p class="card-text">${task.description}</p>
            <span class="badge bg-${badgeColor}">${task.status}</span>
            <p class="mt-2">Due: ${task.due_date}</p>

            ${(role === 'admin' || role === 'manager' || (role === 'staff' && (task.assigned_to + '' === currentUserId))) ? `
              <button class="btn btn-primary btn-sm edit-btn" data-id="${task.id}">Edit</button>
              <button class="btn btn-danger btn-sm delete-btn" data-id="${task.id}">Delete</button>
            ` : ''}

          </div>
        </div>
      </div>
    `;
  });

  document.querySelectorAll('.delete-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const taskId = btn.getAttribute('data-id');
      deleteTask(taskId);
    });
  });

  document.querySelectorAll('.edit-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const taskId = btn.getAttribute('data-id');
      editTask(taskId);
    });
  });
}

// Fungsi hapus task
async function deleteTask(taskId) {
  if (!confirm('Are you sure you want to delete this task?')) return;

  const response = await fetch(`http://127.0.0.1:8000/api/tasks/${taskId}`, {
    method: 'DELETE',
    headers: {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json'
    }
  });

  if (response.ok) {
    alert('Task deleted successfully');
    fetchTasks(); // refresh list
  } else {
    const error = await response.json();
    console.error('Delete failed:', error);
    alert('Failed to delete task: ' + (error.message || 'Unknown error'));
  }

}

// Fungsi edit task
function editTask(taskId) {
  window.location.href = `edit_task.html?id=${taskId}`;
}

document.getElementById('logoutBtn').addEventListener('click', () => {
  localStorage.removeItem('token');
  localStorage.removeItem('role');
  localStorage.removeItem('user_id');
  window.location.href = 'login.html';
});

fetchTasks();
