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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ"
	crossorigin="anonymous">
<!-- <link rel='stylesheet' type='text/css' href='master.css'> -->
<style>
body {
	font-family: Arial, Helvetica, sans-serif;
	padding-top: 65px;
}
*{
    margin: 0;
    padding: 0;
}
.rating {
    float: left;
    height: 46px;
    padding: 0 10px;
}
.rating:not(:checked) > input {
    position:absolute;
    top:-9999px;
}
.rating:not(:checked) > label {
    float:right;
    width:1em;
    overflow:hidden;
    white-space:nowrap;
    cursor:pointer;
    font-size:20px;
    color:#ccc;
}
.rating:not(:checked) > label:before {
    content: '★ ';
}
.rating > input:checked ~ label {
    color: #ffc700;    
}
.rating:not(:checked) > label:hover,
.rating:not(:checked) > label:hover ~ label {
    color: #deb217;  
}
.rating > input:checked + label:hover,
.rating > input:checked + label:hover ~ label,
.rating > input:checked ~ label:hover,
.rating > input:checked ~ label:hover ~ label,
.rating > label:hover ~ input:checked ~ label {
    color: #c59b08;
}
</style>
<meta name="viewport" content="width=device-width, initial-scale=1"
	charset="UTF-8">
<title>Show Individual Brewery</title>
<link rel='stylesheet' type="text/css" href='details.css'>
</head>

<body>
	<jsp:include page="navbar.jsp" /><br>
	<div class="header">
		<img id="header-img" alt="beer-img" src="detail.jpg">
		<div id="brew-name">${brew.name}</div>
	</div>
	<c:choose>
		<c:when test="${not empty brew }">
			<div class="info">
				<div class="left-info">

					<div class="extra-info">
						Website: ${brew.url}<br> Menu: ${brew.menu==true ? "Yes":"No"}<br>
					</div>

					<div class="address-div">
						Address: <br> ${brew.address.street} <br>
						${brew.address.city}, ${brew.address.state} ${brew.address.zip}
					</div>

					<div class="desc-div">
						Description: ${brew.description}<br>
					</div>


				</div>
				<div class="right-info">
					<iframe width="100%" height="500" frameborder="0"
						src="https://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=5763+Arapahoe+Avenue+
						Boulder+Colorado+80303&z=14&output=embed"></iframe>
				</div>

			</div>

			<c:choose>
				<c:when test="${not empty brew.beers}">
					<h4>Beer Listing:</h4>
					<c:forEach items="${brew.beers}" var="beer">
						&nbsp;&nbsp;&nbsp;${beer.name},
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
			<div id="reviewDiv">
				<c:choose>
					<c:when test="${not empty brew.reviews}">
						<c:forEach items="${brew.reviews}" var="review">
						Reviewed By: ${review.user.username}<br>
							<c:forEach begin="1" end="${review.rating }" varStatus="loop">
								<span>🍺</span>
							</c:forEach>
						${review.details }<br>

							<c:if test="${review.user.username == loggedIn.name}">
								<button
									onClick="setReviewData('${review.details}', '${review.rating }', '${review.id }')">
									Update</button>
								<form action="deleteReview.do" method="POST">
									<input type="hidden" name="reviewID" value="${review.id }">
									<input type="hidden" name="brewID" value="${review.brewery.id}">
									<button type="submit">Delete</button>
								</form>
							</c:if>
						</c:forEach>
					</c:when>
					<c:otherwise>No Reviews have been posted.</c:otherwise>
				</c:choose>
			</div>

			<br>
			
			Added By : ${brew.user.username}</li>
			<br>
			Add Review for this Brewery:<br>
			<form id="review_form" action="createReview.do" method="POST"
				modelAttribute="review">
				<!-- DO NOT FORMAT STARS GET WEIRD  -->
				<fieldset class="rating">
    <input type="radio" id="star5" name="rating" value="5" />
    <label for="star5" title="text">5 stars</label>
    <input type="radio" id="star4" name="rating" value="4" />
    <label for="star4" title="text">4 stars</label>
    <input type="radio" id="star3" name="rating" value="3" />
    <label for="star3" title="text">3 stars</label>
    <input type="radio" id="star2" name="rating" value="2" />
    <label for="star2" title="text">2 stars</label>
    <input type="radio" id="star1" name="rating" value="1" />
    <label for="star1" title="text">1 star</label>
  </fieldset>
				<br><br>
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
