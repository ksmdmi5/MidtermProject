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

@import url(//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css);

/* Styling h1 and links
––––––––––––––––––––––––––––––––– */
h1[alt="Simple"] {color: white;}
a[href], a[href]:hover {color: grey; font-size: 0.5em; text-decoration: none}


body
{
  background: #4a4a4c !important;
}

.starrating > input {display: none;}  /* Remove radio buttons */

.starrating > label:before { 
  content: "\f005"; /* Star */
  margin: 2px;
  font-size: 8em;
  font-family: FontAwesome;
  display: inline-block; 
}

.starrating > label
{
  color: #222222; /* Start color when not clicked */
}

.starrating > input:checked ~ label
{ color: #ffca08 ; } /* Set yellow color when star checked */

.starrating > input:hover ~ label
{ color: #ffca08 ;  } /* Set yellow color when star hover */


</style>
<meta name="viewport" content="width=device-width, initial-scale=1"
	charset="UTF-8">
<title>Show Individual Brewery</title>
<!-- <link rel='stylesheet' href='IndexCSS.css'> -->
</head>
<body>
	<jsp:include page="navbar.jsp" /><br>
	<h2>Details of ${brew.name}</h2>
	<br>
	<c:choose>
		<c:when test="${not empty brew }">
				Address: <pre class="tab">${brew.address.street} , ${brew.address.city} , ${brew.address.state} , ${brew.address.zip} </pre>
				Description: ${brew.description}<br>
				URL: ${brew.url}<br>
				menu: ${brew.menu==true ? "Yes":"No"}<br>
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
						${review.rating}<br>
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
<div class="rating">
        <div class="starrating risingstar d-flex flex-row-reverse">
            <input type="radio" id="star5" name="rating" value="5" /><label for="star5" title="5 star">5</label>
            <input type="radio" id="star4" name="rating" value="4" /><label for="star4" title="4 star">4</label>
            <input type="radio" id="star3" name="rating" value="3" /><label for="star3" title="3 star">3</label>
            <input type="radio" id="star2" name="rating" value="2" /><label for="star2" title="2 star">2</label>
            <input type="radio" id="star1" name="rating" value="1" /><label for="star1" title="1 star">1</label>
        </div>
  </div>	
				<br> <br> <br> <br> <br>
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
</body>
</html>
