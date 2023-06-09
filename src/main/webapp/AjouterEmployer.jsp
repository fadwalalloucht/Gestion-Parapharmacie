
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
                  <h1 class="card-title">Ajouter Un Employé</h1>
                  <p class="card-description">
                    Nouveau Employé
                  </p>
                  <form class="forms-sample" action="AjouterEmploye" method="Post" enctype="multipart/form-data">
                   <label for="exampleInputUsername1">Login</label>
                    <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text">@</span>
                      </div>
                      <input type="text" name ="login" class="form-control" placeholder="login" aria-label="Login">
                    </div>
                    <br>
                      <label for="exampleInputPassword1">Mot de passe</label>
                      <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="ti-lock"></i></span>
                      </div>
                      <input type="password" name= "Mt" class="form-control" id="exampleInputPassword1" placeholder="Password">
                    </div>
                    <br>
                    <div class="form-group">
                      <label for="exampleInputPassword1">Nom</label>
                      <input type="text" name="nom" class="form-control" id="exampleInputPassword1" placeholder="Nom">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputPassword1">Prenom</label>
                      <input type="text"  name="prenom" class="form-control" id="exampleInputPassword1" placeholder="Prenom">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputPassword1">CIN</label>
                      <input type="text" name="cin" class="form-control" id="exampleInputPassword1" placeholder="CIN">
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
                      <input type="number" name ="telephone" class="form-control" id="exampleInputPassword1" placeholder="Telephone">
                    </div>
                    <br>
                     <label for="exampleInputPassword1">Email</label>
                    <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="ti-email"></i></span>
                      </div>
                      <input type="Email" name= "email" class="form-control" id="exampleInputPassword1" placeholder="Email">
                    </div>
                    <br>
                    <div class="form-group">
                    <label for="exampleFormControlSelect1">Role</label>
                    <select name="type"  class="form-control form-control-lg" id="exampleFormControlSelect1">
                      <option>Admin</option>
                      <option>Employé</option>
                    </select>
                  </div>
                      <label for="exampleInputPassword1">Salaire</label>
                      <div class="input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text">DH</span>
                      </div>
                      <input type="number" name="salaire" class="form-control" id="exampleInputPassword1" placeholder="Salire">
                      <span class="input-group-text">.00</span>
                    </div>
                     <br>
                     <div class="form-group">
                      <label for="exampleInputConfirmPassword1">Image</label>
                      <input type="file" name="photo" class="form-control" id="exampleInputConfirmPassword1" placeholder="">
                    </div>
                    


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
  

