<?php
require_once 'config.php';
require_once 'functions.php';

$total = (int)$pdo->query('SELECT COUNT(*) FROM manhwa')->fetchColumn();
$reading = (int)$pdo->query("SELECT COUNT(*) FROM manhwa WHERE status = 'Reading'")->fetchColumn();
$completed = (int)$pdo->query("SELECT COUNT(*) FROM manhwa WHERE status = 'Completed'")->fetchColumn();
$planned = (int)$pdo->query("SELECT COUNT(*) FROM manhwa WHERE status = 'Plan to Read'")->fetchColumn();
$folderCount = (int)$pdo->query('SELECT COUNT(*) FROM folders')->fetchColumn();
$recent = $pdo->query(
    'SELECT m.*, f.name AS folder_name FROM manhwa m LEFT JOIN folders f ON f.id = m.folder_id
     ORDER BY m.updated_at DESC, m.id DESC LIMIT 6'
)->fetchAll();

$pageTitle = 'Dashboard';
require 'header.php';
?>
<section class="hero">
    <div>
        <p class="eyebrow">YOUR PERSONAL MANHWA LIBRARY</p>
        <h1>Semua cerita,<br><span class="accent">dalam satu scroll.</span></h1>
        <p class="muted hero-copy">Simpan judul favorit, atur koleksi, dan lanjutkan membaca kapan saja.</p>
        <a class="button" href="manhwa_form.php">＋ Tambah manhwa</a>
    </div>
    <div class="hero-art" aria-hidden="true"><span>読</span><i>✦</i><b>♡</b></div>
</section>

<section class="stats">
    <article class="stat-card"><span>Total manhwa</span><strong><?= $total ?></strong><small>Di perpustakaanmu</small></article>
    <article class="stat-card"><span>Sedang dibaca</span><strong><?= $reading ?></strong><small>Keep scrolling</small></article>
    <article class="stat-card"><span>Selesai</span><strong><?= $completed ?></strong><small>Story completed</small></article>
    <article class="stat-card"><span>Rencana baca</span><strong><?= $planned ?></strong><small>Next on your list</small></article>
</section>

<section class="section-heading">
    <div><p class="eyebrow">YOUR COLLECTION</p><h2>Baru diperbarui</h2></div>
    <a class="text-link" href="manhwa.php">Lihat semua →</a>
</section>

<?php if (!$recent): ?>
    <div class="empty-state"><div class="empty-icon">✧</div><h3>Perpustakaanmu masih kosong</h3><p>Mulai dengan menambahkan manhwa pertama.</p><a class="button" href="manhwa_form.php">Tambah manhwa</a></div>
<?php else: ?>
<div class="manhwa-grid">
<?php foreach ($recent as $m): ?>
    <article class="manhwa-card">
        <a class="cover-link" href="detail.php?id=<?= (int)$m['id'] ?>">
        <?php if (!empty($m['cover_url'])): ?>
            <img class="cover" src="<?= e($m['cover_url']) ?>" alt="Cover <?= e($m['title']) ?>" loading="lazy">
        <?php else: ?>
            <div class="cover cover-placeholder"><span>DS</span><small>NO COVER</small></div>
        <?php endif; ?>
        </a>
        <div class="card-body">
            <span class="status status-<?= strtolower(str_replace(' ', '-', $m['status'])) ?>"><?= e($m['status']) ?></span>
            <h3><a href="detail.php?id=<?= (int)$m['id'] ?>"><?= e($m['title']) ?></a></h3>
            <p class="card-meta"><?= e($m['folder_name'] ?: 'Belum masuk folder') ?></p>
            <div class="progress-row"><span>Chapter <?= (int)$m['current_chapter'] ?><?= $m['total_chapters'] !== null ? ' / '.(int)$m['total_chapters'] : '' ?></span>
            <?php if ($m['total_chapters'] && (int)$m['total_chapters'] > 0): ?>
                <span><?= min(100, (int)round(((int)$m['current_chapter'] / (int)$m['total_chapters']) * 100)) ?>%</span>
            <?php endif; ?></div>
            <?php if ($m['total_chapters'] && (int)$m['total_chapters'] > 0): ?>
            <div class="progress"><span style="width:<?= min(100, (int)round(((int)$m['current_chapter'] / (int)$m['total_chapters']) * 100)) ?>%"></span></div>
            <?php endif; ?>
        </div>
    </article>
<?php endforeach; ?>
</div>
<?php endif; ?>

<section class="folder-summary">
    <div><p class="eyebrow">KEEP IT ORGANIZED</p><h2>Koleksi berdasarkan folder</h2><p class="muted">Atur daftar bacaan sesuai caramu sendiri.</p></div>
    <div class="folder-summary-side"><strong><?= $folderCount ?></strong><span>folder koleksi</span><a class="text-link" href="folders.php">Kelola folder →</a></div>
</section>
<?php require 'footer.php'; ?>
