<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<nav class="navbar fixed-top navbar-light bg-light">
	<a href="/DejaBrew"><button class="btn btn-primary">
			<i class="fa fa-home"></i> Home
		</button></a>
	<form action="searchKeyword.do" method="GET">
		Search by keyword:<br> <input type="text" name="keyword"
			maxlength="10"> <input type="submit" value="Search" />
	</form>
	<div class="login-container">
		<form action="/action_page.php">
			<input type="text" placeholder="Username" name="username"> <input
				type="text" placeholder="Password" name="psw">
			<button type="submit">Login</button>
		</form>
	</div>
	<form action="registration.do" method="GET">
		<br> <input type="submit" value="Register User" />
	</form>
</nav>