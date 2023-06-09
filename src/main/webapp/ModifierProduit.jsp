<%@include file="include/css.jsp" %>
<%@page import="java.sql.*" %>
<%@include file="include/header.jsp" %>
<%@ page import="java.nio.file.Paths" %>
<!-- partial -->
<div class="container-fluid page-body-wrapper">
    <%@include file="include/sidebar.jsp" %>
    <!-- partial -->
    <div class="main-panel">
        <div class="content-wrapper">
            <div class="row" style="margin-right: -476px;margin-left: 348px;">
                <div class="col-md-6 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                            <h1 class="card-title">Modifier Produit</h1>
                            <p class="card-description">
                                <%
                                String idParam = request.getParameter("id");
                                if (idParam == null || idParam.isEmpty()) {
                                    out.print("L'ID du produit est invalide.");
                                    return;
                                }
                                int idProduit = Integer.parseInt(idParam);
                                String driver = "com.mysql.jdbc.Driver";
                                String con = "jdbc:mysql://localhost:3306/db_parapharmacie";

                                try {
                                    Class.forName(driver);
                                    Connection conn = DriverManager.getConnection(con, "root", "");
                                    String req = "SELECT p.nom, p.marque, p.prix_achat, p.prix_vente, p.description, p.image, p.quantite, p.code_barre, c.libelle AS nom_categorie, f.nom AS nom_fournisseur FROM produits p"
                                            + " INNER JOIN categories c ON p.categorie = c.id"
                                            + " INNER JOIN fournisseurs f ON p.fournisseur = f.id WHERE p.id=?";
                                    PreparedStatement stmt = conn.prepareStatement(req);
                                    stmt.setInt(1, idProduit);
                                    ResultSet rs = stmt.executeQuery();

                                    if (rs.next()) {
                                        String vimage = rs.getString("p.image");
                                        String vnom = rs.getString("p.nom");
                                        String vcategorie = rs.getString("nom_categorie");
                                        String vmarque = rs.getString("p.marque");
                                        String vfournisseur = rs.getString("nom_fournisseur");
                                        String description = rs.getString("p.description");
                                        Double prixAchat = rs.getDouble("p.prix_achat");
                                        Double prixVente = rs.getDouble("p.prix_vente");
                                        int quantite = rs.getInt("p.quantite");
                                        String codeBarre = rs.getString("p.code_barre");
                                %>
                                Modifier Produit N° <%= idProduit %>
                                </p>
                               <form class="forms-sample" method="post" action="ModifierProduit?id=<%=idProduit %>" enctype="multipart/form-data">
                                   <div class="form-group">
                                        <label for="exampleInputUsername1">Nom de produit</label>
                                        <input type="text" name="nomp" class="form-control" value="<%= vnom %>">
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputUsername1">Marque</label>
                                        <input type="text" name="marque" class="form-control" id="exampleInputUsername1"
                                            placeholder="Entrer la marque du produit" value="<%= vmarque %>">
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Description</label>
                                        <input type="text" name="description" class="form-control"
                                            id="exampleInputUsername1" placeholder="Entrer la description"
                                            value="<%= description %>">
                                      </div>
                                    <div class="form-group">
                                        <label for="exampleInputPassword1">Prix d'achat</label>
                                        <input type="text" name="prixa" class="form-control"
                                            id="exampleInputPassword1" placeholder="Entrer le prix d'achat"
                                            value="<%= prixAchat %>">
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputConfirmPassword1">Prix de vente</label>
                                        <input type="text" name="prixv" class="form-control"
                                            value="<%= prixVente %>">
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputConfirmPassword1">Quantité</label>
                                        <input type="text" name="qnt" class="form-control" id="exampleInputPassword1"
                                            placeholder="Entrer la quantité" value="<%= quantite %>">
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputConfirmPassword1">Code barre</label>
                                        <input type="text" name="codeB" class="form-control" id="exampleInputPassword1"
                                            placeholder="Entrer le code barre" value="<%= codeBarre %>">
                                    </div>
                                    <div class="form-group">
                                  <label for="exampleInputConfirmPassword1">Image actuelle</label><br>
                                 <img src="Images/<%= vimage %>" alt="Image actuelle" style="max-width: 200px;"><br>
                                 <input type="hidden" name="imageActuelle" value="<%= vimage %>">
                                 </div>
                                    <div class="form-group">
                                <label for="exampleInputConfirmPassword1">Nouvelle image</label>
                                <input type="file" class="form-control"  name="nouvelleImage" placeholder="">
                                   </div>

                                    <%
                                    String req1 = "SELECT * FROM fournisseurs";
                                    String req2 = "SELECT * FROM categories";
                                    Connection conn1 = null;
                                    try {
                                        Class.forName(driver);
                                        conn1 = DriverManager.getConnection(con, "root", "");
                                        Statement st1 = conn1.createStatement();
                                        Statement st2 = conn1.createStatement();
                                        ResultSet res1 = st1.executeQuery(req1);
                                        ResultSet res2 = st2.executeQuery(req2);
                                    %>
                                    <div class="form-group">
                                        <label for="exampleFormControlSelect1">Fournisseur</label>
                                        <select name="typeF" class="form-control form-control-lg"
                                            id="exampleFormControlSelect1">
                                            <% while (res1.next()) { %>
                                            <option <%= vfournisseur.equals(res1.getString("nom")) ? "selected" : "" %>>
                                                <%= res1.getString("nom") %></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleFormControlSelect1">Catégorie</label>
                                        <select name="typeC" class="form-control form-control-lg"
                                            id="exampleFormControlSelect1">
                                            <% while (res2.next()) { %>
                                            <option <%= vcategorie.equals(res2.getString("libelle")) ? "selected" : "" %>>
                                                <%= res2.getString("libelle") %></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <%
                                    res1.close();
                                    res2.close();
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    } finally {
                                        try {
                                            if (conn1 != null)
                                                conn1.close();
                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        }
                                    }
                                    %>
                                    
                                    <button type="submit" class="btn btn-success">Modifier</button>
                                    <button type="reset" class="btn btn-danger">Initialiser</button>
                                </form>
                            <% } else {
                                out.print("Aucun produit trouvé avec l'ID spécifié.");
                            }
                            rs.close();
                            stmt.close();
                            conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } catch (ClassNotFoundException e) {
                            e.printStackTrace();
                        }
                    %>
                </div>
              </div>
            </div>
          </div>
        </div>
         <%@include file="include/footer.jsp" %>
      </div>
     
    </div>
<%@ include file="include/js.jsp" %>

                                            
                                   
