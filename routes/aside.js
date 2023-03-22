document.addEventListener("DOMContentLoaded", () => {
    const $routes = document.querySelectorAll(".aside-routes .route");
    $routes.forEach((route) => {
        route.addEventListener("click", (e) => {
            e.preventDefault();
            document.querySelector(".aside-routes .route.active").classList.remove("active");
            route.classList.add("active");
      
            fetch(`http://localhost/grano_de_oro/view/modulos/${route.dataset.route}.php`)
                .then(rs => rs.text())
                .then(html => {
                    document.querySelector(".content-wrapper").innerHTML = html;
                    if(route.dataset.route == "tablero"){return};
                    fetch(`http://localhost/grano_de_oro/view/layout/datatable.php?tabla=${route.dataset.route}`)
                        .then(res => res.text())
                        .then(html => {
                            document.querySelector('.card-body').innerHTML = html;

                            const $tabla = [];
                            if (route.dataset.route == "vendedores") {
                                $tabla.push({ data: "id" });
                                $tabla.push({ data: "codigo_vendedor" });
                                $tabla.push({ data: "vendedor" });
                                $tabla.push({ data: "estado" });
                            }
                           else if(route.dataset.route =="clientes"){
                                $tabla.push({ data: "id" });
                                $tabla.push({ data: "cliente" });
                                $tabla.push({ data: "ruc_dni" });
                                $tabla.push({ data: "direccion" });
                                $tabla.push({ data: "sector" });
                                $tabla.push({ data: "mercado" });
                                $tabla.push({ data: "giro" });
                                $tabla.push({ data: "distrito" });
                                $tabla.push({ data: "tipo_cliente" });
                                $tabla.push({ data: "telefono" });
                                $tabla.push({ data: "updated" });
                           }
                            else if(route.dataset.route =="proveedores"){
                                $tabla.push({ data: "id" });
                                $tabla.push({ data: "proveedor" });
                                $tabla.push({ data: "ruc_dni" });
                                $tabla.push({ data: "direccion" });
                                $tabla.push({ data: "telefono" });
                                $tabla.push({ data: "updated" });
                            }
                            else if(route.dataset.route =="usuarios"){
                                $tabla.push({ data: "id" });
                                $tabla.push({ data: "usuario" });
                                $tabla.push({ data: "nombre" });
                                $tabla.push({ data: "apellido" });
                                $tabla.push({ data: "cargo" });
                                $tabla.push({ data: "activo" });
                                $tabla.push({ data: "updated" });
                            }
                            else if(route.dataset.route =="categorias"){
                                $tabla.push({ data: "id" });
                                $tabla.push({ data: "categoria" });
                                $tabla.push({ data: "updated" });
                            }
                            else if(route.dataset.route =="productos"){
                                $tabla.push({ data: "id" });
                                $tabla.push({ data: "abreviaturas" });
                                $tabla.push({ data: "tipo_producto" });
                                $tabla.push({ data: "marca" });
                                $tabla.push({ data: "grupo" });
                                $tabla.push({ data: "nombre_corto" });
                                $tabla.push({ data: "abreviaturas2" });
                                $tabla.push({ data: "abreviaturas_producto" });
                            }
                            else if(route.dataset.route =="ventas"){
                                $tabla.push({ data: "fecha" });
                                $tabla.push({ data: "boleta_factura" });
                                $tabla.push({ data: "t_pago" });
                                $tabla.push({ data: "nro_boleta_factura" });
                                $tabla.push({ data: "total_venta" });
                                $tabla.push({ data: "vendedor" });
                                $tabla.push({ data: "cliente" });
                                $tabla.push({ data: "estado" });    
                            }
                            else if(route.dataset.route =="compras"){
                                $tabla.push({ data: "fecha" });
                                $tabla.push({ data: "boleta_factura" });
                                $tabla.push({ data: "t_pago" });
                                $tabla.push({ data: "nro_boleta_factura" });
                                $tabla.push({ data: "total_compra" });
                                $tabla.push({ data: "proveedor" });
                                $tabla.push({ data: "estado" });    
                            }
                            else if(route.dataset.route =="reporte_inventario"){
                                $tabla.push({ data: "codigo_producto" });
                                $tabla.push({ data: "nombre_producto" });
                                $tabla.push({ data: "stock" });
                                $tabla.push({ data: "stock_minimo" });
                                $tabla.push({ data: "stock_maximo" });
                                $tabla.push({ data: "costo" });
                                $tabla.push({ data: "total" });
                            }
                            else if(route.dataset.route =="reporte_ventas"){
                                $tabla.push({ data: "fecha" });
                                $tabla.push({ data: "nro_boleta_factura" });
                                $tabla.push({ data: "producto" });
                                $tabla.push({ data: "cantidad_caja" });
                                $tabla.push({ data: "unid" });
                                $tabla.push({ data: "precio" });
                                $tabla.push({ data: "total" });
                            }
                            else if(route.dataset.route =="reporte_compras"){
                                $tabla.push({ data: "fecha" });
                                $tabla.push({ data: "nro_boleta_factura" });
                                $tabla.push({ data: "producto" });
                                $tabla.push({ data: "cantidad_caja" });
                                $tabla.push({ data: "unid" });
                                $tabla.push({ data: "costo" });
                                $tabla.push({ data: "total" });
                            }
                            else if(route.dataset.route =="reporte_utilidades"){
                                $tabla.push({ data: "fecha" });
                                $tabla.push({ data: "nro_boleta_factura" });
                                $tabla.push({ data: "cliente" });
                                $tabla.push({ data: "total_costo" });
                                $tabla.push({ data: "total_venta" });
                                $tabla.push({ data: "total_utilidad" });
                            }
                            if(route.dataset.route!=="kardex"){
                                datatable = $("#dataTable").DataTable({
                                    ajax: {
                                        "url": `http://localhost/grano_de_oro/api.php/view_${route.dataset.route}`,
                                        "dataSrc": '',
                                        "cache":true
                                    },
                                    columns: $tabla,
                                    dom: '<"d-flex justify-content-between flex-wrap"Bf>t<"bottom d-flex justify-content-between flex-wrap"lip>',
                                    order: [[0, "desc"]],
                                    responsive: true,
                                    lengthChange: false,
                                    autoWidth: false,
                                    buttons: ["copy", "csv", "excel", "pdf", "print", "colvis","pageLength"],
                                    "pageLength": 20,
                                    lengthMenu: [
                                        [ 10, 25, 50, -1 ],
                                        [ '10 rows', '25 rows', '50 rows', 'Show all' ]
                                    ],
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
                            }
                           
                        })
                })
        });
    });
    document.addEventListener("submit",e=>{
        if(e.target.id=="formKardex"){
            e.preventDefault();
            $("#dataTable").DataTable().destroy();
            let idProducto = $("input[name='idProducto']").val();

            datatable = $("#dataTable").DataTable({
                ajax: {
                    "url": `http://localhost/grano_de_oro/procedure.php/sp_kardex/${idProducto}`,
                    "dataSrc": '',
                    "cache": true
                },
                columns: [
                    {data:"codigo"},
                    {data:"fecha"},
                    {data:"detalle"},
                    {data:"entrada_cantidad"},
                    {data:"entrada_costo_unit"},
                    {data:"entrada_costo_final"},
                    {data:"salida_cantidad"},
                    {data:"salida_costo_unit"},
                    {data:"salida_costo_final"},
                    {data:"saldos_cant"},
                    {data:"saldos_pu"},
                    {data:"saldos_pt"}
            ],
                dom: '<"d-flex justify-content-between flex-wrap"Bf>t<"bottom d-flex justify-content-between flex-wrap"lip>',
                order: [
                    [0, "desc"]
                ],
                responsive: true,
                lengthChange: false,
                autoWidth: false,
                buttons: ["copy", "csv", "excel", "pdf", "print", "colvis", "pageLength"],
                "pageLength": 20,
                lengthMenu: [
                    [10, 25, 50, -1],
                    ['10 rows', '25 rows', '50 rows', 'Show all']
                ],
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
        }
    })
});