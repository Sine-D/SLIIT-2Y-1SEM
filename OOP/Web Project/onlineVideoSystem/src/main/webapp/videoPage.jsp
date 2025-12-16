<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${video.title} - StreamVibe</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background-color: #111;
            color: #fff;
            font-family: 'Inter', sans-serif;
        }
        .video-container {
            position: relative;
            padding-bottom: 56.25%; /* 16:9 Aspect Ratio */
            height: 0;
            overflow: hidden;
        }
        .video-container video {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: #000;
        }
        .rating-stars {
            color: #E50914;
        }
        .rating-stars.gray {
            color: #333;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />
    <section class="relative bg-gray-900 py-6">
        <div class="max-w-7xl mx-auto px-6">
            <div class="flex flex-col items-center">
                <!-- Video Player (Centered) -->
                <div class="w-full">
                    <div class="video-container">
                        <!-- Video player with proper source tag -->
                        <video controls>
                            <source src="${pageContext.request.contextPath}${video.videoUrl}" type="video/mp4">
                            Your browser does not support the video tag.
                        </video>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Content Section -->
    <section class="max-w-7xl mx-auto px-6 py-8">
        <!-- Movie Title with Thumbnail -->
        <div class="flex items-center mt-6">
            <img src="${pageContext.request.contextPath}${video.thumbnailUrl}" alt="${video.title}" class="h-40 w-60 rounded-md mr-4 object-cover" onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg';">
            <div>
                <h1 class="text-4xl font-bold mb-4">${video.title}</h1>
                <div class="flex space-x-3">
                    <button class="bg-gray-800 hover:bg-gray-700 text-white p-2 rounded-md">
                        <i class="fas fa-thumbs-up"></i>
                    </button>
                    <button class="bg-gray-800 hover:bg-gray-700 text-white p-2 rounded-md">
                        <i class="fas fa-volume-up"></i>
                    </button>
                </div>
            </div>
        </div>
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <!-- Left Column -->
            <div class="lg:col-span-2">
                <!-- Description -->
                <div class="bg-gray-900 p-6 rounded-md mb-6 mt-6">
                    <h2 class="text-lg font-semibold mb-4">Description</h2>
                    <p class="text-gray-300">${video.description}</p>
                </div>

                <!-- Cast -->
                <div class="mb-6">
                    <div class="flex justify-between items-center mb-4">
                        <h2 class="text-lg font-semibold">Cast</h2>
                        <div class="flex space-x-2">
                            <button class="bg-gray-800 hover:bg-gray-700 p-2 rounded-md">
                                <i class="fas fa-chevron-left"></i>
                            </button>
                            <button class="bg-gray-800 hover:bg-gray-700 p-2 rounded-md">
                                <i class="fas fa-chevron-right"></i>
                            </button>
                        </div>
                    </div>
                    <div class="grid grid-cols-4 md:grid-cols-8 gap-3">
                        <c:forEach var="actor" items="${actors}">
                            <div class="text-center">
                                <div class="h-20 w-20 rounded-full overflow-hidden mx-auto mb-2">
                                    <img src="${pageContext.request.contextPath}${actor.photoUrl}" alt="${actor.name}" class="w-full h-full object-cover" onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg';">
                                </div>
                                <p class="text-xs text-gray-400">${actor.name}</p>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- Reviews -->
                <div>
                    <div class="flex justify-between items-center mb-4">
                        <h2 class="text-lg font-semibold">Reviews</h2>
                        <button class="flex items-center text-gray-400 hover:text-white">
                            <i class="fas fa-plus mr-2"></i> Add Your Review
                        </button>
                    </div>
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <!-- Review 1 -->
                        <div class="bg-gray-900 p-4 rounded-md">
                            <div class="flex justify-between mb-2">
                                <div>
                                    <h3 class="font-medium">Aniket Roy</h3>
                                    <p class="text-xs text-gray-400">From India</p>
                                </div>
                                <div class="flex">
                                    <span class="rating-stars">★★★★★</span>
                                    <span class="text-gray-400 ml-1">4.5</span>
                                </div>
                            </div>
                            <p class="text-sm text-gray-300">This movie was recommended to me by a very dear friend who went for the movie by himself. I went to the cinemas to watch but had a period of sleepiness wasn't watching it.</p>
                        </div>
                        
                        <!-- Review 2 -->
                        <div class="bg-gray-900 p-4 rounded-md">
                            <div class="flex justify-between mb-2">
                                <div>
                                    <h3 class="font-medium">Swaraj</h3>
                                    <p class="text-xs text-gray-400">From India</p>
                                </div>
                                <div class="flex">
                                    <span class="rating-stars">★★★★★</span>
                                    <span class="text-gray-400 ml-1">5</span>
                                </div>
                            </div>
                            <p class="text-sm text-gray-300">A restless king promises his lands to the local chieftain in exchange of a stone (Panjurli, a deity of Kerela village) wherein he finds solace and peace of mind.</p>
                        </div>
                    </div>
                    
                    <div class="flex justify-center mt-6 space-x-2">
                        <button class="bg-gray-800 hover:bg-gray-700 p-2 rounded-md">
                            <i class="fas fa-chevron-left"></i>
                        </button>
                        <button class="bg-gray-800 hover:bg-gray-700 p-2 rounded-md">
                            <i class="fas fa-chevron-right"></i>
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- Right Column -->
            <div>
                <!-- Movie Info -->
                <div class="bg-gray-900 p-6 rounded-md mb-6 mt-6">
                    <div class="flex items-center mb-4">
                        <i class="fas fa-calendar-alt mr-2 text-gray-400"></i>
                        <h3 class="text-sm font-medium">Upload Date</h3>
                    </div>
                    <p class="text-lg mb-6">${video.uploadDate}</p>
                    
                    <div class="flex items-center mb-4">
                        <i class="fas fa-user mr-2 text-gray-400"></i>
                        <h3 class="text-sm font-medium">Uploaded By:</h3>
                    </div>
                    <p class="text-lg mb-6">${creatorUsername}</p>
                    
                    <div class="flex items-center mb-4">
                        <i class="fas fa-language mr-2 text-gray-400"></i>
                        <h3 class="text-sm font-medium">Languages</h3>
                    </div>
                    <div class="grid grid-cols-4 gap-2 mb-6">
                        <span class="bg-gray-800 text-xs py-1 px-2 rounded-md text-center">${video.language}</span>
                    </div>
                    
                    <div class="flex items-center mb-4">
                        <i class="fas fa-star mr-2 text-gray-400"></i>
                        <h3 class="text-sm font-medium">Ratings</h3>
                    </div>
                    <div class="flex justify-between mb-6">
                        <div>
                            <h4 class="font-medium text-sm">IMDb</h4>
                            <div class="flex items-center">
                                <span class="rating-stars">★★★★★</span>
                                <span class="text-gray-400 ml-1">4.5</span>
                            </div>
                        </div>
                        <div>
                            <h4 class="font-medium text-sm">StreamVibe</h4>
                            <div class="flex items-center">
                                <span class="rating-stars">★★★★</span>
                                <span class="rating-stars gray">★</span>
                                <span class="text-gray-400 ml-1">4</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="flex items-center mb-4">
                        <i class="fas fa-film mr-2 text-gray-400"></i>
                        <h3 class="text-sm font-medium">Genres</h3>
                    </div>
                    <div class="grid grid-cols-2 gap-2 mb-6">
                        <c:forEach var="genre" items="${video.genres}">
                            <div>
                                <span class="bg-gray-800 text-xs py-1 px-2 rounded-md text-center">${genre}</span>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                
               
                
            </div>
        </div>
    </section>

    <!-- Subscription Banner -->
    <section class="max-w-7xl mx-auto px-6 py-12 mb-12">
        <div class="bg-gray-900 rounded-lg overflow-hidden relative">
            <div class="absolute inset-0 opacity-20">
                <img src="/api/placeholder/1200/300" alt="Subscription Banner" class="w-full h-full object-cover">
            </div>
            <div class="relative p-8 flex flex-col md:flex-row items-center justify-between">
                <div class="mb-6 md:mb-0">
                    <h2 class="text-2xl font-bold mb-2">Start your free trial today!</h2>
                    <p class="text-gray-400 max-w-xl">This is a short ad to convince you to action that encourages users to sign up for a free trial of StreamVibe.</p>
                </div>
                <button class="bg-red-600 hover:bg-red-700 text-white px-6 py-3 rounded-md">
                    Start a Free Trial
                </button>
            </div>
        </div>
    </section>

    <script>
        // JavaScript for interactive elements
        document.addEventListener('DOMContentLoaded', function() {
            // Like button functionality
            const likeButton = document.querySelector('button i.fa-thumbs-up').parentElement;
            likeButton.addEventListener('click', function() {
                alert('Added to your favorites!');
                this.classList.toggle('bg-red-600');
            });
            
            // Review buttons
            const reviewButton = document.querySelector('button:has(i.fa-plus)');
            if (reviewButton) {
                reviewButton.addEventListener('click', function() {
                    alert('Review feature will be available soon!');
                });
            }
            
            // Trial button
            const trialButton = document.querySelector('button.bg-red-600');
            if (trialButton) {
                trialButton.addEventListener('click', function() {
                    alert('Free trial sign-up process initiated!');
                });
            }
        });
    </script>
    <jsp:include page="footer.jsp" />
</body>
</html>