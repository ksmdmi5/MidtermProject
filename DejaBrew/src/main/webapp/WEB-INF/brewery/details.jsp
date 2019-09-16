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
<style>
body {
    font-family: Arial, Helvetica, sans-serif;
    padding-top: 65px;
}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1"
    charset="UTF-8">
<title>Show Individual Brewery</title>
<!-- <link rel='stylesheet' href='IndexCSS.css'> -->
</head>
<body>
	<jsp:include page="navbar.jsp" />
	<h2>Details of the Brewery you choose:</h2>
	<br>
	<c:choose>
		<c:when test="${not empty brew }">
			<h3>${brew.name}</h3>
			<br>
			
				Address:  ${brew.address}
				<br>
				Description:  ${brew.description}
				<br>
				URL:  ${brew.url}
				<br>
				menu:  ${brewery.menu==true ? "Yes":"No"}
				<br>
			
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
			<form method='POST' action=deleteBrewery.do>
				<button class="btn btn-secondary" type="submit">
					Delete Brewery</button>
				<input type="hidden" name="id" value="${brew.id}">
			</form>
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
	<form action="editBrewery.do" method="GET" >
	<input type="hidden" value="${brew.id }" name="id">
	Edit Brewery:  <input type="submit" value="Edit Brewery" />
</body>
</html>
