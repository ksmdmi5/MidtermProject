<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create New Brewery</title>
</head>
<body>
	<jsp:include page="navbar.jsp"/>
	<h2>Brewery Add Page</h2>
	<form action="createBrewery.do" method="POST" modelAttribute="breweryForm">
		Brewery Name here: <input type="text" name="name" value="${brewery.name}"/><br>
Street Address:   <input type="text" name="street" value="${address.street}"/><br>
City:  <input type="text" name="city" value="${address.city}"/><br>
State:  <input type="text" name="state" value="${address.state}"/><br>
ZipCode:  <input type="number" name="zip" value="${address.zip}"/><br>
<br>
Does the establishment have a food menu? (Y/N)<br>
  <input type="radio" name="menu" value="yes" ${brewery.menu==true ? "checked":""}>Yes<br>
<input type="radio" name="menu" value="no" ${brewery.menu==false ? "checked":""}>No<br>
<br>
Brewery Description:  <input type="text" name="description" value="${brewery.description}"/><br>
<br>
URL for the Brewery: <input type="text" name="url" value="${brewery.url}"/><br>

<input type="hidden" name="userId" value="1"/><!-- Change after authoritazation XXXXXXXX -->

<p>After the Brewery has been created you will be given a chance to add a review of the establishment and add what types of beers they have.</p>
<br>
 <input type="submit" value="Submit New Brewery"/><br>
 
</form>



</body>
</html>