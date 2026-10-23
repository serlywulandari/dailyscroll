<?php
require_once 'config.php';
require_once 'functions.php';
if ($_SERVER['REQUEST_METHOD'] !== 'POST') { http_response_code(405); exit('Metode tidak diizinkan.'); }
verify_csrf();
$id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT);
if (!$id || $id < 1) { flash('ID manhwa tidak valid.', 'error'); redirect('manhwa.php'); }
$stmt = $pdo->prepare('DELETE FROM manhwa WHERE id = ?');
$stmt->execute([$id]);
flash($stmt->rowCount() ? 'Manhwa berhasil dihapus.' : 'Manhwa tidak ditemukan.', $stmt->rowCount() ? 'success' : 'error');
redirect('manhwa.php');
