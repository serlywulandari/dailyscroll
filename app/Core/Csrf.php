<?php
declare(strict_types=1);

namespace DailyScroll\Core;

/**
 * Perlindungan CSRF untuk semua form POST.
 */
final class Csrf
{
    public static function token(): string
    {
        if (empty($_SESSION['csrf_token'])) {
            $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
        }
        return $_SESSION['csrf_token'];
    }

    public static function field(): string
    {
        return '<input type="hidden" name="csrf_token" value="' . self::token() . '">';
    }

    public static function verify(): void
    {
        $sent = $_POST['csrf_token'] ?? '';
        if (!is_string($sent) || !hash_equals(self::token(), $sent)) {
            Response::abort(403, 'Permintaan tidak valid. Muat ulang halaman lalu coba lagi.');
        }
    }
}
