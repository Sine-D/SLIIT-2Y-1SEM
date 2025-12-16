<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Error</title>
    <link rel="icon" type="image/png" href="https://cdn-icons-png.flaticon.com/512/3135/3135715.png"/>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-900 text-white font-sans flex items-center justify-center h-screen">
    <div class="text-center">
        <h1 class="text-4xl font-bold text-red-500 mb-4">Error</h1>
        <p class="text-lg"><%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "An unexpected error occurred." %></p>
        <a href="${pageContext.request.contextPath}/login" class="mt-6 inline-block bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded">Back to Login</a>
    </div>
</body>
</html>