<?php
require_once 'config.php';
require_once 'functions.php';
$id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);
if (!$id || $id < 1) { http_response_code(400); exit('ID manhwa tidak valid.'); }
$stmt = $pdo->prepare('SELECT m.*, f.name AS folder_name FROM manhwa m LEFT JOIN folders f ON f.id=m.folder_id WHERE m.id=?');
$stmt->execute([$id]);
$m = $stmt->fetch();
if (!$m) { http_response_code(404); exit('Manhwa tidak ditemukan.'); }
$pageTitle = $m['title'];
require 'header.php';
?>
<div class="detail-layout">
    <aside>
        <?php if ($m['cover_url']): ?><img class="detail-cover" src="<?= e($m['cover_url']) ?>" alt="Cover <?= e($m['title']) ?>">
        <?php else: ?><div class="detail-cover cover-placeholder"><span>DS</span><small>NO COVER</small></div><?php endif; ?>
        <div class="detail-buttons"><a class="button" href="manhwa_form.php?id=<?= (int)$m['id'] ?>">Edit manhwa</a>
        <form method="post" action="manhwa_delete.php" data-confirm="Yakin ingin menghapus manhwa ini?">
            <input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>"><input type="hidden" name="id" value="<?= (int)$m['id'] ?>">
            <button class="button button-danger" type="submit">Hapus</button>
        </form></div>
    </aside>
    <article class="detail-content">
        <p class="eyebrow">MANHWA DETAILS</p><span class="status status-<?= strtolower(str_replace(' ', '-', $m['status'])) ?>"><?= e($m['status']) ?></span>
        <h1><?= e($m['title']) ?></h1>
        <?php if ($m['alternative_title']): ?><p class="muted"><?= e($m['alternative_title']) ?></p><?php endif; ?>
        <div class="detail-meta">
            <div><span>Folder</span><strong><?= e($m['folder_name'] ?: 'Belum masuk folder') ?></strong></div>
            <div><span>Author</span><strong><?= e($m['author'] ?: 'Belum diisi') ?></strong></div>
            <div><span>Genre</span><strong><?= e($m['genre'] ?: 'Belum diisi') ?></strong></div>
            <div><span>Progres</span><strong>Chapter <?= (int)$m['current_chapter'] ?><?= $m['total_chapters'] !== null ? ' / '.(int)$m['total_chapters'] : '' ?></strong></div>
            <div><span>Rating</span><strong><?= $m['rating'] !== null ? '★ '.e($m['rating']).' / 10' : 'Belum dinilai' ?></strong></div>
        </div>
        <?php if ($m['total_chapters'] && (int)$m['total_chapters'] > 0): ?><div class="progress detail-progress"><span style="width:<?= min(100, (int)round(((int)$m['current_chapter'] / (int)$m['total_chapters']) * 100)) ?>%"></span></div><?php endif; ?>
        <section class="detail-section"><h2>Sinopsis</h2><p class="long-text"><?= e($m['synopsis'] ?: 'Belum ada sinopsis.') ?></p></section>
        <section class="detail-section"><h2>Catatan pribadi</h2><p class="long-text"><?= e($m['personal_notes'] ?: 'Belum ada catatan.') ?></p></section>
        <p class="muted small">Terakhir diperbarui: <?= e($m['updated_at']) ?></p>
    </article>
</div>
<?php require 'footer.php'; ?>
