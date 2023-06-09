package Projet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SupprimerFournisseur
 */
@WebServlet("/SupprimerFournisseur")
public class SupprimerFournisseur extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public SupprimerFournisseur() {
        super();
        
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 PrintWriter out = response.getWriter();
	        // Récupérer l'identifiant de l'annonce à supprimer
	        String FournisseurId = request.getParameter("id");

	        // Vérifier si l'identifiant est valide (non null et non vide)
	        if (FournisseurId != null && !FournisseurId.isEmpty()) {
	            try {
	                String driver = "com.mysql.jdbc.Driver";
	                String url = "jdbc:mysql://localhost:3306/db_parapharmacie";
	                String username = "root";
	                String password = "";

	                Class.forName(driver);
	                Connection connection = DriverManager.getConnection(url, username, password);

	           
	                String sql = "DELETE FROM fournisseurs WHERE id = ?";
	                PreparedStatement statement = connection.prepareStatement(sql);
	                statement.setString(1, FournisseurId);

	               
	                int rowsAffected = statement.executeUpdate();

	                
	                if (rowsAffected > 0) {
	                	response.setContentType("text/html");
	                    out.println("<html><head><script src=\"//cdn.jsdelivr.net/npm/sweetalert2@11\"></script></head><body>");
	                    out.println("<script>");
	                    out.println("swal.fire({ icon: 'success', title: 'bon travail !', text: 'Votre Fournisseur est supprimer avec succès!' }).then(function(result){ window.location = 'ListeFournisseur.jsp'; });");
	                    out.println("</script>");
	                    out.println("</body></html>");
	                } else {
	                    response.sendRedirect("Erreur.jsp");
	                }
	                statement.close();
	                connection.close();
	            } catch (ClassNotFoundException | SQLException e) {
	                e.printStackTrace();
	            }
	        } else {
	            response.sendRedirect("Erreur.jsp");
	        }
	    }
	}



