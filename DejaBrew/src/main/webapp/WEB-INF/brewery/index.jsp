<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<link rel="apple-touch-icon" sizes="180x180" href="/image/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="/image/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="/image/favicon-16x16.png">
<link rel="manifest" href="/image/site.webmanifest">
<link rel="mask-icon" href="/image/safari-pinned-tab.svg" color="#5bbad5">
<meta name="msapplication-TileColor" content="#da532c">
<meta name="theme-color" content="#ffffff">
<link rel='stylesheet' type='text/css' href='IndexCSS.css'>
<link rel='stylesheet' type='text/css' href='theme.css'>
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
	</div>
	<br>
	<!-- <img src="https://picsum.photos/350/305?image=100" alt="Dummy Image"> -->
	<ul>
		<!--  *********************  Opening Divs for All Brewery Cards             **********************************************-->
		<div class="container">
			<div class="card-deck">

				<!--  *********************  FOREA Loop Creating All Brewery Cards             **********************************************-->
				<c:forEach var='brew' items='${brews}'  varStatus="count">


					<!--  *********************  All Brewery Cards             **********************************************-->

					<div class="card mb-4">
						<img class="card-img-top"
							src="https://picsum.photos/350/305?image=100" alt="Card image">
						<div class="card-body">
							<form action="details.do" method="GET">
								<h4 class="card-title">${brew.name }</h4>
								<button type="submit" name="id" value="${brew.id }"
									class="btn btn-primary">View Details</button>
							</form>
						</div>
					</div>
					<!--  *********************  /CSS for Each breweries Card         **********************************************-->
					<!-- <div class="w-100 d-none d-sm-block d-md-none">
						wrap every 2 on sm
					</div>
					<div class="w-100 d-none d-md-block d-lg-none">
						wrap every 3 on md
					</div>
					<div class="w-100 d-none d-lg-block d-xl-none">
						wrap every 4 on lg
					</div> -->
					<c:if test="${count.count % 5 == 0 }">
					<div class="w-100 d-none d-xl-block">
						<!-- wrap every 5 on xl-->
					</div>
					</c:if>

				</c:forEach>
				<!--  *********************  /FOREA Loop Creating All Brewery Cards             **********************************************-->

				<!--  *********************   Add brewery   Card             **********************************************-->
				<div class="card mb-4">
					<img class="card-img-top"
						src="https://picsum.photos/350/305?image=100" alt="Card image">
					<div class="card-body">
						<h4 class="card-title">Add your brewery</h4>
						<p class="card-text">Add your url</p>
						<%-- <a href="details.do" value="${brew.id }" class="btn btn-primary">See Profile</a> --%>
					</div>
				</div>
				<!--  *********************   /Add brewery   Card             **********************************************-->
				<!--  *********************      Closing Divs for all breweries             **********************************************-->



			</div>
		</div>
		<!--  *********************      /Closing Divs for all breweries             **********************************************-->
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