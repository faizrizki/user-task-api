const token = localStorage.getItem('token');
// submit form create user
document.getElementById('userForm').addEventListener('submit', async (e) => {
  e.preventDefault();

  const user = {
    name: document.getElementById('name').value,
    email: document.getElementById('email').value,
    password: document.getElementById('password').value,
    role: document.getElementById('role').value
  };

  const response = await fetch('http://127.0.0.1:8000/api/users', {
    method: 'POST',
    headers: { 'Authorization': 'Bearer ' + token, 'Content-Type': 'application/json', 'Accept': 'application/json' },
    body: JSON.stringify(user)
  });

  const data = await response.json();
  alert(data.message || 'User created successfully');
  fetchUsers();
});

async function fetchUsers() {
  const response = await fetch('http://127.0.0.1:8000/api/users', {
    headers: { 'Authorization': 'Bearer ' + token, 'Accept': 'application/json' }
  });

  const users = await response.json();
  const userList = document.getElementById('userList');
  userList.innerHTML = '<ul class="list-group">' + users.map(u => `
    <li class="list-group-item d-flex justify-content-between align-items-center">
      ${u.name} (${u.email}) - ${u.role}
      <span class="badge bg-${u.status ? 'success' : 'secondary'}">${u.status ? 'Active' : 'Inactive'}</span>
    </li>
  `).join('') + '</ul>';
}

fetchUsers();
