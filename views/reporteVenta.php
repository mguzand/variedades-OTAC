<?php
	include 'views/plantillaVenta.php';
	require 'conexion.php';
	
	$query = "SELECT * FROM tbl_ventas ";
	$resultado = $mysqli->query($query);
	
	$pdf = new PDF();
	$pdf->AliasNbPages();
	$pdf->AddPage();
	
	$pdf->SetFillColor(232,232,232);
	$pdf->SetFont('Arial','B',6);
	$pdf->Cell(10,6,'ID',1,0,'C',1);
	$pdf->Cell(41,6,'FECHA',1,0,'C',1);
	$pdf->Cell(35,6,'CANTIDAD',1,0,'C',1);
	$pdf->Cell(35,6,'ISV',1,0,'C',1);
	$pdf->Cell(35,6,'DESCUENTO',1,0,'C',1);
	$pdf->Cell(35,6,'TOTAL',1,0,'C',1);
	

	$pdf->Ln(6);
	$pdf->SetFont('Arial','',6);
	
	while($row = $resultado->fetch_assoc())
	{
		$pdf->SetFillColor(255,255,255);
		$pdf->Cell(10,6,$row['id_venta'],1,0,'C',1);
		$pdf->Cell(41,6,utf8_decode($row['fecha_venta']),1,0,'C',1);
		$pdf->Cell(35,6,utf8_decode($row['cantidad_venta']),1,0,'C',1);
		$pdf->Cell(35,6,utf8_decode($row['isv']),1,0,'C',1);
		$pdf->Cell(35,6,utf8_decode($row['descuento']),1,0,'C',1);
		$pdf->Cell(35,6,utf8_decode($row['total_venta']),1,0,'C',1);
		
		$pdf->Ln(6);
	}
	$pdf->Output();
?>