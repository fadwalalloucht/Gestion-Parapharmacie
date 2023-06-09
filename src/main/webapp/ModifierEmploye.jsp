<%@ page import="java.sql.*,java.io.*" %>
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
              <h1 class="card-title">Modifier Un Employé</h1>
              <p class="card-description">
                <%
                  String idParam = request.getParameter("id");
                  if (idParam == null || idParam.isEmpty()) {
                    out.print("L'ID de l'annonce est invalide.");
                    return;
                  }
                  int idEmploye = Integer.parseInt(idParam);
                  String driver = "com.mysql.jdbc.Driver";
                  String con = "jdbc:mysql://localhost:3306/db_parapharmacie";

                  try {
                    Class.forName(driver);
                    Connection conn = DriverManager.getConnection(con, "root", "");
                    String req = "SELECT * FROM employes WHERE id=?";
                    PreparedStatement stmt = conn.prepareStatement(req);
                    stmt.setInt(1, idEmploye);
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                      String login = rs.getString("login");
                      String nom = rs.getString("nom");
                      String prenom = rs.getString("prenom");
                      String cin = rs.getString("cin");
                      String Mt = rs.getString("mot_passe");
                      String adresse = rs.getString("adresse");
                      String telephone = rs.getString("telephone");
                      String email = rs.getString("email");
                      String role = rs.getString("Role");
                      String salaire = rs.getString("salaire");
                      String image = rs.getString("image");
                %>
                Modifier Employé N°<%= idEmploye %>
              </p>
              <form class="forms-sample" method="post" action="ModifierEmploye" enctype="multipart/form-data">
                <label for="exampleInputUsername1">Login</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text">@</span>
                  </div>
                  <input type="text" class="form-control" name="login" placeholder="login" aria-label="Login" value="<%= login %>">
                </div>
                <br>
                <label for="exampleInputPassword1">Password</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="ti-lock"></i></span>
                  </div>
                  <input type="password" class="form-control" name="password" value="<%= Mt %>">
                </div>
                <br>
                <div class="form-group">
                  <label for="exampleInputPassword1">Nom</label>
                  <input type="text" class="form-control" name="nom"  value="<%= nom %>">
                </div>
                <div class="form-group">
                  <label for="exampleInputPassword1">Prenom</label>
                  <input type="text" class="form-control" name="prenom"  value="<%= prenom %>">
                </div>
                
                <div class="form-group">
                 <label for="exampleInputPassword1">CIN</label>
                  <input type="text" class="form-control" name="cin" value="<%= cin %>">
                </div>
                <label for="exampleInputPassword1">Adresse</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="ti-home"></i></span>
                  </div>
                  <input type="text" class="form-control" name="adresse" value="<%= adresse %>">
                </div>
                <br>
                <label for="exampleInputPassword1">Téléphone</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="ti-mobile"></i></span>
                  </div>
                  <input type="number" class="form-control" name="telephone" value="<%= telephone %>">
                </div>
                <br>
                <label for="exampleInputPassword1">Email</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="ti-email"></i></span>
                  </div>
                  <input type="email" class="form-control" name="email" value="<%= email %>">
                </div>
                <br>
                <div class="form-group">
                  <label for="exampleFormControlSelect1">Role</label>
                  <select class="form-control form-control-lg" name="role" id="exampleFormControlSelect1">
                    <option <%= role.equals("Admin") ? "selected" : "" %>>Admin</option>
                    <option <%= role.equals("Employé") ? "selected" : "" %>>Employé</option>
                  </select>
                </div>
                <label for="exampleInputPassword1">Salaire</label>
                <div class="input-group">
                  <div class="input-group-prepend">
                    <span class="input-group-text">DH</span>
                  </div>
                  <input type="number" class="form-control" name="salaire" value="<%=salaire %>">
                  <span class="input-group-text">.00</span>
                </div>
                <br>
                <div class="form-group">
                  <label for="exampleInputConfirmPassword1">Image actuelle</label><br>
                  <img src="Images/<%= image %>" alt="Image actuelle" style="max-width: 200px;"><br>
                  <input type="hidden" name="imageActuelle" value="<%= image %>">
                </div>
                <div class="form-group">
                  <label for="exampleInputConfirmPassword1">Nouvelle image</label>
                  <input type="file" class="form-control"  name="nouvelleImage" placeholder="">
               </div>
               <input type="hidden" name="id" value="<%= idEmploye %>">
            <button type="submit" class="btn btn-success">Modifier</button>
            <input value="Annuler" class="btn btn-danger" onclick="location.href ='ListeEmploye.jsp'" style="width: 15%; padding: 1.5%;">
              </form>
               <%
                } else {
                    out.println("Employe non trouvée");
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
  <%@ include file="include/footer.jsp" %>  
  </div>
</div>

<%@ include file="include/js.jsp" %>
