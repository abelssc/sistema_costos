document.addEventListener("DOMContentLoaded", () => {
    const $routes = document.querySelectorAll(".aside-routes .route");
    $routes.forEach((route) => {
        route.addEventListener("click", (e) => {
            e.preventDefault();
            fetch(`http://localhost/grano_de_oro/view/modulos/${route.dataset.route}.php`)
                .then(rs => rs.text())
                .then(html => {
                    document.querySelector(".content-wrapper").innerHTML = html;

                    // fetch(`http://localhost/grano_de_oro/view/layout/datatable.php?tabla=${route.dataset.route}`)
                    //     .then(res => res.text())
                    //     .then(html => {
                    //         document.querySelector('.card-body').innerHTML = html;

                    //         const $tabla=[];
                    //         if(route.dataset.route=="usuarios"){
                    //             $tabla.push({data:"id"});
                    //             $tabla.push({data:"nombre"});
                    //             $tabla.push({data:"usuario"});
                    //             $tabla.push({data:"perfil"});
                    //             $tabla.push({data:"estado"});
                    //             $tabla.push({data:"foto"});
                    //         }else if(route.dataset.route=="categorias"){
                    //             $tabla.push({data:"id"});
                    //             $tabla.push({data:"categoria"});
                    //             $tabla.push({data:"descripcion"});
                    //             $tabla.push({data:"estado"});
                    //         }else if(route.dataset.route=="productos"){
                    //             $tabla.push({data:"id"});
                    //             $tabla.push({data:"imagen"});
                    //             $tabla.push({data:"codigo"});
                    //             $tabla.push({data:"descripcion"});
                    //             $tabla.push({data:"stock"});
                    //             $tabla.push({data:"precio_compra"});
                    //             $tabla.push({data:"precio_venta"});
                    //             $tabla.push({data:"estado"});
                    //         }
                    //         else if(route.dataset.route=="clientes"){
                    //             $tabla.push({data:"id"});
                    //             $tabla.push({data:"nombre"});
                    //             $tabla.push({data:"documento"});
                    //             $tabla.push({data:"email"});
                    //             $tabla.push({data:"telefono"});
                    //             $tabla.push({data:"direccion"});
                    //             $tabla.push({data:"fecha_nacimiento"});
                    //             $tabla.push({data:"estado"});
                    //         }
                    //         datatable=$("#dataTable").DataTable({
                    //             ajax:{
                    //               "url":"http://localhost/grano_de_oro/JSON.json",
                    //               "dataSrc":''
                    //             },
                    //             columns:$tabla,
                    //             dom: '<"d-flex justify-content-between flex-wrap"Bf>t<"bottom d-flex justify-content-between flex-wrap"lip>',
                    //             order: [[0,"desc"]],
                    //             responsive:true, 
                    //             lengthChange:true,
                    //             autoWidth:false,
                    //             buttons: ["copy", "csv", "excel", "pdf", "print", "colvis"],
                    //             language:{
                    //             "decimal": "",
                    //             "emptyTable": "No hay información",
                    //             "info": "Mostrando _START_ a _END_ de _TOTAL_ Entradas",
                    //             "infoEmpty": "Mostrando 0 to 0 of 0 Entradas",
                    //             "infoFiltered": "(Filtrado de _MAX_ total entradas)",
                    //             "infoPostFix": "",
                    //             "thousands": ",",
                    //             "lengthMenu": "Mostrar _MENU_ Entradas",
                    //             "loadingRecords": "Cargando...",
                    //             "processing": "Procesando...",
                    //             "search": "Buscar:",
                    //             "zeroRecords": "Sin resultados encontrados",
                    //             "paginate": {
                    //             "first": "Primero",
                    //             "last": "Ultimo",
                    //             "next": "->",
                    //             "previous": "<-"}
                    //             }
                    //           });
                    //     })
                })
        });
    });
});