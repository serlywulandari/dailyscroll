<?php
declare(strict_types=1);

namespace DailyScroll\Models;

/**
 * Daftar status bacaan beserta label dan warna lencana.
 */
final class ManhwaStatus
{
    public const READING   = 'Reading';
    public const COMPLETED = 'Completed';
    public const PLAN      = 'Plan to Read';

    public static function all(): array
    {
        return [self::READING, self::COMPLETED, self::PLAN];
    }

    public static function isValid(string $status): bool
    {
        return in_array($status, self::all(), true);
    }

    public static function label(string $status): string
    {
        switch ($status) {
            case self::READING:   return 'Sedang dibaca';
            case self::COMPLETED: return 'Selesai dibaca';
            case self::PLAN:      return 'Ingin dibaca';
            default:              return $status;
        }
    }

    public static function badgeClass(string $status): string
    {
        switch ($status) {
            case self::READING:   return 'bg-emerald-100 text-emerald-800';
            case self::COMPLETED: return 'bg-violet-100 text-violet-800';
            default:              return 'bg-amber-100 text-amber-800';
        }
    }
}
