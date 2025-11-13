<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
	<!-- Head of the page -->
	<head>
	    <meta charset="UTF-8">
	    <link rel="stylesheet" href="resources/style/bootstrap_4.4.1.min.css">
	    <title>PlayerPage</title>
	</head>
	<!-- Body of the page -->
	<body>
		<div class="container">
			<jsp:include page="header.jsp"/>
				<div id ="playerPageID">
				<!-- Back to playlist page button -->
				<c:url value="/getPlaylist" var="backPlaylistURL">
                  	<c:param name="playlistID" value="${playlistID}"/>
					<c:param name="currentIndex" value="0"/>
                </c:url>
				<a class="btn btn-primary btn-sm col-sm-2 m-3" id="backToPlaylistID" href='${backPlaylistURL}' type="button">PLAYLIST</a><hr>
				<!-- Song details -->
			    <h1>${song.songTitle}</h1>
				<img width="300" src="data:image/jpeg;base64,${song.imageFile}"/>
			    <p>
			        <strong>Album: </strong><span id="playerAlbumTitle">${song.albumTitle}</span><br>
			        <strong>Artist: </strong><span id="playerArtist">${song.artist}</span><br>
			        <strong>Year: </strong><span id="playerPublicationYear">${song.publicationYear}</span><br>
			        <strong>Genre: </strong><span id="playerMusicalGenre">${song.musicalGenre}</span><br>
			    </p>
			    <!-- Audio player -->
			    <audio controls>
		          	<c:choose>
		                <c:when test="${not empty song.audioFile}">
		                    <source src="data:audio/mpeg;base64,${song.audioFile}" type="audio/mpeg">
		                </c:when>
		                <c:otherwise>
		                    Your browser does not support the audio element
		                </c:otherwise>
		            </c:choose>
		        </audio>
			</div> 
		</div>
	</body>
</html>