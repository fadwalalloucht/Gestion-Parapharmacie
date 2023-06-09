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
@WebServlet("/ModifierEmploye")
public class ModifierEmploye extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ModifierEmploye() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	 PrintWriter out = response.getWriter();
         String login = request.getParameter("login");
         String motDePasse = request.getParameter("password");
         String nom = request.getParameter("nom");
         String prenom = request.getParameter("prenom");
         String cin = request.getParameter("cin");
         String adresse = request.getParameter("adresse");
         String telephone = request.getParameter("telephone");
         String email = request.getParameter("email");
         String role = request.getParameter("role");
         Double salaire = Double.parseDouble(request.getParameter("salaire"));
         String imageActuelle = request.getParameter("imageActuelle");
         Part filePart = request.getPart("nouvelleImage");
         int idEmploye = Integer.parseInt(request.getParameter("id"));
         try {
             String driver = "com.mysql.jdbc.Driver";
             String url = "jdbc:mysql://localhost:3306/db_parapharmacie";
             String username = "root";
             String password = "";
             String query = "UPDATE employes SET nom=?, prenom=?, cin=?, telephone=?, adresse=?,";
             		query+= " email=?, role=?, salaire=?, image=?, login=?, mot_passe=? WHERE id=?";

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

                 st.setString(1, nom);
                 st.setString(2, prenom);
                 st.setString(3, cin);
                 st.setString(4, telephone);
                 st.setString(5, adresse);
                 st.setString(6, email);
                 st.setString(7, role);
                 st.setDouble(8, salaire);
                 st.setString(9, fileName);
                 st.setString(10, login);
                 st.setString(11, motDePasse);
                 st.setInt(12, idEmploye);

                 st.executeUpdate();
             }

            // Affichage d'un message de succès
            response.setContentType("text/html");
            out.println("<html><head><script src=\"//cdn.jsdelivr.net/npm/sweetalert2@11\"></script></head><body>");
            out.println("<script>");
            out.println(
                    "swal.fire({ icon: 'success', title: 'Bon travail !', text: 'Employé a été modifié avec succès!' }).then(function(result){ window.location = 'ListeEmploye.jsp'; });");
            out.println("</script>");
            out.println("</body></html>");
        } catch (ClassNotFoundException e) {
            out.print(e.getMessage());
        } catch (SQLException e) {
            out.print(e.getMessage());
        }
    }
}

       
           
