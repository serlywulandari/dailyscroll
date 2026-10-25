<?php
$active = $active ?? '';
$pageTitle = $pageTitle ?? 'DailyScroll';
$subnav = [
    ['dashboard', 'Dashboard',     'index.php'],
    ['collection', 'Koleksi',      'manhwa.php'],
    ['reading',   'Sedang dibaca', 'manhwa.php?status=Reading'],
    ['completed', 'Selesai',       'manhwa.php?status=Completed'],
    ['plan',      'Ingin dibaca',  'manhwa.php?status=Plan+to+Read'],
    ['folders',   'Folder',        'folders.php'],
];
?>
<!doctype html>
<html lang="id">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= $e($pageTitle) ?> · DailyScroll</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        brand: {
                            DEFAULT: '#bf0000',
                            dark: '#8a0000'
                        }
                    },
                    fontFamily: {
                        sans: ['Poppins', 'ui-sans-serif', 'system-ui', 'sans-serif']
                    }
                }
            }
        };
    </script>
    <link rel="stylesheet" href="assets/css/app.css">
    <script src="assets/js/app.js" defer></script>
</head>

<body class="min-h-screen font-sans text-neutral-900 antialiased">

    <header class="bg-brand text-white">
        <div class="mx-auto flex h-[88px] max-w-[1224px] items-center justify-between gap-4 px-5 md:h-[122px]">
            <div class="flex items-center gap-10">
                <a href="index.php" class="flex items-center gap-3">
                    <img src="logo dailyscroll.jpg" alt="Logo DailyScroll" class="h-11 w-11 rounded-xl bg-white object-contain p-1 md:h-12 md:w-12">
                    <span class="text-xl font-extrabold tracking-tight md:text-[26px]">DailyScroll</span>
                </a>
                <nav class="hidden items-center gap-7 text-[15px] font-semibold md:flex">
                    <a href="manhwa.php" class="hover:underline">Koleksi</a>
                    <a href="folders.php" class="hover:underline">Folder</a>
                    <a href="manhwa.php?notes=1" class="hover:underline">Catatan</a>
                </nav>
            </div>
            <div class="flex items-center gap-4">
                <form id="searchForm" action="manhwa.php" method="get" class="hidden">
                    <input type="search" name="q" autocomplete="off" placeholder="Cari judul, author, genre..."
                        class="w-44 rounded-full border-0 px-4 py-2.5 text-sm text-neutral-900 outline-none sm:w-64">
                </form>
                <button id="searchToggle" type="button" aria-label="Cari" class="grid h-11 w-11 place-items-center rounded-full bg-white text-brand">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round">
                        <circle cx="11" cy="11" r="7" />
                        <path d="m20 20-4-4" />
                    </svg>
                </button>
                <a href="manhwa.php#filter" class="hidden text-[15px] font-semibold hover:underline sm:inline">Filter lanjutan</a>
            </div>
        </div>
    </header>

    <div class="border-b border-neutral-200 bg-white">
        <div class="mx-auto flex h-14 max-w-[1224px] items-center justify-between gap-4 px-5">
            <nav class="no-scrollbar flex gap-7 overflow-x-auto whitespace-nowrap text-[13px] font-semibold uppercase tracking-wide">
                <?php foreach ($subnav as [$key, $label, $href]): ?>
                    <a href="<?= $e($href) ?>" class="py-4 <?= $active === $key ? 'border-b-2 border-brand text-brand' : 'border-b-2 border-transparent text-neutral-700 hover:text-brand' ?>"><?= $e($label) ?></a>
                <?php endforeach; ?>
            </nav>
            <a href="manhwa_form.php" class="shrink-0 rounded-full border-2 border-neutral-900 px-5 py-1.5 text-sm font-semibold transition hover:bg-neutral-900 hover:text-white">Tambah manhwa</a>
        </div>
    </div>

    <main class="mx-auto max-w-[1200px] px-5 py-10">
        <?php if (!empty($flash)): ?>
            <div class="mb-6 rounded-lg px-4 py-3 text-sm font-medium <?= ($flash['type'] ?? '') === 'error' ? 'bg-red-100 text-red-800' : 'bg-emerald-100 text-emerald-800' ?>"><?= $e($flash['message']) ?></div>
        <?php endif; ?>
        <?= $content ?>
    </main>

    <footer class="py-8 text-center text-xs text-neutral-500">DailyScroll <span class="px-1 text-brand">·</span> perpustakaan manhwa pribadimu</footer>
</body>

</html>