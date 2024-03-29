<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!--Modal: Login / Register Form-->
<div class="modal fade" id="modalLRForm" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog cascading-modal" role="document">
		<!--Content-->
		<div class="modal-content">

			<!--Modal cascading tabs-->
			<div class="modal-c-tabs">

				<!-- Nav tabs -->
				<ul class="nav nav-tabs md-tabs tabs-2 light-blue darken-3"
					role="tablist">
					<li class="nav-item"><a class="nav-link active"
						data-toggle="tab" href="#panel7" role="tab">Login</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab"
						href="#panel8" role="tab">Register</a></li>
				</ul>

				<!-- Tab panels -->
				<div class="tab-content">
					<!--Panel 7-->
					<div class="tab-pane fade in show active" id="panel7"
						role="tabpanel">
						<form action="login" method="POST">
							<!--Body-->
							<div class="modal-body mb-1">
								<div class="md-form form-sm mb-5">
									<input type="text" name="username" id="modalLRInput10"
										class="form-control form-control-sm validate"> <label
										data-error="wrong" data-success="right" for="modalLRInput10">Your
										Username</label>
								</div>
								<div class="md-form form-sm mb-4">
									<input type="password" name="password" id="modalLRInput11"
										class="form-control form-control-sm validate"> <label
										data-error="wrong" data-success="right" for="modalLRInput11">Your
										password</label>
								</div>
								<div class="text-center mt-2">
									<button class="btn btn-info" type="submit">Log in</button>
								</div>
							</div>
						</form>
						<!--Footer-->
						<div class="modal-footer">
							<button type="button"
								class="btn btn-outline-info waves-effect ml-auto"
								data-dismiss="modal">Close</button>
						</div>

					</div>
					<!--/.Panel 7-->

					<!--Panel 8-->
					<div class="tab-pane fade" id="panel8" role="tabpanel">
						<form action="createUser.do" method="POST" modelAttribute="user">
							<!--Body-->
							<div class="modal-body">
								<div class="md-form form-sm mb-5">
									<input type="username" name="username" id="modalLRInput12"
										class="form-control form-control-sm validate"> <label
										data-error="wrong" data-success="right" for="modalLRInput12">Your
										username</label>
								</div>
								<div class="md-form form-sm mb-5">
									<input type="password" name="password" id="modalLRInput13"
										class="form-control form-control-sm validate"> <label
										data-error="wrong" data-success="right" for="modalLRInput13">Your
										password</label>
								</div>
								<div class="md-form form-sm mb-4">
									<input type="password" id="modalLRInput14"
										class="form-control form-control-sm validate"> <label
										data-error="wrong" data-success="right" for="modalLRInput14">Repeat
										password</label>
								</div>
								<div class="text-center form-sm mt-2">
									<button class="btn btn-info" type="submit">Sign up</button>
								</div>
							</div>
						</form>

						<!--Footer-->
						<div class="modal-footer">
							<button type="button"
								class="btn btn-outline-info waves-effect ml-auto"
								data-dismiss="modal">Close</button>
						</div>
					</div>
					<!--/.Panel 8-->
				</div>

			</div>
		</div>
		<!--/.Content-->
	</div>
</div>
<!--Modal: Login / Register Form-->


<nav class="navbar fixed-top navbar-light bg-dark">
	<a href="/DejaBrew"><button class="btn btn-primary">
			<i class="fa fa-home"></i> Home
		</button></a>
	<c:choose>
		<c:when test="${auth == '[ROLE_ADMIN]' }">
			<a href="admin.do"><button class="btn btn-primary">God
					Mode</button></a>
		</c:when>
	</c:choose>
	<form action="searchKeyword.do" method="GET">
		<input type="text" name="keyword" placeholder="Enter a Keyword"
			maxlength="10"> <input type="submit" value="Search" />
	</form>
	<c:choose>
		<c:when test="${empty loggedIn }">
			<div class="text-center">
				<a href="" class="btn btn-primary" id="test"
					data-toggle="modal" data-target="#modalLRForm">Login/Register</a>
			</div>
		</c:when>
		<c:otherwise>
			<div class="text-center">
				<a class="btn btn-primary" href="user.do">${loggedIn.name }</a> <a href="logout"
					class="btn btn-primary">Logout</a>
			</div>
		</c:otherwise>
	</c:choose>
</nav>

