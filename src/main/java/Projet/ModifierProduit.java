package Projet;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.servlet.annotation.MultipartConfig;

/**
 * Servlet implementation class ModifierProduit
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // Taille maximale des fichiers avant qu'ils ne soient stockés sur le disque
maxFileSize = 1024 * 1024 * 10, // Taille maximale d'un seul fichier
maxRequestSize = 1024 * 1024 * 50) // Taille maximale totale des fichiers dans une requête
@WebServlet("/ModifierProduit")
public class ModifierProduit extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifierProduit() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	PrintWriter out = response.getWriter();
    	int idProduit = Integer.parseInt(request.getParameter("id"));
        String nomProduit = request.getParameter("nomp");
        String marque = request.getParameter("marque");
        String description = request.getParameter("description");
        String prixAchatParam = request.getParameter("prixa");
        Double prixAchat = (prixAchatParam != null) ? Double.parseDouble(prixAchatParam) : 0.0;
        String prixVenteParam = request.getParameter("prixv");
        Double prixVente = (prixVenteParam != null) ? Double.parseDouble(prixVenteParam):0.0;
        String quantiteStrParam = request.getParameter("qnt");
        int quantiteStr = (quantiteStrParam != null) ? Integer.parseInt(quantiteStrParam) : 0;
        String codeBarre = request.getParameter("codeB");
        String fournisseur = request.getParameter("typeF");
        String categorie = request.getParameter("typeC");
        String imageActuelle = request.getParameter("imageActuelle");
        Part filePart = request.getPart("nouvelleImage");
        int fournisseurId = 0;
        int categorieId = 0;
        try {
            String driver = "com.mysql.jdbc.Driver";
            String url = "jdbc:mysql://localhost:3306/db_parapharmacie";
            String username = "root";
            String password = "";
            String req = "UPDATE produits SET nom=?, marque=?, description=?, prix_achat=?, quantite=?, code_barre=?, image=?, fournisseur=?, categorie=?, prix_vente=? WHERE id=?";

            Class.forName(driver);
            try (Connection conn = DriverManager.getConnection(url, username, password);
                    PreparedStatement st = conn.prepareStatement(req)) {

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

                st.setString(1, nomProduit);
                st.setString(2, marque);
                st.setString(3, description);
                st.setDouble(4, prixAchat);
                st.setInt(5, quantiteStr);
                st.setString(6, codeBarre);

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
                ResultSet rsCategorie= stCategorie.executeQuery();
                if (rsCategorie.next()) {
                	categorieId = rsCategorie.getInt("id");
                	}
                
                // Définir les valeurs des ID et du produitId
                st.setString(7, fileName);
                st.setInt(8, fournisseurId);
                st.setInt(9, categorieId);
                st.setDouble(10, prixVente);
                st.setInt(11, idProduit);

                st.executeUpdate();
            }

            // Affichage d'un message de succès
            response.setContentType("text/html");
            out.println("<html><head><script src=\"//cdn.jsdelivr.net/npm/sweetalert2@11\"></script></head><body>");
            out.println("<script>");
            out.println(
                    "swal.fire({ icon: 'success', title: 'Bon travail !', text: 'Le produit a été modifié avec succès!' }).then(function(result){ window.location = 'ListeProduit.jsp'; });");
            out.println("</script>");
            out.println("</body></html>");
        } catch (ClassNotFoundException e) {
            out.print(e.getMessage());
        } catch (SQLException e) {
            out.print(e.getMessage());
        }
    }
}
