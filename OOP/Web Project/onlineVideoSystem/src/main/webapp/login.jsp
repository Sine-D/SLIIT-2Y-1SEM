<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
      <style>
      

    


    .select_box {
      width: 340px;
      position: relative;
      margin: 30px 0;
      text-align: left;
    }
    
    select {
      width: 70%;
      padding: 7px 15px;
      background-color: #2a2a2a;
      color: #e0e0e0;
      border: none;
      border-radius: 5px;
      font-size: 16px;
      -webkit-appearance: none;
      -moz-appearance: none;
      appearance: none;
      cursor: pointer;
      outline: none;
    }
    
    .select_box::after {
      content: "";
      position: absolute;
      right: 20px;
      top: 50%;
      transform: translateY(-50%);
      width: 0;
      height: 0;
      border-left: 6px solid transparent;
      border-right: 6px solid transparent;
      border-top: 6px solid #ff5722;
      pointer-events: none;
    }
    
    select:focus {
      box-shadow: 0 0 0 2px rgba(255, 87, 34, 0.3);
    }
    
    select option {
      background-color: #2a2a2a;
      color: #e0e0e0;
    }
  </style>
</head>
<body>
	

<div class="container">
    <div class="form-box login">
        <% if (request.getAttribute("error") != null) { %>
            <p class="text-red-500 mb-4 text-center"><%= request.getAttribute("error") %></p>
        <% } %>
        <form action="${pageContext.request.contextPath}/SignInServlet" method="post" id="loginForm" onsubmit="return validateLoginForm()">
            <h1>Login</h1>
            <div class="input-box">
                <input type="email" id="loginEmail" name="email" placeholder="Email" required>
                <i class='bx bxs-envelope'></i>
            </div>
            <div class="input-box">
                <input type="password" id="loginPassword" name="password" placeholder="Password" required>
                <i class='bx bxs-lock-alt'></i>
            </div>
            <div class="forgot-link">
                <a href="#">Forgot Password?</a>
            </div>
            <button type="submit" class="btn">Login</button>
            <p>or login with social platforms</p>
            <div class="social-icons">
                <a href="#"><i class='bx bxl-google'></i></a>
                <a href="#"><i class='bx bxl-facebook'></i></a>
                <a href="#"><i class='bx bxl-github'></i></a>
                <a href="#"><i class='bx bxl-linkedin'></i></a>
            </div>
             <br>
        <a href="loginCus.jsp"
   style="font-size: 15px; color: white; text-decoration: none;"
   onmouseover="this.style.color='orange'; this.style.textDecoration='underline';"
   onmouseout="this.style.color='white'; this.style.textDecoration='none';">
   Customer Care Officer Logging
</a>

        </form>
       
    </div>

    <div class="form-box register">
        <% if (request.getAttribute("error") != null) { %>
            <p class="text-red-500 text-center mb-4"><%= request.getAttribute("error") %></p>
        <% } %>
        <% if (request.getAttribute("success") != null) { %>
            <p class="text-green-500 text-center mb-4"><%= request.getAttribute("success") %></p>
        <% } %>
        <form action="${pageContext.request.contextPath}/SignupServlet" method="post" id="registerForm" onsubmit="return validateRegisterForm()">
            <h1>Registration</h1>
            <div class="input-box">
                <input type="text" id="username" name="username" placeholder="Username" required>
                <i class='bx bxs-user'></i>
            </div>
            <div class="input-box">
                <input type="email" id="registerEmail" name="email" placeholder="Email" required oninput="validateEmail(this)">
                <i class='bx bxs-envelope'></i>
                <span id="emailError" class="error-message"></span>
            </div>
            <div class="input-box">
                <input type="password" id="registerPassword" name="password" placeholder="Password" required oninput="validatePassword(this)">
                <i class='bx bxs-lock-alt'></i>
                <span id="passwordError" class="error-message"></span>
            </div>
            <div class="input-box">
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required oninput="validateConfirmPassword(this)">
                <i class='bx bxs-lock-alt'></i>
                <span id="confirmPasswordError" class="error-message"></span>
            </div>
           <div class="select_box">
			    <select id="role" name="role" required>
			      <option value="" disabled selected>Select your role</option>
			      <option value="normal">Normal</option>
			      <option value="creator">Creator</option>
			    </select>
			  </div>
			  
			  
            <button type="submit" class="btn">Register</button>
        </form>
    </div>

    <div class="toggle-box">
        <div class="toggle-panel toggle-left">
            <h1>Hello, Welcome!</h1>
            <p>Don't have an account?</p>
            <button class="btn register-btn">Register</button>
        </div>
        <div class="toggle-panel toggle-right">
            <h1>Welcome Back!</h1>
            <p>Already have an account?</p>
            <button class="btn login-btn">Login</button>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/login.js"></script>
<script>
    function validateEmail(input) {
        const email = input.value;
        const emailError = document.getElementById('emailError');
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (email && !emailPattern.test(email)) {
            emailError.textContent = 'Please enter a valid email address.';
            emailError.style.display = 'block';
        } else {
            emailError.textContent = '';
            emailError.style.display = 'none';
        }
    }

    function validatePassword(input) {
        const password = input.value;
        const passwordError = document.getElementById('passwordError');
        if (password && password.length < 8) {
            passwordError.textContent = 'Password must be at least 8 characters long.';
            passwordError.style.display = 'block';
        } else {
            passwordError.textContent = '';
            passwordError.style.display = 'none';
        }
    }

    function validateConfirmPassword(input) {
        const confirmPassword = input.value;
        const password = document.getElementById('registerPassword').value;
        const confirmPasswordError = document.getElementById('confirmPasswordError');
        if (confirmPassword && confirmPassword !== password) {
            confirmPasswordError.textContent = 'Passwords do not match.';
            confirmPasswordError.style.display = 'block';
        } else {
            confirmPasswordError.textContent = '';
            confirmPasswordError.style.display = 'none';
        }
    }

    function validateLoginForm() {
        const email = document.getElementById('loginEmail').value;
        const password = document.getElementById('loginPassword').value;
        let isValid = true;
        if (!email || !password) {
            alert('Email and password are required.');
            isValid = false;
        }
        return isValid;
    }

    function validateRegisterForm() {
        const username = document.getElementById('username').value;
        const email = document.getElementById('registerEmail').value;
        const password = document.getElementById('registerPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const role = document.getElementById('role').value;
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        let isValid = true;

        if (!username || !email || !password || !confirmPassword || !role) {
            alert('All fields are required.');
            isValid = false;
        } else if (!emailPattern.test(email)) {
            document.getElementById('emailError').textContent = 'Please enter a valid email address.';
            document.getElementById('emailError').style.display = 'block';
            isValid = false;
        } else if (password.length < 8) {
            document.getElementById('passwordError').textContent = 'Password must be at least 8 characters long.';
            document.getElementById('passwordError').style.display = 'block';
            isValid = false;
        } else if (password !== confirmPassword) {
            document.getElementById('confirmPasswordError').textContent = 'Passwords do not match.';
            document.getElementById('confirmPasswordError').style.display = 'block';
            isValid = false;
        } else if (role !== 'normal' && role !== 'creator') {
            alert('Invalid role selected.');
            isValid = false;
        }

        return isValid;
    }
</script>

<jsp:include page="includes/alert.jsp"/>

</body>
</html>