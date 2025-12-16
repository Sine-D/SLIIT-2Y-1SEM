<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Creator Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .dashboard-header {
            background: linear-gradient(135deg, #0f0f0f 0%, #1a1a1a 100%);
            border-left: 4px solid #ff6b6b;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.4);
        }
        
        .video-card {
            background: linear-gradient(145deg, #0f0f0f 0%, #1a1a1a 100%);
            border-radius: 1rem;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
            border: 1px solid rgba(75, 75, 75, 0.3);
            overflow: hidden;
        }
        
        .video-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.4);
            border-color: rgba(255, 107, 107, 0.5);
        }
        
        .upload-button {
            background: linear-gradient(145deg, #0f0f0f 0%, #1a1a1a 100%);
            border: 1px solid rgba(255, 107, 107, 0.5);
        }
        
        .upload-button:hover {
            background: linear-gradient(145deg, #1a1a1a 0%, #2a2a2a 100%);
            border-color: #ff6b6b;
        }
        
        .error-message {
            background: linear-gradient(145deg, #0f0f0f 0%, #1a1a1a 100%);
            border: 1px solid #ff4757;
        }
    </style>
</head>
<body class="bg-black text-white font-sans">
    <div class="container mx-auto p-6">
        <!-- Header -->
        <div class="dashboard-header mb-10 rounded-xl p-6">
            <h3 class="text-4xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-red-400 to-pink-500">Creator Dashboard</h3>
            <p class="text-gray-400 mt-2">Manage your video content</p>
        </div>

        <!-- Error Message -->
        <c:if test="${not empty error}">
            <p class="error-message text-red-400 p-4 rounded-lg mb-6 text-center shadow-md">${error}</p>
        </c:if>

        <!-- Upload Button -->
        <a href="${pageContext.request.contextPath}/UploadVideoServlet">
            <button class="upload-button cursor-pointer group relative flex items-center gap-2 px-8 py-4 text-white rounded-3xl hover:shadow-lg transition-all duration-300 ease-in-out font-semibold">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"
                     class="w-5 h-5 text-red-400 group-hover:scale-110 group-hover:text-pink-400 transition-transform duration-300 ease-in-out">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4" />
                </svg>
                <span class="group-hover:text-pink-400 transition-colors duration-300 ease-in-out">Upload Video</span>
            </button>
        </a>

        <!-- Your Videos Section -->
        <h3 class="text-2xl font-semibold text-transparent bg-clip-text bg-gradient-to-r from-red-400 to-pink-500 mt-6 mb-5">Your Videos</h3>
        <c:choose>
            <c:when test="${empty videos}">
                <p class="text-gray-400 bg-[#1a1a1a] p-4 rounded-lg text-center shadow-md">No videos uploaded yet.</p>
            </c:when>
            <c:otherwise>
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                    <c:forEach var="video" items="${videos}">
                        <div class="video-card p-5 flex justify-between items-start gap-4">
                            <!-- Left side: Text content -->
                            <div class="flex-1">
                                <h2 class="text-xl font-semibold mb-3">
                                    <a href="${pageContext.request.contextPath}/video/${video.slug}" 
                                       class="text-red-400 hover:text-pink-300 transition-colors">
                                        ${video.title}
                                    </a>
                                </h2>
                                <div class="space-y-1 text-sm text-gray-400">
                                    <p><strong>Available Languages:</strong> ${video.language}</p>
                                    <p><strong>Genres:</strong> ${video.genres}</p>
                                    <p><strong>Duration:</strong> ${video.duration} minutes</p>
                                    <p><strong>Visibility:</strong> ${video.visibility}</p>
                                    <p><strong>Upload Date:</strong> ${video.uploadDate}</p>
                                    <p><strong>Status:</strong> ${video.status}</p>
                                </div>
                                <div class="mt-5 flex items-center justify-between">
                                    <a href="${pageContext.request.contextPath}/EditVideoServlet?slug=${video.slug}" 
                                       class="text-red-300 hover:text-pink-200 text-sm font-medium">
                                        ✏️ Edit
                                    </a>
                                    <form action="${pageContext.request.contextPath}/DeleteVideoServlet" method="post" class="inline">
                                        <input type="hidden" name="videoId" value="${video.videoId}">
                                        <button type="submit" 
                                                class="bg-red-600 hover:bg-red-700 text-white text-sm py-1 px-4 rounded-full transition"
                                                onclick="return confirm('Are you sure you want to delete this video?');">
                                            🗑️ Delete
                                        </button>
                                    </form>
                                </div>
                            </div>
                            <!-- Right side: Thumbnail Image -->
                            <div class="w-28 flex-shrink-0">
                                <img src="${pageContext.request.contextPath}${video.thumbnailUrl}" alt="${video.title}" 
                                     class="rounded-lg w-full h-full object-cover object-center border border-gray-600" 
                                     onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg';">
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>