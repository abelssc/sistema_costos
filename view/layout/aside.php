<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="inicio" class="brand-link">
        <img src="view/assets/dist/img/AdminLTELogo.png" alt="Grano de Oro Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
        <span class="brand-text font-weight-light">Grano de Oro</span>
    </a>
    <!-- Sidebar -->
    <div class="sidebar">
        <!-- Sidebar user (optional) -->
        <div class="user-panel mt-3 pb-3 mb-3 d-flex">
            <div class="info">
                <a href="#" class="d-block">%NOMBRE USER%</a>
                <a href="#" class="d-block">%ROL USER%</a>
            </div>
        </div>

        <!-- SidebarSearch Form -->
        <div class="form-inline">
            <div class="input-group" data-widget="sidebar-search">
                <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
                <div class="input-group-append">
                    <button class="btn btn-sidebar">
                        <i class="fas fa-search fa-fw"></i>
                    </button>
                </div>
            </div>
        </div>
        <!-- NAV -->
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column  aside-routes" data-widget="treeview" role="menu" data-accordion="false">
                <li class="nav-item">
                    <a href="./" class="nav-link route active" data-route="tablero">
                        <i class="nav-icon fa fa-chart-bar"></i>
                        <p>
                            Tablero
                        </p>
                    </a>
                </li>

                <li class="nav-item">
                    <a href="categorias" class="nav-link route" data-route="categorias">
                        <i class="nav-icon fa fa-tag"></i>
                        <p>
                            Categorías
                        </p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="productos" class="nav-link route" data-route="productos">
                        <i class="nav-icon fa fa-box-open"></i>
                        <p>
                            Productos
                        </p>
                    </a>
                </li>
                <!-- contactos -->
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fa fa-users"></i>
                        <p>
                            Contactos
                            <i class="fas fa-angle-left right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="clientes" class="nav-link route" data-route="clientes">
                                <i class="nav-icon fa fa-user"></i>
                                <p>
                                    Clientes
                                </p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="proveedores" class="nav-link route" data-route="proveedores">
                                <i class="nav-icon fa fa-truck"></i>
                                <p>
                                    Proveedores
                                </p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="usuarios" class="nav-link route" data-route="usuarios">
                                <i class="nav-icon fa fa-user-cog"></i>
                                <p>
                                    Usuarios
                                </p>
                            </a>
                        </li>
                    </ul>
                </li>
                <!-- reportes -->
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fa fa-chart-line"></i>
                        <p>
                            Reportes
                            <i class="fas fa-angle-left right"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <li class="nav-item">
                            <a href="reporte_ventas" class="nav-link route" data-route="reporte_ventas">
                                <i class="nav-icon fa fa-chart-line"></i>
                                <p>
                                    Reporte de Ventas
                                </p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="reporte_compras" class="nav-link route" data-route="reporte_compras">
                                <i class="nav-icon fa fa-chart-line"></i>
                                <p>
                                    Reporte de Compras
                                </p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="reporte_inventario" class="nav-link route" data-route="reporte_inventario">
                                <i class="nav-icon fa fa-chart-line"></i>
                                <p>
                                    Reporte de Inventario
                                </p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="reporte_utilidades" class="nav-link route" data-route="reporte_utilidades">
                                <i class="nav-icon fa fa-chart-line"></i>
                                <p>
                                    Reporte de Utilidades
                                </p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="kardex" class="nav-link route" data-route="kardex">
                                <i class="nav-icon fa fa-chart-line"></i>
                                <p>
                                    Kardex
                                </p>
                            </a>
                        </li>
                    </ul>
                </li>

                <li class="nav-item">
                    <a href="gastos" class="nav-link route" data-route="gastos">
                        <i class="nav-icon fa fa-money-check-alt"></i>
                        <p>
                            Gastos
                        </p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="caja" class="nav-link route" data-route="caja">
                        <i class="nav-icon fa fa-cash-register"></i>
                        <p>
                            Caja
                        </p>
                    </a>
                </li>

            </ul>
        </nav>
    </div>
</aside>
<!-- SCRIPT -->
<script src="<?= ROUTES_URL ?>aside.js"></script>