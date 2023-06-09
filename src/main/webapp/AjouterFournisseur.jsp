
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
                  <h1 class="card-title">Ajouter Un Fournisseur</h1>
                  <p class="card-description">
                    Nouveau Fournisseur
                  </p>
                  <form class="forms-sample" action="AjouterFournissur" method="post">
                    <div class="form-group">
                      <label for="exampleInputUsername1">Nom</label>
                      <input type="text" name ="nom" class="form-control" id="exampleInputUsername1" placeholder="Nom">
                    </div>
                   <label for="exampleInputPassword1">Adresse</label>
                       <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="ti-home"></i></span>
                      </div>
                      <input type="text" name="adresse" class="form-control" id="exampleInputPassword1" placeholder="Adresse">
                    </div>
                    <br>
                      <label for="exampleInputPassword1">Téléphone</label>
                      <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="ti-mobile"></i></span>
                      </div>
                      <input type="number" name="telephone" class="form-control" id="exampleInputPassword1" placeholder="Telephone">
                    </div>
                    <br>
                     <label for="exampleInputPassword1">Email</label>
                    <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="ti-email"></i></span>
                      </div>
                      <input type="Email" name="email" class="form-control" id="exampleInputPassword1" placeholder="Email">
                    </div>
                    <br>

                    <button type="submit" class="btn btn-success">Ajouter</button>
                    <button  type="reset" class="btn btn-danger">Initialiser</button>
                  </form>
                </div>
              </div>
            </div>
       
      </div>
       <%@include file="include/footer.jsp" %>
    </div>
    </div>
  </div> 
 <%@ include file="include/js.jsp" %>
  

