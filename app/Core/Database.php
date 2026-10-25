<?php
declare(strict_types=1);

namespace DailyScroll\Core;

use PDO;
use PDOException;
use PDOStatement;

/**
 * Pembungkus koneksi PDO (Singleton).
 */
final class Database
{
    private static ?Database $instance = null;
    private PDO $pdo;

    private function __construct(array $config)
    {
        try {
            $this->pdo = new PDO(
                "mysql:host={$config['host']};dbname={$config['name']};charset={$config['charset']}",
                $config['user'],
                $config['pass'],
                [
                    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                    PDO::ATTR_EMULATE_PREPARES   => false,
                ]
            );
        } catch (PDOException $e) {
            exit('Koneksi database gagal. Periksa config.php dan pastikan MySQL menyala. Detail: '
                . htmlspecialchars($e->getMessage(), ENT_QUOTES, 'UTF-8'));
        }
    }

    public static function getInstance(): self
    {
        if (self::$instance === null) {
            $config = require BASE_PATH . '/config.php';
            self::$instance = new self($config['db']);
        }
        return self::$instance;
    }

    public function query(string $sql, array $params = []): PDOStatement
    {
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt;
    }

    public function lastInsertId(): int
    {
        return (int)$this->pdo->lastInsertId();
    }
}
