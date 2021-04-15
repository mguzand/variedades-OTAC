<?php 

$db = Database::connect();
require_once 'models/Auth.php';

$Auth = new Auth();
$No_Pantalla=10;
$Accion="Ingreso";
$Descripción="Ingreso a consultar bitácora";
$_SESSION['menu'] = $_GET['objeto'];
$Auth->InsertarBitacora($_SESSION['menu'],$Accion,$Descripción);

    if(!isset($_SESSION['admin'])){
        header("location:" . base_url);
	}
     require 'shared/header.php';
     require_once 'models/Admin.php'?>

	<title>Registro de bitácora</title>

	
			<div class="full-box page-header">
				<h3 class="text-left">
					<i class="fas fa-clipboard-list fa-fw"></i> &nbsp; Lista de bitácora
				</h3>
			</div>
			
	<a href='reporteBitacora' class="btn btn-danger btn_new_cliente"><i class="fa fa-file-pdf-o"></i> Reporte</a>
			
			<!-- Content -->
			<div class="container-fluid">
				<div class="table-responsive">
					<table class="table table-dark table-sm">
						<thead>
							<tr class="text-center roboto-medium">
								<th></th>
								<th>#</th>
								<th>FECHA</th>
								<th>NOMBRE</th>
								<th>PANTALLA</th>
								<th>ACCIÓN</th>
								<th>DESCRIPCIÓN</th>
							</tr>
						</thead>
						<tbody>
                        <?php
                        
                            $admin = new Admin();
                             $result=$admin->ListarBitacora();
                            foreach($result as $r){ ?>
							<tr class="text-center" >
								<td></td>
								<th><?= $r['id_bitacora'] ?></th>
								<th><?= $r['fecha_creacion'] ?></th>
								<th><?= $r['usuario'] ?></th>
								<th><?= $r['objeto'] ?></th>
								<th><?= $r['accion'] ?></th>
								<th><?= $r['descripcion'] ?></th>
								<td>
							
									<!-- <form action="">
										<button type="button" class="btn btn-warning">
		  									<i class="far fa-trash-alt"></i>
										</button>
									</form> -->
								</td>
							</tr>
                            <?php  }?>
						</tbody>
					</table>
				</div>
				<!-- <nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
						<li class="page-item disabled">
							<a class="page-link" href="#" tabindex="-1">Previous</a>
						</li>
						<li class="page-item"><a class="page-link" href="#">1</a></li>
						<li class="page-item"><a class="page-link" href="#">2</a></li>
						<li class="page-item"><a class="page-link" href="#">3</a></li>
						<li class="page-item">
							<a class="page-link" href="#">Next</a>
						</li>
					</ul>
				</nav> -->
			</div>

		</section>
	</main>
	
	
<?php require 'shared/footer.php'; ?>
<script type="text/javascript" src="scripts/concepto.js"></script>



