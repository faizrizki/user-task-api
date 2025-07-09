const token = localStorage.getItem('token');

if (!token) {
  window.location.href = 'login.html';
}

async function fetchLogs() {
  const logsList = document.getElementById('logsList');

  try {
    const response = await fetch('http://127.0.0.1:8000/api/logs', {
      headers: {
        'Authorization': 'Bearer ' + token,
        'Accept': 'application/json'
      }
    });

    if (!response.ok) {
      throw new Error('Failed to fetch logs');
    }

    const logs = await response.json();

    if (logs.length === 0) {
      logsList.innerHTML = '<div class="alert alert-info">No activity logs found.</div>';
      return;
    }

    logsList.innerHTML = logs.map(log => `
      <div class="card mb-2">
        <div class="card-body">
          <h5 class="card-title">${log.action}</h5>
          <p class="card-text">${log.description}</p>
          <p class="card-text"><small class="text-muted">User ID: ${log.user_id} | ${log.logged_at}</small></p>
        </div>
      </div>
    `).join('');

  } catch (error) {
    console.error('Error fetching logs:', error);
    logsList.innerHTML = '<div class="alert alert-danger">Failed to load logs.</div>';
  }
}

fetchLogs();
