<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Video List - StreamVibe</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'theme-red': '#e50914',
                        'theme-red-light': '#f5222d',
                        'theme-dark': '#111111',
                        'theme-dark-light': '#1f1f1f',
                        'theme-gray': '#2d2d2d'
                    },
                    animation: {
                        'pulse-slow': 'pulse 3s linear infinite',
                    }
                }
            }
        }
    </script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');
        
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to bottom, #111111, #1a1a1a);
        }
        
        .video-card {
            transition: all 0.4s ease;
            position: relative;
            overflow: hidden;
            border-radius: 8px;
            background: rgba(31, 31, 31, 0.7);
        }
        
        .video-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 10px 25px -5px rgba(229, 9, 20, 0.4);
        }
        
        .video-card .img-box {
            height: 200px;
            overflow: hidden;
            position: relative;
        }
        
        .video-card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.8s ease;
        }
        
        .video-card:hover img {
            transform: scale(1.08);
        }
        
        .video-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(to top, rgba(0,0,0,0.9) 0%, rgba(0,0,0,0) 70%);
            opacity: 0;
            transition: opacity 0.4s ease;
        }
        
        .video-card:hover .video-overlay {
            opacity: 1;
        }
        
        .play-button {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) scale(0.8);
            transition: all 0.4s ease;
            opacity: 0;
        }
        
        .video-card:hover .play-button {
            transform: translate(-50%, -50%) scale(1);
            opacity: 1;
        }
        
        .rating-stars {
            color: #FFD700;
        }
        
        .category-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            z-index: 10;
        }
        
        .nav-link {
            position: relative;
        }
        
        .nav-link::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 0;
            height: 2px;
            background-color: #e50914;
            transition: width 0.3s ease;
        }
        
        .nav-link:hover::after {
            width: 100%;
        }
        
        .header-blur {
            backdrop-filter: blur(10px);
            background-color: rgba(17, 17, 17, 0.8);
        }
        
        .pulse-dot {
            animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
        }
        
        @keyframes pulse {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: 0.5;
            }
        }
        
        .logo-text {
            background: linear-gradient(90deg, #e50914, #ff5f6d);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: shimmer 3s linear infinite;
            background-size: 200% 100%;
        }
        
        @keyframes shimmer {
            0% { background-position: 0% 50%; }
            100% { background-position: 200% 50%; }
        }
        
        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }
        
        ::-webkit-scrollbar-track {
            background: #1a1a1a;
        }
        
        ::-webkit-scrollbar-thumb {
            background: #e50914;
            border-radius: 4px;
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background: #ff5f6d;
        }
    </style>
</head>
<body class="text-gray-100 min-h-screen">
<jsp:include page="header.jsp" />
    <!-- Main Content -->
    <main class="container mx-auto px-4 pt-24 pb-12">
        <div class="flex justify-between items-center mb-8">
            <div>
                <h2 class="text-3xl font-bold">
                    <span class="text-theme-red">Popular</span> Videos
                </h2>
                <p class="text-gray-400 mt-1">Discover trending content that everyone's watching</p>
            </div>
            <div class="flex space-x-2 items-center">
                <div class="relative">
                    <input type="text" id="videoSearch" 
                           class="bg-theme-dark-light text-white px-4 py-2 rounded-full 
                                  focus:outline-none focus:ring-2 focus:ring-theme-red 
                                  pl-10 w-64" 
                           placeholder="Search videos..." 
                           aria-label="Search videos">
                    <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                </div>
                <button class="px-3 py-1 bg-theme-gray rounded-full hover:bg-theme-red transition-colors text-sm">
                    Latest
                </button>
                <button class="px-3 py-1 bg-theme-gray rounded-full hover:bg-theme-red transition-colors text-sm">
                    Popular
                </button>
            </div>
        </div>

        <c:if test="${not empty error}">
            <div class="bg-theme-red bg-opacity-20 border border-theme-red text-white px-4 py-3 rounded mb-6">
                <div class="flex items-center">
                    <i class="fas fa-exclamation-circle mr-2"></i>
                    <span><c:out value="${error}"/></span>
                </div>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty videos}">
                <div class="flex flex-col items-center justify-center py-16">
                    <i class="fas fa-film text-5xl text-theme-red mb-4"></i>
                    <p class="text-gray-400 text-xl">No videos available at the moment.</p>
                    <p class="text-gray-500 mt-2">Check back later for new content!</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                    <c:forEach var="video" items="${videos}">
                        <div class="video-card group">
                            <div class="img-box">
                                <img src="${pageContext.request.contextPath}${video.thumbnailUrl}" 
                                     alt="<c:out value='${video.title}'/>" 
                                     onerror="this.src='${pageContext.request.contextPath}/images/placeholder.jpg';"
                                     loading="lazy" />
                                <div class="video-overlay">
                                    <div class="play-button">
                                        <a href="${pageContext.request.contextPath}/video-page/${video.slug}" 
                                           aria-label="Play <c:out value='${video.title}'/>">
                                            <div class="w-16 h-16 bg-theme-red rounded-full flex items-center justify-center hover:bg-white hover:text-theme-red transition-all">
                                                <i class="fas fa-play text-xl"></i>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <div class="category-badge">
                                    <span class="bg-theme-red px-2 py-1 rounded text-xs font-medium">HD</span>
                                </div>
                            </div>
                            <div class="p-4">
                                <h6 class="font-semibold text-lg group-hover:text-theme-red transition-colors line-clamp-1">
                                    <a href="${pageContext.request.contextPath}/video-page/${video.slug}">
                                        <c:out value="${video.title}"/>
                                    </a>
                                </h6>
                                <div class="flex items-center justify-between mt-2">
                                    <span class="text-xs text-gray-400">
                                        <i class="fas fa-user-circle mr-1"></i>
                                        <c:out value="${creatorUsernames[video.videoId]}"/>
                                    </span>
                                    <div class="rating-stars text-xs">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star-half-alt"></i>
                                    </div>
                                </div>
                                <div class="mt-3 flex justify-between items-center">
                                    <span class="text-xs text-gray-400">
                                        <i class="far fa-clock mr-1"></i> 2h 15m
                                    </span>
                                    <a href="${pageContext.request.contextPath}/video-page/${video.slug}" 
                                       class="text-xs font-medium text-theme-red hover:text-white hover:bg-theme-red px-2 py-1 rounded transition-colors">
                                        Watch Now
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </main>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // Random rating for demo purposes
            const ratingContainers = document.querySelectorAll('.rating-stars');
            
            ratingContainers.forEach(container => {
                const stars = container.querySelectorAll('i');
                const randomRating = (3.5 + Math.random() * 1.5).toFixed(1); // Random between 3.5-5.0
                const fullStars = Math.floor(randomRating);
                const hasHalfStar = randomRating % 1 >= 0.5;
                
                stars.forEach((star, index) => {
                    if (index < fullStars) {
                        star.className = 'fas fa-star';
                    } else if (index === fullStars && hasHalfStar) {
                        star.className = 'fas fa-star-half-alt';
                    } else {
                        star.className = 'far fa-star';
                    }
                });
            });
            
            // Random duration for demo purposes
            const durationElements = document.querySelectorAll('.video-card .text-gray-400 i.far.fa-clock');
            durationElements.forEach(el => {
                const parent = el.parentElement;
                const hours = Math.floor(Math.random() * 2) + 1;
                const minutes = Math.floor(Math.random() * 45) + 15;
                parent.innerHTML = `<i class="far fa-clock mr-1"></i> ${hours}h ${minutes}m`;
            });
            
            // Scroll animations
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('opacity-100', 'translate-y-0');
                    }
                });
            }, { threshold: 0.1 });
            
            document.querySelectorAll('.video-card').forEach(card => {
                card.classList.add('opacity-0', 'translate-y-4', 'transition-all', 'duration-700');
                observer.observe(card);
            });
            
            // Staggered animation for cards
            const cards = document.querySelectorAll('.video-card');
            cards.forEach((card, index) => {
                setTimeout(() => {
                    card.classList.add('opacity-100', 'translate-y-0');
                }, 100 * index);
            });
            
            // Header scroll effect
            const header = document.querySelector('header');
            window.addEventListener('scroll', () => {
                if (window.scrollY > 10) {
                    header.classList.add('shadow-md');
                } else {
                    header.classList.remove('shadow-md');
                }
            });

            // Search functionality
            const searchInput = document.getElementById('videoSearch');
            const videoCards = document.querySelectorAll('.video-card');

            searchInput.addEventListener('input', (e) => {
                const searchTerm = e.target.value.toLowerCase().trim();
                
                videoCards.forEach(card => {
                    const title = card.querySelector('h6').textContent.toLowerCase();
                    
                    if (title.includes(searchTerm)) {
                        card.style.display = 'block';
                        card.classList.remove('opacity-0', 'translate-y-4');
                        card.classList.add('opacity-100', 'translate-y-0');
                    } else {
                        card.style.display = 'none';
                    }
                });
                
                // Update grid layout when search results change
                const visibleCards = document.querySelectorAll('.video-card[style="display: block;"]');
                if (visibleCards.length === 0) {
                    const noResults = document.createElement('div');
                    noResults.className = 'flex flex-col items-center justify-center py-16 w-full';
                    noResults.innerHTML = `
                        <i class="fas fa-search text-5xl text-theme-red mb-4"></i>
                        <p class="text-gray-400 text-xl">No videos found matching your search.</p>
                        <p class="text-gray-500 mt-2">Try different keywords!</p>
                    `;
                    
                    const grid = document.querySelector('.grid');
                    const existingNoResults = grid.querySelector('.no-results');
                    if (!existingNoResults) {
                        noResults.className = 'no-results ' + noResults.className;
                        grid.appendChild(noResults);
                    }
                } else {
                    const existingNoResults = document.querySelector('.no-results');
                    if (existingNoResults) {
                        existingNoResults.remove();
                    }
                }
            });

            // Clear search when pressing Escape key
            searchInput.addEventListener('keydown', (e) => {
                if (e.key === 'Escape') {
                    searchInput.value = '';
                    videoCards.forEach(card => {
                        card.style.display = 'block';
                        card.classList.remove('opacity-0', 'translate-y-4');
                        card.classList.add('opacity-100', 'translate-y-0');
                    });
                    const existingNoResults = document.querySelector('.no-results');
                    if (existingNoResults) {
                        existingNoResults.remove();
                    }
                }
            });
        });
    </script>
    <jsp:include page="footer.jsp" />
</body>
</html>