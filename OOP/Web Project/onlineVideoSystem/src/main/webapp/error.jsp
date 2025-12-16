<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <h2>Error</h2>
    <p style="color: red;">${error}</p>
    <a href="${pageContext.request.contextPath}/index.jsp">Back to Home</a>
</body>
</html>