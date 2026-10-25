<?php use DailyScroll\Core\Csrf; ?>
<?php $this->partial('partials/section_tag', ['label' => 'Folder koleksi']); ?>
<p class="mt-5 text-sm text-neutral-500">Buat kategori sesuai gaya membaca kamu.</p>

<?php if ($errors): ?>
    <div class="mt-5 rounded-lg bg-red-100 px-4 py-3 text-sm text-red-800">
        <ul class="list-disc pl-5"><?php foreach ($errors as $error): ?><li><?= $e($error) ?></li><?php endforeach; ?></ul>
    </div>
<?php endif; ?>

<div class="mt-6 grid items-start gap-6 lg:grid-cols-[320px_minmax(0,1fr)]">
    <form method="post" autocomplete="off" class="rounded-xl bg-white p-6 shadow-sm">
        <h2 class="mb-4 text-lg font-bold"><?= $editing ? 'Edit folder' : 'Buat folder baru' ?></h2>
        <?= Csrf::field() ?>
        <input type="hidden" name="id" value="<?= $editing ? $editing->id() : 0 ?>">
        <label class="mb-4 flex flex-col gap-2 text-sm font-semibold">Nama folder *
            <input class="ds-input" required maxlength="100" name="name" autocomplete="off" value="<?= $e($name) ?>" placeholder="Contoh: favorite"></label>
        <label class="mb-5 flex flex-col gap-2 text-sm font-semibold">Deskripsi
            <textarea class="ds-input" name="description" autocomplete="off" rows="4" placeholder="Isi folder ini..."><?= $e($description) ?></textarea></label>
        <button class="ds-btn ds-btn-primary w-full" type="submit"><?= $editing ? 'Simpan perubahan' : 'Buat folder' ?></button>
        <?php if ($editing): ?><a class="mt-3 block text-center text-sm font-semibold text-brand hover:underline" href="folders.php">Batal edit</a><?php endif; ?>
    </form>

    <div class="space-y-3">
        <?php if (!$folders): ?>
            <div class="rounded-xl border border-dashed border-neutral-300 bg-white p-10 text-center text-sm text-neutral-500">Belum ada folder.</div>
        <?php endif; ?>
        <?php foreach ($folders as $f): ?>
            <article class="flex items-start gap-4 rounded-xl bg-white p-5 shadow-sm">
                <div class="grid h-11 w-11 shrink-0 place-items-center rounded-lg bg-[#f5d9db] text-xl text-brand-dark">▤</div>
                <div class="min-w-0 flex-1">
                    <h3 class="font-bold"><?= $e($f->name()) ?></h3>
                    <p class="mt-0.5 text-sm text-neutral-500"><?= $e($f->description() ?: 'Tidak ada deskripsi') ?></p>
                    <p class="mt-2 text-xs text-neutral-500"><?= $f->manhwaCount() ?> manhwa</p>
                    <a class="mt-1 inline-block text-sm font-semibold text-brand hover:underline" href="manhwa.php?folder_id=<?= $f->id() ?>">Lihat isi →</a>
                </div>
                <div class="flex shrink-0 items-center gap-4 text-sm font-semibold">
                    <a class="text-brand hover:underline" href="folders.php?edit=<?= $f->id() ?>">Edit</a>
                    <form method="post" action="folder_delete.php" data-confirm="Hapus folder ini? Manhwa di dalamnya tetap ada, tetapi tidak lagi terhubung ke folder.">
                        <?= Csrf::field() ?>
                        <input type="hidden" name="id" value="<?= $f->id() ?>">
                        <button class="font-semibold text-neutral-500 hover:text-brand hover:underline" type="submit">Hapus</button>
                    </form>
                </div>
            </article>
        <?php endforeach; ?>
    </div>
</div>
