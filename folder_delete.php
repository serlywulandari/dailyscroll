<?php
require_once 'config.php';
require_once 'functions.php';
if ($_SERVER['REQUEST_METHOD'] !== 'POST') { http_response_code(405); exit('Metode tidak diizinkan.'); }
verify_csrf();
$id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT);
if (!$id || $id < 1) { flash('ID folder tidak valid.', 'error'); redirect('folders.php'); }
$stmt = $pdo->prepare('DELETE FROM folders WHERE id=?');
$stmt->execute([$id]);
flash($stmt->rowCount() ? 'Folder dihapus. Manhwa terkait tetap tersimpan.' : 'Folder tidak ditemukan.', $stmt->rowCount() ? 'success' : 'error');
redirect('folders.php');
