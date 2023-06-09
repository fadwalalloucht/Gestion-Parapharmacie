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
                  <h1 class="card-title">Ajouter Un Annonce</h1>
                  <p class="card-description">
                    Nouveau Annonce
                  </p>
                  
                  <form class="forms-sample" action="Ajouterannonce" method="post"  enctype="multipart/form-data">
                    <div class="form-group">
                      <label for="exampleInputUsername1">Titre</label>
                      <input type="text" name="titre" class="form-control" id="exampleInputUsername1" placeholder="Entrer le titre">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputEmail1">Date</label>
                      <input type="date" name ="date" class="form-control" id="exampleInputEmail1" placeholder="">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputPassword1">Description</label>
                      <input type="text" name="description" class="form-control" id="exampleInputPassword1" placeholder="Entrer Description">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputConfirmPassword1">Image</label>
                      <input type="file" name="photo" class="form-control" id="exampleInputConfirmPassword1" placeholder="">
                    </div>

                    <button type="submit" class="btn btn-success">Ajouter</button>
                    <button type="reset" class="btn btn-danger">Initialiser</button>
                  </form>  
                </div>
              </div>
            </div>
        <%@include file="include/footer.jsp" %>
      </div>
    </div>
    </div>
  </div> 
 <%@ include file="include/js.jsp" %>
 
 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  

