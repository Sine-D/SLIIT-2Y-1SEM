<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="body bg-[#2e3033]">

    <header class="h-20 bg-[#0D0D0D] top-0 w-full fixed shadow px-6 flex items-center justify-between rounded-lg" style="z-index: 31;">
        <!-- Left: Logo & Navigation -->
        <div class="flex items-center gap-6">
            <!-- Logo -->
            <div class="text-xl font-bold text-white">
                VI<span class="text-blue-500">dora</span>
            </div>
        </div>

        <!-- Center: Search Bar -->
        <div class="flex-1 px-50">
            <div class="flex items-center bg-[#1a1a1a] rounded-full px-4 py-2 text-white w-full">
                <i class="mr-3 text-gray-400 fa-solid fa-microphone"></i>
                <input type="text" placeholder="Ask stocks.ai anything" class="w-full text-sm text-white placeholder-gray-400 bg-transparent focus:outline-none">
            </div>
        </div>

        <!-- Right: Icons + Profile -->
        <div class="flex items-center gap-4">
            <!-- Notification Icon -->
            <a href="#" class="bg-[#1a1a1a] p-2 rounded-full text-white">
                <i class="fa-regular fa-bell"></i>
            </a>

            <!-- Settings Icon -->
            <a href="#" class="bg-[#1a1a1a] p-2 rounded-full text-white">
                <i class="fa-solid fa-gear"></i>
            </a>

            <!-- User Info -->
            <div onclick="openUserDropdown()" class="relative flex items-center gap-3 cursor-pointer">
                <img class="rounded-full h-9 w-9 ring-2 ring-white"
                     src="https://images.unsplash.com/photo-1550525811-e5869dd03032?ixlib=rb-1.2.1&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
                     alt="User">
                <div class="text-right text-white">
                    <div class="text-sm font-medium">${username}</div>
                    <div class="text-xs text-gray-400">${email}</div>
                </div>

                <!-- Dropdown -->
                <ul id="user-dropdown" class="absolute right-0 hidden bg-white rounded shadow-md top-14 w-28">
                    
                    <li class="mb-1 text-gray-700 hover:bg-gray-50 hover:text-gray-900">
                        <a class="block px-5 py-2" href="${pageContext.request.contextPath}/index.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </header>

    <div class="fixed w-full z-30 flex bg-white dark:bg-[#0F172A] p-2 items-center justify-center ">
        <div class="flex items-center justify-center flex-none h-full duration-500 ease-in-out transform logo dark:text-white ">
        </div>
        <div class="flex items-center justify-center h-full grow "></div>
        <div class="flex items-center justify-center flex-none h-full text-center ">
        </div>
    </div>

    <aside class="w-60 -translate-x-48 fixed transition transform ease-in-out duration-1000 z-50 flex h-screen bg-[#0D0D0D] mt-13">
        <!-- Open sidebar button -->
        <div class="max-toolbar translate-x-24 scale-x-0 w-full transition transform ease-in duration-300 flex items-center justify-between border-4 border-white dark:border-[#0F172A] bg-[#1a1b1e] absolute top-2 rounded-full h-12 mt-5">
            <div class="flex items-center py-1 pl-10 pr-2 space-x-3 text-black rounded-full group bg-gradient-to-r from-slate-500 to-slate-800:text-black">
                <div class="mr-12 duration-300 ease-in-out transform">
                    <div class="w-40">
                        <h2 class="font-bold text-[]25px]">WELCOME</h2>
                        <p class="text-black-400 text-[20px]">
                            ${username}
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div onclick="openNav()" class="-right-6 transition transform ease-in-out duration-500 flex border-4 border-white dark:border-[#0F172A] bg-[#1a1b1e] dark:hover:bg-red-500 hover:bg-purple-500 absolute top-2 p-3 rounded-full text-white hover:rotate-45 mt-5">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={3} stroke="currentColor" class="w-4 h-4">
                <path strokeLinecap="round" strokeLinejoin="round" d="M3.75 6A2.25 2.25 0 016 3.75h2.25A2.25 2.25 0 0110.5 6v2.25a2.25 2.25 0 01-2.25 2.25H6a2.25 2.25 0 01-2.25-2.25V6zM3.75 15.75A2.25 2.25 0 016 13.5h2.25a2.25 2.25 0 012.25 2.25V18a2.25 2.25 0 01-2.25 2.25H6A2.25 2.25 0 013.75 18v-2.25zM13.5 6a2.25 2.25 0 012.25-2.25H18A2.25 2.25 0 0120.25 6v2.25A2.25 2.25 0 0118 10.5h-2.25a2.25 2.25 0 01-2.25-2.25V6zM13.5 15.75a2.25 2.25 0 012.25-2.25H18a2.25 2.25 0 012.25 2.25V18A2.25 2.25 0 0118 20.25h-2.25A2.25 2.25 0 0113.5 18v-2.25z" />
            </svg>
        </div>
        <!-- MAX SIDEBAR -->
        <div class="max hidden text-white mt-25 flex-col space-y-2 w-full h-[calc(100vh)]">
            <div class="hover:ml-4 w-full text-white hover:text-purple-500 dark:hover:text-blue-500 bg-[#1a1b1e] p-2 pl-8 rounded-full transform ease-in-out duration-300 flex flex-row items-center space-x-3">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" class="w-4 h-4">
                    <path strokeLinecap="round" strokeLinejoin="round" d="M2.25 12l8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25" />
                </svg>    
                <a href="${pageContext.request.contextPath}/HomedashServlet" class="text-white home-link">Home</a>
            </div>
            <div class="hover:ml-4 w-full text-white hover:text-purple-500 dark:hover:text-blue-500 bg-[#1a1b1e] p-2 pl-8 rounded-full transform ease-in-out duration-300 flex flex-row items-center space-x-3">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 5.25h16.5m-16.5 4.5h16.5m-16.5 4.5h16.5m-16.5 4.5h16.5" />
                </svg>                      
                <a href="${pageContext.request.contextPath}/TabledashServlet" class="text-white table-link">Table</a>
            </div>
            <div class="hover:ml-4 w-full text-white hover:text-purple-500 dark:hover:text-blue-500 bg-[#1a1b1e] p-2 pl-8 rounded-full transform ease-in-out duration-300 flex flex-row items-center space-x-3">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 6a7.5 7.5 0 107.5 7.5h-7.5V6z" />
                    <path stroke-linecap="round" stroke-linejoin="round" d="M13.5 10.5H21A7.5 7.5 0 0013.5 3v7.5z" />
                </svg>                      
                <a href="${pageContext.request.contextPath}/GraphdashServlet" class="text-white graph-link">Graph</a>
            </div>
        </div>
        <!-- MINI SIDEBAR -->
        <div class="mini mt-25 flex flex-col space-y-2 w-full h-[calc(100vh)]">
            <div class="hover:ml-4 justify-end pr-5 text-white hover:text-purple-500 dark:hover:text-blue-500 w-full bg-[#1a1b1e] p-3 rounded-full transform ease-in-out duration-300 flex">
                <a href="${pageContext.request.contextPath}/HomedashServlet" class="text-white home-link">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" class="w-4 h-4">
                        <path strokeLinecap="round" strokeLinejoin="round" d="M2.25 12l8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25" />
                    </svg>
                </a>
            </div>
            <div class="hover:ml-4 justify-end pr-5 text-white hover:text-purple-500 dark:hover:text-blue-500 w-full bg-[#1a1b1e] p-3 rounded-full transform ease-in-out duration-300 flex">
                <a href="${pageContext.request.contextPath}/TabledashServlet" class="text-white table-link">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 5.25h16.5m-16.5 4.5h16.5m-16.5 4.5h16.5m-16.5 4.5h16.5" />
                    </svg>
                </a>
            </div>
            <div class="hover:ml-4 justify-end pr-5 text-white hover:text-purple-500 dark:hover:text-blue-500 w-full bg-[#1a1b1e] p-3 rounded-full transform ease-in-out duration-300 flex">
                <a href="${pageContext.request.contextPath}/GraphdashServlet" class="text-white graph-link">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-4 h-4">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 6a7.5 7.5 0 107.5 7.5h-7.5V6z" />
                        <path stroke-linecap="round" stroke-linejoin="round" d="M13.5 10.5H21A7.5 7.5 0 0013.5 3v7.5z" />
                    </svg>
                </a>
            </div>
        </div>
    </aside>
    <!-- CONTENT -->
    <div class="px-2 pt-20 pb-4 ml-12 duration-500 ease-in-out transform content md:px-8 mt-4">
        <nav class="flex px-5 py-3 text-gray-700 rounded-lg bg-gray-50 dark:bg-[#1a1b1e]" aria-label="Breadcrumb">
            <ol class="inline-flex items-center space-x-1 md:space-x-3">
                <li class="inline-flex items-center">
                    <a href="${pageContext.request.contextPath}/dashboard.jsp" class="inline-flex items-center text-sm font-medium text-gray-700 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white">
                        <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z"></path></svg>
                        Home
                    </a>
                </li>
            </ol>
        </nav>
        
            <div id="dynamic-content" class="mt-4"></div>
       
    </div>
</body>
<script>
    function openUserDropdown() {
        document.getElementById('user-dropdown').classList.toggle('hidden');
    }

    const sidebar = document.querySelector("aside");
    const maxSidebar = document.querySelector(".max");
    const miniSidebar = document.querySelector(".mini");
    const maxToolbar = document.querySelector(".max-toolbar");
    const content = document.querySelector('.content');
    const dynamicContent = document.getElementById('dynamic-content');

    // Store the context path during page load
    const contextPath = "${pageContext.request.contextPath}";

    function openNav() {
        if (sidebar.classList.contains('-translate-x-48')) {
            sidebar.classList.remove("-translate-x-48");
            sidebar.classList.add("translate-x-none");
            maxSidebar.classList.remove("hidden");
            maxSidebar.classList.add("flex");
            miniSidebar.classList.remove("flex");
            miniSidebar.classList.add("hidden");
            maxToolbar.classList.add("translate-x-0");
            maxToolbar.classList.remove("translate-x-24", "scale-x-0");
            content.classList.remove("ml-12");
            content.classList.add("ml-12", "md:ml-60");
        } else {
            sidebar.classList.add("-translate-x-48");
            sidebar.classList.remove("translate-x-none");
            maxSidebar.classList.add("hidden");
            maxSidebar.classList.remove("flex");
            miniSidebar.classList.add("flex");
            miniSidebar.classList.remove("hidden");
            maxToolbar.classList.add("translate-x-24", "scale-x-0");
            maxToolbar.classList.remove("translate-x-0");
            content.classList.remove("ml-12", "md:ml-60");
            content.classList.add("ml-12");
        }
    }

    // Function to load content dynamically
    function loadContent(url) {
        fetch(url)
            .then(response => response.text())
            .then(data => {
                dynamicContent.innerHTML = data; // Use innerHTML to insert the servlet response
            })
            .catch(error => {
                dynamicContent.textContent = 'Error loading content: ' + error.message;
            });
    }

    // Add event listeners to sidebar links
    document.querySelectorAll('.home-link').forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            loadContent(contextPath + '/HomedashServlet');
        });
    });

    document.querySelectorAll('.table-link').forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            loadContent(contextPath + '/TabledashServlet');
        });
    });

    document.querySelectorAll('.graph-link').forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            loadContent(contextPath + '/GraphdashServlet');
        });
    });

    // Load HomedashServlet content by default on page load
    window.onload = function() {
        loadContent(contextPath + '/HomedashServlet');
    };
</script>
</html>