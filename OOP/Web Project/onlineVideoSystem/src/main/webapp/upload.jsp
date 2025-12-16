<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Video</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .dashboard-header {
            background: linear-gradient(135deg, #0f0f0f 0%, #1a1a1a 100%);
            border-left: 4px solid #ff6b6b;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.4);
        }
        
        .form-section {
            background: linear-gradient(145deg, #0f0f0f 0%, #1a1a1a 100%);
            border-radius: 1rem;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(75, 75, 75, 0.3);
            transition: all 0.3s ease;
        }
        
        .form-section:hover {
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.4);
            border-color: rgba(255, 107, 107, 0.5);
        }
        
        .actor-field {
            background: linear-gradient(145deg, #0f0f0f 0%, #1a1a1a 100%);
            border: 1px solid rgba(75, 75, 75, 0.3);
        }
        
        .upload-area {
            background: linear-gradient(145deg, #0f0f0f 0%, #1a1a1a 100%);
            border: 2px solid rgba(75, 75, 75, 0.3);
        }
        
        .upload-area:hover {
            border-color: #ff6b6b;
        }
        
        .error-message {
            background: linear-gradient(145deg, #0f0f0f 0%, #1a1a1a 100%);
            border: 1px solid #ff4757;
        }
        
        .file-uploaded {
            background: linear-gradient(145deg, #0f0f0f 0%, #1a1a1a 100%);
            border: 1px solid rgba(75, 75, 75, 0.3);
        }

        .error-text {
            color: #ff4757;
            font-size: 0.875rem;
            margin-top: 0.25rem;
            display: none;
        }

        .invalid-input {
            border-color: #ff4757 !important;
        }
    </style>
    <script>
        let actorCount = 1;

        function addActorField() {
            actorCount++;
            const container = document.getElementById("actorFields");
            const div = document.createElement("div");
            div.className = "actor-field grid grid-cols-1 md:grid-cols-2 gap-4 p-4 rounded-lg";
            div.innerHTML = `
                <div>
                    <label class="text-red-400 font-semibold" for="actor_name_${actorCount}">Actor Name ${actorCount}:</label>
                    <input type="text" id="actor_name_${actorCount}" name="actor_name_${actorCount}" class="w-full px-4 py-2 rounded bg-[#1a1a1a] text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-pink-500" oninput="validateActorName('${actorCount}')">
                    <p id="actor_name_${actorCount}_error" class="error-text">Actor name cannot be empty if provided</p>
                </div>
                <div>
                    <label for="actor_photo_${actorCount}"
                           class="upload-area text-center rounded w-full max-w-sm min-h-[180px] py-4 px-4 flex flex-col items-center justify-center cursor-pointer mx-auto"
                           ondragover="handleDragOver(event)"
                           ondragleave="handleDragLeave(event)"
                           ondrop="handleDrop(event, 'actor_photo_${actorCount}')">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-10 mb-6 fill-gray-400" viewBox="0 0 24 24">
                            <path
                                d="M22 13a1 1 0 0 0-1 1v4.213A2.79 2.79 0 0 1 18.213 21H5.787A2.79 2.79 0 0 1 3 18.213V14a1 1 0 0 0-2 0v4.213A4.792 4.792 0 0 0 5.787 23h12.426A4.792 4.792 0 0 0 23 18.213V14a1 1 0 0 0-1-1Z"
                                data-original="#000000" />
                            <path
                                d="M6.707 8.707 11 4.414V17a1 1 0 0 0 2 0V4.414l4.293 4.293a1 1 0 0 0 1.414-1.414l-6-6a1 1 0 0 0-1.414 0l-6 6a1 1 0 0 0 1.414 1.414Z"
                                data-original="#000000" />
                        </svg>
                        <p class="text-gray-400 font-semibold text-sm">Drag & Drop or <span class="text-pink-500">Choose file</span> to upload</p>
                        <input type="file" id="actor_photo_${actorCount}" name="actor_photo_${actorCount}" accept="image/png,image/jpeg,image/svg+xml,image/webp,image/gif" class="hidden"
                               onchange="handleFileSelect(event, 'actor_photo_${actorCount}'); validateActorPhoto('${actorCount}')">
                        <p class="text-xs text-gray-400 mt-2">PNG, JPG, SVG, WEBP, and GIF are Allowed.</p>
                        <p id="actor_photo_${actorCount}_error" class="error-text">Invalid image format</p>
                    </label>
                </div>
            `;
            container.appendChild(div);
        }

        // Drag-and-drop functionality
        function handleDragOver(event) {
            event.preventDefault();
            event.target.classList.add('border-pink-500');
        }

        function handleDragLeave(event) {
            event.target.classList.remove('border-pink-500');
        }

        function handleDrop(event, inputId) {
            event.preventDefault();
            event.target.classList.remove('border-pink-500');
            const files = event.dataTransfer.files;
            if (files.length > 0) {
                document.getElementById(inputId).files = files;
                displayFile(inputId, files[0].name);
                if (inputId === 'video_file') validateVideoFile();
                else if (inputId === 'thumbnail') validateThumbnail();
                else if (inputId.startsWith('actor_photo_')) validateActorPhoto(inputId.split('_')[2]);
            }
        }

        function handleFileSelect(event, inputId) {
            const files = event.target.files;
            if (files.length > 0) {
                displayFile(inputId, files[0].name);
                if (inputId === 'video_file') validateVideoFile();
                else if (inputId === 'thumbnail') validateThumbnail();
                else if (inputId.startsWith('actor_photo_')) validateActorPhoto(inputId.split('_')[2]);
            }
        }

        function displayFile(inputId, fileName) {
            const container = document.getElementById("uploadedFiles");
            const fileDiv = document.createElement("div");
            fileDiv.className = "file-uploaded flex justify-between items-center p-2 rounded-lg mb-2";
            fileDiv.innerHTML = `
                <div class="flex items-center">
                    <span class="text-red-400 mr-2">✔️</span>
                    <span class="text-white text-sm">${fileName}</span>
                </div>
                <div class="flex items-center">
                    <span class="text-gray-400 text-xs mr-2">Uploading: 78%</span>
                    <button type="button" class="text-red-400 hover:text-pink-300" onclick="removeFile('${inputId}', this)">✖ Cancel</button>
                </div>
            `;
            container.appendChild(fileDiv);
        }

        function removeFile(inputId, button) {
            const input = document.getElementById(inputId);
            input.value = '';
            button.parentElement.parentElement.remove();
            if (inputId === 'video_file') validateVideoFile();
            else if (inputId === 'thumbnail') validateThumbnail();
            else if (inputId.startsWith('actor_photo_')) validateActorPhoto(inputId.split('_')[2]);
        }

       
        function validateTitle() {
            const title = document.querySelector('input[name="title"]');
            const error = document.getElementById('title_error');
            if (!title.value.trim()) {
                title.classList.add('invalid-input');
                error.style.display = 'block';
                return false;
            } else {
                title.classList.remove('invalid-input');
                error.style.display = 'none';
                return true;
            }
        }

        function validateDuration() {
            const duration = document.querySelector('input[name="duration"]');
            const error = document.getElementById('duration_error');
            const value = duration.value.trim();
            if (!value || isNaN(value) || parseInt(value) <= 0) {
                duration.classList.add('invalid-input');
                error.style.display = 'block';
                return false;
            } else {
                duration.classList.remove('invalid-input');
                error.style.display = 'none';
                return true;
            }
        }

        function validateVideoFile() {
            const videoFile = document.getElementById('video_file');
            const error = document.getElementById('video_file_error');
            const validTypes = ['video/mp4', 'video/mpeg', 'video/webm'];
            if (!videoFile.files.length || !validTypes.includes(videoFile.files[0].type)) {
                videoFile.classList.add('invalid-input');
                error.style.display = 'block';
                return false;
            } else {
                videoFile.classList.remove('invalid-input');
                error.style.display = 'none';
                return true;
            }
        }

        function validateThumbnail() {
            const thumbnail = document.getElementById('thumbnail');
            const error = document.getElementById('thumbnail_error');
            const validTypes = ['image/png', 'image/jpeg', 'image/svg+xml', 'image/webp', 'image/gif'];
            if (!thumbnail.files.length || !validTypes.includes(thumbnail.files[0].type)) {
                thumbnail.classList.add('invalid-input');
                error.style.display = 'block';
                return false;
            } else {
                thumbnail.classList.remove('invalid-input');
                error.style.display = 'none';
                return true;
            }
        }

        function validateActorName(index) {
            const actorName = document.getElementById(`actor_name_${index}`);
            const error = document.getElementById(`actor_name_${index}_error`);
            if (actorName.value.trim() === '' && document.getElementById(`actor_photo_${index}`).files.length > 0) {
                actorName.classList.add('invalid-input');
                error.style.display = 'block';
                return false;
            } else {
                actorName.classList.remove('invalid-input');
                error.style.display = 'none';
                return true;
            }
        }

        function validateActorPhoto(index) {
            const actorPhoto = document.getElementById(`actor_photo_${index}`);
            const error = document.getElementById(`actor_photo_${index}_error`);
            const validTypes = ['image/png', 'image/jpeg', 'image/svg+xml', 'image/webp', 'image/gif'];
            if (actorPhoto.files.length > 0 && !validTypes.includes(actorPhoto.files[0].type)) {
                actorPhoto.classList.add('invalid-input');
                error.style.display = 'block';
                return false;
            } else {
                actorPhoto.classList.remove('invalid-input');
                error.style.display = 'none';
                return true;
            }
        }

        function validateGenre() {
            const genre = document.querySelector('input[name="genre"]');
            const error = document.getElementById('genre_error');
            const value = genre.value.trim();
            if (value) {
                const genres = value.split(',').map(g => g.trim());
                if (genres.some(g => g === '')) {
                    genre.classList.add('invalid-input');
                    error.style.display = 'block';
                    return false;
                } else {
                    genre.classList.remove('invalid-input');
                    error.style.display = 'none';
                    return true;
                }
            } else {
                genre.classList.remove('invalid-input');
                error.style.display = 'none';
                return true;
            }
        }

        function validateLanguage() {
            const language = document.querySelector('input[name="language"]');
            const error = document.getElementById('language_error');
            if (language.value.trim() === '' && language.value !== '') {
                language.classList.add('invalid-input');
                error.style.display = 'block';
                return false;
            } else {
                language.classList.remove('invalid-input');
                error.style.display = 'none';
                return true;
            }
        }

        function validateForm() {
            let isValid = true;
            isValid = validateTitle() && isValid;
            isValid = validateDuration() && isValid;
            isValid = validateVideoFile() && isValid;
            isValid = validateThumbnail() && isValid;
            isValid = validateGenre() && isValid;
            isValid = validateLanguage() && isValid;
            for (let i = 1; i <= actorCount; i++) {
                isValid = validateActorName(i) && isValid;
                isValid = validateActorPhoto(i) && isValid;
            }
            return isValid;
        }

        document.addEventListener('DOMContentLoaded', function() {
            // Attach validation listeners
            document.querySelector('input[name="title"]').addEventListener('input', validateTitle);
            document.querySelector('input[name="duration"]').addEventListener('input', validateDuration);
            document.getElementById('video_file').addEventListener('change', validateVideoFile);
            document.getElementById('thumbnail').addEventListener('change', validateThumbnail);
            document.querySelector('input[name="genre"]').addEventListener('input', validateGenre);
            document.querySelector('input[name="language"]').addEventListener('input', validateLanguage);
            document.getElementById('actor_name_1').addEventListener('input', () => validateActorName('1'));
            document.getElementById('actor_photo_1').addEventListener('change', () => validateActorPhoto('1'));

            // Form submission validation
            document.querySelector('form').addEventListener('submit', function(event) {
                if (!validateForm()) {
                    event.preventDefault();
                    alert('Please fix the errors in the form before submitting.');
                }
            });
        });
    </script>
</head>
<body class="bg-black text-white font-sans min-h-screen p-6">
    <div class="max-w-5xl mx-auto">
        <!-- Header -->
        <div class="dashboard-header mb-10 rounded-xl p-6">
            <h2 class="text-4xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-red-400 to-pink-500 mb-6 text-center">Upload Video</h2>
            <p class="text-gray-400 text-center">Add new video content to your library</p>
        </div>

        <!-- Error Message -->
        <% if (request.getAttribute("error") != null) { %>
            <p class="error-message text-red-400 p-4 rounded-lg mb-6 text-center shadow-md"><%= request.getAttribute("error") %></p>
        <% } %>

        <form action="${pageContext.request.contextPath}/UploadVideoServlet" method="post" enctype="multipart/form-data" class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <!-- Left Section: Video Overview -->
            <div class="md:col-span-2 form-section p-6 rounded-lg">
                <h3 class="text-xl font-semibold text-transparent bg-clip-text bg-gradient-to-r from-red-400 to-pink-500 mb-4">Video Overview</h3>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <!-- Title -->
                    <div class="md:col-span-2">
                        <label class="block text-red-400 font-semibold">Video Name:</label>
                        <input type="text" name="title" required class="w-full px-4 py-2 rounded bg-[#1a1a1a] text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-pink-500" oninput="validateTitle()">
                        <p id="title_error" class="error-text">Video name is required</p>
                    </div>

                    <!-- Description -->
                    <div class="md:col-span-2">
                        <label class="block text-red-400 font-semibold">Description:</label>
                        <textarea name="description" rows="3" class="w-full px-4 py-2 rounded bg-[#1a1a1a] text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-pink-500"></textarea>
                    </div>

                    <!-- Genre -->
                    <div>
                        <label class="block text-red-400 font-semibold">Genres (comma-separated):</label>
                        <input type="text" name="genre" class="w-full px-4 py-2 rounded bg-[#1a1a1a] text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-pink-500" oninput="validateGenre()">
                        <p id="genre_error" class="error-text">Invalid genre format</p>
                    </div>

                    <!-- Language -->
                    <div>
                        <label class="block text-red-400 font-semibold">Language:</label>
                        <input type="text" name="language" class="w-full px-4 py-2 rounded bg-[#1a1a1a] text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-pink-500" oninput="validateLanguage()">
                        <p id="language_error" class="error-text">Language cannot be empty if provided</p>
                    </div>

                    <!-- Duration -->
                    <div>
                        <label class="block text-red-400 font-semibold">Duration (minutes):</label>
                        <input type="number" name="duration" required class="w-full px-4 py-2 rounded bg-[#1a1a1a] text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-pink-500" oninput="validateDuration()">
                        <p id="duration_error" class="error-text">Duration must be a positive number</p>
                    </div>

                    <!-- Visibility -->
                    <div>
                        <label class="block text-red-400 font-semibold">Visibility:</label>
                        <select name="visibility" class="w-full px-4 py-2 rounded bg-[#1a1a1a] text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-pink-500">
                            <option value="public">Public</option>
                            <option value="private">Private</option>
                            <option value="early_access">Early Access</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Right Section: File Upload -->
            <div class="form-section p-6 rounded-lg">
                <h3 class="text-xl font-semibold text-transparent bg-clip-text bg-gradient-to-r from-red-400 to-pink-500 mb-4">Upload Files</h3>
                <!-- Video File -->
                <div class="mb-4">
                    <label class="block text-red-400 font-semibold mb-2">Video Upload</label>
                    <label for="video_file"
                           class="upload-area text-center rounded w-full max-w-sm min-h-[180px] py-4 px-4 flex flex-col items-center justify-center cursor-pointer mx-auto"
                           ondragover="handleDragOver(event)"
                           ondragleave="handleDragLeave(event)"
                           ondrop="handleDrop(event, 'video_file')">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-10 mb-6 fill-gray-400" viewBox="0 0 24 24">
                            <path
                                d="M22 13a1 1 0 0 0-1 1v4.213A2.79 2.79 0 0 1 18.213 21H5.787A2.79 2.79 0 0 1 3 18.213V14a1 1 0 0 0-2 0v4.213A4.792 4.792 0 0 0 5.787 23h12.426A4.792 4.792 0 0 0 23 18.213V14a1 1 0 0 0-1-1Z"
                                data-original="#000000" />
                            <path
                                d="M6.707 8.707 11 4.414V17a1 1 0 0 0 2 0V4.414l4.293 4.293a1 1 0 0 0 1.414-1.414l-6-6a1 1 0 0 0-1.414 0l-6 6a1 1 0 0 0 1.414 1.414Z"
                                data-original="#000000" />
                        </svg>
                        <p class="text-gray-400 font-semibold text-sm">Drag & Drop or <span class="text-pink-500">Choose file</span> to upload</p>
                        <input type="file" id="video_file" name="video_file" accept="video/mp4,video/mpeg,video/webm" required class="hidden"
                               onchange="handleFileSelect(event, 'video_file')">
                        <p class="text-xs text-gray-400 mt-2">MP4, MPEG, and WEBM are Allowed.</p>
                        <p id="video_file_error" class="error-text">A valid video file is required (MP4, MPEG, WEBM)</p>
                    </label>
                </div>

                <!-- Thumbnail -->
                <div>
                    <label class="block text-red-400 font-semibold mb-2">Thumbnail Upload</label>
                    <label for="thumbnail"
                           class="upload-area text-center rounded w-full max-w-sm min-h-[180px] py-4 px-4 flex flex-col items-center justify-center cursor-pointer mx-auto"
                           ondragover="handleDragOver(event)"
                           ondragleave="handleDragLeave(event)"
                           ondrop="handleDrop(event, 'thumbnail')">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-10 mb-6 fill-gray-400" viewBox="0 0 24 24">
                            <path
                                d="M22 13a1 1 0 0 0-1 1v4.213A2.79 2.79 0 0 1 18.213 21H5.787A2.79 2.79 0 0 1 3 18.213V14a1 1 0 0 0-2 0v4.213A4.792 4.792 0 0 0 5.787 23h12.426A4.792 4.792 0 0 0 23 18.213V14a1 1 0 0 0-1-1Z"
                                data-original="#000000" />
                            <path
                                d="M6.707 8.707 11 4.414V17a1 1 0 0 0 2 0V4.414l4.293 4.293a1 1 0 0 0 1.414-1.414l-6-6a1 1 0 0 0-1.414 0l-6 6a1 1 0 0 0 1.414 1.414Z"
                                data-original="#000000" />
                        </svg>
                        <p class="text-gray-400 font-semibold text-sm">Drag & Drop or <span class="text-pink-500">Choose file</span> to upload</p>
                        <input type="file" id="thumbnail" name="thumbnail" accept="image/png,image/jpeg,image/svg+xml,image/webp,image/gif" required class="hidden"
                               onchange="handleFileSelect(event, 'thumbnail')">
                        <p class="text-xs text-gray-400 mt-2">PNG, JPG, SVG, WEBP, and GIF are Allowed.</p>
                        <p id="thumbnail_error" class="error-text">A valid image file is required (PNG, JPG, SVG, WEBP, GIF)</p>
                    </label>
                </div>
            </div>

            <!-- Actor Fields -->
            <div class="md:col-span-3 form-section p-6 rounded-lg">
                <h3 class="text-xl font-semibold text-transparent bg-clip-text bg-gradient-to-r from-red-400 to-pink-500 mb-4">Actors</h3>
                <div id="actorFields" class="space-y-4">
                    <div class="actor-field grid grid-cols-1 md:grid-cols-2 gap-4 p-4 rounded-lg">
                        <div>
                            <label class="block text-red-400 font-semibold">Actor Name 1:</label>
                            <input type="text" id="actor_name_1" name="actor_name_1" class="w-full px-4 py-2 rounded bg-[#1a1a1a] text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-pink-500" oninput="validateActorName('1')">
                            <p id="actor_name_1_error" class="error-text">Actor name cannot be empty if provided</p>
                        </div>
                        <div>
                            <label class="block text-red-400 font-semibold mb-2">Actor Photo Upload</label>
                            <label for="actor_photo_1"
                                   class="upload-area text-center rounded w-full max-w-sm min-h-[180px] py-4 px-4 flex flex-col items-center justify-center cursor-pointer mx-auto"
                                   ondragover="handleDragOver(event)"
                                   ondragleave="handleDragLeave(event)"
                                   ondrop="handleDrop(event, 'actor_photo_1')">
                                <svg xmlns="http://www.w3.org/2000/svg" class="w-10 mb-6 fill-gray-400" viewBox="0 0 24 24">
                                    <path
                                        d="M22 13a1 1 0 0 0-1 1v4.213A2.79 2.79 0 0 1 18.213 21H5.787A2.79 2.79 0 0 1 3 18.213V14a1 1 0 0 0-2 0v4.213A4.792 4.792 0 0 0 5.787 23h12.426A4.792 4.792 0 0 0 23 18.213V14a1 1 0 0 0-1-1Z"
                                        data-original="#000000" />
                                    <path
                                        d="M6.707 8.707 11 4.414V17a1 1 0 0 0 2 0V4.414l4.293 4.293a1 1 0 0 0 1.414-1.414l-6-6a1 1 0 0 0-1.414 0l-6 6a1 1 0 0 0 1.414 1.414Z"
                                        data-original="#000000" />
                                </svg>
                                <p class="text-gray-400 font-semibold text-sm">Drag & Drop or <span class="text-pink-500">Choose file</span> to upload</p>
                                <input type="file" id="actor_photo_1" name="actor_photo_1" accept="image/png,image/jpeg,image/svg+xml,image/webp,image/gif" class="hidden"
                                       onchange="handleFileSelect(event, 'actor_photo_1'); validateActorPhoto('1')">
                                <p class="text-xs text-gray-400 mt-2">PNG, JPG, SVG, WEBP, and GIF are Allowed.</p>
                                <p id="actor_photo_1_error" class="error-text">Invalid image format</p>
                            </label>
                        </div>
                    </div>
                </div>
                <button type="button" onclick="addActorField()" class="bg-red-600 hover:bg-pink-500 text-white font-semibold px-4 py-2 rounded transition duration-300 mt-4">Add Another Actor</button>
            </div>

            
            <div class="md:col-span-3">
                <div id="uploadedFiles" class="space-y-2"></div>
            </div>

            
            <div class="md:col-span-3 flex justify-end">
                <button type="submit" class="bg-red-600 hover:bg-pink-500 text-white font-bold px-6 py-2 rounded-lg shadow-lg transition duration-300">Submit Video</button>
            </div>
        </form>
    </div>
</body>
</html>