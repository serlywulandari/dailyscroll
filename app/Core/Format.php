<?php
declare(strict_types=1);

namespace DailyScroll\Core;

/**
 * Helper format tampilan.
 */
final class Format
{
    private const MONTHS = [
        1 => 'Jan', 2 => 'Feb', 3 => 'Mar', 4 => 'Apr', 5 => 'Mei', 6 => 'Jun',
        7 => 'Jul', 8 => 'Agu', 9 => 'Sep', 10 => 'Okt', 11 => 'Nov', 12 => 'Des',
    ];

    public static function date(string $timestamp): string
    {
        $time = strtotime($timestamp);
        if ($time === false) {
            return '-';
        }
        return date('j', $time) . ' ' . self::MONTHS[(int)date('n', $time)] . ' ' . date('Y', $time);
    }
}
