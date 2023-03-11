<?php
require 'config/dirs.php';
?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Grano de Oro</title>
  <link rel="icon" href="<?=ASSETS_URL?>dist/img/AdminLTELogo.png">

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="<?=ASSETS_URL?>plugins/fontawesome-free/css/all.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="<?=ASSETS_URL?>plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="<?=ASSETS_URL?>plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="<?=ASSETS_URL?>plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="<?=ASSETS_URL?>dist/css/adminlte.min.css">
</head>

<body class="hold-transition sidebar-mini">

  <div class="wrapper">
    <?php include LAYOUT_PATH . 'header.php' ?>
    <?php include LAYOUT_PATH . 'aside.php' ?>

    <div class="content-wrapper">
      <?php include LAYOUT_PATH . 'main.php' ?>
     
    </div>

    <?php include LAYOUT_PATH . 'footer.php' ?>
  </div>

  <!-- ./wrapper -->
  <!-- REQUIRED SCRIPTS -->
  <!-- jQuery -->
  <script defer src="<?=ASSETS_URL?>plugins/jquery/jquery.min.js"></script>
  <!-- Bootstrap 4 -->
  <script defer src="<?=ASSETS_URL?>plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
  <!-- DataTables  & Plugins -->
  <script defer src="<?=ASSETS_URL?>plugins/datatables/jquery.dataTables.min.js"></script>
  <script defer src="<?=ASSETS_URL?>plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
  <script defer src="<?=ASSETS_URL?>plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
  <script defer src="<?=ASSETS_URL?>plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
  <script defer src="<?=ASSETS_URL?>plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
  <script defer src="<?=ASSETS_URL?>plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
  <script defer src="<?=ASSETS_URL?>plugins/jszip/jszip.min.js"></script>
  <script defer src="<?=ASSETS_URL?>plugins/pdfmake/pdfmake.min.js"></script>
  <script defer src="<?=ASSETS_URL?>plugins/pdfmake/vfs_fonts.js"></script>
  <script defer src="<?=ASSETS_URL?>plugins/datatables-buttons/js/buttons.html5.min.js"></script>
  <script defer src="<?=ASSETS_URL?>plugins/datatables-buttons/js/buttons.print.min.js"></script>
  <script defer src="<?=ASSETS_URL?>plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
  <!-- AdminLTE App -->
  <script defer src="<?=ASSETS_URL?>dist/js/adminlte.min.js"></script>
</body>

</html>