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
<head>
<meta charset="UTF-8">
<title>User Account Page</title>
<link rel='stylesheet' type='text/css' href='IndexCSS.css'>
<link rel="stylesheet" type="text/css" href="theme.css">
</head>
<body>

	<jsp:include page="navbar.jsp" /><br>
	<div id="review-list">
		<h2>User Reviews:</h2>
		<c:choose>

			<c:when test="${not empty reviews}">
				<c:set var="breweryName" scope="page" value="" />
				<c:forEach items="${reviews}" var="review">
					<c:if test="${breweryName != review.brewery.name }">
						<form:form action="userBrewDetails.do" method="GET">
						<input type="hidden" name="brewId" value="${review.brewery.id }"/>
						<h2>
						<button type="submit" class="btn-link">${review.brewery.name} </button>
							<%-- <a href="userBrewDetails.do">${review.brewery.name}</a> --%>
						</h2>
						</form:form>
					</c:if>
					<div class="user-review">
						<c:set var="breweryName" scope="page"
							value="${review.brewery.name }" />
						<c:forEach begin="1" end="${review.rating }" varStatus="loop">
							<span>🍺</span>
						</c:forEach>
						${review.dateReviewed}<br> ${review.details}
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
	You have not left any reviews yet.
	</c:otherwise>
		</c:choose>
	</div>
</body>
</html>