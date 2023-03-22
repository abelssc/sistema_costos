<?php
require MODELS_PATH . "get.php";

class GetController
{
    public $table;
    public $model;

    public $sentence_filter="";
    public $sentence_order="";
    public $sentence_page="";
    public $sentence_embed="";
    public $joins=[];
    public $page;
    public $limit=10;

    function __construct($table)
    {
        $this->table = $table;
        $this->model = new GetModel($this->table);
    }
    /*--===============================================
    FUNCIONES PARA CREAR LAS SENTENCIAS SQL
    =================================================*/
    public function filter_include($filters)
    {
        $key=$filters["key"];
        $values=$filters["array_values"];
        $sentence="";
        foreach ($values as $value) {
            $sentence.= "$key = '$value' or ";
        }
        $sentence=rtrim($sentence," or ");
        $this->sentence_filter .= "$sentence and ";
        
    }
    public function filter_exclude($filters)
    {
        $key=$filters["key"];
        $values=$filters["array_values"];
        foreach ($values as $value) {
            $this->sentence_filter .= "$key <> '$value' and ";
        }
    }

    public function filter_like($filters)
    {
        $key=$filters["key"];
        $values=$filters["array_values"];
        foreach ($values as $value) {
            $this->sentence_filter .= "$key LIKE '%$value%' and ";
        }
    }
    public function filter_gte($filters){
        $key=$filters["key"];
        $values=$filters["array_values"];
        foreach ($values as $value) {
            $this->sentence_filter .= "$key >= $value and ";
        }
    }
    public function filter_lte($filters){
        $key=$filters["key"];
        $values=$filters["array_values"];
        foreach ($values as $value) {
            $this->sentence_filter .= "$key <= $value and ";
        }
    }
    public function order($order){
        $col=$order["col"];
        $sort=$order["sort"];
        $this->sentence_order .= "$col $sort , ";
    }
    public function setPage($page){
        $this->page=$page;
    }
    public function setLimit($limit){
        $this->limit=$limit;
    }
    public function getColumns($tabla){
        return $this->model->getColumns($tabla);
    }
    public function embed($tabla){
        $columns= $this->getColumns($tabla);
        $text="";
        foreach ($columns as $value) {
             $text.="'$value',$tabla.$value,";
        }
         $text=rtrim( $text,",");
         $text="JSON_OBJECT($text) AS '$tabla'";
         $this->sentence_embed.="$text,";
         $this->joins[]=$tabla;
    }
    /*--===============================================
    FUNCIONES PARA EL ENVIO DE LA DATA
    =================================================*/
    public function getAll()
    {
        return $this->model->getAll();
    }
    public function getOne($id)
    {
        return $this->model->getOne($id);
    }
    public function getData(){
        //RECORDAR:
        // EMPTY= SI TIENE VALOR Y NO ES CERO
        // ISSET= SI ESTA DECLARADA Y NO ES NULL
        //LLENAMOS DATA
        if(!empty($this->sentence_filter)){
            $this->sentence_filter="WHERE $this->sentence_filter";
            $this->sentence_filter=rtrim($this->sentence_filter," and ");
        }
        if(!empty($this->sentence_order)){
            $this->sentence_order="ORDER BY $this->sentence_order";
            $this->sentence_order=rtrim($this->sentence_order," , ");
        }
        if(isset($this->page)){
            $page=$this->page*$this->limit;
            $this->sentence_page="LIMIT $page,$this->limit";
        }
        if(!empty($this->sentence_embed)){
            $this->sentence_embed=rtrim($this->sentence_embed,",");
            $this->sentence_embed="$this->sentence_embed FROM $this->table";
            foreach ($this->joins as $key => $value) {
                if($key==0) continue;
                $this->sentence_embed.=" INNER JOIN $value ON ".$this->joins[$key-1].".id=$value.".$this->joins[$key-1]."_id";
            }
        }
 
        //EJECUTAMOS
        return $this->model->getData($this->sentence_embed,$this->sentence_filter,$this->sentence_order,$this->sentence_page);
    } 
    public function getProcedure($id){
        return $this->model->getProcedure("CALL $this->table($id)");
    }  

 
}
