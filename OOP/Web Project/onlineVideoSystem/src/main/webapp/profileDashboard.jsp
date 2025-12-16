<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    colors: {
                        'dark-red': '#B91C1C',
                        'light-red': '#EF4444',
                    }
                }
            }
        }
    </script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body class="bg-gray-900 text-white min-h-screen">
    <div class="container mx-auto px-4 py-8">
        <!-- Header -->
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-red-500">Profile Dashboard</h1>
            <p class="text-gray-400 mt-2">Manage your account settings</p>
        </div>

        <!-- Notification Messages -->
        <% if (request.getAttribute("error") != null) { %>
            <div id="error-alert" class="bg-red-900 bg-opacity-50 text-white p-4 rounded mb-6 flex justify-between items-center">
                <p class="text-red-300"><%= request.getAttribute("error") %></p>
                <button onclick="document.getElementById('error-alert').style.display='none'" class="text-red-300 hover:text-white">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        <% } %>
        
        <% if (request.getAttribute("success") != null) { %>
            <div id="success-alert" class="bg-green-900 bg-opacity-50 text-white p-4 rounded mb-6 flex justify-between items-center">
                <p class="text-green-300"><%= request.getAttribute("success") %></p>
                <button onclick="document.getElementById('success-alert').style.display='none'" class="text-green-300 hover:text-white">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        <% } %>

        <div class="flex flex-col md:flex-row gap-8">
            <!-- Profile Photo Sidebar -->
            <div class="md:w-1/3 bg-gray-800 rounded-lg p-6 shadow-lg">
                <div class="flex flex-col items-center">
                    <div class="relative w-40 h-40 mb-4">
                        <% String profilePictureUrl = (String) request.getAttribute("profilePictureUrl"); %>
                        <div class="w-40 h-40 rounded-full overflow-hidden bg-gray-700 flex items-center justify-center border-2 border-red-500">
                            <% if (profilePictureUrl != null && !profilePictureUrl.isEmpty()) { %>
                                <img src="<%= profilePictureUrl %>?t=<%= System.currentTimeMillis() %>" alt="Profile Picture" class="w-full h-full object-cover" id="profile-preview" onerror="this.src='<%= request.getContextPath() %>/images/default-profile.png'; this.onerror=null;">
                            <% } else { %>
                                <i class="fas fa-user text-6xl text-gray-500"></i>
                                <img src="" alt="" class="hidden" id="profile-preview">
                            <% } %>
                        </div>
                        <button id="change-photo-btn" class="absolute bottom-0 right-0 bg-red-500 hover:bg-red-600 text-white p-2 rounded-full shadow-lg transition duration-300">
                            <i class="fas fa-camera"></i>
                        </button>
                    </div>
                    
                    <h2 class="text-xl font-bold mt-2" id="username-display"><%= request.getAttribute("username") != null ? request.getAttribute("username") : "Username" %></h2>
                    <p class="text-gray-400 text-sm" id="email-display"><%= request.getAttribute("email") != null ? request.getAttribute("email") : "email@example.com" %></p>
                    
                    <div class="mt-6 w-full">
                        <h3 class="text-lg font-semibold mb-2 text-red-400">Account Info</h3>
                        <div class="bg-gray-700 bg-opacity-50 rounded p-4">
                            <div class="flex items-center mb-2">
                                <i class="fas fa-calendar-alt text-gray-400 mr-3"></i>
                                <span>Member since: <span class="text-white">January 2023</span></span>
                            </div>
                            <div class="flex items-center">
                                <i class="fas fa-signal text-gray-400 mr-3"></i>
                                <span>Status: <span class="text-green-400">Active</span></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Profile Form -->
            <div class="md:w-2/3">
                <div class="bg-gray-800 rounded-lg p-6 shadow-lg">
                    <h2 class="text-xl font-bold mb-6 text-red-500">Edit Profile</h2>
                    
                    <form id="profile-form" action="ProfileDashboardServlet" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                        <!-- Hidden file input (activated by the change photo button) -->
                        <input type="file" id="profile-photo-input" name="profilePhoto" accept="image/*" class="hidden" onchange="previewImage(this)">
                        
                        <div class="space-y-6">
                            <!-- Username -->
                            <div>
                                <label for="username" class="block text-sm font-medium text-gray-400 mb-1">Username</label>
                                <input type="text" id="username" name="username" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" class="w-full bg-gray-700 border border-gray-600 rounded px-4 py-2 text-white focus:outline-none focus:ring-2 focus:ring-red-500" required>
                            </div>
                            
                            <!-- Email -->
                            <div>
                                <label for="email" class="block text-sm font-medium text-gray-400 mb-1">Email</label>
                                <input type="email" id="email" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" class="w-full bg-gray-700 border border-gray-600 rounded px-4 py-2 text-white focus:outline-none focus:ring-2 focus:ring-red-500" required oninput="validateEmail(this)">
                                <p id="email-error" class="text-xs mt-1 text-red-400"></p>
                            </div>
                            
                            <!-- New Password -->
                            <div>
                                <label for="password" class="block text-sm font-medium text-gray-400 mb-1">New Password (Leave blank to keep unchanged)</label>
                                <input type="password" id="password" name="password" class="w-full bg-gray-700 border border-gray-600 rounded px-4 py-2 text-white focus:outline-none focus:ring-2 focus:ring-red-500" placeholder="Enter new password">
                                <div class="flex mt-1">
                                    <div class="password-strength-meter flex-1 h-1 bg-gray-600 rounded-full mt-2 overflow-hidden">
                                        <div id="password-strength-bar" class="h-full w-0 bg-red-500 transition-all duration-300"></div>
                                    </div>
                                    <span id="password-strength-text" class="text-xs ml-2 text-gray-400 mt-1">Strength</span>
                                </div>
                            </div>
                            
                            <!-- Confirm Password -->
                            <div>
                                <label for="confirm-password" class="block text-sm font-medium text-gray-400 mb-1">Confirm Password</label>
                                <input type="password" id="confirm-password" name="confirmPassword" class="w-full bg-gray-700 border border-gray-600 rounded px-4 py-2 text-white focus:outline-none focus:ring-2 focus:ring-red-500" placeholder="Confirm new password">
                                <p id="password-match" class="text-xs mt-1 text-gray-400"></p>
                            </div>
                            
                            <!-- Bio -->
                            <div>
                                <label for="bio" class="block text-sm font-medium text-gray-400 mb-1">Bio</label>
                                <textarea id="bio" name="bio" rows="3" class="w-full bg-gray-700 border border-gray-600 rounded px-4 py-2 text-white focus:outline-none focus:ring-2 focus:ring-red-500" placeholder="Tell us about yourself..."></textarea>
                            </div>
                            
                            <div class="flex flex-col sm:flex-row gap-4 pt-4">
                                <button type="submit" class="bg-red-500 hover:bg-red-600 text-white py-2 px-6 rounded transition duration-300">
                                    <i class="fas fa-save mr-2"></i> Save Changes
                                </button>
                                <button type="reset" class="bg-gray-700 hover:bg-gray-600 text-white py-2 px-6 rounded transition duration-300">
                                    <i class="fas fa-undo mr-2"></i> Reset
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
                
                <!-- Danger Zone -->
                <div class="bg-gray-800 rounded-lg p-6 shadow-lg mt-6 border border-red-900">
                    <h2 class="text-xl font-bold mb-4 text-red-500">Danger Zone</h2>
                    <p class="text-gray-400 mb-4">Once you delete your account, there is no going back. Please be certain.</p>
                    
                    <button id="delete-account-btn" class="bg-red-900 hover:bg-red-800 text-white py-2 px-6 rounded transition duration-300">
                        <i class="fas fa-trash-alt mr-2"></i> Delete Profile
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Back button -->
        <div class="mt-10 text-center">
            <a href="index.jsp" class="text-red-500 hover:underline">
                <i class="fas fa-arrow-left mr-2"></i> Back to Home
            </a>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="delete-modal" class="fixed inset-0 bg-black bg-opacity-75 flex items-center justify-center z-50 hidden">
        <div class="bg-gray-800 rounded-lg p-6 max-w-md w-full mx-4">
            <h3 class="text-xl font-bold mb-4 text-red-500">Confirm Account Deletion</h3>
            <p class="text-gray-300 mb-6">Are you sure you want to permanently delete your account? This action cannot be undone.</p>
            
            <form action="ProfileDashboardServlet" method="post">
                <input type="hidden" name="action" value="delete">
                <div class="flex flex-col sm:flex-row gap-4">
                
                    <button type="submit" class="bg-red-600 hover:bg-red-700 text-white py-2 px-6 rounded transition duration-300">
                        Yes, Delete My Account
                    </button>
                    <button type="button" id="cancel-delete" class="bg-gray-700 hover:bg-gray-600 text-white py-2 px-6 rounded transition duration-300">
                        Cancel
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Handle profile photo change button
        document.getElementById('change-photo-btn').addEventListener('click', function() {
            document.getElementById('profile-photo-input').click();
        });

        // Preview image before upload
        function previewImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    const preview = document.getElementById('profile-preview');
                    preview.src = e.target.result;
                    preview.classList.remove('hidden');
                    
                    // Hide the placeholder icon if it exists
                    const iconPlaceholder = preview.parentElement.querySelector('i');
                    if (iconPlaceholder) {
                        iconPlaceholder.style.display = 'none';
                    }
                };
                
                reader.readAsDataURL(input.files[0]);
            }
        }

        // Real-time email validation
        function validateEmail(input) {
            const email = input.value;
            const emailError = document.getElementById('email-error');
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (email && !emailPattern.test(email)) {
                emailError.textContent = 'Please enter a valid email address (e.g., user@example.com)';
            } else {
                emailError.textContent = '';
            }
        }

        // Password strength meter
        document.getElementById('password').addEventListener('input', function() {
            const pass = this.value;
            let strength = 0;
            
            // Basic checks
            if (pass.length >= 8) strength += 1;
            if (/[A-Z]/.test(pass)) strength += 1;
            if (/[a-z]/.test(pass)) strength += 1;
            if (/[0-9]/.test(pass)) strength += 1;
            if (/[^A-Za-z0-9]/.test(pass)) strength += 1;
            
            // Update visual indicators
            const bar = document.getElementById('password-strength-bar');
            const text = document.getElementById('password-strength-text');
            
            bar.style.width = (strength * 20) + '%';
            
            switch(strength) {
                case 0:
                case 1:
                    bar.className = 'h-full bg-red-600 transition-all duration-300';
                    text.textContent = 'Weak';
                    text.className = 'text-xs ml-2 text-red-400 mt-1';
                    break;
                case 2:
                case 3:
                    bar.className = 'h-full bg-yellow-500 transition-all duration-300';
                    text.textContent = 'Fair';
                    text.className = 'text-xs ml-2 text-yellow-400 mt-1';
                    break;
                case 4:
                case 5:
                    bar.className = 'h-full bg-green-500 transition-all duration-300';
                    text.textContent = 'Strong';
                    text.className = 'text-xs ml-2 text-green-400 mt-1';
                    break;
            }
        });

        // Password match check
        document.getElementById('confirm-password').addEventListener('input', function() {
            const newPass = document.getElementById('password').value;
            const confirmPass = this.value;
            const matchText = document.getElementById('password-match');
            
            if (newPass === confirmPass) {
                matchText.textContent = 'Passwords match';
                matchText.className = 'text-xs mt-1 text-green-400';
            } else {
                matchText.textContent = 'Passwords do not match';
                matchText.className = 'text-xs mt-1 text-red-400';
            }
        });

        // Form validation
        function validateForm() {
            const email = document.getElementById('email').value;
            const emailError = document.getElementById('email-error');
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                emailError.textContent = 'Please enter a valid email address (e.g., user@example.com)';
                return false;
            }

            const newPass = document.getElementById('password').value;
            const confirmPass = document.getElementById('confirm-password').value;
            const matchText = document.getElementById('password-match');
            
            if (newPass && newPass !== confirmPass) {
                matchText.textContent = 'Passwords do not match';
                matchText.className = 'text-xs mt-1 text-red-400';
                return false;
            }

            if (newPass && newPass.length < 8) {
                matchText.textContent = 'Password must be at least 8 characters long';
                matchText.className = 'text-xs mt-1 text-red-400';
                return false;
            }

            return true;
        }

        // Delete account modal controls
        document.getElementById('delete-account-btn').addEventListener('click', function() {
            document.getElementById('delete-modal').classList.remove('hidden');
        });

        document.getElementById('cancel-delete').addEventListener('click', function() {
            document.getElementById('delete-modal').classList.add('hidden');
        });

        // Refresh image to avoid caching
        function refreshProfileImage() {
            const img = document.getElementById('profile-preview');
            if (img && img.src && !img.src.includes('default-profile.png')) {
                img.src = img.src.split('?')[0] + '?t=' + new Date().getTime();
            }
        }

        window.onload = refreshProfileImage;
        window.addEventListener('pageshow', refreshProfileImage);
    </script>
</body>
</html>