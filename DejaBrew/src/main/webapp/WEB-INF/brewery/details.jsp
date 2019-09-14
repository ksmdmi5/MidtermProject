<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
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
<title>Show Individual Brewery</title>
</head>
<body>
	<jsp:include page="navbar.jsp"/>
	<h2>Details of the Brewery you choose:</h2>
	<br>
	<c:choose>
		<c:when test="${not empty brewery.id }">
			<h3>${brewery.name}</h3>
			<br>
			<ul>
				<li>Address: ${brewery.address}</li>
				<br>
				<li>Description: ${brewery.description}</li>
				<br>
				<li>url: ${brewery.url}</li>
				<br>
				<li>menu: ${brewery.menu}</li>
				<br>
		 	</ul>
			<%--<c:if test="${not empty brewery.beers}">
				<c:forEach items="${brewery.beers}" var="beer">
					<li>Beers: ${beer.type}</li>
					<li>Beers: ${beer.name}</li>
					<br>
				</c:forEach>
			</c:if>
	<br>
	<c:if test="${not empty brewery.reviews}">

		<c:forEach items="${brewery.reviews}" var="review">
			<li>Reviews: ${review.details}</li>
			<li>Reviews: ${review.rating}</li>
			<br>
		</c:forEach>
	</c:if>
	<br>
	<li>added by user: ${brewery.user}</li>
	<br>
 --%>
	</c:when>
	<c:otherwise>
		<p>No Brewery Found</p>
	</c:otherwise>

	</c:choose>
</body>
</html>