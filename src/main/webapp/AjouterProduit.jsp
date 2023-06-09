<%@include file="include/css.jsp" %>
<%@include file="include/header.jsp" %>
<%@page import="java.sql.*" %>
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
                            <h1 class="card-title">Ajouter produit</h1>

                            <form class="forms-sample" action="AjouterProduit" method="post" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label for="exampleInputUsername1">Nom de produit</label>
                                    <input type="text" name="nomp" class="form-control" id="exampleInputUsername1"
                                        placeholder="Entrer le nom du produit">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputUsername1">Marque</label>
                                    <input type="text" name="marque" class="form-control" id="exampleInputUsername1"
                                        placeholder="Entrer la marque du produit">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Description</label>
                                    <input type="text" name="description" class="form-control" id="exampleInputUsername1"
                                        placeholder="Entrer la description">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">Prix d'achat</label>
                                    <input type="text" name="prixa" class="form-control" id="exampleInputPassword1"
                                        placeholder="Entrer le prix d'achat">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputConfirmPassword1">Prix de vente</label>
                                    <input type="text" name="prixv" class="form-control" id="exampleInputPassword1"
                                        placeholder="Entrer le prix de vente">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputConfirmPassword1">Quantité</label>
                                    <input type="text" name="qnt" class="form-control" id="exampleInputPassword1"
                                        placeholder="Entrer la quantité">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputConfirmPassword1">Code barre</label>
                                    <input type="text" name="codeB" class="form-control" id="exampleInputPassword1"
                                        placeholder="Entrer le code barre ">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputConfirmPassword1">Image</label>
                                    <input type="file" class="form-control" name="photo"
                                        id="exampleInputConfirmPassword1" placeholder="">
                                </div>

                                <% 
                                String driver = "com.mysql.jdbc.Driver";
                                String con = "jdbc:mysql://localhost:3306/db_parapharmacie";
                                String req1 = "SELECT * FROM fournisseurs";
                                String req2 = "SELECT * FROM categories";
                                Connection conn = null;
                                try {
                                    Class.forName(driver);
                                    conn = DriverManager.getConnection(con, "root", "");
                                    Statement st1 = conn.createStatement();
                                    Statement st2 = conn.createStatement();
                                    ResultSet res = st1.executeQuery(req1);
                                    %>
                                    <div class="form-group">
                                        <label for="exampleFormControlSelect1">Fournisseur</label>
                                        <select name="typeF" class="form-control form-control-lg"
                                            id="exampleFormControlSelect1">
                                            <% while (res.next()) { %>
                                            <option><%= res.getString("nom") %></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <% res.close();
                                    
                                    res = st2.executeQuery(req2);
                                    %>
                                    <div class="form-group">
                                        <label for="exampleFormControlSelect1">Catégorie</label>
                                        <select name="typeC" class="form-control form-control-lg"
                                            id="exampleFormControlSelect1">
                                            <% while (res.next()) { %>
                                            <option><%= res.getString("libelle") %></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <% 
                                    res.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    try {
                                        if (conn != null)
                                            conn.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                %>

                                <button type="submit" class="btn btn-success">Ajouter</button>
                                <button type="reset" class="btn btn-danger">Initialiser</button>

                            </form>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <%@include file="include/footer.jsp" %>
    </div>
</div>
<%@ include file="include/js.jsp" %>

