# DailyScroll

Website pengelola koleksi dan jurnal manhwa pribadi berbasis PHP + MySQL. Website ini mencatat data dan progres secara manual; bukan platform untuk membaca chapter.

## Persyaratan
- XAMPP (Apache dan MySQL)
- PHP 8.1+ disarankan
- MySQL/MariaDB

## Cara menjalankan
1. Ekstrak folder `dailyscroll` ke `C:\xampp\htdocs\dailyscroll` (Windows), atau folder `htdocs` milik XAMPP.
2. Buka XAMPP Control Panel, jalankan **Apache** dan **MySQL**.
3. Buka `http://localhost/phpmyadmin`.
4. Pilih tab **Import**, pilih file `dailyscroll.sql` dari folder proyek, lalu klik **Import/Go**.
5. Jika username/password MySQL kamu berbeda, ubah bagian koneksi di `config.php`.
6. Buka `http://localhost/dailyscroll/`.

## Struktur (OOP + MVC ringan)
- `index.php`, `manhwa.php`, `detail.php`, `manhwa_form.php`, `folders.php`, `*_delete.php`: pintu masuk tipis, hanya memanggil controller.
- `config.php`: pengaturan database.
- `app/Core/`: `Database` (PDO singleton), `Session`, `Csrf`, `Request`, `Response`, `View`, `Format`.
- `app/Models/`: entitas `Manhwa`, `Folder`, dan `ManhwaStatus`.
- `app/Repositories/`: `ManhwaRepository`, `FolderRepository` (semua query SQL).
- `app/Validators/ManhwaValidator.php`: validasi input form.
- `app/Controllers/`: `DashboardController`, `ManhwaController`, `FolderController`.
- `views/`: template tampilan (Tailwind CSS) beserta `layouts/` dan `partials/`.
- `assets/`: `css/app.css` (komponen kecil) dan `js/app.js` (carousel, cari, grid/list, konfirmasi hapus).
- `dailyscroll.sql`: database dan tabel `folders` serta `manhwa`.

## Catatan
- Tailwind CSS dan font Poppins dimuat lewat CDN, jadi butuh koneksi internet saat membuka web.
- Kode kompatibel dengan PHP 8.0 ke atas.
