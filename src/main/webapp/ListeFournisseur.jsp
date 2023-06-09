 <%@include file="include/css.jsp" %>
  <%@include file ="include/header.jsp" %>
  <%@page import="java.sql.*" %>
 <div class="container-fluid page-body-wrapper">
 <%@include file="include/sidebar.jsp" %>
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
                         <th>
                            ID
                          </th>
                          <th>
                            NOM
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
                            OPERATION
                          </th>
                        </tr>
                      </thead>
                      <tbody>
                       <%
 String driver ="com.mysql.jdbc.Driver";
		String con ="jdbc:mysql://localhost:3306/db_parapharmacie";
		String req="select * from fournisseurs";
		try {
			Class.forName(driver);
			Connection conn = DriverManager.getConnection(con,"root","");
			PreparedStatement st =conn.prepareStatement(req);
			
			
			
			ResultSet res = st.executeQuery();
			
			while(res.next()) {
				int vid =res.getInt(1);
				String vnom = res.getString("nom");
				String vadresse =res.getString("adresse");
				String vtelephone= res.getString("telephone");
				String vemail =res.getString("email");
				%>
				<tr>
				<td><%=vid%></td>
				<td><%=vnom%></td>
				<td><%=vadresse%></td>
				<td><%=vtelephone%></td>
				<td><%=vemail%></td>
                          <td>
                          <a href="ModifierFournisseur.jsp?id=<%=vid%>"><button type="button" class="btn btn-outline-success btn-icon-text">
                          <i class="ti-file btn-icon-prepend"></i>Modifier</button></a>                                                    
                          
                         <a href="#" onclick="confirmDelete(<%=vid%>)">
                         <button type="button" class="btn btn-outline-danger btn-icon-text">
                          <i class="ti-trash btn-icon-prepend"></i>                                                    
                          Supprimer
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
      text: "Êtes-vous sûr de vouloir supprimer ce fournisseur ?",
      icon: "warning",
      buttons: ["Annuler", "Supprimer"],
      dangerMode: true,
    }).then((confirm) => {
      if (confirm) {
        window.location.href = "./SupprimerFournisseur?id=" + id;
      }
    });
  }
</script>
           