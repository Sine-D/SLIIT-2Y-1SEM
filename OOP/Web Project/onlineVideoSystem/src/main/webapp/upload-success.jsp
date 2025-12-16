<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Success</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.6);
            z-index: 1000;
            animation: fadeIn 0.3s ease;
        }
        
        .modal-container {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1001;
            animation: slideIn 0.3s ease;
        }
        
        .modal-content {
            background: linear-gradient(145deg, #0f0f0f 0%, #1a1a1a 100%);
            border: 1px solid rgba(255, 107, 107, 0.5);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.4);
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        @keyframes slideIn {
            from { transform: translate(-50%, -60%); opacity: 0; }
            to { transform: translate(-50%, -50%); opacity: 1; }
        }
    </style>
</head>
<body class="bg-black text-white font-sans">
    <!-- Modal Overlay -->
    <div id="successModal" class="modal-overlay">
        <div class="modal-container max-w-md w-full">
            <div class="modal-content rounded-lg overflow-hidden">
                <div class="p-6">
                    <div class="text-center">
                        <div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-opacity-20 bg-red-900 mb-4">
                            <svg class="h-10 w-10 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                            </svg>
                        </div>
                        <h2 class="text-2xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-red-400 to-pink-500 mb-3">Upload Successful!</h2>
                        <p class="text-gray-400 mb-6">Your video has been uploaded successfully.</p>
                        <div class="flex justify-center space-x-4">
                            <a href="${pageContext.request.contextPath}/video/${videoSlug}" 
                               class="bg-red-600 hover:bg-pink-500 text-white font-semibold px-6 py-2 rounded-lg shadow-lg transition duration-300">
                                View Video
                            </a>
                            <a href="${pageContext.request.contextPath}/dashboard.jsp" 
                               id="closeModalBtn"
                               class="bg-gray-600 hover:bg-gray-500 text-white font-semibold px-6 py-2 rounded-lg shadow-lg transition duration-300">
                                Close
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            showModal();
            
            document.getElementById('closeModalBtn').addEventListener('click', function() {
                hideModal();
            });
            
            document.getElementById('successModal').addEventListener('click', function(e) {
                if (e.target === this) {
                    hideModal();
                }
            });
            
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape') {
                    hideModal();
                }
            });
        });
        
        function showModal() {
            document.getElementById('successModal').style.display = 'block';
            document.body.style.overflow = 'hidden';
        }
        
        function hideModal() {
            document.getElementById('successModal').style.display = 'none';
            document.body.style.overflow = 'auto';
        }
    </script>
</body>
</html>