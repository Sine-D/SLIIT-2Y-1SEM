<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<header>
    <div class="logo">VIDOORA</div>
	
    <nav>
	
      <a href="index.jsp">HOME</a>
      <a href="${pageContext.request.contextPath}/VideoListServlet">MOVIES</a>
     
      <div class="dropdown">
        <button class="dropbtn">CONTACT US</button>
        <div class="dropdown-content">
          <a href="AboutUs.jsp">About Us</a>
          <a href="contact.jsp">Contact</a>
          <a href="faq.jsp">FAQ</a>
          <a href="privacyAndPolicy.jsp">Privacy Policy</a>
          <a href="pricing.jsp">Pricing</a>
        </div>
      </div>
    </nav>

  </header>
  	
	<style>
    header {
      background: #0d0d0d;
      color: white;
      padding: 6px 10px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      position: relative;
	  height: 75px;
    }
    .logo {
      font-size: 24px;
      color: #00aaff;
      font-weight: bold;
	  padding: 6px;
    }
    nav {
      display: flex;
      align-items: center;
      position: absolute;
      left: 50%;
      transform: translateX(-50%);
    }
    nav a {
      color: #ccc;
      margin: 0 15px;
      text-decoration: none;
      font-size: 16px;
    }
    nav a:hover {
      color: #fff;
    }
    .dropdown {
      position: relative;
      display: inline-block;
    }
    .dropbtn {
      color: #ccc;
      background: none;
      border: none;
      font-size: 15px;
      cursor: pointer;
      padding: 0;
    }
    .dropdown-content {
      display: none;
      position: absolute;
      background: #333;
      min-width: 150px;
      box-shadow: 0 8px 16px rgba(0,0,0,0.2);
      z-index: 1;
    }
    .dropdown-content a {
      color: #ccc;
      padding: 12px 16px;
      text-decoration: none;
      display: block;
    }
    .dropdown-content a:hover {
      background: #444;
    }
    .dropdown:hover .dropdown-content {
      display: block;
    }
    .icons a {
      color: #ccc;
      margin-left: 15px;
      text-decoration: none;
      font-size: 18px;
    }
    .profile {
      background: #ff4444;
      border-radius: 50%;
      width: 30px;
      height: 30px;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      color: white;
    }
  </style>
</html>