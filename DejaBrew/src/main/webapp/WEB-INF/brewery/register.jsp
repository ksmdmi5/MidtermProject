<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<style>
body {
    font-family: Arial, Helvetica, sans-serif;
    padding-top: 65px;
}
</style>
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
    crossorigin="anonymous">
<meta name="viewport" content="width=device-width, initial-scale=1"
    charset="UTF-8">
<title>Register</title>
</head>
<body>
<jsp:include page="navbar.jsp"/>
<form action="createUser.do" method="POST" modelAttribute="user">
<h3>Register New User</h3>
	<hr>
	<div>
    <label for="username">Username:</label>
    <input type="text" id="username" name="username"/>
</div>

<div>
    <label for="password">Password:</label>
    <input type="password" id="password" name="password"/>
</div>

<input type="submit" value="Register User">


</form>
</body>
</html>