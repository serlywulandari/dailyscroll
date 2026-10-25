<?php
declare(strict_types=1);

namespace DailyScroll\Controllers;

use DailyScroll\Core\Csrf;
use DailyScroll\Core\Response;
use DailyScroll\Core\Session;

final class FolderController extends Controller
{
    /** folders.php : daftar + form buat/edit */
    public function index(): void
    {
        $editId = $this->request->queryInt('edit');
        $editing = $editId !== null ? $this->folders->find($editId) : null;
        $errors = [];
        $name = $editing ? $editing->name() : '';
        $description = $editing ? (string)$editing->description() : '';

        if ($this->request->isPost()) {
            Csrf::verify();
            $name = $this->request->post('name');
            $description = $this->request->post('description');
            $id = $this->request->postInt('id');

            if ($name === '') {
                $errors[] = 'Nama folder wajib diisi.';
            }
            if (mb_strlen($name) > 100) {
                $errors[] = 'Nama folder maksimal 100 karakter.';
            }

            if (!$errors) {
                $desc = $description !== '' ? $description : null;
                if ($id !== null) {
                    $this->folders->update($id, $name, $desc);
                    Session::flash('Folder berhasil diperbarui.');
                } else {
                    $this->folders->create($name, $desc);
                    Session::flash('Folder berhasil dibuat.');
                }
                Response::redirect('folders.php');
            }
            if ($id !== null && $editing === null) {
                $editing = $this->folders->find($id);
            }
        }

        $this->render('folders/index', [
            'pageTitle'   => 'Folder',
            'active'      => 'folders',
            'folders'     => $this->folders->allWithCount(),
            'editing'     => $editing,
            'errors'      => $errors,
            'name'        => $name,
            'description' => $description,
        ]);
    }

    /** folder_delete.php (POST) */
    public function delete(): void
    {
        if (!$this->request->isPost()) {
            Response::abort(405, 'Metode tidak diizinkan.');
        }
        Csrf::verify();
        $id = $this->request->postInt('id');
        if ($id === null) {
            Session::flash('ID folder tidak valid.', 'error');
        } elseif ($this->folders->delete($id)) {
            Session::flash('Folder dihapus. Manhwa terkait tetap tersimpan.');
        } else {
            Session::flash('Folder tidak ditemukan.', 'error');
        }
        Response::redirect('folders.php');
    }
}
