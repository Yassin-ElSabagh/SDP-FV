<?php
// config/Database.php

class Database {
    private static $instance = null;
    private $connection;

    private function __construct()
    {
        $dsn  = 'mysql:host=127.0.0.1;port=3306;dbname=basmah;charset=utf8mb4';
        $user = 'basmah_app';
        $pass = 'Demouser2801';
        try {
            $this->connection = new PDO($dsn, $user, $pass, [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            ]);
        } catch (PDOException $e) {
            exit('Connection failed: ' . $e->getMessage());
        }
    }


    public static function getInstance() {
        if (self::$instance == null) {
            self::$instance = new Database();
        }
        return self::$instance;
    }

    public function getConnection() {
        return $this->connection;
    }
}
?>
