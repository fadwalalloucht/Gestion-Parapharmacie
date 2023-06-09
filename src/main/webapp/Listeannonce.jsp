<%@include file="include/css.jsp" %>
<%@include file="include/header.jsp" %>
<div class="container-fluid page-body-wrapper">
  <%@include file="include/sidebar.jsp" %>
  <%@page import="java.sql.*" %>
  <div class="main-panel">
    <div class="content-wrapper">
      <div class="col-lg-12 grid-margin stretch-card">
        <div class="card">
          <div class="card-body">
            <h1 class="card-title">LES ANNONCES</h1>
            <div class="table-responsive">
              <table class="table table-striped">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>IMAGE</th>
                    <th>TITRE</th>
                    <th>DATE</th>
                    <th>DESCRIPTION</th>
                    <th>OPERATION</th>
                  </tr>
                </thead>
                <tbody>
                  <% 
                  String driver = "com.mysql.jdbc.Driver";
                  String con = "jdbc:mysql://localhost:3306/db_parapharmacie";
                  String req = "select * from annonces";
                  try {
                    Class.forName(driver);
                    Connection conn = DriverManager.getConnection(con, "root", "");
                    PreparedStatement st = conn.prepareStatement(req);
                    ResultSet res = st.executeQuery();

                    while (res.next()) {
                      int vid = res.getInt(1);
                      String vimage = res.getString("image");
                      String vtitre = res.getString("titre");
                      String vdate = res.getString("date");
                      String description = res.getString("description");
                  %>
                  <tr>
                    <td class="py-1"><%=vid%></td>
                    <td><img src="Images/<%=vimage%>"></td>
                    <td><%=vtitre%></td>
                    <td><%=vdate%></td>
                    <td><%=description%></td>
                    <td>
                      <a href="Modifierannonce.jsp?id=<%=vid%>">
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
  </div>
</div>
<%@include file="include/footer.jsp" %>
<%@include file="include/js.jsp" %>
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
        window.location.href = "./Supprimerannonce?id=" + id;
      }
    });
  }
</script>
