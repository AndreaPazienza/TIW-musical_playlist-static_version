<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
	
<!DOCTYPE html>
<html>
	<!-- Head of the page -->
	<head>
	    <meta charset="UTF-8">
	    <link rel="stylesheet" href="resources/style/bootstrap_4.4.1.min.css">
   	    <title>HomePage</title>
	</head>
	<!-- Body of the page -->
	<body>
		<div class="container">
			<jsp:include page="header.jsp"/>
			<div id="homePageID">
				<!-- Playlist list -->
				<div class="row my-2 p-1 bg-light border border-secondary rounded">
					<div class="col-sm-6">
						<div>
							<h1>Playlist collection</h1><hr>
							<div id="playlistContainerID">
								<c:choose>
									<c:when test="${playlistList.size() > 0}">
										<c:forEach var="playlist" items="${playlistList}">
											<div class="divListPlaylist row py-1">
											    <div class="col-sm-4">
											        <c:url value="/getPlaylist" var="regURL">
													    <c:param name="playlistID" value="${playlist.playlistID}"/>
														<c:param name="currentIndex" value="0"/>
													</c:url>
													<a href="${regURL}"><c:out value="${playlist.playlistName}"/></a>
											    </div>
											    <div class="col-sm-6"> 
											    	Created <fmt:formatDate type="both" value="${playlist.creationDate}"/>
											    </div>
											</div>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<p>No playlists to display</p>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
				<!-- Create new playlist form -->
				<div class="row my-2 p-1 bg-light border border-secondary rounded">
					<div class="col-sm-6">
						<div>
							<h2>Create new playlist</h2><hr>
						    <c:url value="/createPlaylist" var="createUrl"/>	
						    <form method="post" action="${createUrl}">
								<div class="row py-1">
									<input class="col-sm-6" type="text" id="playlistName" placeholder="Playlist name" name="playlistName" required>
								</div>
								<div class="row py-1">
						    		<select class="col-sm-6" id="selectedSongs" name="selectedSongs" multiple="multiple" required>
								        <c:forEach var="song" items="${songList}">
								            <option value="${song.songID}">${song.songTitle} - ${song.albumTitle}</option>
								        </c:forEach>
									</select> 
								</div>
								<div class="row py-1">
									<button class="btn btn-primary btn-sm col-sm-4 m-3" type="submit">CREATE PLAYLIST</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<!--  Add new song form -->
				<div class="row my-2 p-1 bg-light border border-secondary rounded">
					<div class="col-sm-6">
						<div>
							<h2>Add new song</h2><hr>
							<c:url value="/addSong" var="addUrl"/>
							<form method="post" action="${addUrl}" enctype="multipart/form-data">
								<div class="row py-1">
									<label class="col-sm-4 form-label" for="songTitle">Song title:</label>
									<input class="col-sm-6 form-control" type="text" id="songTitle" name="songTitle" required>
								</div>
								<div class="row py-1">
									<label class="col-sm-4 form-label" for="albumTitle">Album title:</label>
									<input class="col-sm-6 form-control" type="text" id="albumTitle" name="albumTitle" required>
								</div>
								<div class="row py-1">
									<label class="col-sm-4 form-label" for="imageFile">Album image:</label>
									<input class="col-sm-6 form-control" type="file" id="imageFile" name="imageFile" accept="image/*" required>
								</div>
								<div class="row py-1">
									<label class="col-sm-4 form-label" for="artist">Artist:</label>
									<input class="col-sm-6 form-control" type="text" id="artist" name="artist" required>
								</div>
								<div class="row py-1">
									<label class="col-sm-4 form-label" for="publicationYear">Publication year:</label>
									<input class="col-sm-6 form-control" type="number" id="publicationYear" name="publicationYear" required>
								</div>
								<div class="row py-1">
									<label class="col-sm-4 form-label" for="musicalGenre">Musical genre:</label>
									<select class="col-sm-6 form-control form-control-sm selectOdm" id="musicalGenre" name="musicalGenre" required>
										<option value="Rap">Rap</option>
										<option value="Rock">Rock</option>
										<option value="Pop">Pop</option>
										<option value="Jazz">Jazz</option>
										<option value="Classic">Classic</option>
									</select>
								</div>
								<div class="row py-1">
									<label class="col-sm-4 form-label" for="audioFile">Audio file:</label> 
									<input class="col-sm-6 form-control" type="file" id="audioFile" name="audioFile" accept="audio/*" required> 
								</div>
								<div class="row py-1">
									<button class="btn btn-primary btn-sm col-sm-4 m-3" type="submit">ADD SONG</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>

