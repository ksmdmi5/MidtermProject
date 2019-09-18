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

<meta name="viewport" content="width=device-width, initial-scale=1"
	charset="UTF-8">
<title>Show Individual Brewery</title>
<link rel='stylesheet' type="text/css" href='details.css'>
</head>

<body>
	<jsp:include page="navbar.jsp" /><br>
	
	<div class="header">
		<img id="header-img" alt="beer-img" src="/img/details.jpg">
		<div id="brew-name">${brew.name}</div>
	</div>
	<c:choose>
		<c:when test="${not empty brew }">
			<div class="info">
				<div class="left-info">

					<div class="extra-info">
						<h4>Website:</h4>${brew.url}<br> <br>
						<h4>Menu:</h4>
						${brew.menu==true ? "Yes":"No"}<br>
					</div>

					<div class="address-div">
						<h4>Address:</h4>
						${brew.address.street} <br> ${brew.address.city},
						${brew.address.state} ${brew.address.zip}
					</div>

					<div class="desc-div">
						<h4>Description:</h4>
						${brew.description}<br>
					</div>


				</div>
				<div class="right-info">
					<iframe width="100%" height="500" frameborder="0"
						src="https://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=5763+Arapahoe+Avenue+
						Boulder+Colorado+80303&z=14&output=embed"></iframe>
				</div>

			</div>
      
			<div class="list-container">
				<div class="beer-list">
					<c:choose>


						<c:when test="${not empty brew.beers}">
							<h2>Beer Listing:</h2>
							<c:forEach items="${brew.beers}" var="beer">


								<div class="beer-detail">

									<img class="beer-img" alt="beer" src="beer.png" width="50px">


									<div class="beer-info">

										<h3>${beer.name}</h3>
										<c:forEach items="${beer.types}" var="bt">
								Style: ${bt.name}    <%--  Description: ${bt.description} --%>
										</c:forEach>
										<br>

									</div>




								</div>

							</c:forEach>


						</c:when>
						<c:otherwise>
							No beer listing found.<br>
						</c:otherwise>
					</c:choose>
				</div>
				<div id="review-list">
					<h2>Reviews:</h2>
					<c:choose>
						<c:when test="${not empty brew.reviews}">
							<c:forEach items="${brew.reviews}" var="review">
									Reviewed By: ${review.user.username}       ${review.dateReviewed}<br>
										<c:forEach begin="1" end="${review.rating }" varStatus="loop">
											<span>🍺</span>
										</c:forEach>
									<div class="review-detail">Review: ${review.details}</div>

									<c:if test="${review.user.username == loggedIn.name}">
										<button
											onClick="setReviewData('${review.details}', '${review.rating }', '${review.id }')">
											Update</button>
										<form action="deleteReview.do" method="POST">
											<input type="hidden" name="reviewID" value="${review.id }">
											<input type="hidden" name="brewID"
												value="${review.brewery.id}">
											<button type="submit">Delete</button>
										</form>
									</c:if>
							</c:forEach>
						</c:when>
						<c:otherwise>No Reviews have been posted.</c:otherwise>
					</c:choose>
				</div>

			</div>


			Added By : ${brew.user.username}
			<br>
			Add Review for this Brewery:<br>
			<form id="review_form" action="createReview.do" method="POST"
				modelAttribute="review">
				<!-- DO NOT FORMAT STARS GET WEIRD  -->
				<div class="rating">
					<fieldset class="rating">
						<input type="radio" id="star5" name="rating" value="5" /> <label
							for="star5" title="text">5 stars</label> <input type="radio"
							id="star4" name="rating" value="4" /> <label for="star4"
							title="text">4 stars</label> <input type="radio" id="star3"
							name="rating" value="3" /> <label for="star3" title="text">3
							stars</label> <input type="radio" id="star2" name="rating" value="2" />
						<label for="star2" title="text">2 stars</label> <input
							type="radio" id="star1" name="rating" value="1" /> <label
							for="star1" title="text">1 star</label>
					</fieldset>
				</div>
				<br>
				<br>
				<textarea type="text" id="review_textbox" name="details" rows="6"
					cols="90">
			</textarea>
				<input type="hidden" id="review_id" name="reviewID" /><br> <input
					type="hidden" value="${brew.id}" name="breweryID" /><br> <input
					id="review_btn" type="submit" value="Add Review" />
				<button style="display: none;" id="cancel_update_btn"
					onClick="window.location.reload();">Cancel</button>
			</form>

			<br>
		</c:when>
		<c:otherwise>
			<p>No Brewery Found</p>
		</c:otherwise>
	</c:choose>
	<form action="editBrewery.do" method="GET">

		<br> <br> <input type="hidden" value="${brew.id }" name="id">
		<input type="submit" value="Edit Brewery" />
	</form>

	<form method='POST' action=deleteBrewery.do>

		<button class="btn btn-secondary" type="submit">Delete
			Brewery</button>
		<input type="hidden" name="id" value="${brew.id}">
	</form>

	<br>
	<br> Here is your chance to add a specific beer associated with
	this Brewery:
	<br>
	<form action="addBeer.do" method="POST">
		What Style is this beer?<select name="beerTypeId">
			<option value="1">I.P.A.</option>
			<option value="2">A.P.A.</option>
			<option value="3">Ale</option>
			<option value="4">Lager</option>
			<option value="5">Porter</option>
			<option value="6">Stout</option>
			<option value="7">Pilsner</option>
			<option value="8">Bock</option>
			<option value="9">E.S.B.</option>
			<option value="10">Brown</option>
			<option value="11">Gose</option>
			<option value="12">Saison</option>
			<option value="13">Belgian</option>
			<option value="14">Wheat/Weisse/Hefeweizen</option>
			<option value="15">Blond</option>
			<option value=16">Amber</option>
			<option value="17">Other</option>
		</select> Specific Name: <input type="text" name="beerName" /> <input
			type="hidden" name="brewId" value="${brew.id}" /> <input
			type="submit" name="Add A New Beer" />


	</form>



	<script type="text/javascript">
		function setReviewData(details, rating, id) {
			let star = "star" + rating;
			let review_btn = document.getElementById("review_btn");

			document.getElementById(star).checked = true;
			document.getElementById("review_textbox").value = details;
			document.getElementById("review_form").action = "updateReview.do";
			review_btn.value = "Update Review";
			document.getElementById("review_id").value = id;
			document.getElementById("cancel_update_btn").style.display = "block";
			review_btn.focus();
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous">

	</script>
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
