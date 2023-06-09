<%@ include file="include/css.jsp" %>
<%@ include file="include/header.jsp" %>
<div class="container-fluid page-body-wrapper">
    <%@ include file="include/sidebar.jsp" %>
    <%@ page import="java.sql.*" %>
    <div class="main-panel">
        <div class="content-wrapper">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h1 class="card-title">LES PRODUITS</h1>
                         
                        <button type="button" class="btn btn-success btn-icon-text"
                            style="margin-left: 66%; margin-top: -4%;">
                            Imprimer
                            <i class="ti-printer btn-icon-append"></i>
                        </button>
                        <form action="RechercheProduit.jsp">
                        <div class="form-group">
                            <div class="input-group">
                                <input type="text" name="nom" class="form-control" placeholder="Chercher un produit"
                                    aria-label="Chercher un produit" style="margin-left: 77%; margin-top: -4%;">
                                <div class="input-group-append">
                                <%
                                String driver = "com.mysql.jdbc.Driver";
                                String con = "jdbc:mysql://localhost:3306/db_parapharmacie";
                                String searchTerm = request.getParameter("nom"); // Récupérer le terme de recherche depuis la requête

                                // Requête SQL pour rechercher les produits par nom
                                String req1 = "SELECT p.id, p.nom, p.marque, p.prix_achat, p.prix_vente, p.description, p.image, p.quantite, p.code_barre, c.libelle AS nom_categorie, f.nom AS nom_fournisseur FROM produits p"
                                        + " INNER JOIN categories c ON p.categorie = c.id"
                                        + " INNER JOIN fournisseurs f ON p.fournisseur = f.id"
                                        + " WHERE p.nom LIKE ?"; // Utilisation du paramètre LIKE pour rechercher les noms similaires

                                try {
                                    Class.forName(driver);
                                    Connection conn = DriverManager.getConnection(con, "root", "");
                                    PreparedStatement st = conn.prepareStatement(req1);
                                    st.setString(1, "%" + searchTerm + "%"); // Ajouter le terme de recherche à la requête
                                    ResultSet res = st.executeQuery();
                                        } catch (Exception e) {
                                            out.print(e.getMessage());
                                        }
                                        %>
                                    <button class="btn btn-sm btn-primary" type="submit"
                                        style="margin-top: -120%; margin-bottom: 16%;">
                                        <i class="ti-search"></i>
                                    </button>
                                  
                                </div>
                            </div>
                        </div>
                        </form>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>
                                            N°
                                        </th>
                                        <th>
                                            IMAGE
                                        </th>
                                        <th>
                                            NOM
                                        </th>
                                        <th>
                                            CATEGORIE
                                        </th>
                                        <th>
                                            MARQUE
                                        </th>
                                        <th>
                                            FOURNISSEUR
                                        </th>
                                        <th>
                                            DESCRIPTION
                                        </th>
                                        <th>
                                            PRIX D'ACHAT
                                        </th>
                                        <th>
                                            PRIX VENTE
                                        </th>
                                        <th>
                                            QUANTITE
                                        </th>
                                        <th>
                                            CODE BARRE
                                        </th>
                                        <th>
                                            OPERATION
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                
                                    <%
                                        String req = "SELECT p.id, p.nom, p.marque, p.prix_achat, p.prix_vente,p.description,p.image,p.quantite,p.code_barre, c.libelle AS nom_categorie, f.nom AS nom_fournisseur FROM produits p"
                                                + " INNER JOIN categories c ON p.categorie = c.id"
                                                + " INNER JOIN fournisseurs f ON p.fournisseur = f.id";
                                           
                                        try {
                                            Class.forName(driver);
                                            Connection conn = DriverManager.getConnection(con, "root", "");
                                            PreparedStatement st = conn.prepareStatement(req);
                                            ResultSet res = st.executeQuery();

                                            while (res.next()) {
                                            	int vid = res.getInt("p.id");
                                                String vimage = res.getString("p.image");
                                                String vnom = res.getString("p.nom");
                                                String vcategorie = res.getString("nom_categorie");
                                                String vmarque = res.getString("p.marque");
                                                String vfournisseur = res.getString("nom_fournisseur");
                                                String description = res.getString("p.description");
                                                Double prixAchat = res.getDouble("p.prix_achat");
                                                Double prixVente = res.getDouble("p.prix_vente");
                                                int quantite = res.getInt("p.quantite");
                                                String codeBarre = res.getString("p.code_barre");       
                                    %>
                                    <tr>
                                        <td ><%= vid %></td>
                                        <td class="py-1"><img src="Images/<%= vimage %>"></td>
                                        <td><%= vnom %></td>
                                        <td><%= vcategorie %></td>
                                        <td><%= vmarque %></td>
                                        <td><%= vfournisseur %></td>
                                        <td><%= description %></td>
                                        <td><%= prixAchat %></td>
                                        <td><%= prixVente %></td>
                                        <td><%= quantite %></td>
                                        <td><%= codeBarre %></td>
                                        <td>
                                            <a href="ModifierProduit.jsp?id=<%= vid %>">
                                                <button type="button" class="btn btn-outline-success btn-icon-text">
                                                    <i class="ti-file btn-icon-prepend"></i>Modifier
                                                </button>
                                            </a>
                                            <a href="#" onclick="confirmDelete(<%= vid %>)">
                                                <button type="button" class="btn btn-outline-danger btn-icon-text">
                                                    <i class="ti-trash btn-icon-prepend"></i>Supprimer
                                                </button>
                                            </a>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    } catch (Exception e) {
                                        out.print(e.getMessage());
                                    }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@ include file="include/footer.jsp" %>
    </div>
</div>

<%@ include file="include/js.jsp" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
  function confirmDelete(id) {
    swal({
      title: "Confirmation",
      text: "Êtes-vous sûr de vouloir supprimer ce produit ?",
      icon: "warning",
      buttons: ["Annuler", "Supprimer"],
      dangerMode: true,
    }).then((confirm) => {
      if (confirm) {
        window.location.href = "./SupprimerProduit?id=" + id;
      }
    });
  }
</script>

