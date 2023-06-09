 <%@include file="include/css.jsp" %>
  <%@include file ="include/header.jsp" %>
 <div class="container-fluid page-body-wrapper">
 <%@include file="include/sidebar.jsp" %>
 <%@page import="java.sql.*" %>
 <div class="main-panel">        
        <div class="content-wrapper">
 <div class="col-lg-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <h1 class="card-title">LES EMPLOYES</h1>
                  <div class="table-responsive">
                    <table class="table table-striped">
                      <thead>
                        <tr>
                         <th>
                            ID
                          </th>
                          <th>
                            IMAGE
                          </th>
                          <th>
                            NOM
                          </th>
                          <th>
                           PRENOM
                          </th>
                          <th>
                            CIN
                          </th>
                           <th>
                            ADRESSE
                          </th>
                           <th>
                            TELEPHONE
                          </th>
                           <th>
                            EMAIL
                          </th>
                           <th>
                            ROLE
                          </th>
                            <th>
                            SALAIRE
                          </th>
                         
                          
                          <th>
                            OPERATION
                          </th>
                        </tr>
                      </thead>
                      <tbody>
                        <% 
                  String driver = "com.mysql.jdbc.Driver";
                  String con = "jdbc:mysql://localhost:3306/db_parapharmacie";
                  String req = "SELECT * FROM employes";
                  try {
                    Class.forName(driver);
                    Connection conn = DriverManager.getConnection(con, "root", "");
                    PreparedStatement st = conn.prepareStatement(req);
                    ResultSet res = st.executeQuery();

                    while (res.next()) {
                      int vid = res.getInt(1);
                      String login = res.getString("login");
                      String nom = res.getString("nom");
                      String prenom = res.getString("prenom");
                      String cin = res.getString("cin");
                      String adresse = res.getString("adresse");
                      String telephone = res.getString("telephone");
                      String email = res.getString("email");
                      
                      String role = res.getString("role");
                      Double salaire = res.getDouble("salaire");
                      String image = res.getString("image");
                  %>
                  <tr>
                    <td ><%=vid%></td>
                    <td class="py-1"><img src="Images/<%=image%>"></td>
                    <td><%=nom%></td>
                    <td><%=prenom%></td>
                    <td><%=cin%></td>
                    <td><%=adresse%></td>
                    <td><%=telephone%></td>
                    <td><%=email%></td>
                    <td><%=role%></td>
                    <td><%=salaire%></td>
                    
                    <td>
                      <a href="ModifierEmploye.jsp?id=<%=vid%>">
                        <button type="button" class="btn btn-outline-success btn-icon-text">
                          <i class="ti-file btn-icon-prepend"></i>Modifier
                        </button>
                      </a>
                      <a href="#" onclick="confirmDelete(<%=vid%>)">
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
            <%@include file="include/footer.jsp" %>
           </div>
           </div>
           
           <%@ include file="include/js.jsp" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
  function confirmDelete(id) {
    swal({
      title: "Confirmation",
      text: "Êtes-vous sûr de vouloir supprimer cette annonce ?",
      icon: "warning",
      buttons: ["Annuler", "Supprimer"],
      dangerMode: true,
    }).then((confirm) => {
      if (confirm) {
        window.location.href = "./SupprimerEmploye?id=" + id;
      }
    });
  }
</script>
           