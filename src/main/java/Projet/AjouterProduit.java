package Projet;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // Taille seuil en octets avant d'écrire sur le disque
    maxFileSize = 1024 * 1024 * 5, // Taille maximale des fichiers téléchargés (5 Mo ici)
    maxRequestSize = 1024 * 1024 * 10 // Taille maximale de la requête (10 Mo ici)
)
@WebServlet("/AjouterProduit")
public class AjouterProduit extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AjouterProduit() {
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
        String nomProduit = request.getParameter("nomp");
        String marque = request.getParameter("marque");
        String description = request.getParameter("description");
        String prixAchatStr = request.getParameter("prixa");
        String prixVenteStr = request.getParameter("prixv");
        String quantiteStr = request.getParameter("qnt");
        String codeBarre = request.getParameter("codeB");
        String fournisseur = request.getParameter("typeF");
        String categorie = request.getParameter("typeC");
        Part filePart = request.getPart("photo");

        // Validation des champs
  
        if (nomProduit.isEmpty() || marque.isEmpty() || description.isEmpty() || prixAchatStr.isEmpty()
                || quantiteStr.isEmpty() || codeBarre.isEmpty() || fournisseur.isEmpty() || categorie.isEmpty()) {
        	 out.println("<html><head><script src=\"//cdn.jsdelivr.net/npm/sweetalert2@11\"></script></head><body>");
             out.println("<script>");
             out.println("swal.fire({ icon: 'error', title: 'Oops...', text: 'Veuillez remplir tous les champs!' }).then(function(result){ window.location = 'AjouterProduit.jsp'; });");
             out.println("</script>");
             out.println("</body></html>");
            return;
            
        }

        double prixAchat = Double.parseDouble(prixAchatStr);
        double prixVente = Double.parseDouble(prixVenteStr);
        int quantite = Integer.parseInt(quantiteStr);
        String fileName = null; // Déplacer la déclaration ici
        int fournisseurId = 0;
        int categorieId = 0;

        if (filePart != null) {
            fileName = filePart.getSubmittedFileName();
            System.out.println("Selected Image File Name: " + fileName);
            String uploadPath = "C:/Users/FADWA LALLOUCHT/eclipse-workspace/Parapharmachie/src/main/webapp/Images/"
                    + fileName;
            System.out.println("Upload Path: " + uploadPath);

            try (FileOutputStream fos = new FileOutputStream(uploadPath);
                    InputStream inputStream = filePart.getInputStream()) {
                // Lire les données du fichier uploadé et les écrire sur le disque
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                }
            } catch (IOException e) {
                e.printStackTrace();
                out.println("<html><head><script src=\"//cdn.jsdelivr.net/npm/sweetalert2@11\"></script></head><body>");
                out.println("<script>");
                out.println(
                        "swal.fire({ icon: 'error', title: 'Erreur', text: 'Erreur lors de l'upload de l'image.' });.then(function(result){ window.location = 'AjouterProduit.jsp'; });");
                out.println("</script>");
                out.println("</body></html>");
                return;
            }

            // Connexion à la base de données et insertion du produit
            String driver = "com.mysql.jdbc.Driver";
            String con = "jdbc:mysql://localhost:3306/db_parapharmacie";
            String req = "INSERT INTO produits (nom, marque, description, prix_achat, quantite, code_barre, image, fournisseur, categorie, prix_vente) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try {
                Class.forName(driver);
                Connection conn = DriverManager.getConnection(con, "root", "");
                PreparedStatement st = conn.prepareStatement(req);
                st.setString(1, nomProduit);
                st.setString(2, marque);
                st.setString(3, description);
                st.setDouble(4, prixAchat);
                st.setInt(5, quantite);
                st.setString(6, codeBarre);
                st.setString(7, fileName);

                // Récupérer l'ID du fournisseur
                String reqFournisseur = "SELECT id FROM fournisseurs WHERE nom = ?";
                PreparedStatement stFournisseur = conn.prepareStatement(reqFournisseur);
                stFournisseur.setString(1, fournisseur);
                ResultSet rsFournisseur = stFournisseur.executeQuery();
                if (rsFournisseur.next()) {
                    fournisseurId = rsFournisseur.getInt("id");
                }
                
                // Récupérer l'ID de la catégorie
                String reqCategorie = "SELECT id FROM categories WHERE libelle = ?";
                PreparedStatement stCategorie = conn.prepareStatement(reqCategorie);
                stCategorie.setString(1, categorie);
                ResultSet rsCategorie = stCategorie.executeQuery();
                if (rsCategorie.next()) {
                    categorieId = rsCategorie.getInt("id");
                }
                // Définir les valeurs des ID
                st.setInt(8, fournisseurId);
                st.setInt(9, categorieId);
                st.setDouble(10, prixVente);
                
              st.executeUpdate();
              out.println("<html><head><script src=\"//cdn.jsdelivr.net/npm/sweetalert2@11\"></script></head><body>");
              out.println("<script>");
              out.println("swal.fire({ icon: 'success', title: 'bon travail !', text: 'Votre Produit est ajoutée avec succès!' }).then(function(result){ window.location = 'ListeProduit.jsp'; });");
              out.println("</script>");
              out.println("</body></html>");
            } catch (Exception e) {
            	out.print(e.getMessage());
                
            }
        }
    }
}

                           

