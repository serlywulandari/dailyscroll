<?php
$pageTitle = $pageTitle ?? 'DailyScroll.ini';
$flashMessage = get_flash();
?>
<!doctype html>
<html lang="id">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= e($pageTitle) ?> · DailyScroll.ini</title>
    <link rel="stylesheet" href="style.css">
    <script src="script.js" defer></script>
</head>
<body>
<header class="topbar">
    <a class="brand" href="index.php"><span class="brand-mark">DS</span><span>DailyScroll<span class="accent">.ini</span></span></a>
    <nav>
        <a href="index.php">Dashboard</a>
        <a href="manhwa.php">Manhwa</a>
        <a href="folders.php">Folder</a>
        <a class="nav-cta" href="manhwa_form.php">+ Tambah</a>
    </nav>
</header>
<main class="container">
<?php if ($flashMessage): ?>
    <div class="alert <?= e($flashMessage['type']) ?>"><?= e($flashMessage['message']) ?></div>
<?php endif; ?>
