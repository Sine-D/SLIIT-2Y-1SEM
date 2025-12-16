<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Admin Dashboard</title>
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

        table {
            margin: 40px auto;
            border-spacing: 0;
            width: 100%;
            max-width: 900px;
            background: #2d3748;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
            border-radius: 12px;
            overflow: hidden;
        }

        table thead {
            background: linear-gradient(90deg, #b91c1c, #7f1414);
        }

        table thead tr th {
            color: #fff;
            font-size: 16px;
            font-weight: 600;
            padding: 16px;
            text-align: center;
            text-transform: uppercase;
        }

        table tbody tr {
            border-bottom: 1px solid #4b5563;
            transition: background 0.3s ease;
        }

        table tbody tr:hover {
            background: #374151;
        }

        table tbody td {
            padding: 16px;
            color: #d1d5db;
            text-align: center;
            font-size: 14px;
        }

        table thead th:first-of-type {
            border-radius: 12px 0 0 0;
        }

        table thead th:last-of-type {
            border-radius: 0 12px 0 0;
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
                        <a href="#" class="flex flex-col items-center space-y-2">
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
                <h1 class="text-2xl font-bold text-red-500 text-center w-full">Dashboard</h1>
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
                    <a href="${pageContext.request.contextPath}/SignOutServlet" class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded text-sm transition-all hover:shadow-lg logout">Logout</a>
                </div>
            </header>
            <!-- Main Area -->
            <main class="p-6 flex-1 overflow-auto">
                <div class="max-w-4xl w-full mx-auto px-4">
                    <div class="flex flex-col items-center mb-6 space-y-4">
                        <h2 class="text-2xl font-semibold text-white text-center">Manage Customer Care Officers</h2>
                        <a href="createAdmin" class="action-btn bg-red-600 hover:bg-red-700 text-white px-6 py-2 rounded-lg shadow animate-pulse">
                            <span>Add Officer</span>
                        </a>
                    </div>
                    <!-- Admin Records Table -->
                    <div class="rounded-lg">
                        <table class="min-w-full text-sm text-black text-center">
                            <thead>
                                <tr>
                                    <th class="px-6 py-3 font-semibold text-red-300">Officer Name</th>
                                    <th class="px-6 py-3 font-semibold text-red-300">Email</th>
                                    <th class="px-6 py-3 font-semibold text-red-300">Phone Number</th>
                                    <th class="px-6 py-3 font-semibold text-red-300">Password</th>
                                    <th class="px-6 py-3 font-semibold text-red-300">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="admin" items="${admins}">
                                    <tr class="hover:bg-gray-700">
                                        <td class="px-6 py-4">${admin.userName}</td>
                                        <td class="px-6 py-4">${admin.email}</td>
                                        <td class="px-6 py-4">${admin.phoneNumber}</td>
                                        <td class="px-6 py-4">${admin.password}</td>
                                        <td class="px-6 py-4">
                                            <div class="flex justify-center space-x-4">
                                                <a href="editAdmin?id=${admin.id}" class="action-btn bg-blue-500 hover:bg-blue-600 text-white">
                                                    <span>Edit</span>
                                                </a>
                                                <a href="deleteAdmin?id=${admin.id}" class="action-btn bg-red-500 hover:bg-red-600 text-white">
                                                    <span>Delete</span>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
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
    </script>
</body>
</html>