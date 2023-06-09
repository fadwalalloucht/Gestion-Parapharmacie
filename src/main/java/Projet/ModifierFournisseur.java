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

@WebServlet("/ModifierFournisseur")
public class ModifierFournisseur extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ModifierFournisseur() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	PrintWriter out = response.getWriter();
        int idFournisseur = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String adresse = request.getParameter("adresse");
        String telephone = request.getParameter("telephone");
        String email = request.getParameter("email");

        String driver = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/db_parapharmacie";
        String username = "root";
        String password = "";

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url, username, password);

            String sql = "UPDATE fournisseurs SET nom=?, adresse=?, telephone=?, email=? WHERE id=?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, nom);
            stmt.setString(2, adresse);
            stmt.setString(3, telephone);
            stmt.setString(4, email);
            stmt.setInt(5, idFournisseur);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
            	response.setContentType("text/html");
                out.println("<html><head><script src=\"//cdn.jsdelivr.net/npm/sweetalert2@11\"></script></head><body>");
                out.println("<script>");
                out.println(
                        "swal.fire({ icon: 'success', title: 'Bon travail !', text: 'Fournisseur a été modifiée avec succès!' }).then(function(result){ window.location = 'ListeFournisseur.jsp'; });");
                out.println("</script>");
                out.println("</body></html>");
            } else {
                response.sendRedirect("erreur.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
