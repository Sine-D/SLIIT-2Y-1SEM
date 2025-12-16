<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Video</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-800 text-white min-h-screen font-sans">
    <div class="max-w-2xl mx-auto p-6">
        <h2 class="text-3xl font-bold text-red-600 mb-6 text-center">Edit Video</h2>

        <c:if test="${not empty error}">
            <div class="bg-red-800 text-white px-4 py-2 rounded mb-4">
                ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/EditVideoServlet" method="post" class="bg-gray-900 p-6 rounded-lg shadow-lg space-y-4">
            <input type="hidden" name="videoId" value="${video.videoId}">

            <div>
                <label for="title" class="block text-sm font-medium text-red-400">Title</label>
                <input type="text" id="title" name="title" value="${video.title}" required class="w-full mt-1 p-2 bg-gray-800 text-white border border-red-500 rounded">
            </div>

            <div>
                <label for="description" class="block text-sm font-medium text-red-400">Description</label>
                <textarea id="description" name="description" rows="3" class="w-full mt-1 p-2 bg-gray-800 text-white border border-red-500 rounded">${video.description}</textarea>
            </div>

            <div>
                <label for="genre" class="block text-sm font-medium text-red-400">Genres (comma-separated)</label>
                <input type="text" id="genre" name="genre" value="${video.genres}" class="w-full mt-1 p-2 bg-gray-800 text-white border border-red-500 rounded">
            </div>

            <div>
                <label for="language" class="block text-sm font-medium text-red-400">Language</label>
                <input type="text" id="language" name="language" value="${video.language}" class="w-full mt-1 p-2 bg-gray-800 text-white border border-red-500 rounded">
            </div>

            <div>
                <label for="duration" class="block text-sm font-medium text-red-400">Duration (minutes)</label>
                <input type="number" id="duration" name="duration" value="${video.duration}" required class="w-full mt-1 p-2 bg-gray-800 text-white border border-red-500 rounded">
            </div>

            <div>
                <label for="visibility" class="block text-sm font-medium text-red-400">Visibility</label>
                <select id="visibility" name="visibility" class="w-full mt-1 p-2 bg-gray-800 text-white border border-red-500 rounded">
                    <option value="public" ${video.visibility == 'public' ? 'selected' : ''}>Public</option>
                    <option value="premium" ${video.visibility == 'premium' ? 'selected' : ''}>Premium</option>
                    <option value="early_access" ${video.visibility == 'early_access' ? 'selected' : ''}>Early Access</option>
                </select>
            </div>

            <div>
                <label for="status" class="block text-sm font-medium text-red-400">Status</label>
                <select id="status" name="status" class="w-full mt-1 p-2 bg-gray-800 text-white border border-red-500 rounded">
                    <option value="active" ${video.status == 'active' ? 'selected' : ''}>Active</option>
                    <option value="pending" ${video.status == 'pending' ? 'selected' : ''}>Pending</option>
                    <option value="removed" ${video.status == 'removed' ? 'selected' : ''}>Removed</option>
                </select>
            </div>

            <div class="text-center">
                <button type="submit" class="bg-red-600 hover:bg-red-700 text-white font-semibold py-2 px-6 rounded transition">Update Video</button>
            </div>
        </form>

        <div class="text-center mt-6">
            <a href="dashboard.jsp" class="text-red-400 hover:underline">← Back to Video</a>
        </div>
    </div>
</body>
</html>
