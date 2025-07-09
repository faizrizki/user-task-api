const token = localStorage.getItem('token');
var role = localStorage.getItem('role');
const currentUserId = localStorage.getItem('user_id');

if (!token) {
  window.location.href = 'login.html';
}

console.log('Using token:', token);

async function fetchTasks() {
  const response = await fetch('http://127.0.0.1:8000/api/tasks', {
    headers: { 
      'Authorization': 'Bearer ' + token, 
      'Accept': 'application/json'
    }
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

// Fungsi create task (untuk manager)
async function createTask() {
  const title = document.getElementById('title').value;
  const description = document.getElementById('description').value;
  const assigned_to = document.getElementById('assigned_to').value;
  const due_date = document.getElementById('due_date').value;

  if (!title || !description || !assigned_to || !due_date) {
    alert('Please fill in all fields');
    return;
  }

  const response = await fetch('http://127.0.0.1:8000/api/tasks', {
    method: 'POST',
    headers: {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ title, description, assigned_to, due_date })
  });

  if (response.ok) {
    alert('Task created successfully');
    // Clear form
    document.getElementById('title').value = '';
    document.getElementById('description').value = '';
    document.getElementById('assigned_to').value = '';
    document.getElementById('due_date').value = '';
    fetchTasks();
  } else {
    const error = await response.json();
    console.error('Create task failed:', error);
    alert('Failed to create task: ' + (error.message || 'Unknown error'));
  }
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
    fetchTasks();
  } else {
    const error = await response.json();
    console.error('Delete failed:', error);
    alert('Failed to delete task: ' + (error.message || 'Unknown error'));
  }
}

// Fungsi redirect ke halaman edit task
function editTask(taskId) {
  window.location.href = `edit_task.html?id=${taskId}`;
}

//Logout: hapus token dan redirect ke login
document.getElementById('logoutBtn').addEventListener('click', () => {
  localStorage.removeItem('token');
  localStorage.removeItem('role');
  localStorage.removeItem('user_id');
  window.location.href = 'login.html';
});

// Menampilkan tombol View Logs hanya untuk admin
const logsButton = document.getElementById('logsButton');
if (logsButton) {
  if (role === 'admin') {
    logsButton.innerHTML = '<a href="logs.html" class="btn btn-warning btn-sm">View Activity Logs</a>';
  } else {
    logsButton.innerHTML = '';
  }
}


fetchTasks();
