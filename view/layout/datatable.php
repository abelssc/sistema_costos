<?php

$columnasTabla = [];
if ($_GET["tabla"] == "vendedores") {
    $columnasTabla = ["id", "Codigo Vendedor", "Vendedor", "Estado"];
} 
else if ($_GET["tabla"] == "clientes") {
    $columnasTabla = ["id", "Cliente", "RUC/DNI", "Direccion","Sector", "Mercado", "Giro", "Distrito", "Tipo de Cliente","Telefono","Updated"];
}  
else if ($_GET["tabla"] == "proveedores") {
    $columnasTabla = ["id", "Proveedor", "RUC/DNI", "Direccion", "Telefono","Updated"];
}
else if ($_GET["tabla"] == "usuarios") {
    $columnasTabla = ["id", "Usuario", "Nombre", "Apellido", "Cargo","Activo","Updated"];
}

else if ($_GET["tabla"] == "categorias") {
    $columnasTabla = ["id", "Categoria", "Updated"];
} 
else if ($_GET["tabla"] == "productos") {
    $columnasTabla = ["id", "abreviaturas","Tipo de Producto","Marca","Grupo","Nombre Corto","Abreviaturas2","Abreviaturas Producto"];
} 
 
else if ($_GET["tabla"] == "ventas") {
    $columnasTabla = ["Fecha","Boleta/Factura","T/Pago","Nro. de Boleta/Factura","Total Venta","Vendedor","Cliente","Estado"];
}
else if ($_GET["tabla"] == "compras") {
    $columnasTabla = ["Fecha","Boleta/Factura","T/Pago","Nro. de Boleta/Factura","Total Compra","Proveedor","Estado"];
}

else if($_GET["reporte_inventario"]){
    $columnasTabla=["Código Producto","Nombre Producto","Stock","Stock Mínimo","Stock Máximo","Costo","Total"];
}
else if($_GET["reporte_ventas"]){
    $columnasTabla=["Fecha","Nro. de Boleta/Factura","Producto","Cantidad Caja","Unid","Precio","Total"];
}
else if($_GET["reporte_compras"]){
    $columnasTabla=["Fecha","Nro. de Boleta/Factura","Producto","Cantidad Caja","Unid","Costo","Total"];
}
else if($_GET["reporte_utilidades"]){
    $columnasTabla=["Fecha","Nro. de Boleta/Factura","Cliente","Total Costo","Total Venta","Total Utilidad"];
}
// else if($_GET["kardex"]){
//     $columnasTabla=["Fecha","Detalle",""];
// }


$columnas_js = array();
foreach($columnasTabla as $columna){
    $columnas_js[]=array("data"=>$columna);
}
$json_columnas=json_encode($columnas_js);
?>
<table id="dataTable" class="table table-sm table-hover">
    <thead>
        <tr>
            <?php foreach ($columnasTabla as $value) : ?>
                <th><?= $value ?></th>
            <?php endforeach; ?>
        </tr>
    </thead>
    <tbody>
        <!-- LLENADO DE LA TABLA -->
    </tbody>
</table>
<!-- SCRIPT -->
