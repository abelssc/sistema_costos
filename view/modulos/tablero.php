<!-- Content Header (Page header) -->
<div class="content-header">
    <div class="container-fluid">
        <div class="row mb-2">
            <div class="col-sm-6">
                <h1 class="m-0">Tablero</h1>
            </div><!-- /.col -->
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item active">Starter Page</li>
                </ol>
            </div><!-- /.col -->
        </div><!-- /.row -->
    </div><!-- /.container-fluid -->
</div>
<!-- /.content-header -->

<!-- Main content -->
<div class="content">
    <div class="content-fluid">
        <div class="row">
            <div class="col">
                <h1>ESTADO DE RESULTADOS</h1>
                <form action="" id="formEstadoResultados" class="d-flex flex-gap-5 align-items-center">
                    <div class="mr-4">
                        <label class="mb-0" for="fecha_inicial">Fecha Inicial</label>
                        <input type="date" name="fecha_inicio" id="fecha_inicial">
                    </div>
                    <div class="mr-4">
                        <label class="mb-0" for="fecha_final">Fecha Final</label>
                        <input type="date" name="fecha_fin" id="fecha_final">
                    </div>
                    <button class="btn btn-success">Buscar</button>
                </form>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h2>Utilidad bruta</h2>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Concepto</th>
                                    <th>Importe</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Ingresos</td>
                                    <td id="ingresos_totales">0.00</td>
                                </tr>
                                <tr>
                                    <td >Costo de ventas</td>
                                    <td id="costos_totales">0.00</td>
                                </tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th>Utilidad bruta</th>
                                    <th id="utilidad_bruta">0.00</th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h2>Utilidad operativa</h2>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Concepto</th>
                                    <th>Importe</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Gastos de operación</td>
                                    <td>0.00</td>
                                </tr>
                                <tr>
                                    <td>Utilidad bruta</td>
                                    <td>0.00</td>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th>Utilidad operativa</th>
                                    <th>0.00</th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h2>Utilidad antes de impuestos</h2>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Concepto</th>
                                    <th>Importe</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Gastos de operación</td>
                                    <td>0.00</td>
                                </tr>
                                <tr>
                                    <td>Utilidad operativa</td>
                                    <td>0.00</td>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th>Utilidad antes de impuestos</th>
                                    <th>0.00</th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h2>Utilidad neta</h2>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Concepto</th>
                                    <th>Importe</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>IGV</td>
                                    <td>0.00</td>
                                </tr>
                                <tr>
                                    <td>Utilidad antes de impuestos</td>
                                    <td>0.00</td>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th>Utilidad neta</th>
                                    <th>0.00</th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
    </div>
</div>
<!-- /.content -->