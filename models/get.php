<?php
require CONFIG_PATH."conexion.php";
class GetModel{
    public $table;
    public $dbh;

    public function __construct($table)
    {
        $this->table = $table;
        $this->dbh = Conexion::getConexion();
    }

    public  function getAll()
    {
        $stmt = $this->dbh->prepare("SELECT * FROM $this->table");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);

    }
    public  function getOne($id)
    {
        $stmt = $this->dbh->prepare("SELECT * FROM $this->table WHERE id='$id'");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);

    }
   
    public function getData($sentence_embed,$sentence_filter,$sentence_order,$sentence_page){
        return $sentence_embed;
        if($sentence_embed!==""){
            $stmt=$this->dbh->prepare("SELECT $sentence_embed $sentence_filter $sentence_order $sentence_page");
        }else{
            $stmt=$this->dbh->prepare("SELECT * FROM $this->table $sentence_filter $sentence_order $sentence_page");
        }
        $stmt->execute();
        $data= $stmt->fetchAll(PDO::FETCH_ASSOC);
        if($sentence_embed!==""){
            $data = array_map(function($item) {
                return array_map('json_decode', $item);
            }, $data);
        }
        return $data;
    }
    public function getColumns($tabla){
        // return "DESCRIBE '$this->table'";
        $stmt=$this->dbh->prepare("DESCRIBE $tabla");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_COLUMN,0);
        
    }
    public function getProcedure($procedure){
        $stmt=$this->dbh->prepare("$procedure");
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }
}
