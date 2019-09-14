<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<style>
body {
    font-family: Arial, Helvetica, sans-serif;
    padding-top: 65px;
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

<form action="details.do" method="GET">
		Search for Brewery: <input type="text" name="brew" /> <input
			type="submit" value="Find Brewery" />
	</form>

<body>
<jsp:include page="navbar.jsp"/>
    <%-- <jsp:include page="navbar.jsp" /> --%>
    <ul>
        <c:forEach var='brew' items='${brews}'>
            <form method='get' action=details.do>
                <li>${brew.name }</li>
                <button class="btn btn-secondary" type="submit">
                  View Brewery Data:   </button>
                <input type="hidden" name="id" value="${brew.id}">
            </form>
        </c:forEach>
    </ul>

</body>
</html>  