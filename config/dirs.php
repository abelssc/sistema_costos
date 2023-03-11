<?php
// Path: Config
define("SERVER_NAME","grano_de_oro");
define("SERVER_URL","http://localhost/".SERVER_NAME."/");
define("ROOT_PATH",$_SERVER["DOCUMENT_ROOT"]."/".SERVER_NAME."/");
define("CONFIG_PATH",ROOT_PATH."config/");

//RUTAS ABSOLUTAS ROOT_PATH USADO PARA INCLUIR ARCHIVOS
// Path: MVC
define("VIEW_PATH",ROOT_PATH."view/");
define("CONTROLLERS_PATH",ROOT_PATH."controllers/");
define("MODELS_PATH",ROOT_PATH."models/");
// Path: routes
define("ROUTES_PATH",ROOT_PATH."routes/");
// Path: layout - modulos - assets
define("LAYOUT_PATH",VIEW_PATH."layout/");
define("MODULOS_PATH",VIEW_PATH."modulos/");

//RUTAS RELATIVAS SERVER_URL USADO PARA ENLACES
// Path: VIEW
define("VIEW_URL",SERVER_URL."view/");
define("ASSETS_URL",SERVER_URL."view/assets/");

// Path routes
define("ROUTES_URL",SERVER_URL."routes/");


