package Projet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AjouterFournissur
 */
@WebServlet("/AjouterFournissur")
public class AjouterFournissur extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjouterFournissur() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
        String vnom = request.getParameter("nom");
        String vadresse = request.getParameter("adresse");
        String vtelephone = request.getParameter("telephone");
        String vemail = request.getParameter("email");
        
     // Vérifier si les champs sont remplis
        if (vnom.isEmpty() || vadresse.isEmpty() || vtelephone.isEmpty() || vemail.isEmpty()) {
            out.println("<html><head><script src=\"//cdn.jsdelivr.net/npm/sweetalert2@11\"></script></head><body>");
            out.println("<script>");
            out.println("swal.fire({ icon: 'error', title: 'Oops...', text: 'Veuillez remplir tous les champs!' }).then(function(result){ window.location = 'AjouterFournisseur.jsp'; });");
            out.println("</script>");
            out.println("</body></html>");
            return; // Arrêter l'exécution de la méthode doPost si les champs ne sont pas remplis
        }
        
        
        // Validation de l'adresse e-mail
        String emailPattern = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        if (!vemail.matches(emailPattern)) {
            out.println("<html><head><script src=\"//cdn.jsdelivr.net/npm/sweetalert2@11\"></script></head><body>");
            out.println("<script>");
            out.println(
                    "swal.fire({ icon: 'error', title: 'Oops...', text: 'Veuillez entrer une adresse e-mail valide!' }).then(function(result){ window.location = 'AjouterFournisseur.jsp'; });");
            out.println("</script>");
            out.println("</body></html>");
            return; // Arrêter l'exécution de la méthode doPost si l'adresse e-mail est invalide
        }
       
            String driver = "com.mysql.jdbc.Driver";
            String con = "jdbc:mysql://localhost:3306/db_parapharmacie";
            String req = "INSERT INTO fournisseurs (nom, adresse, telephone, email) VALUES (?, ?, ?, ?)";
            try {
            	
                Class.forName(driver);
                Connection conn = DriverManager.getConnection(con, "root", "");
                PreparedStatement st = conn.prepareStatement(req);
                st.setString(1, vnom);
                st.setString(2, vadresse);
                st.setString(3, vtelephone);
                st.setString(4,vemail);
               
                st.executeUpdate();

                response.setContentType("text/html");
                out.println("<html><head><script src=\"//cdn.jsdelivr.net/npm/sweetalert2@11\"></script></head><body>");
                out.println("<script>");
                out.println(
                        "swal.fire({ icon: 'success', title: 'Bon travail !', text: 'Fournisseur a été ajouter avec succès!' }).then(function(result){ window.location = 'ListeFournisseur.jsp'; });");
                out.println("</script>");
                out.println("</body></html>");
    
            } catch (Exception e) {
                out.print(e.getMessage());
            }
        } 
	}

