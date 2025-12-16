<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pricing - VIDOORA</title>
	
	<link rel="stylesheet" href="css/price.css" />
	
	
	
</head>
<body>
    
	<jsp:include page="header.jsp" />

	
    <!-- Main Pricing Content -->
    <main class="pricing-container">
        <h1 class="page-title">Choose Your Plan</h1>
        <p class="page-subtitle">Simple and transparent pricing for everyone.</p>
        <div class="pricing-cards">
            <div class="card">
                <h2 class="card-title">Basic</h2>
                <p class="card-price">$9.99 <span>/ month</span></p>
                <ul class="card-features">
                    <li>Access to basic content</li>
                    <li>Standard support</li>
                    <li>Single device</li>
                </ul>
                <button class="btn-select">Select</button>
            </div>
            <div class="card popular">
                <div class="popular-badge">Most Popular</div>
                <h2 class="card-title">Standard</h2>
                <p class="card-price">$19.99 <span>/ month</span></p>
                <ul class="card-features">
                    <li>Access to all content</li>
                    <li>Priority support</li>
                    <li>Up to 3 devices</li>
                </ul>
                <button class="btn-select">Select</button>
            </div>
            <div class="card">
                <h2 class="card-title">Premium</h2>
                <p class="card-price">$29.99 <span>/ month</span></p>
                <ul class="card-features">
                    <li>All Standard features</li>
                    <li>Offline downloads</li>
                    <li>Unlimited devices</li>
                </ul>
                <button class="btn-select">Select</button>
            </div>
        </div>
    </main>
	<script src="js.js"></script>
	
	<jsp:include page="footer.jsp" />


</body>
</html>
