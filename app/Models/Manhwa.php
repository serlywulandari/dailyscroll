<?php
declare(strict_types=1);

namespace DailyScroll\Models;

/**
 * Entitas satu judul manhwa.
 */
final class Manhwa
{
    private const TONES = ['bg-[#f5d9db]', 'bg-[#e1f1e7]', 'bg-[#ffeed2]', 'bg-[#e8dedd]'];

    public function __construct(
        private int $id,
        private ?int $folderId,
        private ?string $folderName,
        private string $title,
        private ?string $alternativeTitle,
        private ?string $synopsis,
        private ?string $genre,
        private ?string $author,
        private string $status,
        private int $currentChapter,
        private ?int $totalChapters,
        private ?float $rating,
        private ?string $coverUrl,
        private ?string $personalNotes,
        private string $createdAt,
        private string $updatedAt
    ) {
    }

    public static function fromRow(array $r): self
    {
        return new self(
            (int)$r['id'],
            isset($r['folder_id']) ? (int)$r['folder_id'] : null,
            $r['folder_name'] ?? null,
            (string)$r['title'],
            $r['alternative_title'] ?? null,
            $r['synopsis'] ?? null,
            $r['genre'] ?? null,
            $r['author'] ?? null,
            (string)$r['status'],
            (int)$r['current_chapter'],
            isset($r['total_chapters']) ? (int)$r['total_chapters'] : null,
            isset($r['rating']) ? (float)$r['rating'] : null,
            $r['cover_url'] ?? null,
            $r['personal_notes'] ?? null,
            (string)$r['created_at'],
            (string)$r['updated_at']
        );
    }

    public function id(): int { return $this->id; }
    public function folderId(): ?int { return $this->folderId; }
    public function folderName(): string { return $this->folderName ?: 'Belum masuk folder'; }
    public function title(): string { return $this->title; }
    public function alternativeTitle(): ?string { return $this->alternativeTitle; }
    public function synopsis(): ?string { return $this->synopsis; }
    public function genre(): ?string { return $this->genre; }
    public function author(): ?string { return $this->author; }
    public function status(): string { return $this->status; }
    public function currentChapter(): int { return $this->currentChapter; }
    public function totalChapters(): ?int { return $this->totalChapters; }
    public function rating(): ?float { return $this->rating; }
    public function coverUrl(): ?string { return $this->coverUrl; }
    public function personalNotes(): ?string { return $this->personalNotes; }
    public function createdAt(): string { return $this->createdAt; }
    public function updatedAt(): string { return $this->updatedAt; }

    public function statusLabel(): string
    {
        return ManhwaStatus::label($this->status);
    }

    public function hasCover(): bool
    {
        return $this->coverUrl !== null && $this->coverUrl !== '';
    }

    public function ratingText(): ?string
    {
        return $this->rating !== null ? number_format($this->rating, 1) : null;
    }

    /** Persentase progres, atau null bila total chapter belum diketahui. */
    public function progressPercent(): ?int
    {
        if ($this->totalChapters === null || $this->totalChapters <= 0) {
            return null;
        }
        return min(100, (int)round($this->currentChapter / $this->totalChapters * 100));
    }

    /** Dianggap "baru" bila ditambahkan dalam beberapa hari terakhir. */
    public function isNew(int $days = 7): bool
    {
        $created = strtotime($this->createdAt);
        return $created !== false && $created >= time() - $days * 86400;
    }

    /** Warna latar pastel yang konsisten per judul. */
    public function tone(): string
    {
        return self::TONES[$this->id % count(self::TONES)];
    }

    public function toFormArray(): array
    {
        return [
            'folder_id'         => (string)($this->folderId ?? ''),
            'title'             => $this->title,
            'alternative_title' => (string)$this->alternativeTitle,
            'synopsis'          => (string)$this->synopsis,
            'genre'             => (string)$this->genre,
            'author'            => (string)$this->author,
            'status'            => $this->status,
            'current_chapter'   => (string)$this->currentChapter,
            'total_chapters'    => $this->totalChapters === null ? '' : (string)$this->totalChapters,
            'rating'            => $this->rating === null ? '' : (string)$this->rating,
            'cover_url'         => (string)$this->coverUrl,
            'personal_notes'    => (string)$this->personalNotes,
        ];
    }
}
