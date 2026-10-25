<?php
declare(strict_types=1);

namespace DailyScroll\Core;

final class Response
{
    public static function redirect(string $url): void
    {
        header('Location: ' . $url);
        exit;
    }

    public static function abort(int $code, string $message): void
    {
        http_response_code($code);
        exit(htmlspecialchars($message, ENT_QUOTES, 'UTF-8'));
    }
}
