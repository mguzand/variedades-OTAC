<?php 

$db = Database::connect();
require_once 'models/Auth.php';

$Auth = new Auth();
$No_Pantalla=26;
$Accion="Ingreso";
$Descripción="Ingreso de venta";
$_SESSION['menu'] = $_GET['objeto'];
$Auth->InsertarVenta($_SESSION['menu'],$Accion,$Descripción);

    if(!isset($_SESSION['admin'])){
        header("location:" . base_url);
	}
     require 'admin/shared/header.php';
     require_once 'models/Admin.php'?>


	
			<div class="full-box page-header">
				<h3 class="text-left">
					<i class="fas fa-clipboard-list fa-fw"></i> &nbsp; DATOS DEL CLIENTE
				</h3>
			</div>
		

<a href='VentasNew' class="btn btn-primary btn_new_cliente"><i class="fas fa-user-plus"></i> Nuevo Cliente</a>
<div class="container-fluid">
	<div class="col-lg-12">
		<div class="card">
            <div class="card-body">
              <form method="post" name="form_new_cliente_venta" id="form_new_cliente_venta">
              <input type="hidden" name="action" value="addCliente">
              <input type="hidden" id="id_cliente" value="1" name="id_cliente" required>
               <div class="row">
               <div class="col-lg-4">
                 <div class="form-group">
                    <label>Dni</label>
                     <input type="number" name="DNI" id="DNI" class="form-control">
                 </div>
               </div>
               <div class="col-lg-4">
                <div class="form-group">
                      <label>Nombre</label>
                      <input type="text" name="nombre_cliente" id="nombre_cliente" class="form-control" disabled required>
                </div>
               </div>
               <div class="col-lg-4">
                 <div class="form-group">
                      <label>Teléfono</label>
                      <input type="number" name="telfono_cliente" id="telfono_cliente" class="form-control" disabled required>
                 </div>
                 </div>
                <div class="col-lg-4">
                   <div class="form-group">
                      <label>Dirreción</label>
                      <input type="text" name="direccion_cliente" id="direccion_cliente" class="form-control" disabled required>
                        </div>

                        </div>
                        <div id="div_registro_cliente" style="display: none;">
                        <button type="submit" class="btn btn-primary">Guardar</button>
                       </div>
                	</div>
                </form>
            </div>
		</div>
	</div>
</div>


			<div class="full-box page-header">
				<h3 class="text-left">
					<i class="fas fa-clipboard-list fa-fw"></i> &nbsp; DATOS DE VENTA
				</h3>
			</div>

			<div class="row">
                   <div class="col-lg-6">
                     <div class="form-group">
                          
                     </div>
                   </div>
                 <div class="col-lg-6">
                      <label>Acciones</label>
                  <div id="acciones_venta" class="form-group">
                           <a href="#" class="btn btn-danger" id="btn_anular_venta">Anular</a>
                           <a href="#" class="btn btn-primary" id="btn_facturar_venta"><i class="fas fa-save"></i> Generar Venta</a>
                  </div>
                </div>
            </div>			

						<div class="table-responsive">
                                <table class="table table-hover">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th width="100px">Código</th>
                                            <th>Descripción</th>
                                            <th>Stock</th>
                                            <th width="100px">Cantidad</th>
                                            <th class="textright">Precio</th>
                                            <th class="textright">Precio Total</th>
                                            <th>Acciones</th>
                                        </tr>
                                        <tr>
                                            <td><input type="number" name="id_producto" id="id_producto"></td>
                                            <td id="nombre_producto">-</td>
                                            <td id="stock">-</td>
                                            <td><input type="text" name="stock" id="stock"value="0" min="1" disabled></td>
                                            <td id="precio_venta" class="textright">0.00</td>
                                            <td id="txt_precio_total" class="txtright">0.00</td>
                                            <td><a href="#" id="add_product_venta" class="btn btn-dark" style="display: none;">Agregar</a></td>
                                        </tr>
                                        <tr>
                                            <th>Código</th>
                                            <th colspan="2">Descripción</th>
                                            <th>Cantidad</th>
                                            <th class="textright">Precio</th>
                                            <th class="textright">Precio Total</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody id="detalle_venta">
                                        <!-- Contenido ajax -->
                                    </tbody>
                                    <tfoot id="detalle_totales">
                                         <!-- Contenido ajax -->
                                    </tfoot>
                                </table>
                            </div>


	<?php require 'admin/shared/footer.php'; ?>
<script type="text/javascript" src="scripts/concepto.js"></script>
