package Projet;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.servlet.annotation.MultipartConfig;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10,      // 10MB
maxRequestSize = 1024 * 1024 * 50)   // 50MB

@WebServlet("/AjouterEmploye")
public class AjouterEmploye extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AjouterEmploye() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Code de traitement pour la méthode GET
        // Vous pouvez ajouter ici la logique nécessaire pour gérer les requêtes GET
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String login = request.getParameter("login");
        String motDePasse = request.getParameter("Mt");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String cin = request.getParameter("cin");
        String adresse = request.getParameter("adresse");
        String telephone = request.getParameter("telephone");
        String email = request.getParameter("email");
        String type = request.getParameter("type");
        String salaire = request.getParameter("salaire");
        Part filePart = request.getPart("photo");
        if (login.isEmpty() || motDePasse.isEmpty() ||
        	    nom.isEmpty() ||
        	    prenom.isEmpty() ||
        	     cin.isEmpty() ||
        	    adresse.isEmpty() ||
        	    telephone.isEmpty() ||
        	  email.isEmpty() ||
        	  
        	     type.isEmpty() ||
        	     salaire.isEmpty()) {
        	    
        	    response.setContentType("text/html");
        	    out.println("<html><head><script src=\"//cdn.jsdelivr.net/npm/sweetalert2@11\"></script></head><body>");
        	    out.println("<script>");
        	    out.println("swal.fire({ icon: 'error', title: 'Erreur', text: 'Veuillez remplir tous les champs obligatoires.' }).then(function(result){ window.location = 'AjouterEmployer.jsp'; });");
        	    out.println("</script>");
        	    out.println("</body></html>");
        	    return;
        	}

        String fileName = null; // Déplacer la déclaration ici
        Double salaireA=Double.parseDouble(salaire);

        if (filePart != null) {
            fileName = filePart.getSubmittedFileName();
            System.out.println("Selected Image File Name: " + fileName);
            String uploadPath = "C:/Users/FADWA LALLOUCHT/eclipse-workspace/Parapharmachie/src/main/webapp/Images/"
                    + fileName;
            System.out.println("Upload Path: " + uploadPath);

            try (FileOutputStream fos = new FileOutputStream(uploadPath);
                 InputStream is = filePart.getInputStream()) {
                byte[] data = new byte[is.available()];
                is.read(data);
                fos.write(data);
            } catch (IOException e) {
                out.print("Une erreur s'est produite lors du téléchargement du fichier. Veuillez réessayer.");
                e.printStackTrace();
                return;
            }
        }
        String driver = "com.mysql.jdbc.Driver";
        String con = "jdbc:mysql://localhost:3306/db_parapharmacie";
        String req = "INSERT INTO employes (nom, prenom, cin, telephone, adresse, email, role, salaire, image, login, mot_passe) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            Class.forName(driver);
            Connection conn = DriverManager.getConnection(con, "root", "");
            PreparedStatement st = conn.prepareStatement(req);

            st.setString(1, nom);
            st.setString(2, prenom);
            st.setString(3, cin);
            st.setString(4, telephone);
            st.setString(5, adresse);
            st.setString(6, email);
            st.setString(7, type);
            st.setDouble(8, salaireA);
            st.setString(9, fileName);
            st.setString(10, login);
            st.setString(11, motDePasse);

            st.executeUpdate();

            response.setContentType("text/html");
            out.println("<html><head><script src=\"//cdn.jsdelivr.net/npm/sweetalert2@11\"></script></head><body>");
            out.println("<script>");
            out.println(
                    "swal.fire({ icon: 'success', title: 'Bon travail !',text: 'Employé ajouté avec succès!' }).then(function(result){ window.location = 'ListeEmploye.jsp'; });");
            out.println("</script>");
            out.println("</body></html>");
            } catch (Exception e) {
            out.print(e.getMessage());
            }

    }}






