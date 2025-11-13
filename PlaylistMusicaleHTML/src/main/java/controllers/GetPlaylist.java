
package controllers;

import beans.User;
import beans.Playlist;
import beans.Song;
import dao.PlaylistDAO;
import dao.SongDAO;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.UnavailableException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/getPlaylist")
//Loading of the playlist page
public class GetPlaylist extends HttpServlet {

	//Serial version of the object
	private static final long serialVersionUID = 1L;
	//Connection with the database
	private Connection connection = null;

	//Initialization and connection with the database
	public void init() throws ServletException {
		
		try {
			ServletContext context = getServletContext();
			String driver = context.getInitParameter("dbDriver");
			String url = context.getInitParameter("dbUrl");
			String user = context.getInitParameter("dbUser");
			String password = context.getInitParameter("dbPassword");
			Class.forName(driver);
			connection = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			throw new UnavailableException("Can't load database driver");
		} catch (SQLException e) {
			throw new UnavailableException("Couldn't get db connection");
		}
	}
	
	//Extraction of the elements and loading of the playlist page
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		//Check on the validity of the session and the user
		if ((session == null) || (session.getAttribute("currentUser")) == null) {
			request.setAttribute("error", true);
	        request.setAttribute("errorMessage", "Error in the server session");
	        request.getRequestDispatcher("/start.jsp").forward(request, response);
		}
		else {
			int userID = ((User) session.getAttribute("currentUser")).getUserID();
			int playlistID = 0;
			int currentIndex = 0;
			int lastIndex = 0;
			boolean error = false;
			//Creation of the PlaylistDAO and the SongDAO
			PlaylistDAO playlistDAO = new PlaylistDAO(connection);
			SongDAO songDAO = new SongDAO(connection);
			//Extraction of the playlistID and the current index
			if ((request.getParameter("playlistID") != null) && request.getParameter("currentIndex") != null) {
				try {
					playlistID = Integer.parseInt(request.getParameter("playlistID"));
					currentIndex = Integer.parseInt(request.getParameter("currentIndex"));
				} catch (NumberFormatException e) { 
					error = true;
			        request.setAttribute("errorMessage", "Wrong parameter format");
				}
			} else {
				error = true;
		        request.setAttribute("errorMessage", "Incomplete parameter insertion");
			}
			//Extraction of the playlist song list and the song list
			if(!error) {
				try {
					Playlist playlist = playlistDAO.getPlaylist(playlistID);
					List<Song> playlistSongs = songDAO.getPlaylistSongs(playlistID);
					List<Song> songList = songDAO.getNotPlaylistSongs(userID, playlistID);
					lastIndex = playlistSongs.size() - 1;
					//Setting of the attributes of the request
					String path = null;
					if ((playlist != null) && (playlistSongs != null) && (songList != null) && (currentIndex >= 0) && (currentIndex % 5 == 0) && (currentIndex <= lastIndex)) {
						path = "/WEB-INF/playlist.jsp";
						request.setAttribute("currentPlaylist", playlist);
						request.setAttribute("playlistSongs", playlistSongs);
						request.setAttribute("songList", songList);
						request.setAttribute("currentIndex", currentIndex);
						request.setAttribute("lastIndex", lastIndex);
					} else {
						path = "/WEB-INF/error.jsp";
						request.setAttribute("errorTitle", "Parameter error");
						request.setAttribute("errorMessage", "Not possible to load the page");
					}
					RequestDispatcher dispatcher = request.getRequestDispatcher(path);
					dispatcher.forward(request, response);
				} catch (SQLException e) {
					request.setAttribute("errorTitle", "Database error");
			        request.setAttribute("errorMessage", "Database access failed");
			        request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
				}			
			} else {
				request.setAttribute("errorTitle", "Parameter error");
		        request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
			}
		}
	}
	
	//Closure of the connection 
	public void destroy() {
			
		try {
			if (connection != null) {
				connection.close();
			}
		} catch (SQLException e) {}
	}
}
