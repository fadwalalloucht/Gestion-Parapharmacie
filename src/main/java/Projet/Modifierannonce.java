package Projet;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
@WebServlet("/Modifierannonce")
public class Modifierannonce extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public Modifierannonce() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String vtitre = request.getParameter("titre");
        String vdate = request.getParameter("date");
        String vdescription = request.getParameter("description");
        String imageActuelle = request.getParameter("imageActuelle");
        Part filePart = request.getPart("nouvelleImage");
        int idAnnonce = Integer.parseInt(request.getParameter("id"));
        try {
            String driver = "com.mysql.jdbc.Driver";
            String url = "jdbc:mysql://localhost:3306/db_parapharmacie";
            String username = "root";
            String password = "";
            String query = "UPDATE annonces SET titre=?, description=?, date=?, image=? WHERE id=?";

            Class.forName(driver);
            try (Connection conn = DriverManager.getConnection(url, username, password);
                    PreparedStatement st = conn.prepareStatement(query)) {

                // Gestion de la nouvelle image
                String fileName = null;
                if (filePart != null && filePart.getSize() > 0) {
                    fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uploadPath = "C:/Users/FADWA LALLOUCHT/eclipse-workspace/Parapharmachie/src/main/webapp/Images/";
                    String filePath = uploadPath + fileName;
                    filePart.write(filePath);
                } else {
                    fileName = imageActuelle;
                }

                st.setString(1, vtitre);
                st.setString(2, vdescription);
                st.setString(3, vdate);
                st.setString(4, fileName);
                st.setInt(5, idAnnonce);

                st.executeUpdate();
            }

            // Affichage d'un message de succès
            response.setContentType("text/html");
            out.println("<html><head><script src=\"//cdn.jsdelivr.net/npm/sweetalert2@11\"></script></head><body>");
            out.println("<script>");
            out.println(
                    "swal.fire({ icon: 'success', title: 'Bon travail !', text: 'Votre annonce a été modifiée avec succès!' }).then(function(result){ window.location = 'Listeannonce.jsp'; });");
            out.println("</script>");
            out.println("</body></html>");
        } catch (ClassNotFoundException e) {
            out.print(e.getMessage());
        } catch (SQLException e) {
            out.print(e.getMessage());
        }
    }
}
