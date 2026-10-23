<?php
require_once 'config.php';
require_once 'functions.php';

$id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);
$isEdit = $id !== false && $id !== null && $id > 0;
$data = [
    'folder_id' => '', 'title' => '', 'alternative_title' => '', 'synopsis' => '',
    'genre' => '', 'author' => '', 'status' => 'Plan to Read', 'current_chapter' => 0,
    'total_chapters' => '', 'rating' => '', 'cover_url' => '', 'personal_notes' => ''
];
if ($isEdit) {
    $stmt = $pdo->prepare('SELECT * FROM manhwa WHERE id = ?');
    $stmt->execute([$id]);
    $existing = $stmt->fetch();
    if (!$existing) { http_response_code(404); exit('Manhwa tidak ditemukan.'); }
    $data = array_merge($data, $existing);
}

$errors = [];
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    verify_csrf();
    $title = trim((string)($_POST['title'] ?? ''));
    $folderRaw = $_POST['folder_id'] ?? '';
    $status = (string)($_POST['status'] ?? 'Plan to Read');
    $currentRaw = $_POST['current_chapter'] ?? '0';
    $totalRaw = trim((string)($_POST['total_chapters'] ?? ''));
    $ratingRaw = trim((string)($_POST['rating'] ?? ''));

    if ($title === '') $errors[] = 'Judul wajib diisi.';
    if (!in_array($status, ['Reading','Completed','Plan to Read'], true)) $errors[] = 'Status tidak valid.';
    if (!ctype_digit((string)$currentRaw)) $errors[] = 'Chapter saat ini harus berupa angka 0 atau lebih.';
    if ($totalRaw !== '' && !ctype_digit($totalRaw)) $errors[] = 'Total chapter harus berupa angka 0 atau lebih.';
    if ($ratingRaw !== '' && (!is_numeric($ratingRaw) || (float)$ratingRaw < 1 || (float)$ratingRaw > 10)) $errors[] = 'Rating harus antara 1 sampai 10.';
    if ($totalRaw !== '' && ctype_digit((string)$currentRaw) && (int)$currentRaw > (int)$totalRaw) $errors[] = 'Chapter saat ini tidak boleh melebihi total chapter.';
    $folderIdValue = null;
    if ($folderRaw !== '') {
        if (!ctype_digit((string)$folderRaw)) $errors[] = 'Folder tidak valid.';
        else {
            $check = $pdo->prepare('SELECT id FROM folders WHERE id = ?');
            $check->execute([(int)$folderRaw]);
            if (!$check->fetch()) $errors[] = 'Folder yang dipilih tidak ditemukan.';
            else $folderIdValue = (int)$folderRaw;
        }
    }

    $data = [
        'folder_id' => $folderRaw, 'title' => $title,
        'alternative_title' => trim((string)($_POST['alternative_title'] ?? '')),
        'synopsis' => trim((string)($_POST['synopsis'] ?? '')),
        'genre' => trim((string)($_POST['genre'] ?? '')),
        'author' => trim((string)($_POST['author'] ?? '')),
        'status' => $status, 'current_chapter' => $currentRaw,
        'total_chapters' => $totalRaw, 'rating' => $ratingRaw,
        'cover_url' => trim((string)($_POST['cover_url'] ?? '')),
        'personal_notes' => trim((string)($_POST['personal_notes'] ?? '')),
    ];

    if (!$errors) {
        $values = [
            $folderIdValue, $title, $data['alternative_title'] ?: null,
            $data['synopsis'] ?: null, $data['genre'] ?: null, $data['author'] ?: null,
            $status, (int)$currentRaw, $totalRaw === '' ? null : (int)$totalRaw,
            $ratingRaw === '' ? null : (float)$ratingRaw,
            $data['cover_url'] ?: null, $data['personal_notes'] ?: null
        ];
        if ($isEdit) {
            $values[] = $id;
            $stmt = $pdo->prepare('UPDATE manhwa SET folder_id=?, title=?, alternative_title=?, synopsis=?, genre=?, author=?, status=?, current_chapter=?, total_chapters=?, rating=?, cover_url=?, personal_notes=? WHERE id=?');
            $stmt->execute($values);
            flash('Data manhwa berhasil diperbarui.');
        } else {
            $stmt = $pdo->prepare('INSERT INTO manhwa (folder_id,title,alternative_title,synopsis,genre,author,status,current_chapter,total_chapters,rating,cover_url,personal_notes) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)');
            $stmt->execute($values);
            flash('Manhwa berhasil ditambahkan.');
        }
        redirect('manhwa.php');
    }
}
$folders = get_folders($pdo);
$pageTitle = $isEdit ? 'Edit Manhwa' : 'Tambah Manhwa';
require 'header.php';
?>
<section class="page-heading"><div><p class="eyebrow">YOUR LIBRARY, YOUR RULES</p><h1><?= $isEdit ? 'Edit' : 'Tambah' ?> <span class="accent">manhwa.</span></h1><p class="muted">Isi detail yang kamu ingat. Kolom selain judul boleh dikosongkan.</p></div></section>
<?php if ($errors): ?><div class="alert error"><strong>Periksa kembali:</strong><ul><?php foreach ($errors as $error): ?><li><?= e($error) ?></li><?php endforeach; ?></ul></div><?php endif; ?>
<form method="post" class="form-panel" autocomplete="off">
    <input type="hidden" name="csrf_token" value="<?= e(csrf_token()) ?>">
    <div class="form-grid">
        <label class="field field-wide">Judul manhwa *<input name="title" autocomplete="off" maxlength="255" required value="<?= e($data['title']) ?>" placeholder="Contoh: Solo Leveling"></label>
        <label class="field">Judul alternatif<input name="alternative_title" autocomplete="off" maxlength="255" value="<?= e($data['alternative_title']) ?>" placeholder="Judul lain / bahasa asli"></label>
        <label class="field">Author<input name="author" autocomplete="off" maxlength="150" value="<?= e($data['author']) ?>" placeholder="Nama author"></label>
        <label class="field">Genre<input name="genre" autocomplete="off" maxlength="255" value="<?= e($data['genre']) ?>" placeholder="Action, Fantasy, Romance"></label>
        <label class="field">Folder
            <select name="folder_id"><option value="">— Tanpa folder —</option><?php foreach ($folders as $f): ?><option value="<?= (int)$f['id'] ?>" <?= (string)$data['folder_id'] === (string)$f['id'] ? 'selected' : '' ?>><?= e($f['name']) ?></option><?php endforeach; ?></select>
        </label>
        <label class="field">Status<select name="status"><?php foreach (['Reading','Completed','Plan to Read'] as $s): ?><option value="<?= e($s) ?>" <?= $data['status'] === $s ? 'selected' : '' ?>><?= e($s) ?></option><?php endforeach; ?></select></label>
        <label class="field">Chapter saat ini<input type="number" min="0" step="1" name="current_chapter" autocomplete="off" value="<?= e($data['current_chapter']) ?>"></label>
        <label class="field">Total chapter (opsional)<input type="number" min="0" step="1" name="total_chapters" autocomplete="off" value="<?= e($data['total_chapters']) ?>" placeholder="Kosongkan jika belum tahu"></label>
        <label class="field">Rating (1–10)<input type="number" min="1" max="10" step="0.1" name="rating" autocomplete="off" value="<?= e($data['rating']) ?>" placeholder="Misal 9.5"></label>
        <label class="field field-wide">URL cover gambar<input type="url" name="cover_url" autocomplete="off" value="<?= e($data['cover_url']) ?>" placeholder="https://..."></label>
        <label class="field field-wide">Sinopsis<textarea name="synopsis" autocomplete="off" rows="4" placeholder="Tentang cerita ini..."><?= e($data['synopsis']) ?></textarea></label>
        <label class="field field-wide">Catatan pribadi<textarea name="personal_notes" autocomplete="off" rows="3" placeholder="Pendapat, chapter favorit, atau catatan lainnya..."><?= e($data['personal_notes']) ?></textarea></label>
    </div>
    <div class="form-actions"><a class="button button-light" href="<?= $isEdit ? 'detail.php?id='.(int)$id : 'manhwa.php' ?>">Batal</a><button class="button" type="submit">Simpan manhwa</button></div>
</form>
<?php require 'footer.php'; ?>
