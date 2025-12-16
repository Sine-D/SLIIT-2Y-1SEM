<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vidoora - FAQ</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: radial-gradient(circle at top right, #1f1f1f, #111111);
        }
        .faq-card {
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(255, 0, 0, 0.1);
        }
        .faq-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(255, 0, 0, 0.2);
        }
        .accordion-content {
            max-height: 0;
            overflow: hidden;
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .accordion-toggle:checked ~ .accordion-content {
            max-height: 500px;
        }
        .accordion-arrow {
            transition: transform 0.3s ease;
        }
        .accordion-toggle:checked ~ label .accordion-arrow {
            transform: rotate(180deg);
        }
        .glow {
            box-shadow: 0 0 15px rgba(255, 0, 0, 0.5);
        }
        .pulse {
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% {
                box-shadow: 0 0 0 0 rgba(239, 68, 68, 0.7);
            }
            70% {
                box-shadow: 0 0 0 10px rgba(239, 68, 68, 0);
            }
            100% {
                box-shadow: 0 0 0 0 rgba(239, 68, 68, 0);
            }
        }
    </style>
</head>

<body class="bg-black text-white min-h-screen">
	<jsp:include page="header.jsp" />

    <section class="max-w-5xl mx-auto my-8 px-4 relative">
        <div class="text-center mb-12">
            <h2 class="text-4xl font-bold text-red-500 mb-4 relative inline-block">
                Frequently Asked Questions
                <span class="absolute bottom-0 left-0 w-full h-1 bg-gradient-to-r from-transparent via-red-500 to-transparent transform -translate-y-2"></span>
            </h2>
            <p class="text-gray-400 max-w-2xl mx-auto">Everything you need to know about our streaming service. Can't find the answer you're looking for? Contact our support team.</p>
        </div>

        <div class="space-y-6" id="faq-container">
            <!-- FAQ 1 -->
            <div class="faq-card bg-gray-900 rounded-xl border border-red-500/50 hover:border-red-500 transition-all duration-300">
                <input type="checkbox" id="faq1" class="hidden accordion-toggle">
                <label for="faq1" class="flex justify-between items-center p-5 cursor-pointer group">
                    <span class="font-semibold text-lg group-hover:text-red-400 transition-colors duration-300">What is Vidoora?</span>
                    <span class="text-red-500 accordion-arrow bg-gray-800 rounded-full p-1 h-8 w-8 flex items-center justify-center">▼</span>
                </label>
                <div class="accordion-content">
                    <div class="p-5 text-gray-300 border-t border-red-500/30">
                        <p>Vidoora is an immersive online streaming platform where you can watch a wide variety of movies and TV series anytime, anywhere. With our curated content library, you'll always find something exciting to watch. Subscribe today to access our full library of entertainment!</p>
                    </div>
                </div>
            </div>
            
            <!-- FAQ 2 -->
            <div class="faq-card bg-gray-900 rounded-xl border border-red-500/50 hover:border-red-500 transition-all duration-300">
                <input type="checkbox" id="faq2" class="hidden accordion-toggle">
                <label for="faq2" class="flex justify-between items-center p-5 cursor-pointer group">
                    <span class="font-semibold text-lg group-hover:text-red-400 transition-colors duration-300">Do I need a subscription to watch content?</span>
                    <span class="text-red-500 accordion-arrow bg-gray-800 rounded-full p-1 h-8 w-8 flex items-center justify-center">▼</span>
                </label>
                <div class="accordion-content">
                    <div class="p-5 text-gray-300 border-t border-red-500/30">
                        <p>Yes, Vidoora requires a subscription to access our premium movies and TV series. We offer flexible plans to suit your viewing habits:</p>
                        <ul class="mt-3 space-y-2 list-disc list-inside text-gray-400">
                            <li>Monthly Plan: Full access with monthly billing</li>
                            <li>Annual Plan: Save 20% with our yearly subscription</li>
                            <li>Family Plan: Up to 5 profiles under one subscription</li>
                        </ul>
                    </div>
                </div>
            </div>
            
            <!-- FAQ 3 -->
            <div class="faq-card bg-gray-900 rounded-xl border border-red-500/50 hover:border-red-500 transition-all duration-300">
                <input type="checkbox" id="faq3" class="hidden accordion-toggle">
                <label for="faq3" class="flex justify-between items-center p-5 cursor-pointer group">
                    <span class="font-semibold text-lg group-hover:text-red-400 transition-colors duration-300">Can I watch content offline?</span>
                    <span class="text-red-500 accordion-arrow bg-gray-800 rounded-full p-1 h-8 w-8 flex items-center justify-center">▼</span>
                </label>
                <div class="accordion-content">
                    <div class="p-5 text-gray-300 border-t border-red-500/30">
                        <div class="flex items-center">
                            <svg class="w-6 h-6 text-red-500 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                            <p>Currently, offline viewing is not available on Vidoora.</p>
                        </div>
                        <p class="mt-3">However, we're actively developing a download feature that will allow subscribers to enjoy their favorite content without an internet connection. Stay tuned for updates—this feature is high on our priority list!</p>
                    </div>
                </div>
            </div>
            
            <!-- FAQ 4 -->
            <div class="faq-card bg-gray-900 rounded-xl border border-red-500/50 hover:border-red-500 transition-all duration-300">
                <input type="checkbox" id="faq4" class="hidden accordion-toggle">
                <label for="faq4" class="flex justify-between items-center p-5 cursor-pointer group">
                    <span class="font-semibold text-lg group-hover:text-red-400 transition-colors duration-300">What devices can I use to watch Vidoora?</span>
                    <span class="text-red-500 accordion-arrow bg-gray-800 rounded-full p-1 h-8 w-8 flex items-center justify-center">▼</span>
                </label>
                <div class="accordion-content">
                    <div class="p-5 text-gray-300 border-t border-red-500/30">
                        <p>Vidoora is designed to be accessible across multiple platforms for your convenience:</p>
                        <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mt-4">
                            <div class="text-center p-3 bg-gray-800 rounded-lg">
                                <svg class="w-8 h-8 mx-auto text-red-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M2 4a2 2 0 012-2h12a2 2 0 012 2v12a2 2 0 01-2 2H4a2 2 0 01-2-2V4zm10 3a1 1 0 100-2H8a1 1 0 000 2h4z"></path>
                                </svg>
                                <p class="mt-2">Smart TVs</p>
                            </div>
                            <div class="text-center p-3 bg-gray-800 rounded-lg">
                                <svg class="w-8 h-8 mx-auto text-red-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M7 2a2 2 0 00-2 2v12a2 2 0 002 2h6a2 2 0 002-2V4a2 2 0 00-2-2H7zm3 14a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd"></path>
                                </svg>
                                <p class="mt-2">Smartphones</p>
                            </div>
                            <div class="text-center p-3 bg-gray-800 rounded-lg">
                                <svg class="w-8 h-8 mx-auto text-red-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M6 2a2 2 0 00-2 2v12a2 2 0 002 2h8a2 2 0 002-2V4a2 2 0 00-2-2H6zm1 2a1 1 0 000 2h6a1 1 0 100-2H7z" clip-rule="evenodd"></path>
                                </svg>
                                <p class="mt-2">Tablets</p>
                            </div>
                            <div class="text-center p-3 bg-gray-800 rounded-lg">
                                <svg class="w-8 h-8 mx-auto text-red-400" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd" d="M3 5a2 2 0 012-2h10a2 2 0 012 2v8a2 2 0 01-2 2h-2.22l.123.489.804.804A1 1 0 0113 18H7a1 1 0 01-.707-1.707l.804-.804L7.22 15H5a2 2 0 01-2-2V5zm5.771 7H5V5h10v7H8.771z" clip-rule="evenodd"></path>
                                </svg>
                                <p class="mt-2">Laptops</p>
                            </div>
                        </div>
                        <p class="mt-4">Simply access our website from any modern browser, sign in, and start streaming your favorite content immediately!</p>
                    </div>
                </div>
            </div>
            
            <!-- FAQ 5 -->
            <div class="faq-card bg-gray-900 rounded-xl border border-red-500/50 hover:border-red-500 transition-all duration-300">
                <input type="checkbox" id="faq5" class="hidden accordion-toggle">
                <label for="faq5" class="flex justify-between items-center p-5 cursor-pointer group">
                    <span class="font-semibold text-lg group-hover:text-red-400 transition-colors duration-300">How often is new content added?</span>
                    <span class="text-red-500 accordion-arrow bg-gray-800 rounded-full p-1 h-8 w-8 flex items-center justify-center">▼</span>
                </label>
                <div class="accordion-content">
                    <div class="p-5 text-gray-300 border-t border-red-500/30">
                        <p>We're constantly refreshing our content library to keep your entertainment experience exciting:</p>
                        <div class="mt-4 bg-gray-800 p-4 rounded-lg">
                            <div class="flex items-center mb-2">
                                <div class="w-3 h-3 bg-red-500 rounded-full mr-3 pulse"></div>
                                <p class="font-medium">New Movies: Every Friday</p>
                            </div>
                            <div class="flex items-center mb-2">
                                <div class="w-3 h-3 bg-red-500 rounded-full mr-3 pulse"></div>
                                <p class="font-medium">TV Series Updates: Weekly episodes for ongoing shows</p>
                            </div>
                            <div class="flex items-center">
                                <div class="w-3 h-3 bg-red-500 rounded-full mr-3 pulse"></div>
                                <p class="font-medium">Vidoora Originals: New seasons quarterly</p>
                            </div>
                        </div>
                        <p class="mt-4">Follow our social media channels to stay updated on the latest additions to our growing collection!</p>
                    </div>
                </div>
            </div>
            
            <!-- FAQ 6 - New! -->
            <div class="faq-card bg-gray-900 rounded-xl border border-red-500/50 hover:border-red-500 transition-all duration-300 relative">
                <div class="absolute -top-2 -right-2 bg-red-600 text-white text-xs px-2 py-1 rounded-full">NEW</div>
                <input type="checkbox" id="faq6" class="hidden accordion-toggle">
                <label for="faq6" class="flex justify-between items-center p-5 cursor-pointer group">
                    <span class="font-semibold text-lg group-hover:text-red-400 transition-colors duration-300">What streaming quality does Vidoora offer?</span>
                    <span class="text-red-500 accordion-arrow bg-gray-800 rounded-full p-1 h-8 w-8 flex items-center justify-center">▼</span>
                </label>
                <div class="accordion-content">
                    <div class="p-5 text-gray-300 border-t border-red-500/30">
                        <p>Vidoora delivers exceptional streaming quality to enhance your viewing experience:</p>
                        <div class="mt-4 space-y-3">
                            <div class="bg-gradient-to-r from-gray-800 to-gray-900 p-3 rounded-lg flex items-center">
                                <div class="w-12 h-12 bg-red-500/20 rounded-full flex items-center justify-center mr-3">
                                    <span class="font-bold">SD</span>
                                </div>
                                <div>
                                    <h4 class="font-medium">Standard Definition</h4>
                                    <p class="text-sm text-gray-400">Available on all plans</p>
                                </div>
                            </div>
                            <div class="bg-gradient-to-r from-gray-800 to-gray-900 p-3 rounded-lg flex items-center">
                                <div class="w-12 h-12 bg-red-500/30 rounded-full flex items-center justify-center mr-3">
                                    <span class="font-bold">HD</span>
                                </div>
                                <div>
                                    <h4 class="font-medium">High Definition (1080p)</h4>
                                    <p class="text-sm text-gray-400">Available on Standard and Premium plans</p>
                                </div>
                            </div>
                            <div class="bg-gradient-to-r from-gray-800 to-gray-900 p-3 rounded-lg flex items-center">
                                <div class="w-12 h-12 bg-red-500/60 rounded-full flex items-center justify-center mr-3 glow">
                                    <span class="font-bold">4K</span>
                                </div>
                                <div>
                                    <h4 class="font-medium">Ultra HD (4K) + HDR</h4>
                                    <p class="text-sm text-gray-400">Exclusive to Premium plan subscribers</p>
                                </div>
                            </div>
                        </div>
                        <p class="mt-4">Streaming quality will automatically adjust based on your internet connection speed to ensure smooth playback.</p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Contact CTA -->
        <div class="mt-12 p-6 bg-gradient-to-br from-gray-900 to-black border border-red-500/30 rounded-xl text-center">
            <h3 class="text-xl font-bold mb-3">Still have questions?</h3>
            <p class="text-gray-400 mb-4">Our support team is here to help you with any other questions you might have.</p>
            <a href="contact.jsp">
            <button class="bg-red-600 hover:bg-red-700 text-white font-medium py-2 px-6 rounded-full transition-all duration-300 transform hover:scale-105 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-opacity-50">
                Contact Support
            </button>
            </a>
        </div>
    </section>

<jsp:include page="footer.jsp" />

    <!-- JavaScript for animations -->
    <script>
        // GSAP Animation for orbs in the header
        document.addEventListener('DOMContentLoaded', () => {
            const orbs = document.querySelectorAll('.red-orb');
            
            orbs.forEach((orb, index) => {
                // Set random initial positions
                gsap.set(orb, {
                    x: Math.random() * window.innerWidth,
                    y: Math.random() * 200 - 100
                });
                
                // Animate the orbs
                gsap.to(orb, {
                    x: `+=${Math.random() * 400 - 200}`,
                    y: `+=${Math.random() * 200 - 100}`,
                    duration: 8 + index * 2,
                    ease: 'sine.inOut',
                    repeat: -1,
                    yoyo: true
                });
            });
            
            // Animate FAQ items on load
            const faqItems = document.querySelectorAll('.faq-card');
            gsap.from(faqItems, {
                y: 30,
                opacity: 0,
                duration: 0.8,
                stagger: 0.1,
                ease: 'power2.out'
            });
            
            // FAQ click effect
            document.querySelectorAll('.accordion-toggle').forEach(toggle => {
                toggle.addEventListener('change', function() {
                    if(this.checked) {
                        const card = this.closest('.faq-card');
                        gsap.fromTo(card, 
                            {boxShadow: '0 0 0 rgba(239, 68, 68, 0.5)'},
                            {boxShadow: '0 0 15px rgba(239, 68, 68, 0.5)', duration: 0.3}
                        );
                        setTimeout(() => {
                            gsap.to(card, {boxShadow: '0 4px 6px rgba(255, 0, 0, 0.1)', duration: 0.5});
                        }, 300);
                    }
                });
            });
        });
        
        // Intersection Observer for scroll animations
        const observerOptions = {
            threshold: 0.1
        };
        
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate-fade-in');
                    observer.unobserve(entry.target);
                }
            });
        }, observerOptions);
        
        // Add animation class to elements
        document.querySelectorAll('.faq-card').forEach(card => {
            observer.observe(card);
        });
        
        // Optional: Add hover effect to FAQ cards
        document.querySelectorAll('.faq-card').forEach(card => {
            card.addEventListener('mouseenter', () => {
                gsap.to(card, {
                    scale: 1.02,
                    duration: 0.3,
                    ease: 'power2.out'
                });
            });
            
            card.addEventListener('mouseleave', () => {
                gsap.to(card, {
                    scale: 1,
                    duration: 0.3,
                    ease: 'power2.out'
                });
            });
        });
        
        // Scroll to FAQ when clicking on question links
        document.querySelectorAll('a[href^="#faq"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                
                if (target) {
                    const offset = 100;
                    const targetPosition = target.getBoundingClientRect().top + window.pageYOffset - offset;
                    
                    window.scrollTo({
                        top: targetPosition,
                        behavior: 'smooth'
                    });
                    
                    // Open the FAQ if it's closed
                    const toggle = target.querySelector('.accordion-toggle');
                    if (toggle && !toggle.checked) {
                        toggle.checked = true;
                        
                        // Add highlight effect
                        gsap.fromTo(target,
                            {backgroundColor: 'rgba(239, 68, 68, 0.1)'},
                            {backgroundColor: 'transparent', duration: 1.5}
                        );
                    }
                }
            });
        });
        
        // Add typing animation effect to the heading
        const heading = document.querySelector('h2');
        const headingText = heading.textContent;
        heading.textContent = '';
        
        let i = 0;
        const typeEffect = setInterval(() => {
            if (i < headingText.length) {
                heading.textContent += headingText.charAt(i);
                i++;
            } else {
                clearInterval(typeEffect);
                // Add the underline animation after typing is complete
                const span = heading.querySelector('span');
                if (span) {
                    gsap.fromTo(span,
                        {width: 0},
                        {width: '100%', duration: 0.8, ease: 'power2.out'}
                    );
                }
            }
        }, 50);