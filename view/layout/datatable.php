<?php
include_once "../../config/dirs.php";
$columnasTabla = [];
if ($tabla == "usuarios") {
    $columnasTabla = ["id", "nombre", "usuario", "perfil", "estado", "foto"];
} else if ($tabla == "categorias") {
    $columnasTabla = ["id", "categoria", "descripcion", "estado"];
} else if ($tabla == "productos") {
    $columnasTabla = ["id", "imagen", "codigo", "descripcion", "stock", "precio_compra", "precio_venta", "fecha", "categoria", "estado"];
} else if ($tabla == "clientes") {
    $columnasTabla = ["id", "nombre", "documento", "email", "telefono", "direccion", "fecha_nacimiento", "estado"];
}
$columnas_js = array();
foreach($columnasTabla as $columna){
    $columnas_js[]=array("data"=>$columna);
}
$json_columnas=json_encode($columnas_js);
?>
<table id="dataTable" class="table table-hover">
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
