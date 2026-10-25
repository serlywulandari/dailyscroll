<?php
use DailyScroll\Core\Format;
use DailyScroll\Models\ManhwaStatus;

/** @var DailyScroll\Models\Manhwa[] $reading */
/** @var DailyScroll\Models\Manhwa[] $recent */
?>
<!-- SEDANG DIBACA -->
<section>
    <div class="flex items-start justify-between gap-4">
        <?php $this->partial('partials/section_tag', ['label' => 'Sedang dibaca']); ?>
        <div class="flex gap-2">
            <button type="button" data-carousel-prev aria-label="Sebelumnya" class="grid h-11 w-[52px] place-items-center bg-brand-dark text-white transition hover:bg-black">
                <svg width="8" height="10" viewBox="0 0 8 10"><path d="M8 0v10L0 5z" fill="currentColor"/></svg>
            </button>
            <button type="button" data-carousel-next aria-label="Berikutnya" class="grid h-11 w-[52px] place-items-center bg-brand-dark text-white transition hover:bg-black">
                <svg width="8" height="10" viewBox="0 0 8 10"><path d="M0 0v10l8-5z" fill="currentColor"/></svg>
            </button>
        </div>
    </div>

    <?php if (!$reading): ?>
        <div class="mt-6 rounded-xl border border-dashed border-neutral-300 bg-white p-8 text-center text-sm text-neutral-500">
            Belum ada manhwa berstatus “Sedang dibaca”. <a href="manhwa_form.php" class="font-semibold text-brand hover:underline">Tambah manhwa</a>
        </div>
    <?php else: ?>
        <div data-carousel class="no-scrollbar mt-6 flex snap-x snap-mandatory gap-6 overflow-x-auto pb-2 pl-2 pt-2">
            <?php foreach ($reading as $m): ?>
                <div class="relative flex shrink-0 basis-[290px] snap-start gap-4 lg:basis-[calc(25%-18px)]">
                    <div class="relative w-[100px] shrink-0">
                        <a href="detail.php?id=<?= $m->id() ?>" class="block">
                            <?php $this->partial('partials/cover', ['item' => $m, 'class' => 'h-36 w-full']); ?>
                        </a>
                        <span class="absolute -left-2 -top-2 grid h-8 w-8 place-items-center rounded-full bg-brand text-[9px] font-bold text-white"><?= $m->isNew() ? 'Baru' : 'Baca' ?></span>
                    </div>
                    <div class="min-w-0 flex-1">
                        <a href="detail.php?id=<?= $m->id() ?>" class="line-clamp-2 text-[16px] font-bold leading-snug hover:text-brand"><?= $e($m->title()) ?></a>
                        <p class="mt-1 text-xs text-neutral-500">Diperbarui <?= $e(Format::date($m->updatedAt())) ?></p>
                        <div class="mt-3 flex flex-col items-start gap-2">
                            <?php $this->partial('partials/pill', ['text' => 'Chapter ' . $m->currentChapter()]); ?>
                            <?php if ($m->totalChapters() !== null): ?>
                                <?php $this->partial('partials/pill', ['text' => 'Total ' . $m->totalChapters()]); ?>
                            <?php elseif ($m->ratingText() !== null): ?>
                                <?php $this->partial('partials/pill', ['text' => '★ ' . $m->ratingText()]); ?>
                            <?php endif; ?>
                        </div>
                    </div>
                </div>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>
</section>

<div class="mt-12 grid gap-10 lg:grid-cols-[minmax(0,1fr)_300px]">
    <!-- BARU DIPERBARUI -->
    <section>
        <div class="flex items-center gap-4">
            <svg width="26" height="30" viewBox="0 0 26 30" aria-hidden="true"><polygon points="0,0 26,0 14,15 26,30 0,30" fill="#bf0000"/></svg>
            <h2 class="text-xl font-semibold uppercase tracking-wide">Baru diperbarui</h2>
            <span class="h-px flex-1 bg-neutral-300"></span>
        </div>

        <?php if (!$recent): ?>
            <div class="mt-8 rounded-xl border border-dashed border-neutral-300 bg-white p-10 text-center">
                <p class="font-semibold">Perpustakaanmu masih kosong</p>
                <p class="mt-1 text-sm text-neutral-500">Mulai dengan menambahkan manhwa pertama.</p>
                <a href="manhwa_form.php" class="ds-btn ds-btn-primary mt-5">Tambah manhwa</a>
            </div>
        <?php else: ?>
            <div class="mt-8 grid grid-cols-2 gap-5 sm:grid-cols-3 xl:grid-cols-5">
                <?php foreach ($recent as $m): ?>
                    <article>
                        <a href="detail.php?id=<?= $m->id() ?>" class="block">
                            <?php $this->partial('partials/cover', ['item' => $m]); ?>
                        </a>
                        <a href="detail.php?id=<?= $m->id() ?>" class="mt-2 line-clamp-2 text-[15px] font-bold leading-snug hover:text-brand"><?= $e($m->title()) ?></a>
                        <div class="mt-2"><?php $this->partial('partials/pill', ['text' => 'Chapter ' . $m->currentChapter()]); ?></div>
                    </article>
                <?php endforeach; ?>
            </div>
            <a href="manhwa.php" class="mt-8 inline-block text-sm font-semibold text-brand hover:underline">Lihat semua koleksi →</a>
        <?php endif; ?>
    </section>

    <!-- SIDEBAR -->
    <aside class="space-y-12">
        <section>
            <?php $this->partial('partials/section_tag', ['label' => 'Ringkasan koleksi']); ?>
            <dl class="mt-6">
                <?php
                $rows = [
                    ['Total koleksi', $counts['total'], 'manhwa.php'],
                    ['Sedang dibaca', $counts[ManhwaStatus::READING], 'manhwa.php?status=Reading'],
                    ['Selesai dibaca', $counts[ManhwaStatus::COMPLETED], 'manhwa.php?status=Completed'],
                    ['Ingin dibaca', $counts[ManhwaStatus::PLAN], 'manhwa.php?status=Plan+to+Read'],
                ];
                foreach ($rows as [$label, $value, $href]): ?>
                    <a href="<?= $e($href) ?>" class="flex items-center justify-between border-b border-neutral-300 py-3 text-[15px] transition hover:text-brand">
                        <span class="text-neutral-600"><?= $e($label) ?></span>
                        <strong class="font-bold"><?= (int)$value ?></strong>
                    </a>
                <?php endforeach; ?>
            </dl>
        </section>

        <section>
            <?php $this->partial('partials/section_tag', ['label' => 'Folder koleksi']); ?>
            <div class="mt-6">
                <?php if (!$topFolders): ?>
                    <p class="text-sm text-neutral-500">Belum ada folder.</p>
                <?php endif; ?>
                <?php foreach ($topFolders as $f): ?>
                    <a href="manhwa.php?folder_id=<?= $f->id() ?>" class="flex items-center justify-between gap-3 border-b border-neutral-300 py-3 text-[15px] transition hover:text-brand">
                        <span class="truncate"><?= $e($f->name()) ?></span>
                        <span class="shrink-0 text-sm text-neutral-500"><?= $f->manhwaCount() ?> judul</span>
                    </a>
                <?php endforeach; ?>
            </div>
            <a href="folders.php" class="mt-5 inline-block text-sm font-bold text-brand hover:underline">Kelola folder (<?= (int)$folderCount ?>) →</a>
        </section>
    </aside>
</div>
