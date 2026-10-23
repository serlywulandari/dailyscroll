<?php
require_once 'config.php';
require_once 'functions.php';
$errors = [];
$editId = filter_input(INPUT_GET, 'edit', FILTER_VALIDATE_INT);
$editing = null;
if ($editId && $editId > 0) {
    $stmt = $pdo->prepare('SELECT * FROM folders WHERE id=?');
    $stmt->execute([$editId]);
    $editing = $stmt->fetch();
    if (!$editing) $editId = null;
}
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    verify_csrf();
    $action = (string)($_POST['action'] ?? 'save');
    if ($action === 'save') {
        $name = trim((string)($_POST['name'] ?? ''));
        $description = trim((string)($_POST['description'] ?? ''));
        $id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT);
        if ($name === '') $errors[] = 'Nama folder wajib diisi.';
        if (mb_strlen($name) > 100) $errors[] = 'Nama folder maksimal 100 karakter.';
        if (!$errors) {
            if ($id && $id > 0) {
                $stmt = $pdo->prepare('UPDATE folders SET name=?, description=? WHERE id=?');
                $stmt->execute([$name, $description ?: null, $id]);
                flash('Folder berhasil diperbarui.');
            } else {
                $stmt = $pdo->prepare('INSERT INTO folders (name, description) VALUES (?,?)');
                $stmt->execute([$name, $description ?: null]);
                flash('Folder berhasil dibuat.');
            }
            redirect('folders.php');
        }
    }
}
$folders = $pdo->query('SELECT f.*, COUNT(m.id) AS manhwa_count FROM folders f LEFT JOIN manhwa m ON m.folder_id=f.id GROUP BY f.id ORDER BY f.name')->fetchAll();
$pageTitle = 'Folder';
require 'header.php';
?>
<section class="page-heading"><div><p class="eyebrow">ORGANIZE YOUR STORIES</p><h1>Folder <span class="accent">koleksi.</span></h1><p class="muted">Buat kategori sesuai gaya membaca kamu.</p></div></section>
<?php if ($errors): ?><div class="alert error"><ul><?php foreach ($errors as $error): ?><li><?= e($error) ?></li><?php endforeach; ?></ul></div><?php endif; ?>
<div class="folder-page-grid">
<form method="post" class="form-panel folder-form">
    <h2><?= $editing ? 'Edit folder' : 'Buat folder baru' ?></h2>
    <input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>"><input type="hidden" name="action" value="save">
    <input type="hidden" name="id" value="<?= (int)($editing['id'] ?? 0) ?>">
    <label class="field">Nama folder *<input required maxlength="100" name="name" value="<?= e($editing['name'] ?? ($_POST['name'] ?? '')) ?>" placeholder="Contoh: favorite"></label>
    <label class="field">Deskripsi<textarea name="description" rows="4" placeholder="Isi folder ini..."><?= e($editing['description'] ?? ($_POST['description'] ?? '')) ?></textarea></label>
    <button class="button" type="submit"><?= $editing ? 'Simpan perubahan' : 'Buat folder' ?></button>
    <?php if ($editing): ?><a class="text-link" href="folders.php">Batal edit</a><?php endif; ?>
</form>
<div class="folder-list">
<?php if (!$folders): ?><div class="empty-state"><p>Belum ada folder.</p></div><?php endif; ?>
<?php foreach ($folders as $f): ?>
    <article class="folder-card"><div class="folder-icon">▤</div><div class="folder-card-main"><h3><?= e($f['name']) ?></h3><p><?= e($f['description'] ?: 'Tidak ada deskripsi') ?></p><span><?= (int)$f['manhwa_count'] ?> manhwa</span><a class="text-link" href="manhwa.php?folder_id=<?= (int)$f['id'] ?>">Lihat isi →</a></div>
    <div class="folder-actions"><a href="folders.php?edit=<?= (int)$f['id'] ?>">Edit</a><form method="post" action="folder_delete.php" data-confirm="Hapus folder ini? Manhwa di dalamnya tetap ada, tetapi tidak lagi terhubung ke folder."><input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>"><input type="hidden" name="id" value="<?= (int)$f['id'] ?>"><button class="link-danger" type="submit">Hapus</button></form></div></article>
<?php endforeach; ?>
</div>
</div>
<?php require 'footer.php'; ?>
