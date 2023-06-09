<%@ page import="java.sql.*" %>
<%@include file ="include/css.jsp" %>
<%@include file ="include/header.jsp" %>
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
              <h1 class="card-title">Modifier Une Annonce</h1>
              <%
                String idParam = request.getParameter("id");
                if (idParam == null || idParam.isEmpty()) {
                    out.print("L'ID de l'annonce est invalide.");
                    return;
                }
                int idAnnonce = Integer.parseInt(idParam);
                String driver = "com.mysql.jdbc.Driver";
                String con = "jdbc:mysql://localhost:3306/db_parapharmacie";

                try {
                    Class.forName(driver);
                    Connection conn = DriverManager.getConnection(con, "root", "");
                    String req = "SELECT * FROM annonces WHERE id=?";
                    PreparedStatement stmt = conn.prepareStatement(req);
                    stmt.setInt(1, idAnnonce);
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        String titre = rs.getString("titre");
                        String date = rs.getString("date");
                        String description = rs.getString("description");
                        String image = rs.getString("image");
              %>
              <p class="card-description">
                Modifier Annonce N°<%=idAnnonce%>
              </p>
              <form class="forms-sample" method="post" action="Modifierannonce" enctype="multipart/form-data">
                <div class="form-group">
                  <label for="exampleInputUsername1">Titre</label>
                  <input type="text" class="form-control" id="exampleInputUsername1" name="titre" value="<%= titre %>" placeholder="Entrer le titre">
                </div>
                <div class="form-group">
                  <label for="exampleInputEmail1">Date</label>
                  <input type="date" class="form-control" id="exampleInputEmail1" name="date" value="<%= date %>" placeholder="">
                </div>
                <div class="form-group">
                  <label for="exampleInputPassword1">Description</label>
                  <input type="text" class="form-control" id="exampleInputPassword1" name="description" value="<%= description %>" placeholder="Entrer Description">
                </div>
                <div class="form-group">
                  <label for="exampleInputConfirmPassword1">Image actuelle</label><br>
                  <img src="Images/<%= image %>" alt="Image actuelle" style="max-width: 200px;"><br>
                  <input type="hidden" name="imageActuelle" value="<%= image %>">
                </div>
                <div class="form-group">
                  <label for="exampleInputConfirmPassword1">Nouvelle image</label>
                  <input type="file" class="form-control" id="exampleInputConfirmPassword1" name="nouvelleImage" placeholder="">
               </div>
               <input type="hidden" name="id" value="<%= idAnnonce %>">
            <button type="submit" class="btn btn-success">Modifier</button>
            <input value="Annuler" class="btn btn-danger" onclick="location.href ='Listeannonce.jsp'" style="width: 15%; padding: 1.5%;">
          </form>
          
          <%
                } else {
                    out.println("Annonce non trouvée");
                }

                rs.close();
                stmt.close();
                conn.close();
            } catch (ClassNotFoundException e) {
                out.print(e.getMessage());
            } catch (SQLException e) {
                out.print(e.getMessage());
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
<%@include file="include/js.jsp" %>
