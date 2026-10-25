<?php
use DailyScroll\Core\Csrf;
use DailyScroll\Models\ManhwaStatus;
?>
<?php $this->partial('partials/section_tag', ['label' => $isEdit ? 'Edit manhwa' : 'Tambah manhwa']); ?>
<p class="mt-5 text-sm text-neutral-500">Catat informasi yang ingin kamu simpan. Hanya judul yang wajib diisi.</p>

<?php if ($errors): ?>
    <div class="mt-5 rounded-lg bg-red-100 px-4 py-3 text-sm text-red-800">
        <strong>Periksa kembali:</strong>
        <ul class="mt-1 list-disc pl-5"><?php foreach ($errors as $error): ?><li><?= $e($error) ?></li><?php endforeach; ?></ul>
    </div>
<?php endif; ?>

<form method="post" autocomplete="off" class="mt-6 rounded-xl bg-white p-6 shadow-sm">
    <?= Csrf::field() ?>
    <div class="grid gap-5 sm:grid-cols-2">
        <label class="flex flex-col gap-2 text-sm font-semibold sm:col-span-2">Judul manhwa *
            <input class="ds-input" name="title" autocomplete="off" maxlength="255" required value="<?= $e($form['title']) ?>" placeholder="Contoh: Solo Leveling"></label>
        <label class="flex flex-col gap-2 text-sm font-semibold">Judul alternatif
            <input class="ds-input" name="alternative_title" autocomplete="off" maxlength="255" value="<?= $e($form['alternative_title']) ?>" placeholder="Judul lain / bahasa asli"></label>
        <label class="flex flex-col gap-2 text-sm font-semibold">Author
            <input class="ds-input" name="author" autocomplete="off" maxlength="150" value="<?= $e($form['author']) ?>" placeholder="Nama author"></label>
        <label class="flex flex-col gap-2 text-sm font-semibold">Genre
            <input class="ds-input" name="genre" autocomplete="off" maxlength="255" value="<?= $e($form['genre']) ?>" placeholder="Action, Fantasy, Romance"></label>
        <label class="flex flex-col gap-2 text-sm font-semibold">Folder
            <select class="ds-input" name="folder_id">
                <option value="">— Tanpa folder —</option>
                <?php foreach ($folders as $f): ?>
                    <option value="<?= $f->id() ?>" <?= (string)$form['folder_id'] === (string)$f->id() ? 'selected' : '' ?>><?= $e($f->name()) ?></option>
                <?php endforeach; ?>
            </select></label>
        <label class="flex flex-col gap-2 text-sm font-semibold">Status
            <select class="ds-input" name="status">
                <?php foreach (ManhwaStatus::all() as $s): ?>
                    <option value="<?= $e($s) ?>" <?= $form['status'] === $s ? 'selected' : '' ?>><?= $e(ManhwaStatus::label($s)) ?></option>
                <?php endforeach; ?>
            </select></label>
        <label class="flex flex-col gap-2 text-sm font-semibold">Chapter saat ini
            <input class="ds-input" type="number" min="0" step="1" name="current_chapter" autocomplete="off" value="<?= $e($form['current_chapter']) ?>"></label>
        <label class="flex flex-col gap-2 text-sm font-semibold">Total chapter (opsional)
            <input class="ds-input" type="number" min="0" step="1" name="total_chapters" autocomplete="off" value="<?= $e($form['total_chapters']) ?>" placeholder="Kosongkan jika belum tahu"></label>
        <label class="flex flex-col gap-2 text-sm font-semibold">Rating (1–10)
            <input class="ds-input" type="number" min="1" max="10" step="0.1" name="rating" autocomplete="off" value="<?= $e($form['rating']) ?>" placeholder="Misal 9.5"></label>
        <label class="flex flex-col gap-2 text-sm font-semibold sm:col-span-2">URL cover gambar
            <input class="ds-input" type="url" name="cover_url" autocomplete="off" value="<?= $e($form['cover_url']) ?>" placeholder="https://..."></label>
        <label class="flex flex-col gap-2 text-sm font-semibold sm:col-span-2">Sinopsis
            <textarea class="ds-input" name="synopsis" autocomplete="off" rows="4" placeholder="Tentang cerita ini..."><?= $e($form['synopsis']) ?></textarea></label>
        <label class="flex flex-col gap-2 text-sm font-semibold sm:col-span-2">Catatan pribadi
            <textarea class="ds-input" name="personal_notes" autocomplete="off" rows="3" placeholder="Pendapat, chapter favorit, atau catatan lainnya..."><?= $e($form['personal_notes']) ?></textarea></label>
    </div>
    <div class="mt-6 flex justify-end gap-3 border-t border-neutral-200 pt-5">
        <a class="ds-btn ds-btn-light" href="<?= $isEdit ? 'detail.php?id=' . (int)$editId : 'manhwa.php' ?>">Batal</a>
        <button class="ds-btn ds-btn-primary" type="submit">Simpan manhwa</button>
    </div>
</form>
