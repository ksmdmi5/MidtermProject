<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
    crossorigin="anonymous">
<style>
body {
    font-family: Arial, Helvetica, sans-serif;
    padding-top: 65px;
}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1"
    charset="UTF-8">

<title>Create New Brewery</title>
</head>
<body>
	<jsp:include page="navbar.jsp" /><br>
	<c:if test="${not empty brew }">
		<h2>Brewery Add Page</h2>
	</c:if>
	<c:choose>
	
	<c:when test="${not empty brew }">
	<form action="createBrewery.do" method="POST"
		modelAttribute="breweryForm">
	
	</c:when>
	<c:otherwise>
	<form action="breweryEdited.do" method="POST"
		modelAttribute="breweryForm">
	
	</c:otherwise>
	</c:choose>
		Brewery Name here: <input type="text" name="name"
			value="${editBrew.name}" /><br> Street Address: <input
			type="text" name="street" value="${editBrew.address.street}" /><br>
		City: <input type="text" name="city" value="${editBrew.address.city}" /><br>
		State: <input type="text" name="state" value="${editBrew.address.state}" /><br>
		ZipCode: <input type="number" name="zip" value="${editBrew.address.zip}" /><br>
		<br> Does the establishment have a food menu? (Y/N)<br> <input
			type="radio" name="menu" value="yes"
			${editBrew.menu==true ? "checked":""}>Yes<br> <input
			type="radio" name="menu" value="no"
			${editBrew.menu==false ? "checked":""}>No<br> <br>
		Brewery Description: <input type="text" name="description"
			value="${editBrew.description}" /><br> <br> URL for the
		Brewery: <input type="text" name="url" value="${editBrew.url}" /><br>

		<input type="hidden" name="userId" value="1" />
		<input type="hidden" name="brewId" value="${editBrew.id }" />
		<!-- Change after authoritazation XXXXXXXX -->

		<p>After the Brewery has been created you will be given a chance
			to add a review of the establishment and add what types of beers they
			have.</p>
		<br>
		<c:choose>
			<c:when test="${not empty brew }">
				<input type="submit" value="Submit New Brewery" />
				<br>
			</c:when>
			<c:otherwise>
				<input type="submit" value="Update Brewery" />
			</c:otherwise>
		</c:choose>

	</form>



</body>
</html>