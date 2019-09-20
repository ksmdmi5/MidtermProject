<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel='stylesheet' type='text/css' href='IndexCSS.css'>
<link rel="stylesheet" type="text/css" href="theme.css">
	<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
<link rel="manifest" href="/site.webmanifest">
<link rel="mask-icon" href="/safari-pinned-tab.svg" color="#5bbad5">
<meta name="msapplication-TileColor" content="#da532c">
<head>
<style type="text/css">
body {
	font-family: Arial, Helvetica, sans-serif;
	padding-top: 65px;
}
</style>
<meta charset="UTF-8">
<title>Admin</title>
</head>
<body>
	<jsp:include page="navbar.jsp" /><br>
	<div align="center">
	<c:choose>
		<c:when test="${not empty users}">
			<c:forEach items="${users}" var="user">
				${user.username }
				<form action="deleteUser.do" method="POST">
					<button type="submit" >
					Delete User</button>
				<input type="hidden" name="id" value="${user.id}"/>
				</form>
			</c:forEach>
		</c:when>
	<c:otherwise>
	No users found.
	</c:otherwise>
	</c:choose>
	</div>
</body>
</html>