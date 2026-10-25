<?php
declare(strict_types=1);

namespace DailyScroll\Models;

/**
 * Entitas folder koleksi.
 */
final class Folder
{
    public function __construct(
        private int $id,
        private string $name,
        private ?string $description,
        private int $manhwaCount = 0
    ) {
    }

    public static function fromRow(array $r): self
    {
        return new self(
            (int)$r['id'],
            (string)$r['name'],
            $r['description'] ?? null,
            (int)($r['manhwa_count'] ?? 0)
        );
    }

    public function id(): int { return $this->id; }
    public function name(): string { return $this->name; }
    public function description(): ?string { return $this->description; }
    public function manhwaCount(): int { return $this->manhwaCount; }
}
