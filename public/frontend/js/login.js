console.log('Login JS loaded');

document.addEventListener('DOMContentLoaded', () => {
  const form = document.getElementById('loginForm');
  console.log('Form element:', form);

  form.addEventListener('submit', async (e) => {
    e.preventDefault();
    console.log('Login form submitted');

    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;

    console.log('Submitting login for:', email);

    try {
        const response = await fetch('http://127.0.0.1:8000/api/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
        },
        body: JSON.stringify({ email, password }),
        mode: 'cors', // Ensure CORS is enabled
    });

    console.log('Fetch response status:', response.status);

    const data = await response.json();
    console.log('Login response data:', data);
    if (response.ok) {
      console.log('Login successful, redirecting...');
      localStorage.setItem('token', data.token);
      localStorage.setItem('role', data.user.role);
      window.location.href = 'index.html';
    } else {
      console.log('Login failed:', data.message);
      alert(data.message);
    }
  } catch (error) {
    console.error('Fetch error:', error.name, error.message);
    alert('Login failed due to fetch error: ' + error.message);
    
}

  });
});
