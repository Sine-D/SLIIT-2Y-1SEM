<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Graph</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-[#2e2e30] px-2 pt-20 pb-4 ml-12 duration-500 ease-in-out transform content md:px-8 mt-4">
    <div class="px-2 pt-20 pb-4 ml-12">
        <h2 class="text-2xl font-bold text-white">Graph</h2>
        <p class="text-white mt-2">This is a placeholder for graph content with a sample Chart.js bar chart.</p>
        <canvas id="myChart" width="400" height="200"></canvas>
    </div>
    <script>
        const ctx = document.getElementById('myChart').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['January', 'February', 'March', 'April', 'May'],
                datasets: [{
                    label: 'Video Views',
                    data: [12, 19, 3, 5, 2],
                    backgroundColor: 'rgba(59, 130, 246, 0.6)',
                    borderColor: 'rgba(59, 130, 246, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>