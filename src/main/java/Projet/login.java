package Projet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



/**
 * Servlet implementation class login
 */
@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		
		PrintWriter tp = response.getWriter();

		String driver="com.mysql.jdbc.Driver";
		String con = "jdbc:mysql://localhost:3306/bd_parapharmacie";
		String gmail = request.getParameter("email");
		String pass = request.getParameter("pass");
		String req="select * from users where email ='"+gmail+"' and password='"+pass+"'";
		try {
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(con,"root","");

		Statement st = conn.createStatement();
		ResultSet res = st.executeQuery(req);
		
		if(res.next()){
			HttpSession session = request.getSession();
			String username = res.getString(2);
			session.setAttribute("username",username );
			response.sendRedirect("index.jsp");
		}   
		else {
			String driverR="com.mysql.jdbc.Driver";
			String conR = "jdbc:mysql://localhost:3306/bd_parapharmacie";
			
			String gmailR = request.getParameter("email");
			String passR = request.getParameter("pass");
			String reqR="select * from clients where email ='"+gmailR+"' and pass='"+passR+"'";
			try {
			Class.forName(driverR);
			Connection conn1 = DriverManager.getConnection(conR,"root","");
			//Statement st = conn.createStatement();
			//st.executeUpdate(req);
			Statement st1 = conn1.createStatement();
			ResultSet res1 = st1.executeQuery(reqR);
			if(res1.next()){
				String nom = res1.getString(2) ;
				HttpSession session1 = request.getSession();
				session1.setAttribute("username",nom );
				
				response.sendRedirect("Acceuil.jsp");
			}   
			else {
				String driverR1="com.mysql.jdbc.Driver";
				String conR1 = "jdbc:mysql://localhost:3306/bd_parapharmacie";
				String gmailR1 = request.getParameter("email");
				String passR1 = request.getParameter("pass");
				String reqR1="select * from employes where email ='"+gmailR1+"' and mot_passe='"+passR1+"'";
				try {
				Class.forName(driverR1);
				Connection conn11 = DriverManager.getConnection(conR1,"root","");
				//Statement st = conn.createStatement();
				//st.executeUpdate(req);
				Statement st11 = conn11.createStatement();
				ResultSet res11 = st11.executeQuery(reqR1);
				if(res11.next()){
					String nom = res11.getString(2);
					
					HttpSession session12 = request.getSession();
					session12.setAttribute("username",nom );
					response.sendRedirect("index.jsp");
				}   
				else {
					response.sendRedirect("login.jsp");
				}
			     }
			catch(Exception e) {
			tp.println("errors");
			}
			}
		     }
		catch(Exception e) {
		tp.println("errors");
		}
		}
	     }
	catch(Exception e) {
	tp.println("errors");
	}
	
	}

}
