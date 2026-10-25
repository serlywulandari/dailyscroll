<?php /** @var DailyScroll\Models\Manhwa $item */ ?>
<div class="m-cover relative overflow-hidden <?= $e($item->tone()) ?> <?= $e($class ?? 'aspect-[3/4] w-full') ?>">
    <?php if ($item->hasCover()): ?>
        <img src="<?= $e($item->coverUrl()) ?>" alt="Cover <?= $e($item->title()) ?>" loading="lazy"
             class="h-full w-full object-contain"
             onerror="this.classList.add('hidden');this.nextElementSibling.classList.remove('hidden')">
    <?php endif; ?>
    <div class="<?= $item->hasCover() ? 'hidden ' : '' ?>absolute inset-0 grid place-items-center p-6">
        <img src="logo dailyscroll.jpg" alt="DailyScroll" class="max-h-full max-w-full rounded-2xl bg-white/70 object-contain p-3 opacity-90">
    </div>
</div>
