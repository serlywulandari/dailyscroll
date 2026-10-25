<?php
declare(strict_types=1);

namespace DailyScroll\Core;

/**
 * Akses aman ke $_GET dan $_POST.
 */
final class Request
{
    public function isPost(): bool
    {
        return ($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'POST';
    }

    public function query(string $key, string $default = ''): string
    {
        $value = $_GET[$key] ?? $default;
        return is_string($value) ? trim($value) : $default;
    }

    public function queryInt(string $key): ?int
    {
        return self::positiveInt($_GET[$key] ?? null);
    }

    public function post(string $key, string $default = ''): string
    {
        $value = $_POST[$key] ?? $default;
        return is_string($value) ? trim($value) : $default;
    }

    public function postInt(string $key): ?int
    {
        return self::positiveInt($_POST[$key] ?? null);
    }

    /** Seluruh isi $_POST (dipakai validator). */
    public function allPost(): array
    {
        return $_POST;
    }

    private static function positiveInt(mixed $value): ?int
    {
        if (is_string($value) && ctype_digit($value) && (int)$value > 0) {
            return (int)$value;
        }
        return null;
    }
}
