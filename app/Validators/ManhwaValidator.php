<?php
declare(strict_types=1);

namespace DailyScroll\Validators;

use DailyScroll\Models\ManhwaStatus;
use DailyScroll\Repositories\FolderRepository;

/**
 * Validasi + normalisasi input form manhwa.
 * Setelah validate(): errors() untuk pesan, formData() untuk isi ulang form, dbData() untuk disimpan.
 */
final class ManhwaValidator
{
    private array $errors = [];
    private array $form = [];
    private array $db = [];

    public function __construct(private FolderRepository $folders)
    {
    }

    public function validate(array $in): bool
    {
        $this->errors = [];

        $title     = $this->str($in, 'title');
        $alt       = $this->str($in, 'alternative_title');
        $synopsis  = $this->str($in, 'synopsis');
        $genre     = $this->str($in, 'genre');
        $author    = $this->str($in, 'author');
        $cover     = $this->str($in, 'cover_url');
        $notes     = $this->str($in, 'personal_notes');
        $folderRaw = $this->str($in, 'folder_id');
        $status    = $this->str($in, 'status') ?: ManhwaStatus::PLAN;
        $current   = $this->str($in, 'current_chapter');
        $total     = $this->str($in, 'total_chapters');
        $rating    = $this->str($in, 'rating');

        if ($title === '') {
            $this->errors[] = 'Judul wajib diisi.';
        } elseif (mb_strlen($title) > 255) {
            $this->errors[] = 'Judul maksimal 255 karakter.';
        }
        if (!ManhwaStatus::isValid($status)) {
            $this->errors[] = 'Status tidak valid.';
        }
        if (!ctype_digit($current)) {
            $this->errors[] = 'Chapter saat ini harus berupa angka 0 atau lebih.';
        }
        if ($total !== '' && !ctype_digit($total)) {
            $this->errors[] = 'Total chapter harus berupa angka 0 atau lebih.';
        }
        if ($rating !== '' && (!is_numeric($rating) || (float)$rating < 1 || (float)$rating > 10)) {
            $this->errors[] = 'Rating harus antara 1 sampai 10.';
        }
        if ($total !== '' && ctype_digit($total) && ctype_digit($current) && (int)$current > (int)$total) {
            $this->errors[] = 'Chapter saat ini tidak boleh melebihi total chapter.';
        }
        if ($cover !== '' && !preg_match('#^https?://#i', $cover)) {
            $this->errors[] = 'URL cover harus diawali http:// atau https://.';
        }

        $folderId = null;
        if ($folderRaw !== '') {
            if (!ctype_digit($folderRaw) || !$this->folders->exists((int)$folderRaw)) {
                $this->errors[] = 'Folder yang dipilih tidak ditemukan.';
            } else {
                $folderId = (int)$folderRaw;
            }
        }

        $this->form = [
            'folder_id' => $folderRaw, 'title' => $title, 'alternative_title' => $alt, 'synopsis' => $synopsis,
            'genre' => $genre, 'author' => $author, 'status' => $status, 'current_chapter' => $current,
            'total_chapters' => $total, 'rating' => $rating, 'cover_url' => $cover, 'personal_notes' => $notes,
        ];

        $this->db = [
            'folder_id'         => $folderId,
            'title'             => $title,
            'alternative_title' => $alt !== '' ? $alt : null,
            'synopsis'          => $synopsis !== '' ? $synopsis : null,
            'genre'             => $genre !== '' ? $genre : null,
            'author'            => $author !== '' ? $author : null,
            'status'            => $status,
            'current_chapter'   => ctype_digit($current) ? (int)$current : 0,
            'total_chapters'    => ($total !== '' && ctype_digit($total)) ? (int)$total : null,
            'rating'            => ($rating !== '' && is_numeric($rating)) ? (float)$rating : null,
            'cover_url'         => $cover !== '' ? $cover : null,
            'personal_notes'    => $notes !== '' ? $notes : null,
        ];

        return $this->errors === [];
    }

    public function errors(): array { return $this->errors; }
    public function formData(): array { return $this->form; }
    public function dbData(): array { return $this->db; }

    private function str(array $in, string $key): string
    {
        return isset($in[$key]) && is_string($in[$key]) ? trim($in[$key]) : '';
    }
}
