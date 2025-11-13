<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
	<!-- Head of the page -->
	<head>
	    <meta charset="UTF-8">
	    <link rel="stylesheet" href="resources/style/bootstrap_4.4.1.min.css">
	    <title>PlaylistPage</title>
	</head>
	<!-- Body of the page -->
	<body>
		<div class="container">
			<jsp:include page="header.jsp"/>
			<div id = "playlistPageID">
				<!-- Back to the home page button -->
				<a class="btn btn-primary btn-sm col-sm-2 m-3" id="backToHomeID" href='getHome' type="button">HOME</a><hr>
				<!-- Playlist song table -->
				<div class="row my-2 p-1 bg-light border border-secondary rounded">
					<div class="col-sm-12">
						<div class="row">
						    <h1 id="playListNameID"><c:out value="${currentPlaylist.playlistName}"></c:out></h1>
						    <table id="playlistSongTableID" class="table">
						        <tr id="playlistSongTableRowID">
						           <c:forEach var="pSong" items="${playlistSongs}" begin="${currentIndex}" end="${currentIndex + 4}" varStatus="loop">
									    <c:if test="${loop.index <= lastIndex}">
									        <td>
									            <c:url value="/getPlayer" var="songURL">
									            	<c:param name="playlistID" value="${currentPlaylist.playlistID}"/>
									            	<c:param name="songID" value="${pSong.songID}"/>
								            	</c:url>
									            <a href="${songURL}"><img width="200" src="data:image/jpeg;base64,${pSong.imageFile}"/></a><br>
									            <c:out value="${pSong.songTitle}"/>
									        </td>
									    </c:if>
									</c:forEach>
						        </tr>
						    </table>
						</div>
						<div class="row">
							<!-- Previous page button -->
							<div class="col-sm-4">
				                <c:if test="${currentIndex >= 5}">
				                    <c:url value="/getPlaylist" var="prevPageURL">
				                    	<c:param name="playlistID" value="${currentPlaylist.playlistID}"/>
										<c:param name="currentIndex" value="${currentIndex - 5}"/>
				                    </c:url>
									<a class="btn btn-primary btn-sm m-3" id="previousPageID" href='${prevPageURL}' type="button">PREVIOUS</a>
		                		</c:if>
						    </div>
						    <!-- Next page button -->
						    <div class="col-sm-4 offset-sm-4">
				                <c:if test="${currentIndex <= lastIndex - 5}">
				                    <c:url value="/getPlaylist" var="nextPageURL">
				                    	<c:param name="playlistID" value="${currentPlaylist.playlistID}"/>
				                    	<c:param name="currentIndex" value="${currentIndex + 5}"/>
				                    </c:url>
							    	<a class="btn btn-primary btn-sm m-3 float-right" id="nextPageID" href='${nextPageURL}' type="button">NEXT</a>
				                </c:if>			    
							</div>
						</div>
					</div>
				</div>
				<c:choose>
					<c:when test="${songList.size() > 0}">
						<!-- Add song to playlist form -->
						<div class="row my-2 p-1 bg-light border border-secondary rounded">
							<div class="col-sm-6">
						        <h2>Add song to <c:out value="${currentPlaylist.playlistName}"></c:out></h2><hr>
						        <c:url value="/addSongToPlaylist" var="addPUrl"/>
							    <form method="post" action="${addPUrl}">
									<div class="row py-1">
										<input type="hidden" name="playlistID" value="${currentPlaylist.playlistID}" required>
							            <select class="col-sm-6" id="playlistSongSelectID" name="selectedSongs" multiple="multiple" required>
											<c:forEach var="song" items="${songList}">
												<option value="${song.songID}">${song.songTitle} - ${song.albumTitle}</option>
											</c:forEach>
							            </select>
									</div>
									<button class="btn btn-primary btn-sm col-sm-4 m-3" type="submit">ADD TO PLAYLIST</button>
						        </form>
							</div>
						</div>
       				</c:when>
				</c:choose>
			</div>
		</div>
	</body>
</html>