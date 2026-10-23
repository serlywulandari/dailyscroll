# DailyScroll.ini

Website perpustakaan manhwa pribadi berbasis PHP + MySQL, cocok untuk XAMPP.

## Persyaratan
- XAMPP (Apache dan MySQL)
- PHP 8.1+ disarankan
- MySQL/MariaDB

## Cara menjalankan
1. Ekstrak folder `dailyscroll` ke `C:\xampp\htdocs\dailyscroll` (Windows), atau folder `htdocs` milik XAMPP.
2. Buka XAMPP Control Panel, jalankan **Apache** dan **MySQL**.
3. Buka `http://localhost/phpmyadmin`.
4. Pilih tab **Import**, pilih file `database.sql` dari folder proyek, lalu klik **Import/Go**.
5. Jika username/password MySQL kamu berbeda, ubah bagian koneksi di `config.php`.
6. Buka `http://localhost/dailyscroll/`.

## File utama
- `database.sql`: membuat database dan tabel `folders` serta `manhwa`.
- `config.php`: koneksi PDO ke MySQL.
- `index.php`: dashboard dan ringkasan.
- `manhwa.php`: daftar, pencarian, dan filter.
- `manhwa_form.php`: tambah/edit manhwa.
- `detail.php`: detail dan aksi edit/hapus.
- `folders.php`: membuat, mengedit, dan melihat folder.
- `manhwa_delete.php`, `folder_delete.php`: proses penghapusan.
- `style.css`: desain responsif.
- `script.js`: konfirmasi hapus dan fallback cover.

## Catatan
- Ini starter project lokal, belum memiliki login pengguna. Jangan pasang ke internet publik tanpa menambahkan autentikasi, otorisasi, HTTPS, dan pengamanan deployment.
- `cover_url` menyimpan URL gambar; aplikasi tidak mengunggah file gambar ke server.
- `folder_id` boleh kosong. Jika folder dihapus, manhwa tetap ada dan hubungan foldernya dilepas.
