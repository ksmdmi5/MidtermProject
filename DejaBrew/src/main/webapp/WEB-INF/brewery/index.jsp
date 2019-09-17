<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<style>
body {
	text-align: center;
    font-family: Arial, Helvetica, sans-serif;
    padding-top: 65px;
    color: white;
    background-image: url("/image/Flag-of-Colorado-XL.jpg");
}

.masonry {
	display: flex;
	flex-flow: row wrap;
	margin-left: -8px; /* Adjustment for the gutter */
	width: 100%;
}

.masonry-brick {
	flex: auto;
	height: 250px;
	min-width: 150px;
	margin: 0 8px 8px 0; /* Some gutter */
}

.masonry-brick:nth-child(4n+1) {
	width: 250px;
}

.masonry-brick:nth-child(4n+1):nth-child(4n+2) {
	width: 325px;
}

.masonry-brick:nth-child(4n+1):nth-child(4n+3) {
	width: 180px;
}

.masonry-brick:nth-child(4n+1):nth-child(4n+4) {
	width: 380px;
}
</style>
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
	<form action="creationFormBrewery.do" method="GET">
		To Add a Brewery: <input type="submit" value="Create Brewery" />
	</form>
	<br>
	<!-- <img src="https://picsum.photos/350/305?image=100" alt="Dummy Image"> -->
	<ul>

		<div class="masonry-wrapper">
			<div class="masonry">


				<c:forEach var='brew' items='${brews}'>
					<c:set var="count" value="${count + 1}" scope="page" />


					<div class="masonry-item">
						<div class="masonry-content">
							<div class="card" style="width: 250px">
								<img class="card-img-top"
									src="https://picsum.photos/350/305?image=100" alt="Card image">
								<div class="card-body">
									<h4 class="card-title">${brew.name }</h4>
									<p class="card-text">${brew.url }</p>
									<a href="details.do" value="${brew.id }" class="btn btn-primary">See Profile</a>
								</div>
							</div>


							<%-- <h3 class="masonry-title">${brew.name }</h3>
							<p class="masonry-description">${brew.description }</p> --%>
						</div>
					</div>


				</c:forEach>
				<div class="card" style="width: 250px">
								<img class="card-img-top"
									src="https://picsum.photos/350/305?image=100" alt="Card image">
								<div class="card-body">
									<h4 class="card-title">Add your brewery</h4>
									<p class="card-text">Add your url</p>
									<%-- <a href="details.do" value="${brew.id }" class="btn btn-primary">See Profile</a> --%>
								</div>
							</div>


			</div>

		</div>

	</ul>
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
	</div>
</body>
</html>
