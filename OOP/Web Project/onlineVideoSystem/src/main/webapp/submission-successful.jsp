<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Submission Successful</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #1E2A44;
            font-family: Arial, sans-serif;
            color: #e2e8f0;
        }
        .container-bg {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(5px);
            border-radius: 15px;
        }
        .button-creative {
            background: linear-gradient(90deg, #F56565, #E53E3E);
            border-radius: 25px;
            padding: 10px 20px;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .button-creative:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(245, 101, 101, 0.5);
        }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen">
    <div class="container-bg p-8 rounded-lg shadow-lg w-full max-w-md text-center">
        <h2 class="text-3xl font-bold text-white mb-4">Submission Successful</h2>
        <div class="bg-green-500 text-white p-4 rounded mb-6">
            Thank you for your message! We will get back to you soon.
        </div>
        <a href="${pageContext.request.contextPath}/contact.jsp" 
           class="button-creative text-white font-semibold text-lg inline-block">
            Back to Contact Form
        </a>
    </div>
</body>
</html>