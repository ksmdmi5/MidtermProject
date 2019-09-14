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
	<jsp:include page="navbar.jsp" />
	<h2>Details of the Brewery you choose:</h2>
	<br>
	<c:choose>
		<c:when test="${not empty brew }">
			<h3>${brew.name}</h3>
			<br>
			<ul>
				<li>Address: ${brew.address}</li>
				<br>
				<li>Description: ${brew.description}</li>
				<br>
				<li>url: ${brew.url}</li>
				<br>
				<li>menu: ${brew.menu}</li>
				<br>
			</ul>
			<c:choose>
				<c:when test="${not empty brew.beers}">
					<h4>Beer Listing:</h4>
					<c:forEach items="${brew.beers}" var="beer">
						<li>${beer.name}</li>
						<c:forEach items="${beer.types}" var="bt">
							<li>Style: ${bt.name}</li>
							<li>Description: ${bt.description}</li>
						</c:forEach>
						<br>
					</c:forEach>
				</c:when>
				<c:otherwise>
			No beer listing found.
			</c:otherwise>
			</c:choose>
			<br>
			<c:choose>
				<c:when test="${not empty brew.reviews}">
					<c:forEach items="${brew.reviews}" var="review">
						<li>Rating: ${review.rating}</li>
						<li>Review: ${review.details}</li>
						<br>
					</c:forEach>
				</c:when>
			</c:choose>
			<br>
			<li>added by user: ${brewery.user}</li>
			<br>
		</c:when>
		<c:otherwise>
			<p>No Brewery Found</p>
		</c:otherwise>

	</c:choose>
</body>
</html>