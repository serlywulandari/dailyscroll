<?php
use DailyScroll\Models\ManhwaStatus;
/** @var DailyScroll\Models\Manhwa[] $items */
$sorts = ['updated' => 'Terakhir diperbarui', 'title' => 'Judul A–Z', 'rating' => 'Rating tertinggi', 'progress' => 'Chapter terbanyak'];
?>
<div class="flex items-end justify-between gap-4">
    <div>
        <?php $this->partial('partials/section_tag', ['label' => $heading]); ?>
        <p class="mt-5 text-sm text-neutral-500">Kelola judul, status, folder, dan progres yang kamu catat.</p>
    </div>
</div>

<form id="filter" method="get" class="mt-6 grid gap-3 rounded-xl bg-white p-4 shadow-sm sm:grid-cols-2 lg:grid-cols-[1fr_auto_auto_auto_auto_auto]">
    <input class="ds-input" type="search" name="q" autocomplete="off" placeholder="Cari judul, author, genre..." value="<?= $e($filters['q']) ?>">
    <select class="ds-input" name="status">
        <option value="">Semua status</option>
        <?php foreach (ManhwaStatus::all() as $s): ?>
            <option value="<?= $e($s) ?>" <?= $filters['status'] === $s ? 'selected' : '' ?>><?= $e(ManhwaStatus::label($s)) ?></option>
        <?php endforeach; ?>
    </select>
    <select class="ds-input" name="folder_id">
        <option value="">Semua folder</option>
        <?php foreach ($folders as $f): ?>
            <option value="<?= $f->id() ?>" <?= (int)$filters['folder_id'] === $f->id() ? 'selected' : '' ?>><?= $e($f->name()) ?></option>
        <?php endforeach; ?>
    </select>
    <select class="ds-input" name="sort" aria-label="Urutkan koleksi">
        <?php foreach ($sorts as $key => $label): ?>
            <option value="<?= $e($key) ?>" <?= $filters['sort'] === $key ? 'selected' : '' ?>><?= $e($label) ?></option>
        <?php endforeach; ?>
    </select>
    <button class="ds-btn ds-btn-primary" type="submit">Terapkan</button>
    <a class="ds-btn ds-btn-light" href="manhwa.php">Reset</a>
</form>

<?php if (!$items): ?>
    <div class="mt-8 rounded-xl border border-dashed border-neutral-300 bg-white p-12 text-center">
        <p class="font-semibold">Manhwa tidak ditemukan</p>
        <p class="mt-1 text-sm text-neutral-500">Coba ubah kata kunci, status, folder, atau urutan koleksi.</p>
    </div>
<?php else: ?>
    <div class="mt-8 flex items-center justify-between">
        <span class="text-sm text-neutral-600"><?= count($items) ?> judul ditemukan</span>
        <div class="flex rounded-full border border-neutral-300 bg-white p-0.5" role="group" aria-label="Mode tampilan">
            <button type="button" class="view-btn" data-view="grid" aria-pressed="true">▦ Grid</button>
            <button type="button" class="view-btn" data-view="list" aria-pressed="false">☷ List</button>
        </div>
    </div>

    <div class="mt-5 grid grid-cols-2 gap-5 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5" data-collection-grid>
        <?php foreach ($items as $m): ?>
            <article class="m-card">
                <a href="detail.php?id=<?= $m->id() ?>" class="block"><?php $this->partial('partials/cover', ['item' => $m]); ?></a>
                <div class="m-body mt-2">
                    <span class="inline-block rounded-full px-2.5 py-0.5 text-[10px] font-bold <?= $e(ManhwaStatus::badgeClass($m->status())) ?>"><?= $e($m->statusLabel()) ?></span>
                    <a href="detail.php?id=<?= $m->id() ?>" class="mt-1 line-clamp-2 block text-[15px] font-bold leading-snug hover:text-brand"><?= $e($m->title()) ?></a>
                    <?php if ($m->alternativeTitle()): ?><p class="truncate text-xs text-neutral-500"><?= $e($m->alternativeTitle()) ?></p><?php endif; ?>
                    <p class="truncate text-xs text-neutral-500"><?= $e($m->folderName()) ?></p>
                    <div class="mt-2 flex flex-wrap items-center gap-2">
                        <?php $this->partial('partials/pill', ['text' => 'Chapter ' . $m->currentChapter() . ($m->totalChapters() !== null ? ' / ' . $m->totalChapters() : '')]); ?>
                        <?php if ($m->ratingText() !== null): ?><span class="text-xs font-semibold text-brand">★ <?= $e($m->ratingText()) ?></span><?php endif; ?>
                    </div>
                    <?php if ($m->progressPercent() !== null): ?>
                        <div class="mt-2 h-1 overflow-hidden rounded-full bg-neutral-200"><span class="block h-full rounded-full bg-brand" style="width:<?= $m->progressPercent() ?>%"></span></div>
                    <?php endif; ?>
                    <div class="mt-2 flex gap-4 text-xs font-bold text-brand">
                        <a class="hover:underline" href="detail.php?id=<?= $m->id() ?>">Detail</a>
                        <a class="hover:underline" href="manhwa_form.php?id=<?= $m->id() ?>">Edit</a>
                    </div>
                </div>
            </article>
        <?php endforeach; ?>
    </div>
<?php endif; ?>
