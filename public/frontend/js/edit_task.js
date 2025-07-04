const token = localStorage.getItem('token');
if (!token) {
  window.location.href = 'login.html';
}

const urlParams = new URLSearchParams(window.location.search);
const taskId = urlParams.get('id');

async function getTaskDetail() {
  const response = await fetch('http://127.0.0.1:8000/api/tasks', {
    headers: {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json'
    }
  });

  const tasks = await response.json();
  const task = tasks.find(t => t.id === taskId);

  if (!task) {
    alert('Task not found');
    window.location.href = 'index.html';
    return;
  }

  document.getElementById('title').value = task.title;
  document.getElementById('description').value = task.description;
  document.getElementById('status').value = task.status;
  document.getElementById('due_date').value = task.due_date;
}

document.getElementById('editTaskForm').addEventListener('submit', async (e) => {
  e.preventDefault();

  const updatedTask = {
    title: document.getElementById('title').value,
    description: document.getElementById('description').value,
    status: document.getElementById('status').value,
    due_date: document.getElementById('due_date').value
  };

  const response = await fetch(`http://127.0.0.1:8000/api/tasks/${taskId}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json'
    },
    body: JSON.stringify(updatedTask)
  });

  if (response.ok) {
    alert('Task updated successfully');
    window.location.href = 'index.html';
  } else {
    const errorData = await response.json();
    alert('Failed to update task: ' + JSON.stringify(errorData.errors));
  }
});

getTaskDetail();
