<?php
use DailyScroll\Core\Csrf;
use DailyScroll\Core\Format;
use DailyScroll\Models\ManhwaStatus;
/** @var DailyScroll\Models\Manhwa $m */
?>
<div class="grid gap-10 md:grid-cols-[260px_minmax(0,1fr)]">
    <aside>
        <?php $this->partial('partials/cover', ['item' => $m, 'class' => 'aspect-[3/4] w-full rounded-xl']); ?>
        <div class="mt-4 space-y-2">
            <a class="ds-btn ds-btn-primary w-full" href="manhwa_form.php?id=<?= $m->id() ?>">Edit manhwa</a>
            <form method="post" action="manhwa_delete.php" data-confirm="Yakin ingin menghapus manhwa ini?">
                <?= Csrf::field() ?>
                <input type="hidden" name="id" value="<?= $m->id() ?>">
                <button class="ds-btn ds-btn-danger w-full" type="submit">Hapus</button>
            </form>
        </div>
    </aside>

    <article class="min-w-0">
        <?php $this->partial('partials/section_tag', ['label' => 'Detail manhwa']); ?>
        <div class="mt-6">
            <span class="inline-block rounded-full px-3 py-1 text-xs font-bold <?= $e(ManhwaStatus::badgeClass($m->status())) ?>"><?= $e($m->statusLabel()) ?></span>
            <h1 class="mt-2 text-3xl font-bold leading-tight md:text-4xl"><?= $e($m->title()) ?></h1>
            <?php if ($m->alternativeTitle()): ?><p class="mt-1 text-neutral-500"><?= $e($m->alternativeTitle()) ?></p><?php endif; ?>
        </div>

        <dl class="mt-6 grid gap-4 rounded-xl bg-white p-5 shadow-sm sm:grid-cols-2">
            <div><dt class="text-xs text-neutral-500">Folder</dt><dd class="text-sm font-semibold"><?= $e($m->folderName()) ?></dd></div>
            <div><dt class="text-xs text-neutral-500">Author</dt><dd class="text-sm font-semibold"><?= $e($m->author() ?: 'Belum diisi') ?></dd></div>
            <div><dt class="text-xs text-neutral-500">Genre</dt><dd class="text-sm font-semibold"><?= $e($m->genre() ?: 'Belum diisi') ?></dd></div>
            <div><dt class="text-xs text-neutral-500">Progres</dt><dd class="text-sm font-semibold">Chapter <?= $m->currentChapter() ?><?= $m->totalChapters() !== null ? ' / ' . $m->totalChapters() : '' ?></dd></div>
            <div><dt class="text-xs text-neutral-500">Rating</dt><dd class="text-sm font-semibold"><?= $m->ratingText() !== null ? '★ ' . $e($m->ratingText()) . ' / 10' : 'Belum dinilai' ?></dd></div>
        </dl>

        <?php if ($m->progressPercent() !== null): ?>
            <div class="mt-4 h-2 overflow-hidden rounded-full bg-neutral-200"><span class="block h-full rounded-full bg-brand" style="width:<?= $m->progressPercent() ?>%"></span></div>
        <?php endif; ?>

        <section class="mt-8">
            <h2 class="text-lg font-bold">Sinopsis</h2>
            <p class="mt-2 whitespace-pre-wrap text-sm leading-7 text-neutral-600"><?= $e($m->synopsis() ?: 'Belum ada sinopsis.') ?></p>
        </section>
        <section class="mt-6">
            <h2 class="text-lg font-bold">Catatan pribadi</h2>
            <p class="mt-2 whitespace-pre-wrap text-sm leading-7 text-neutral-600"><?= $e($m->personalNotes() ?: 'Belum ada catatan.') ?></p>
        </section>
        <p class="mt-8 text-xs text-neutral-500">Terakhir diperbarui: <?= $e(Format::date($m->updatedAt())) ?></p>
    </article>
</div>
