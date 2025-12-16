<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Service Officer Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            background: linear-gradient(135deg, #1a202c 50%, #2d3748 50%);
        }
        .card {
            background: rgba(45, 55, 72, 0.9);
            backdrop-filter: blur(10px);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.5);
        }
        .input-focus {
            transition: all 0.3s ease;
        }
        .input-focus:focus {
            border-color: #ff5100;
            box-shadow: 0 0 0 3px rgba(255, 81, 0, 0.3);
        }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen">
    <div class="flex w-full max-w-4xl rounded-xl overflow-hidden card">
        <!-- Left Side: Decorative Section -->
        <div class="hidden md:block w-1/2 p-8 bg-gradient-to-br from-gray-800 to-gray-900 text-white flex flex-col justify-center items-center">
            <h2 class="text-3xl font-bold mb-4">Welcome Back!</h2>
            <p class="text-gray-300 text-center">Log in to manage customer care with ease and efficiency.</p>
        </div>
        <!-- Right Side: Login Form -->
        <div class="w-full md:w-1/2 p-8">
            <h2 class="text-2xl font-bold text-white mb-6 text-center">Officer Login</h2>
            <% 
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
                <p class="text-red-500 text-center mb-4"><%= error %></p>
            <% } %>
            <form action="<%= request.getContextPath() %>/officer" method="post" class="space-y-5">
                <input type="hidden" name="action" value="login">
                <div>
                    <label for="username" class="block text-sm font-medium text-gray-300">Username</label>
                    <input type="text" id="username" name="username" required class="mt-1 p-3 w-full bg-gray-700 border border-gray-600 rounded-lg text-white input-focus">
                </div>
                <div>
                    <label for="password" class="block text-sm font-medium text-gray-300">Password</label>
                    <input type="password" id="password" name="password" required class="mt-1 p-3 w-full bg-gray-700 border border-gray-600 rounded-lg text-white input-focus">
                </div>
                <button type="submit" style="background-color: #ff5100;" class="w-full text-white p-3 rounded-lg hover:opacity-90 transition-opacity">Login</button>
            </form>
            <p class="text-center text-gray-400 mt-4 text-sm">
                <a href="#" class="text-orange-400 hover:underline">Forgot Password?</a>
            </p>
        </div>
    </div>
</body>
</html>