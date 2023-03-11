<!--==========================
MODAL AGREGAR
==========================-->
<div class="modal fade" id="modalAgregar">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <form role="form">

        <!-- Modal Header -->
        <div class="modal-header bg-primary text-white">
          <h4 class="modal-title">Agregar</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>

        <!-- Modal body -->
        <div class="modal-body">
          <div class="card-body">
            <div class="form-group">
              <div class="input-group">
                <span class="input-group-text"><i class="fa fa-user"></i></span>
                <input type="text" class="form-control input-lg" name="nombre" placeholder="Ingresar Nombre" required">
              </div>
            </div>
            <div class="form-group">
              <div class="input-group">
                  <span class="input-group-text"><i class="fa fa-key"></i></span>
                  <input type="text" class="form-control input-lg" name="usuario" placeholder="Ingresar Usuario" required pattern="^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ]+$">
              </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                  <span class="input-group-text"><i class="fa fa-lock"></i></span>
                  <input type="password" class="form-control input-lg" name="password" placeholder="Ingresar Contraseña" require>
              </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                  <span class="input-group-text"><i class="fa fa-users"></i></span>
                  <select name="rol" id="" class="form-control input lg" required>
                    <option value="" disabled selected>Seleccione Perfil</option>
                    <?php $roles=ModeloUsuarios::MdlMostrarRoles();?>
                    <?php while ($row=$roles->fetch_assoc()):?>
                      <option value="<?php echo $row["nombre_rol"]?>"><?php echo $row["nombre_rol"]?></option>
                    <?php endwhile ?>
                  </select>
              </div>
            </div>
            <div class="form-group">
              <div class="custom-file">
                <input type="file" class="custom-file-input file_foto_agregar" name="foto" accept="image/png,image/jpeg,image/webp" lang="es">
                <label class="custom-file-label" for="customFile">Elegir Foto</label>
                <input type="hidden" name="prevFoto">
              </div>
              <p class="text-muted">Peso Máximo de la foto 200mb</p>
              
              <img src="vista/dist/img/profile.png" class="img-thumbnail file_imagen_agregar agregar" width="100px">
            </div>   
          </div>
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Registrar Usuario</button>
          <button type="button" class="btn btn-default " data-dismiss="modal">Salir</button>
        
        </div>
      </form>
    </div>
  </div>
</div>
<!--==========================
MODAL EDITAR
==========================-->
<div class="modal fade" id="modalEditar">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <form role="form">
        <!-- Modal Header -->
        <div class="modal-header bg-primary text-white">
          <h4 class="modal-title">Editar </h4>
          <input type="hidden" name="editar">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>

        <!-- Modal body -->
        <div class="modal-body">
          <div class="card-body">
            <div class="form-group">
              <div class="input-group">
                <span class="input-group-text"><i class="fa fa-user"></i></span>
                <input type="text" class="form-control input-lg" name="nombre" placeholder="Editar Nombre" required>
              </div>
            </div>
            <div class="form-group">
              <div class="input-group">
                  <span class="input-group-text"><i class="fa fa-key"></i></span>
                  <input type="text" class="form-control input-lg" name="usuario" placeholder="Editar Usuario" required pattern="^[a-zA-Z0-9ñÑáéíóúÁÉÍÓÚ]+$"  readonly>
              </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                  <span class="input-group-text"><i class="fa fa-lock"></i></span>
                  <input type="password" class="form-control input-lg" name="password" placeholder="Editar Contraseña">
                  <input type="hidden" name="prevPassword">
                </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                  <span class="input-group-text"><i class="fa fa-users"></i></span>
                  <select name="rol" id="" class="form-control input lg" required>
                    <option value="" disabled selected>Seleccione Perfil</option>
                    <?php $roles=ModeloUsuarios::MdlMostrarRoles();?>
                    <?php while ($row=$roles->fetch_assoc()):?>
                      <option value="<?php echo $row["nombre_rol"]?>"><?php echo $row["nombre_rol"]?></option>
                    <?php endwhile ?>
                  </select>
              </div>
            </div>
            <div class="form-group">
              <div class="custom-control custom-switch custom-switch-off-danger custom-switch-on-success">
                <input type="checkbox" name="estado" class="custom-control-input" id="customSwitch3">
                <label class="custom-control-label" for="customSwitch3"></label>
              </div>
            </div>
            
            <div class="form-group">
              <div class="custom-file">
                <input type="file" class="custom-file-input file_foto_editar" name="foto" accept="image/png,image/jpeg,image/webp" lang="es">
                <label class="custom-file-label" for="customFile">Elegir Foto</label>
                <input type="hidden" name="prevFoto">
              </div>

              <p class="text-muted">Peso Máximo de la foto 200mb</p>

              <img src="vista/dist/img/avatar.png" class="img-thumbnail file_imagen_editar" width="100px">
            </div>    
          </div>
        </div>

        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="submit" class="btn btn-primary">Guardar Cambios</button>
          <button type="button" class="btn btn-default " data-dismiss="modal">Salir</button>
        
        </div>
      </form>
    </div>
  </div>
</div>