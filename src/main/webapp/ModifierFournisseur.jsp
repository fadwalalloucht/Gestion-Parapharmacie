<%@ page import="java.sql.*" %>
<%@ include file="include/css.jsp" %>
<%@ include file="include/header.jsp" %>
<!-- partial -->
<div class="container-fluid page-body-wrapper">
  <%@ include file="include/sidebar.jsp" %>
  <!-- partial -->
  <div class="main-panel">        
    <div class="content-wrapper">
      <div class="row" style="margin-right: -476px;margin-left: 348px;">
        <div class="col-md-6 grid-margin stretch-card">
          <div class="card">
            <div class="card-body">
              <h1 class="card-title">Modifier Un Fournisseur</h1>
              <p class="card-description">
              <%
                String idParam = request.getParameter("id");
                if (idParam == null || idParam.isEmpty()) {
                    out.print("L'ID du fournisseur est invalide.");
                    return;
                }
                int idFournisseur = Integer.parseInt(idParam);
                String driver = "com.mysql.jdbc.Driver";
                String url = "jdbc:mysql://localhost:3306/db_parapharmacie";
                String username = "root";
                String password = "";

                try {
                    Class.forName(driver);
                    Connection conn = DriverManager.getConnection(url, username, password);
                    String sql = "SELECT * FROM fournisseurs WHERE id=?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, idFournisseur);
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        String vnom = rs.getString("nom");
                        String vadresse = rs.getString("adresse");
                        String vtelephone = rs.getString("telephone");
                        String vemail = rs.getString("email");
              %>
              Modifier Fournisseur N°<%= idFournisseur %>
              </p>
              <form class="forms-sample" action="ModifierFournisseur" method="post">
                <div class="form-group">
                  <label for="exampleInputUsername1">Nom</label>
                  <input type="text" class="form-control" id="exampleInputUsername1" placeholder="Nom" name="nom" value="<%= vnom %>">
                </div>
                <label for="exampleInputPassword1">Adresse</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="ti-home"></i></span>
                  </div>
                  <input type="text" class="form-control" id="exampleInputPassword1" placeholder="Adresse" name="adresse" value="<%= vadresse %>">
                </div>
                <br>
                <label for="exampleInputPassword1">Téléphone</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="ti-mobile"></i></span>
                  </div>
                  <input type="number" class="form-control" id="exampleInputPassword1" placeholder="Telephone" name="telephone" value="<%= vtelephone %>">
                </div>
                <br>
                <label for="exampleInputPassword1">Email</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="ti-email"></i></span>
                  </div>
                  <input type="email" class="form-control" id="exampleInputPassword1" placeholder="Email" name="email" value="<%= vemail %>">
                </div>
                <br>
                <input type="hidden" name="id" value="<%= idFournisseur %>">
                <button type="submit" class="btn btn-success">Modifier</button>
                <input value="Annuler" class="btn btn-danger" onclick="location.href ='ListeFournisseur.jsp'" style="width: 15%; padding: 1.5%;">
                
              </form>
              <%
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("Une erreur s'est produite : " + e.getMessage());
                }
              %>
            </div>
          </div>
        </div>
      </div>
      <%@ include file="include/footer.jsp" %>
    </div>
  </div>
</div>
<%@ include file="include/js.jsp" %>

