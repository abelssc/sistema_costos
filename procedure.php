<?php
header("Access-Control-Allow-Origin: *");
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Allow-Methods: PUT, GET, POST, DELETE, OPTIONS');
header("Access-Control-Allow-Headers: X-Requested-With");
header('Content-Type: text/html; charset=utf-8');
header('P3P: CP="IDC DSP COR CURa ADMa OUR IND PHY ONL COM STA"');

require $_SERVER["DOCUMENT_ROOT"]."/grano_de_oro/config/dirs.php";
function obtenerDatosdelaURL(){
    ##Obtenemos la url /chatApp/chats/option
    $url_actual = parse_url($_SERVER["REQUEST_URI"]);
    
    ##Eliminamos las / al inicio y al final de la url
    $ruta = trim($url_actual["path"], '/');
    
    ##Obtenemos los fragmentos de la ruta
    $fragmentos_de_ruta = explode("/", $ruta);
    $tabla = $fragmentos_de_ruta[2];
    $id = $fragmentos_de_ruta[3] ?? null;
    
    ##obtenemos el metodo
    $method = $_SERVER["REQUEST_METHOD"];
    
    return array(
        "url"=>$url_actual,
        "tabla"=>$tabla,
        "id"=>$id,
        "method"=>$method
    );
    }
    $datosURL=obtenerDatosdelaURL();
    include(CONTROLLERS_PATH . $datosURL['method'] . '.php');
    if ($datosURL['method'] === "GET") {
        $class = new GetController($datosURL['tabla']);
        echo json_encode($class->getProcedure($datosURL['id']));
    }