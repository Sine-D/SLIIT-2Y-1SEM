<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Creator Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <style>
        .dashboard-header {
            background: linear-gradient(135deg, #0f0f0f 0%, #1a1a1a 100%);
            border-left: 4px solid #ff6b6b;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.4);
        }
        
        .stat-card {
            background: linear-gradient(145deg, #0f0f0f 0%, #1a1a1a 100%);
            border-radius: 1rem;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
            border: 1px solid rgba(75, 75, 75, 0.3);
            overflow: hidden;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.4);
            border-color: rgba(255, 107, 107, 0.5);
        }
        
        .stat-card-active {
            border-top: 3px solid #ff6b6b;
        }
        
        .stat-card-inactive {
            border-top: 3px solid #ff9e9e;
        }
        
        .stat-card-total {
            border-top: 3px solid #ff4757;
        }
        
        .chart-container {
            background: #1a1a1a;
            border-radius: 1rem;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(75, 75, 75, 0.2);
            transition: all 0.3s ease;
        }
        
        .chart-container:hover {
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.4);
            border-color: rgba(255, 107, 107, 0.3);
        }
        
        .chart-header {
            border-bottom: 1px solid rgba(75, 75, 75, 0.2);
        }
    </style>
</head>
<body class="bg-black text-white font-sans">
    <div class="container mx-auto p-6">
      
        <div class="dashboard-header mb-10 rounded-xl p-6">
            <h3 class="text-4xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-red-400 to-pink-500">Your Video Statistics</h3>
            <p class="text-gray-400 mt-2">Analytics dashboard for your content</p>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8 mb-12">
            
            <div class="stat-card stat-card-active p-6">
                <div class="flex justify-between items-center">
                    <div>
                        <p class="text-gray-400 text-sm uppercase tracking-wider">Active Videos</p>
                        <h4 class="text-3xl font-bold mt-1 text-red-400">${creatorStats.activeVideos}</h4>
                    </div>
                    <div class="p-4 bg-opacity-20 bg-red-900 rounded-lg">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-red-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z" />
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>
                </div>
                <div class="mt-4 pt-4 border-t border-gray-700">
                    <p class="text-gray-400 text-sm">Currently published and visible to viewers</p>
                </div>
            </div>
            
          
            <div class="stat-card stat-card-inactive p-6">
                <div class="flex justify-between items-center">
                    <div>
                        <p class="text-gray-400 text-sm uppercase tracking-wider">Deactivated Videos</p>
                        <h4 class="text-3xl font-bold mt-1 text-pink-300">${creatorStats.deactivatedVideos}</h4>
                    </div>
                    <div class="p-4 bg-opacity-20 bg-pink-900 rounded-lg">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-pink-300" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728A9 9 0 015.636 5.636m12.728 12.728L5.636 5.636" />
                        </svg>
                    </div>
                </div>
                <div class="mt-4 pt-4 border-t border-gray-700">
                    <p class="text-gray-400 text-sm">Content that is currently unavailable to viewers</p>
                </div>
            </div>
            
            
            <div class="stat-card stat-card-total p-6">
                <div class="flex justify-between items-center">
                    <div>
                        <p class="text-gray-400 text-sm uppercase tracking-wider">Total Videos</p>
                        <h4 class="text-3xl font-bold mt-1 text-red-500">${creatorStats.totalVideos}</h4>
                    </div>
                    <div class="p-4 bg-opacity-20 bg-red-900 rounded-lg">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10 text-red-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
                        </svg>
                    </div>
                </div>
                <div class="mt-4 pt-4 border-t border-gray-700">
                    <p class="text-gray-400 text-sm">All content in your library</p>
                </div>
            </div>
        </div>

       

        
    </div>
</body>
</html>