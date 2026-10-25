<?php
declare(strict_types=1);

namespace DailyScroll\Repositories;

use DailyScroll\Core\Database;
use DailyScroll\Models\Manhwa;
use DailyScroll\Models\ManhwaStatus;

/**
 * Semua query tabel `manhwa`.
 */
final class ManhwaRepository
{
    public const SORTS = [
        'updated'  => 'm.updated_at DESC, m.title ASC',
        'title'    => 'm.title ASC',
        'rating'   => 'm.rating DESC, m.title ASC',
        'progress' => 'm.current_chapter DESC, m.title ASC',
    ];

    private const BASE_SELECT = 'SELECT m.*, f.name AS folder_name FROM manhwa m LEFT JOIN folders f ON f.id = m.folder_id';

    public function __construct(private Database $db)
    {
    }

    public function find(int $id): ?Manhwa
    {
        $row = $this->db->query(self::BASE_SELECT . ' WHERE m.id = ?', [$id])->fetch();
        return $row ? Manhwa::fromRow($row) : null;
    }

    /**
     * @param array $filters q, status, folder_id, notes, sort
     * @return Manhwa[]
     */
    public function search(array $filters): array
    {
        $sql = self::BASE_SELECT . ' WHERE 1=1';
        $params = [];

        if (($filters['q'] ?? '') !== '') {
            $sql .= ' AND (m.title LIKE ? OR m.alternative_title LIKE ? OR m.author LIKE ? OR m.genre LIKE ?)';
            $like = '%' . $filters['q'] . '%';
            array_push($params, $like, $like, $like, $like);
        }
        if (ManhwaStatus::isValid((string)($filters['status'] ?? ''))) {
            $sql .= ' AND m.status = ?';
            $params[] = $filters['status'];
        }
        if (!empty($filters['folder_id'])) {
            $sql .= ' AND m.folder_id = ?';
            $params[] = (int)$filters['folder_id'];
        }
        if (!empty($filters['notes'])) {
            $sql .= " AND m.personal_notes IS NOT NULL AND m.personal_notes <> ''";
        }

        $sort = (string)($filters['sort'] ?? 'updated');
        $sql .= ' ORDER BY ' . (self::SORTS[$sort] ?? self::SORTS['updated']);

        return $this->mapAll($this->db->query($sql, $params)->fetchAll());
    }

    /** @return Manhwa[] */
    public function latest(int $limit, ?string $status = null): array
    {
        $sql = self::BASE_SELECT;
        $params = [];
        if ($status !== null) {
            $sql .= ' WHERE m.status = ?';
            $params[] = $status;
        }
        $sql .= ' ORDER BY m.updated_at DESC, m.id DESC LIMIT ' . (int)$limit;
        return $this->mapAll($this->db->query($sql, $params)->fetchAll());
    }

    /** @return array{total:int, Reading:int, Completed:int, 'Plan to Read':int} */
    public function countsByStatus(): array
    {
        $counts = ['total' => 0];
        foreach (ManhwaStatus::all() as $status) {
            $counts[$status] = 0;
        }
        foreach ($this->db->query('SELECT status, COUNT(*) AS c FROM manhwa GROUP BY status')->fetchAll() as $row) {
            $counts[$row['status']] = (int)$row['c'];
            $counts['total'] += (int)$row['c'];
        }
        return $counts;
    }

    public function create(array $d): int
    {
        $this->db->query(
            'INSERT INTO manhwa (folder_id, title, alternative_title, synopsis, genre, author, status,
             current_chapter, total_chapters, rating, cover_url, personal_notes) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)',
            $this->values($d)
        );
        return $this->db->lastInsertId();
    }

    public function update(int $id, array $d): void
    {
        $this->db->query(
            'UPDATE manhwa SET folder_id=?, title=?, alternative_title=?, synopsis=?, genre=?, author=?, status=?,
             current_chapter=?, total_chapters=?, rating=?, cover_url=?, personal_notes=? WHERE id=?',
            array_merge($this->values($d), [$id])
        );
    }

    public function delete(int $id): bool
    {
        return $this->db->query('DELETE FROM manhwa WHERE id = ?', [$id])->rowCount() > 0;
    }

    private function values(array $d): array
    {
        return [
            $d['folder_id'], $d['title'], $d['alternative_title'], $d['synopsis'], $d['genre'], $d['author'],
            $d['status'], $d['current_chapter'], $d['total_chapters'], $d['rating'], $d['cover_url'], $d['personal_notes'],
        ];
    }

    private function mapAll(array $rows): array
    {
        return array_map(static fn(array $r): Manhwa => Manhwa::fromRow($r), $rows);
    }
}
