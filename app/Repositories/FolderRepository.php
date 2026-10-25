<?php
declare(strict_types=1);

namespace DailyScroll\Repositories;

use DailyScroll\Core\Database;
use DailyScroll\Models\Folder;

/**
 * Semua query tabel `folders`.
 */
final class FolderRepository
{
    public function __construct(private Database $db)
    {
    }

    /** @return Folder[] */
    public function all(): array
    {
        return $this->mapAll($this->db->query('SELECT id, name, description FROM folders ORDER BY name ASC')->fetchAll());
    }

    /** @return Folder[] */
    public function allWithCount(): array
    {
        return $this->withCount(0);
    }

    /** @return Folder[] folder dengan isi terbanyak */
    public function topWithCount(int $limit): array
    {
        return $this->withCount($limit);
    }

    public function find(int $id): ?Folder
    {
        $row = $this->db->query('SELECT id, name, description FROM folders WHERE id = ?', [$id])->fetch();
        return $row ? Folder::fromRow($row) : null;
    }

    public function exists(int $id): bool
    {
        return (bool)$this->db->query('SELECT id FROM folders WHERE id = ?', [$id])->fetch();
    }

    public function count(): int
    {
        return (int)$this->db->query('SELECT COUNT(*) FROM folders')->fetchColumn();
    }

    public function create(string $name, ?string $description): int
    {
        $this->db->query('INSERT INTO folders (name, description) VALUES (?, ?)', [$name, $description]);
        return $this->db->lastInsertId();
    }

    public function update(int $id, string $name, ?string $description): void
    {
        $this->db->query('UPDATE folders SET name = ?, description = ? WHERE id = ?', [$name, $description, $id]);
    }

    public function delete(int $id): bool
    {
        return $this->db->query('DELETE FROM folders WHERE id = ?', [$id])->rowCount() > 0;
    }

    private function withCount(int $limit): array
    {
        $sql = 'SELECT f.*, COUNT(m.id) AS manhwa_count FROM folders f
                LEFT JOIN manhwa m ON m.folder_id = f.id
                GROUP BY f.id ORDER BY manhwa_count DESC, f.name ASC';
        if ($limit > 0) {
            $sql .= ' LIMIT ' . (int)$limit;
        }
        return $this->mapAll($this->db->query($sql)->fetchAll());
    }

    private function mapAll(array $rows): array
    {
        return array_map(static fn(array $r): Folder => Folder::fromRow($r), $rows);
    }
}
