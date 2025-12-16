<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Create New Customer Care Officer</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            font-family: 'Red Hat Display', sans-serif;
            font-weight: 400;
            background: #1f2937;
            height: 100vh;
            margin: 0;
            color: #e5e7eb;
        }

        .form-container {
            margin: 40px auto;
            width: 100%;
            max-width: 500px;
            background: #2d3748;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
            border-radius: 12px;
            overflow: hidden;
            padding: 24px;
        }

        .badge {
            display: inline-block;
            padding: 6px 12px;
            background: linear-gradient(45deg, #ef4444, #f87171);
            color: #fff;
            font-size: 12px;
            font-weight: 700;
            border-radius: 20px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .badge:hover {
            transform: scale(1.1);
            box-shadow: 0 4px 10px rgba(239, 68, 68, 0.4);
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        }

        .logout {
            display: inline-flex;
            align-items: center;
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .logout:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        }

        .avatar {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #ef4444, #b91c1c);
            color: #fff;
            font-size: 20px;
            border-radius: 50%;
            border: 2px solid #f87171;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .avatar:hover {
            box-shadow: 0 0 15px rgba(239, 68, 68, 0.5);
        }

        .error-message {
            color: #ef4444;
            font-size: 12px;
            margin-top: 4px;
        }
    </style>
</head>
<body class="bg-gray-900 text-white font-sans">
    <div class="flex h-screen">
        <!-- Sidebar Overlay -->
        <div id="overlay" class="fixed inset-0 z-20 bg-black bg-opacity-60 hidden md:hidden"></div>
        <!-- Sidebar -->
        <aside id="sidebar" class="fixed z-30 inset-y-0 left-0 w-48 bg-gray-800 shadow-lg transform -translate-x-full transition-transform duration-300 md:translate-x-0 md:static md:inset-0">
            <div class="p-4 text-xl font-extrabold text-red-500 border-b border-gray-700 text-center">Admin</div>
            <nav class="mt-6">
                <ul class="space-y-6 text-center">
                    <li class="text-white font-medium py-2">
                        <a href="admin" class="flex flex-col items-center space-y-2">
                            <span class="badge">Dashboard</span>
                        </a>
                    </li>
                    <li class="text-white font-medium py-2">
                        <a href="admin/actions" class="flex flex-col items-center space-y-2">
                            <span class="badge">Records</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </aside>
        <!-- Main Content -->
        <div class="flex-1 flex flex-col w-full">
            <!-- Top Bar -->
            <header class="bg-gray-800 shadow px-6 py-4 flex justify-center items-center relative">
                <button id="menu-toggle" class="absolute left-4 md:hidden text-gray-300 focus:outline-none">
                    <span class="text-sm font-bold bg-red-500 text-white px-2 py-1 rounded">MENU</span>
                </button>
                <h1 class="text-2xl font-bold text-red-500 text-center w-full">Create New Customer Care Officer</h1>
                <div class="absolute right-4 flex items-center gap-4">
                    <div class="hidden sm:flex flex-col items-center">
                        <% String profilePictureUrl = (String) session.getAttribute("profilePictureUrl");
                           if (profilePictureUrl != null && !profilePictureUrl.isEmpty()) { %>
                            <img src="<%= profilePictureUrl %>" alt="Profile Photo" class="w-10 h-10 rounded-full object-cover mr-2">
                        <% } else { %>
                            <div class="avatar"><i class="fa-solid fa-user"></i></div>
                        <% } %>
                        <p class="text-sm font-semibold text-gray-300"><%= session.getAttribute("username") != null ? session.getAttribute("username") : "Admin" %></p>
                    </div>
                    <a href="${pageContext.request.contextPath}/logout" class="action-btn bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded logout">Logout</a>
                </div>
            </header>
            <!-- Main Area -->
            <main class="p-6 flex-1 overflow-auto">
                <div class="max-w-4xl w-full mx-auto px-4">
                    <div class="form-container">
                        <h3 class="text-xl font-semibold text-white mb-4">Create New Officer</h3>
                        <% if (request.getAttribute("error") != null) { %>
                            <p class="error-message"><%= request.getAttribute("error") %></p>
                        <% } %>
                        <form id="createAdminForm" action="createAdmin" method="POST" onsubmit="return validateForm(event)">
                            <div class="mb-4">
                                <label class="block text-sm text-gray-300">Officer Name</label>
                                <input type="text" name="userName" class="w-full p-2 bg-gray-700 rounded text-white" required>
                            </div>
                            <div class="mb-4">
                                <label class="block text-sm text-gray-300">Email</label>
                                <input type="email" name="email" class="w-full p-2 bg-gray-700 rounded text-white" required oninput="validateEmail(this)">
                                <span id="emailError" class="error-message"></span>
                            </div>
                            <div class="mb-4">
                                <label class="block text-sm text-gray-300">Phone Number</label>
                                <input type="text" name="phoneNumber" class="w-full p-2 bg-gray-700 rounded text-white" pattern="[0-9]{10}" title="Phone number must be exactly 10 digits" oninput="validatePhone(this)">
                                <span id="phoneError" class="error-message"></span>
                            </div>
                            <div class="mb-4">
                                <label class="block text-sm text-gray-300">Password</label>
                                <input type="password" name="password" class="w-full p-2 bg-gray-700 rounded text-white" required>
                            </div>
                            <div class="mb-4">
                                <label class="block text-sm text-gray-300">Confirm Password</label>
                                <input type="password" name="confirmPassword" class="w-full p-2 bg-gray-700 rounded text-white" required>
                                <span id="passwordError" class="error-message"></span>
                            </div>
                            <div class="flex justify-end space-x-2">
                                <a href="admin" class="action-btn bg-gray-600 hover:bg-gray-700 text-white px-4 py-2 rounded">Cancel</a>
                                <button type="submit" class="action-btn bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded">Save</button>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <!-- Sidebar Toggle Script -->
    <script>
        const menuToggle = document.getElementById('menu-toggle');
        const sidebar = document.getElementById('sidebar');
        const overlay = document.getElementById('overlay');
        menuToggle.addEventListener('click', () => {
            sidebar.classList.toggle('-translate-x-full');
            overlay.classList.toggle('hidden');
        });
        overlay.addEventListener('click', () => {
            sidebar.classList.add('-translate-x-full');
            overlay.classList.add('hidden');
        });

        // Real-time email validation
        function validateEmail(input) {
            const email = input.value;
            const emailError = document.getElementById('emailError');
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (email && !emailPattern.test(email)) {
                emailError.textContent = 'Please enter a valid email address (e.g., user@example.com)';
            } else {
                emailError.textContent = '';
            }
        }

        // Real-time phone number validation
        function validatePhone(input) {
            const phoneNumber = input.value;
            const phoneError = document.getElementById('phoneError');
            const phonePattern = /^[0-9]*$/;
            const phoneLength = phoneNumber.length;
            if (phoneNumber && !phonePattern.test(phoneNumber)) {
                phoneError.textContent = 'Phone number must contain only numbers';
            } else if (phoneNumber && phoneLength !== 10) {
                phoneError.textContent = 'Phone number must be exactly 10 digits';
            } else {
                phoneError.textContent = '';
            }
        }

        // Form submission validation
        function validateForm(event) {
            event.preventDefault();
            let isValid = true;
            const email = document.querySelector('input[name="email"]').value;
            const emailError = document.getElementById('emailError');
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                emailError.textContent = 'Please enter a valid email address (e.g., user@example.com)';
                isValid = false;
            } else {
                emailError.textContent = '';
            }

            const phoneNumber = document.querySelector('input[name="phoneNumber"]').value;
            const phoneError = document.getElementById('phoneError');
            const phonePattern = /^[0-9]*$/;
            const phoneLength = phoneNumber.length;
            if (phoneNumber && !phonePattern.test(phoneNumber)) {
                phoneError.textContent = 'Phone number must contain only numbers';
                isValid = false;
            } else if (phoneNumber && phoneLength !== 10) {
                phoneError.textContent = 'Phone number must be exactly 10 digits';
                isValid = false;
            } else {
                phoneError.textContent = '';
            }

            const password = document.querySelector('input[name="password"]').value;
            const confirmPassword = document.querySelector('input[name="confirmPassword"]').value;
            const passwordError = document.getElementById('passwordError');
            if (password !== confirmPassword) {
                passwordError.textContent = 'Passwords do not match';
                isValid = false;
            } else if (password.length < 8) {
                passwordError.textContent = 'Password must be at least 8 characters long';
                isValid = false;
            } else {
                passwordError.textContent = '';
            }

            if (isValid) {
                document.getElementById('createAdminForm').submit();
            }
            return isValid;
        }
    </script>
</body>
</html>