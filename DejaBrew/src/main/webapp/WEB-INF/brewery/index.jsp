<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<link rel='stylesheet' type='text/css' href='IndexCSS.css'>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
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
					<h2>Your Source For Finding Local Breweries</h2>
					<h3>We Encourage Our Visitors to Contribute and Add to Our
						List</h3>
					<h3>And Feel Free to Write a Review of Your Favorite Brewery</h3>
				</div>
				<br>

				<form action="creationFormBrewery.do" method="GET">
					To Add a Brewery: <input type="submit" value="Create Brewery" />
				</form>
			</div>
		</div>
	</div>
	<br>

	<div class="masonry">
		<c:forEach var='brew' items='${brews}'>
			<c:set var="count" value="${count + 1}" scope="page" />
			<div class="masonry-item">
				<div class="masonry-content">
					<div class="card" style="width: 250px">
						<form action="details.do" method="GET">
							<c:choose>
								<c:when test="${not empty brew.logourl}">

									<img class="card-img-top" src="${brew.logourl}"
										style="width: 250px" alt=" Cardimage">
									<div class="card-body">
										<h4 class="card-title">${brew.name }</h4>
										<button type="submit" name="id" value="${brew.id }"
											class="btn btn-primary">View Details</button>
											</div>
								</c:when>
								<c:otherwise>
									<img class="card-img-top" src="/image/detail.jpg"
										style="width: 250px" alt=" Cardimage">
									<div class="card-body">
										<h4 class="card-title">${brew.name }</h4>
										<button type="submit" name="id" value="${brew.id }"
											class="btn btn-primary">View Details</button>
											</div>
								</c:otherwise>
							</c:choose>
						</form>
					</div>
				</div>


				<%-- <h3 class="masonry-title">${brew.name }</h3>
							<p class="masonry-description">${brew.description }</p> --%>
			</div>

	</c:forEach>
			
	</div>

	<div class="card" style="width: 250px">
		<img class="card-img-top" src="/image/taps.jpg" alt="Card image">
		<div class="card-body">
			<h4 class="card-title">Add your brewery</h4>
			<!-- <p class="card-text">Add your url</p> -->
			<%-- <a href="details.do" value="${brew.id }" class="btn btn-primary">See Profile</a> --%>
			<form action="creationFormBrewery.do" method="GET">
				<input type="submit" class="btn btn-primary" value="Create Brewery" />
			</form>
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