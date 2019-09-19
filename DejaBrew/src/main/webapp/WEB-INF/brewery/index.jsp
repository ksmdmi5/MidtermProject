<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<link rel='stylesheet' type='text/css' href='IndexCSS.css'>

<link rel="stylesheet" type="text/css" href="theme.css">

<!-- <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous"> -->

<meta name="viewport" content="width=device-width, initial-scale=1"
	charset="UTF-8">
<title>index</title>
</head>

<body>
	<jsp:include page="navbar.jsp" />
	<br>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-md-8">
				<div>
					<em><h1>Deja Brew</h1></em>
					<br>
					<h2>Your Source For Finding Local Breweries</h2>
					<br>
					<h5>We encourage our visitors to contribute and add to our
						list</h5>
					<h5>and feel free to write a review of your favorite brewery</h5>
				</div>

<%-- 				<form action="creationFormBrewery.do" method="GET">
					To Add a Brewery: <input type="submit" value="Create Brewery" />
				</form> --%>
			</div>
		</div>
	</div>
	<br>
	<div class="container">
		<div class="card-deck">
			<c:forEach var='brew' items='${brews}' varStatus="count">
				<div class="card mb-4">
					<form action="details.do" method="GET">
						<c:choose>

							<c:when test="${not empty brew.logourl}">
								<div class="flex-container">
									<div class="img-div">

										<input type="image" class="card-img-top" src="${brew.logourl}"
											alt=" Cardimage"> <input type="hidden" name="id"
											value="${brew.id }">
									</div>


									<div class="card-body">
										<h4 align="center" position="bottom" class="card-title">${brew.name }</h4>
									<%-- 	<button type="submit" name="id" value="${brew.id }"
											class="btn btn-primary">View Details</button> --%>
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class="flex-container">
									<div class="img-div">

										<input type="image" class="card-img-top" src="/image/detail.jpg"
											alt=" Cardimage"> <input type="hidden" name="id"
											value="${brew.id }">
									</div>


									<div class="card-body">
										<h4 align="center" class="card-title">${brew.name }</h4>
								<%-- 		<button type="submit" name="id" value="${brew.id }"
											class="btn btn-primary">View Details</button> --%>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</form>
				</div>
				<c:if test="${count.count % 3 == 0 }">
					<div class="w-100 d-none d-md-block d-lg-none"></div>
				</c:if>
				<c:if test="${count.count % 4 == 0 }">
					<div class="w-100 d-none d-lg-block d-xl-none"></div>
				</c:if>
				<c:if test="${count.count %5 ==0 }">
					<div class="w-100 d-none d-xl-block"></div>
				</c:if>
			</c:forEach>
			<div class="card mb-4">
				<img class="card-img-top" src="/image/taps.jpg" alt="Card image">
				<div class="card-body">
					<h4 class="card-title">Add your brewery</h4>
					<form action="creationFormBrewery.do" method="GET">
						<input type="submit" class="btn btn-primary"
							value="Create Brewery" />
					</form>
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>

</body>
</html>