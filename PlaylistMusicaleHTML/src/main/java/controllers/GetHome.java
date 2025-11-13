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
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.UnavailableException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/getHome")
//Loading the home page
public class GetHome extends HttpServlet {

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
	
	//Extraction of the elements and loading of the home page
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		//Check on the validity of the session and the user
		if ((session == null) || (session.getAttribute("currentUser") == null)) {
	        request.setAttribute("errorMessage", "Error in the server session");
	        request.getRequestDispatcher("/start.jsp").forward(request, response);
		}
		else {
			int userID = ((User) session.getAttribute("currentUser")).getUserID();
			//Creation of the PlaylistDAO and the SongDAO
			PlaylistDAO playlistDAO = new PlaylistDAO(connection);
			SongDAO songDAO = new SongDAO(connection);
			//Extraction of the playlist list and the song list
			try {
				List<Playlist> playlistList = playlistDAO.getPlaylistList(userID);
				List <Song> songList = songDAO.getAllSongs(userID);
				//Setting of the attributes of the request
				request.setAttribute("playlistList", playlistList);
				request.setAttribute("songList", songList);
				request.getRequestDispatcher("/WEB-INF/home.jsp").forward(request, response);
			} catch (SQLException e) {
				request.setAttribute("errorTitle", "Database error");
		        request.setAttribute("errorMessage", "Database access failed");
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
