<?php
	error_reporting(E_ALL);
ini_set('display_errors', '1');



	header('Access-Control-Allow-Origin: *');
	header('Content-type: application/json');
	date_default_timezone_set("America/Tegucigalpa");

	include_once('../config/db.php');


	
	class api {
		
		function __construct() { 
			$this->db = Database::connect();

			if (isset($_POST['action'])) {
				if ($_POST['action']== "newCategory" ) {
					$this->newCategory();
				}
			}
		}


		public function newCategory(){
			 $name = $_POST['name'];
			 $q = "INSERT INTO `tbl_categoria`(`nombre_categoria`) VALUES ('$name')";
			 $stmt = $this->db->query($q);

			 if (!$stmt) {
			 	echo json_encode(array('ok' => false, 'err'=> $stmt ));
			 	return;
			 }

			 echo json_encode(array('ok' => true ));
		}



 

		  





	}

 $v = new api();
 





