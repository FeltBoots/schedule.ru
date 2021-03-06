<?php
    require_once ("vendor/autoload.php");
    include ("includes/classes/database.php");
    include ("includes/classes/constants.php");
    ob_start();
    session_start();
    $session = '';
    if(isset($_SESSION['userLoggedIn'])) {
        $session = 'loggedIn';
    }
    else{
        $session = 'guest';
    }
    $dbname = 'fefu';
    $user = 'postgres';
    $password = 'root';

    $connection = pg_connect("host=localhost port=5432 dbname={$dbname} user={$user} password={$password}");
    $database = new database($connection);

    $loader = new \Twig\Loader\FilesystemLoader('style/templates');
    $twig = new \Twig\Environment($loader);

    //echo $twig->render('index', ['name' => 'Fabien']);
    