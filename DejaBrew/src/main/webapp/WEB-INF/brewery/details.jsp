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
	<jsp:include page="navbar.jsp" /><br>
	<h2>Details of the Brewery you choose:</h2>
	<br>
	<c:choose>
		<c:when test="${not empty brew }">
			<h3>${brew.name}</h3>
			<br>
				Address: <pre class="tab">${brew.address.street} , ${brew.address.city} , ${brew.address.state} , ${brew.address.zip} </pre>
				Description: ${brew.description}<br>
				URL: ${brew.url}<br>
				menu: ${brew.menu==true ? "Yes":"No"}<br>
			<c:choose>
				<c:when test="${not empty brew.beers}">
					<h4>Beer Listing:</h4>
					<c:forEach items="${brew.beers}" var="beer">
						${beer.name},
						<c:forEach items="${beer.types}" var="bt">
							  Style: ${bt.name}    <%--  Description: ${bt.description} --%>
						</c:forEach>
						<br>
					</c:forEach>
				</c:when>
				<c:otherwise>
			No beer listing found.<br>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${not empty brew.reviews}">
					<c:forEach items="${brew.reviews}" var="review">
						Rating: ${review.rating}<br>
						Review: ${review.details}<br>
					</c:forEach>
				</c:when>
				<c:otherwise>No Reviews have been posted.</c:otherwise>
			</c:choose>
			<br>
			Added By:  ${brew.user.username}
			<br>
			<br>
			<form action="createReview.do" method="POST">
				Add Review for this Brewery:<br>
				<textarea rows="6" cols="90">
			</textarea>
				<br> <input type="submit" name="addReview" value="Add Review" /><br>
				<br>
		</c:when>
		<c:otherwise>
			<p>No Brewery Found</p>
		</c:otherwise>
	</c:choose>
	<form action="editBrewery.do" method="GET">
		<input type="hidden" value="${brew.id }" name="id"> <input
			type="submit" value="Edit Brewery" /><br>
		<br>
		<form method='POST' action=deleteBrewery.do>
			<button class="btn btn-secondary" type="submit"
				value="Delete Brewery">Delete Brewery</button>
			<input type="hidden" name="id" value="${brew.id}">
		</form>
</body>
</html>
