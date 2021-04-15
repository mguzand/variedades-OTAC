<?php
if(isset($_SESSION['admin']) == null){
	header("location:" . base_url);

	
	
}

$db = Database::connect();

?>

<?php require 'shared/header.php';?>
	<title>Lista usuarios</title>

	




	<div class="container-fluid">

	<!-- Page Heading -->
	<div class="d-sm-flex align-items-center justify-content-between mb-4">
		<h1 class="h3 mb-0 text-gray-800">Panel de Administración</h1>
	</div>

	<!-- Content Row -->
	<div class="row">

		<!-- Earnings (Monthly) Card Example -->
		<div class="row mt-3 ml-3 mr-3">
			<div class="col-lg-12">
			<div class="card">
				<div class="card-body">
				
									
				</div>
				<hr>
				<div class="alert alert-success col-md-4 ml-4">
					<p><b><large>Productos totales</large></b></p>
				<hr>
					<p class="text-right"><b><large>
					<?php 
					$produc = $db->query("SELECT COUNT(id_producto) as amount FROM tbl_productos ");
					echo $produc->num_rows > 0 ? number_format($produc->fetch_array()['amount'],2) : "0.00";

					 ?>
					 	



					 </large></b></p>
				</div>
			</div>
			
		</div>
		</div>

		<!-- Earnings (Monthly) Card Example -->
		<a class="col-xl-3 col-md-6 mb-4" href="lista_cliente.php">
			<div class="card border-left-success shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-success text-uppercase mb-1">Clientes</div>
							<div class="h5 mb-0 font-weight-bold text-gray-800">


							<?php 
							 $produc = $db->query("SELECT COUNT(id_cliente) as amount FROM tbl_clientes");
							 echo $produc->num_rows > 0 ? $produc->fetch_array()['amount']:0;

							 ?>
					 	



					 </div>
						</div>
						<div class="col-auto">
							<i class="fas fa-users fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>
			</div>
		</a>

		<!-- Earnings (Monthly) Card Example -->
		<a class="col-xl-3 col-md-6 mb-4" href="lista_productos.php">
			<div class="card border-left-info shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-info text-uppercase mb-1">Productos</div>
							<div class="row no-gutters align-items-center">
								<div class="col-auto">
									<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">


									<?php 
							 $produc = $db->query("SELECT COUNT(*) as amount FROM tbl_productos");
							 echo $produc->num_rows > 0 ? $produc->fetch_array()['amount']:0;

							 ?>
							 	


							 </div>
								</div>
								<div class="col">
									<div class="progress progress-sm mr-2">
										<div class="progress-bar bg-info" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>
			</div>
		</a>

		<!-- Pending Requests Card Example -->
		<a class="col-xl-3 col-md-6 mb-4" href="ventas.php">
			<div class="card border-left-warning shadow h-100 py-2">
				<div class="card-body">
					<div class="row no-gutters align-items-center">
						<div class="col mr-2">
							<div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Ventas</div>
							<div class="h5 mb-0 font-weight-bold text-gray-800">
								
								<?php 
							 $produc = $db->query("SELECT COUNT(*) as amount FROM tbl_ventas");
							 echo $produc->num_rows > 0 ? $produc->fetch_array()['amount']:0;

							 ?>


							</div>
						</div>
						<div class="col-auto">
							<i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
						</div>
					</div>
				</div>
			</div>
		</a>
	</div>
<?php require 'shared/footer.php'; ?>
<script type="text/javascript" src="scripts/concepto.js"></script>



