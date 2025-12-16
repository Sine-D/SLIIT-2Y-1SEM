<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${video.title}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .video-section, .details-section, .manage-section, .cast-section {
            background: linear-gradient(145deg, #0f0f0f 0%, #1a1a1a 100%);
            border-radius: 1rem;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(75, 75, 75, 0.3);
            transition: all 0.3s ease;
        }
        
        .video-section:hover, .details-section:hover, .manage-section:hover, .cast-section:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.4);
            border-color: rgba(255, 107, 107, 0.5);
        }
        
        .carousel {
            display: flex;
            overflow-x: auto;
            scroll-behavior: smooth;
            gap: 1rem;
            padding: 1rem 0;
        }
        
        .carousel .actor-card {
            min-width: 100px;
            text-align: center;
        }
        
        .carousel img {
            width: 100px;
            height: 150px;
            object-fit: cover;
            border-radius: 0.25rem;
            border: 1px solid rgba(75, 75, 75, 0.3);
        }
        
        .carousel::-webkit-scrollbar {
            height: 0.5rem;
        }
        
        .carousel::-webkit-scrollbar-thumb {
            background: #ff6b6b;
            border-radius: 0.25rem;
        }
        
        .carousel::-webkit-scrollbar-track {
            background: #1a1a1a;
        }
        
        .error-message {
            background: linear-gradient(145deg, #0f0f0f 0%, #1a1a1a 100%);
            border: 1px solid #ff4757;
        }
    </style>
</head>
<body class="bg-black text-white font-sans min-h-screen p-6">
    <!-- Main Content with Bento Grid -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 max-w-5xl mx-auto">
        <!-- Video Section -->
        <div class="md:col-span-2 video-section p-6 rounded-lg">
            <h2 class="text-2xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-red-400 to-pink-500 mb-4">${video.title}</h2>
            <c:if test="${not empty error}">
                <p class="error-message text-red-400 p-4 rounded-lg mb-4">${error}</p>
            </c:if>
            <c:if test="${not empty video}">
                <video controls class="w-full h-64 mb-4 rounded-lg border border-gray-600">
                    <source src="${pageContext.request.contextPath}${video.videoUrl}" type="video/mp4">
                    Your browser does not support the video tag.
                </video>
                <p class="text-gray-400 mb-2">${video.description}</p>
            </c:if>
        </div>

        <!-- Details and Manage Section -->
        <div class="flex flex-col gap-6">
            <div class="details-section p-6 rounded-lg">
                <h3 class="text-lg font-semibold text-transparent bg-clip-text bg-gradient-to-r from-red-400 to-pink-500 mb-2">Details</h3>
                <c:if test="${not empty video}">
                    <p class="text-gray-400"><strong>Available Languages:</strong> ${video.language}</p>
                    <p class="text-gray-400"><strong>Genres:</strong> ${video.genres}</p>
                    <p class="text-gray-400"><strong>Duration:</strong> ${video.duration} minutes</p>
                    <p class="text-gray-400"><strong>Visibility:</strong> ${video.visibility}</p>
                    <p class="text-gray-400"><strong>Upload Date:</strong> ${video.uploadDate}</p>
                    <p class="text-gray-400"><strong>Status:</strong> ${video.status}</p>
                </c:if>
            </div>

            <c:if test="${sessionScope.userId eq video.creatorId}">
                <div class="manage-section p-6 rounded-lg">
                    <h3 class="text-lg font-semibold text-transparent bg-clip-text bg-gradient-to-r from-red-400 to-pink-500 mb-4">Manage Video</h3>
                    <c:if test="${not empty video}">
                        <a href="${pageContext.request.contextPath}/EditVideoServlet?slug=${video.slug}" 
                           class="block bg-red-600 hover:bg-pink-500 text-white text-center px-4 py-2 rounded mb-2 transition duration-300">Edit Video</a>
                        <form action="${pageContext.request.contextPath}/DeleteVideoServlet" method="post" class="inline">
                            <input type="hidden" name="videoId" value="${video.videoId}">
                            <button type="submit" 
                                    class="w-full bg-red-600 hover:bg-pink-500 text-white px-4 py-2 rounded transition duration-300">Delete Video</button>
                        </form>
                    </c:if>
                </div>
            </c:if>
        </div>

        <!-- Cast Section -->
        <div class="md:col-span-3 cast-section p-6 rounded-lg">
            <h3 class="text-lg font-semibold text-transparent bg-clip-text bg-gradient-to-r from-red-400 to-pink-500 mb-4">Cast</h3>
            <c:if test="${not empty video}">
                <div class="carousel">
                    <c:forEach var="actor" items="${actors}">
                        <div class="actor-card">
                            <c:choose>
                                <c:when test="${not empty actor.photoUrl}">
                                    <img src="${pageContext.request.contextPath}${actor.photoUrl}" alt="${actor.name}" 
                                         width="100" onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg';">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/images/placeholder.jpg" alt="No Photo" width="100">
                                </c:otherwise>
                            </c:choose>
                            <p class="text-gray-400 mt-2">${actor.name}</p>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Back to Dashboard -->
    <div class="mt-6 text-center">
        <a href="${pageContext.request.contextPath}/dashboard.jsp" 
           class="text-red-400 hover:text-pink-300 transition-colors">Back to Dashboard</a>
    </div>
</body>
</html>