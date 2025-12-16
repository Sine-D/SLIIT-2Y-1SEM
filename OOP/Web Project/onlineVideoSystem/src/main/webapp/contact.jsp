<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contact Us</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background-color: #1E2A44;
            font-family: Arial, sans-serif;
        }
        .container-bg {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(5px);
        }
        .form-bg {
            background-color: #4A5568;
            border-radius: 15px;
        }
        .input-field {
            background: transparent;
            border-bottom: 2px solid #A0AEC0;
            color: #FFFFFF;
        }
        .input-field:focus {
            border-bottom-color: #FFFFFF;
            outline: none;
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
        .error {
            color: #F56565;
            font-size: 0.875rem;
        }
    </style>
    <script>
        function validateForm() {
            const name = document.getElementById('name').value.trim();
            const email = document.getElementById('email').value.trim();
            const subject = document.getElementById('subject').value.trim();
            const message = document.getElementById('message').value.trim();
            const emailRegex = /^[A-Za-z0-9+_.-]+@(.+)$/;
            let valid = true;

            document.getElementById('nameError').textContent = '';
            document.getElementById('emailError').textContent = '';
            document.getElementById('subjectError').textContent = '';
            document.getElementById('messageError').textContent = '';

            if (!name) {
                document.getElementById('nameError').textContent = 'Name is required';
                valid = false;
            }
            if (!email || !emailRegex.test(email)) {
                document.getElementById('emailError').textContent = 'Valid email is required';
                valid = false;
            }
            if (!subject) {
                document.getElementById('subjectError').textContent = 'Subject is required';
                valid = false;
            }
            if (!message) {
                document.getElementById('messageError').textContent = 'Message is required';
                valid = false;
            }

            return valid;
        }
    </script>
</head>

<body class="min-h-screen flex items-center justify-center p-8">
	


    <div class="w-full max-w-4xl container-bg rounded-xl p-10">
        <h2 class="text-5xl font-extrabold text-white mb-6 text-center">CONTACT</h2>
        <p class="text-white mb-8 text-lg text-center">Need help or have feedback? Contact the Vidoora team anytime — we're just a message away and ready to support your journey.</p>
        <div class="flex flex-col md:flex-row gap-10">
            <!-- Left Section: Contact Details -->
            <div class="flex-1 text-white text-left">
                <p class="font-bold mb-2">Address</p>
                <p class="mb-4">163/4 Borella, Colombo 8 </p>
                <p class="font-bold mb-2">Phone</p>
                <p class="mb-4">Ph: +94 763043876</p>
                <p class="font-bold mb-2">Email</p>
                <p class="mb-4">Vidoora@gmail.com</p>
                <div class="flex space-x-4 mt-4">
                    <a href="#" class="text-white hover:text-gray-300"><i class="fab fa-linkedin"></i></a>
                    <a href="#" class="text-white hover:text-gray-300"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="text-white hover:text-gray-300"><i class="fab fa-facebook"></i></a>
                    <a href="#" class="text-white hover:text-gray-300"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
            <!-- Right Section: Form -->
            <div class="flex-1 form-bg p-6 rounded-xl shadow-lg">
                <h3 class="text-2xl font-semibold text-white mb-6 text-center">GET IN TOUCH</h3>
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="bg-red-500 text-white p-3 rounded mb-4 text-center"><%= request.getAttribute("errorMessage") %></div>
                <% } %>
                <form action="${pageContext.request.contextPath}/contact" method="post" class="space-y-6" onsubmit="return validateForm()">
                    <div>
                        <label for="name" class="block text-sm font-medium text-gray-200">Name</label>
                        <input type="text" id="name" name="name" class="mt-1 block w-full input-field p-2 text-lg">
                        <span id="nameError" class="error"></span>
                    </div>
                    <div>
                        <label for="email" class="block text-sm font-medium text-gray-200">Email</label>
                        <input type="email" id="email" name="email" class="mt-1 block w-full input-field p-2 text-lg">
                        <span id="emailError" class="error"></span>
                    </div>
                    <div>
                        <label for="subject" class="block text-sm font-medium text-gray-200">Subject</label>
                        <input type="text" id="subject" name="subject" class="mt-1 block w-full input-field p-2 text-lg">
                        <span id="subjectError" class="error"></span>
                    </div>
                    <div>
                        <label for="message" class="block text-sm font-medium text-gray-200">Message</label>
                        <textarea id="message" name="message" rows="4" class="mt-1 block w-full input-field p-2 text-lg"></textarea>
                        <span id="messageError" class="error"></span>
                    </div>
                    <button type="submit" class="w-full button-creative text-white font-semibold text-lg">Send Message</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>