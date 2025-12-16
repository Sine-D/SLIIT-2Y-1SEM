<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.video.model.Contact" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Service Officer Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            background: linear-gradient(135deg, #1a202c 0%, #2d3748 100%);
            color: #e2e8f0;
            transition: all 0.3s ease;
        }
        .card {
            background: rgba(45, 55, 72, 0.9);
            backdrop-filter: blur(10px);
            border-radius: 12px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
        }
        .message-card {
            transition: all 0.3s ease;
        }
        .message-card:hover {
            background-color: #3a506b;
        }
    </style>
</head>
<body class="p-6">
    <!-- Main Content -->
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-2xl font-bold text-white">Customer Service Dashboard</h2>
        <div class="flex items-center space-x-4">
            <p class="text-gray-300">Welcome, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Unknown Officer" %>!</p>
       <a href = "index.jsp">
                <button type="submit" class="bg-red-500 text-white p-2 rounded hover:bg-red-600">Logout</button>
            </a>
        </div>
    </div>

    <h3 class="text-xl font-semibold text-white mb-4">Messages</h3>
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 mb-6">
        <% 
            List<Contact> contacts = (List<Contact>) request.getAttribute("contacts");
            if (contacts != null) {
                for (Contact contact : contacts) {
        %>
        <div class="card p-4 message-card">
            <p class="text-sm text-gray-400">ID: <%= contact.getMessageId() %></p>
            <p class="font-medium">Name: <%= contact.getName() %></p>
            <p class="text-sm text-gray-300">Email: <%= contact.getEmail() %></p>
            <p class="text-sm text-gray-300">Subject: <%= contact.getSubject() %></p>
            <p class="text-sm text-gray-400">Message: <%= contact.getMessage().length() > 50 ? contact.getMessage().substring(0, 50) + "..." : contact.getMessage() %></p>
            <p class="text-sm text-gray-300">Status: <%= contact.getStatus() %></p>
            <p class="text-sm text-gray-300">Handled By: <%= contact.getHandledBy() %></p>
            <p class="text-sm text-gray-400">Created: <%= contact.getCreatedAt() %></p>
            <div class="mt-2 space-x-2">
                <a href="<%= request.getContextPath() %>/officer/edit?id=<%= contact.getMessageId() %>" class="text-blue-400 hover:underline">Edit</a> |
                <a href="<%= request.getContextPath() %>/officer/delete?id=<%= contact.getMessageId() %>" class="text-red-400 hover:underline" onclick="return confirm('Are you sure you want to delete this message?')">Delete</a>
            </div>
        </div>
        <%      }
            }
        %>
    </div>

    <% 
        Contact contactToEdit = (Contact) request.getAttribute("contact");
        if (contactToEdit != null) {
    %>
    <h3 class="text-xl font-semibold text-white mb-4">Edit Message #<%= contactToEdit.getMessageId() %></h3>
    <div class="card p-6">
        <form action="<%= request.getContextPath() %>/officer" method="post" class="space-y-4">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= contactToEdit.getMessageId() %>">
            <div>
                <label for="status" class="block text-sm font-medium text-gray-300">Status</label>
                <select id="status" name="status" class="mt-1 p-2 w-full bg-gray-700 border border-gray-600 rounded text-white">
                    <option value="Pending" <%= "Pending".equals(contactToEdit.getStatus()) ? "selected" : "" %>>Pending</option>
                    <option value="Resolved" <%= "Resolved".equals(contactToEdit.getStatus()) ? "selected" : "" %>>Resolved</option>
                </select>
            </div>
            <div>
                <label for="handledBy" class="block text-sm font-medium text-gray-300">Handled By</label>
                <input type="text" id="handledBy" name="handledBy" value="<%= contactToEdit.getHandledBy() %>" class="mt-1 p-2 w-full bg-gray-700 border border-gray-600 rounded text-white">
            </div>
            <div>
                <label for="internalNotes" class="block text-sm font-medium text-gray-300">Internal Notes</label>
                <textarea id="internalNotes" name="internalNotes" rows="3" class="mt-1 p-2 w-full bg-gray-700 border border-gray-600 rounded text-white"><%= contactToEdit.getInternalNotes() != null ? contactToEdit.getInternalNotes() : "" %></textarea>
            </div>
            <button type="submit" class="w-full bg-green-600 text-white p-2 rounded hover:bg-green-700 transition-colors">Update</button>
        </form>
    </div>
    <% } %>
</body>
</html>