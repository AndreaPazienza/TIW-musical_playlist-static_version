<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Logged user and logout button -->
<div class="row my-2 p-1">
	<h2 class="col-sm-4" >User: <c:out value="${currentUser.username}"></c:out></h2>
    <a class="col-sm-2 btn btn-primary btn-sm" id="logoutID" href='logout' type="button">LOGOUT</a>
</div>
<hr>