<?php
declare(strict_types=1);

define('BASE_PATH', dirname(__DIR__));

// Autoloader sederhana (PSR-4): DailyScroll\Core\View -> app/Core/View.php
spl_autoload_register(static function (string $class): void {
    $prefix = 'DailyScroll\\';
    if (strncmp($class, $prefix, strlen($prefix)) !== 0) {
        return;
    }
    $file = BASE_PATH . '/app/' . str_replace('\\', '/', substr($class, strlen($prefix))) . '.php';
    if (is_file($file)) {
        require $file;
    }
});

\DailyScroll\Core\Session::start();
