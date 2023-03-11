$(document).ready(function() {
    console.log("hiiiii");
    alert("hola");
    
    document.querySelector("tbody").innerHTML="HOLAAAA";
    const $column=JSON.parse('<?= $json_columnas ?>');
    console.log($column);
    $('#dataTable').DataTable({
        ajax: {
            "url": "http://localhost/grano_de_oro/JSON.json",
            "dataSrc": ''
        },
        columns:  $column,
        dom: '<"d-flex justify-content-between flex-wrap"Bf>t<"bottom d-flex justify-content-between flex-wrap"lip>',
        order: [
            [0, "desc"]
        ],
        responsive: true,
        lengthChange: true,
        autoWidth: false,
        buttons: ["copy", "csv", "excel", "pdf", "print", "colvis"],
        language: {
            "decimal": "",
            "emptyTable": "No hay información",
            "info": "Mostrando _START_ a _END_ de _TOTAL_ Entradas",
            "infoEmpty": "Mostrando 0 to 0 of 0 Entradas",
            "infoFiltered": "(Filtrado de _MAX_ total entradas)",
            "infoPostFix": "",
            "thousands": ",",
            "lengthMenu": "Mostrar _MENU_ Entradas",
            "loadingRecords": "Cargando...",
            "processing": "Procesando...",
            "search": "Buscar:",
            "zeroRecords": "Sin resultados encontrados",
            "paginate": {
                "first": "Primero",
                "last": "Ultimo",
                "next": "->",
                "previous": "<-"
            }
        }
    });
});