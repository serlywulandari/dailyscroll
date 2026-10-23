<?php
require_once 'config.php';
require_once 'functions.php';

$q = trim((string)($_GET['q'] ?? ''));
$status = trim((string)($_GET['status'] ?? ''));
$folderId = filter_input(INPUT_GET, 'folder_id', FILTER_VALIDATE_INT);
$allowedStatuses = ['Reading', 'Completed', 'Plan to Read'];

$sql = 'SELECT m.*, f.name AS folder_name FROM manhwa m LEFT JOIN folders f ON f.id = m.folder_id WHERE 1=1';
$params = [];
if ($q !== '') {
    $sql .= ' AND (m.title LIKE ? OR m.alternative_title LIKE ? OR m.author LIKE ? OR m.genre LIKE ?)';
    $like = '%' . $q . '%';
    array_push($params, $like, $like, $like, $like);
}
if (in_array($status, $allowedStatuses, true)) {
    $sql .= ' AND m.status = ?';
    $params[] = $status;
}
if ($folderId !== false && $folderId !== null && $folderId > 0) {
    $sql .= ' AND m.folder_id = ?';
    $params[] = $folderId;
}
$sql .= ' ORDER BY m.updated_at DESC, m.title ASC';
$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$manhwa = $stmt->fetchAll();
$folders = get_folders($pdo);

$pageTitle = 'Semua Manhwa';
require 'header.php';
?>
<section class="page-heading">
    <div><p class="eyebrow">THE LIBRARY</p><h1>Semua <span class="accent">manhwa.</span></h1><p class="muted">Koleksi cerita yang sedang dan ingin kamu baca.</p></div>
    <a class="button" href="manhwa_form.php">＋ Tambah manhwa</a>
</section>
<form class="filter-bar" method="get">
    <input type="search" name="q" placeholder="Cari judul, author, genre..." value="<?= e($q) ?>">
    <select name="status">
        <option value="">Semua status</option>
        <?php foreach (['Reading','Completed','Plan to Read'] as $s): ?>
        <option value="<?= e($s) ?>" <?= $status === $s ? 'selected' : '' ?>><?= e($s) ?></option>
        <?php endforeach; ?>
    </select>
    <select name="folder_id">
        <option value="">Semua folder</option>
        <?php foreach ($folders as $f): ?>
        <option value="<?= (int)$f['id'] ?>" <?= (string)$folderId === (string)$f['id'] ? 'selected' : '' ?>><?= e($f['name']) ?></option>
        <?php endforeach; ?>
    </select>
    <button class="button" type="submit">Filter</button>
    <a class="button button-light" href="manhwa.php">Reset</a>
</form>

<?php if (!$manhwa): ?>
<div class="empty-state"><div class="empty-icon">⌕</div><h3>Manhwa tidak ditemukan</h3><p>Coba ubah kata kunci atau filter.</p></div>
<?php else: ?>
<div class="manhwa-grid">
<?php foreach ($manhwa as $m): ?>
    <article class="manhwa-card">
        <a class="cover-link" href="detail.php?id=<?= (int)$m['id'] ?>">
        <?php if ($m['cover_url']): ?><img class="cover" src="<?= e($m['cover_url']) ?>" alt="Cover <?= e($m['title']) ?>" loading="lazy">
        <?php else: ?><div class="cover cover-placeholder"><span>DS</span><small>NO COVER</small></div><?php endif; ?>
        </a>
        <div class="card-body">
            <span class="status status-<?= strtolower(str_replace(' ', '-', $m['status'])) ?>"><?= e($m['status']) ?></span>
            <h3><a href="detail.php?id=<?= (int)$m['id'] ?>"><?= e($m['title']) ?></a></h3>
            <?php if ($m['alternative_title']): ?><p class="card-meta"><?= e($m['alternative_title']) ?></p><?php endif; ?>
            <p class="card-meta"><?= e($m['folder_name'] ?: 'Belum masuk folder') ?></p>
            <div class="progress-row"><span>Chapter <?= (int)$m['current_chapter'] ?><?= $m['total_chapters'] !== null ? ' / '.(int)$m['total_chapters'] : '' ?></span><span><?= $m['rating'] !== null ? '★ '.e($m['rating']) : '' ?></span></div>
            <?php if ($m['total_chapters'] && (int)$m['total_chapters'] > 0): ?><div class="progress"><span style="width:<?= min(100, (int)round(((int)$m['current_chapter'] / (int)$m['total_chapters']) * 100)) ?>%"></span></div><?php endif; ?>
            <div class="card-actions"><a href="detail.php?id=<?= (int)$m['id'] ?>">Detail</a><a href="manhwa_form.php?id=<?= (int)$m['id'] ?>">Edit</a></div>
        </div>
    </article>
<?php endforeach; ?>
</div>
<?php endif; ?>
<?php require 'footer.php'; ?>
