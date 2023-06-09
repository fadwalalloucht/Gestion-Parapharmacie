package Projet;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
@WebServlet("/Ajouterannonce")
public class Ajouterannonce extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public Ajouterannonce() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String vtitre = request.getParameter("titre");
        String vdate = request.getParameter("date");
        String vdescripton = request.getParameter("description");
        Part filePart = request.getPart("photo");
        String fileName = filePart.getSubmittedFileName();
        
        // Vérifier si les champs sont remplis
        if (vtitre.isEmpty() || vdate.isEmpty() || vdescripton.isEmpty() || fileName.isEmpty()) {
            out.println("<html><head><script src=\"//cdn.jsdelivr.net/npm/sweetalert2@11\"></script></head><body>");
            out.println("<script>");
            out.println("swal.fire({ icon: 'error', title: 'Oops...', text: 'Veuillez remplir tous les champs!' }).then(function(result){ window.location = 'Ajouterannonce.jsp'; });");
            out.println("</script>");
            out.println("</body></html>");
            return; // Arrêter l'exécution de la méthode doPost si les champs ne sont pas remplis
        }
        
        System.out.println("Selected Image File Name : " + fileName);
        String uploadPath = "C:/Users/FADWA LALLOUCHT/eclipse-workspace/Parapharmachie/src/main/webapp/Images/"
                + fileName;
        System.out.println("Upload Path : " + uploadPath);
        FileOutputStream fos = new FileOutputStream(uploadPath);
        InputStream is = filePart.getInputStream();
        byte[] data = new byte[is.available()];
        is.read(data);
        fos.write(data);
        fos.close();

        String driver = "com.mysql.jdbc.Driver";
        String con = "jdbc:mysql://localhost:3306/db_parapharmacie";
        String req = "INSERT INTO annonces (titre, description, date, image) VALUES (?, ?, ?, ?)";
        try {
            Class.forName(driver);
            Connection conn = DriverManager.getConnection(con, "root", "");
            PreparedStatement st = conn.prepareStatement(req);
            st.setString(1, vtitre);
            st.setString(2, vdescripton);
            st.setString(3, vdate);
            st.setString(4, fileName);

            st.executeUpdate();

            out.println("<html><head><script src=\"//cdn.jsdelivr.net/npm/sweetalert2@11\"></script></head><body>");
            out.println("<script>");
            out.println("swal.fire({ icon: 'success', title: 'bon travail !', text: 'Votre annonce est ajoutée avec succès!' }).then(function(result){ window.location = 'Listeannonce.jsp'; });");
            out.println("</script>");
            out.println("</body></html>");
        } catch (Exception e) {
            out.print(e.getMessage());
        }
    }
}
