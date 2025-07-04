const token = localStorage.getItem('token');
const role = localStorage.getItem('role');
  if (!token) {
      window.location.href = 'login.html';
    }
async function fetchTasks() {
  const response = await fetch('http://127.0.0.1:8000/api/tasks', {
    headers: { 'Authorization': 'Bearer ' + token, 'Accept': 'application/json' }
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
            <!-- Tambah Edit/Delete button sesuai role -->

            ${(role === 'admin' || role === 'manager' || (role === 'staff' && task.assigned_to === currentUserId)) ? `
              <button class="btn btn-primary btn-sm">Edit</button>
              <button class="btn btn-danger btn-sm">Delete</button>
            ` : ''}

          </div>
        </div>
      </div>
    `;
  });
}

fetchTasks();
