<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
	<!-- Head of the page -->
	<head>
	    <meta charset="UTF-8">
	    <link rel="stylesheet" href="resources/style/bootstrap_4.4.1.min.css">
	    <title>ErrorPage</title>
	</head>
	<!-- Body of the page -->
	<body>
		<jsp:include page="header.jsp"/>
		<!-- Button to go back to the application -->
		<a class="btn btn-primary btn-sm col-sm-2 m-3" id="backToHomeID" href='getHome' type="button">HOME</a><hr>
		<!-- Error message -->
		<h1>${errorTitle}</h1><br>
		<h2>${errorMessage}</h2><br>
	</body>
</html>