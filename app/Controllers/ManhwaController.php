<?php
declare(strict_types=1);

namespace DailyScroll\Controllers;

use DailyScroll\Core\Csrf;
use DailyScroll\Core\Response;
use DailyScroll\Core\Session;
use DailyScroll\Models\ManhwaStatus;
use DailyScroll\Repositories\ManhwaRepository;
use DailyScroll\Validators\ManhwaValidator;

final class ManhwaController extends Controller
{
    private const ACTIVE_BY_STATUS = [
        ManhwaStatus::READING   => 'reading',
        ManhwaStatus::COMPLETED => 'completed',
        ManhwaStatus::PLAN      => 'plan',
    ];

    /** manhwa.php : daftar + pencarian + filter */
    public function index(): void
    {
        $status = $this->request->query('status');
        if (!ManhwaStatus::isValid($status)) {
            $status = '';
        }
        $sort = $this->request->query('sort', 'updated');
        if (!isset(ManhwaRepository::SORTS[$sort])) {
            $sort = 'updated';
        }
        $filters = [
            'q'         => $this->request->query('q'),
            'status'    => $status,
            'folder_id' => $this->request->queryInt('folder_id'),
            'notes'     => $this->request->query('notes') === '1',
            'sort'      => $sort,
        ];

        $heading = 'Koleksi';
        if ($status !== '') {
            $heading = ManhwaStatus::label($status);
        } elseif ($filters['notes']) {
            $heading = 'Catatan pribadi';
        } elseif ($filters['folder_id']) {
            $folder = $this->folders->find($filters['folder_id']);
            $heading = $folder ? 'Folder: ' . $folder->name() : $heading;
        }

        $this->render('manhwa/index', [
            'pageTitle' => $heading,
            'heading'   => $heading,
            'active'    => self::ACTIVE_BY_STATUS[$status] ?? 'collection',
            'items'     => $this->manhwa->search($filters),
            'folders'   => $this->folders->all(),
            'filters'   => $filters,
        ]);
    }

    /** detail.php?id= */
    public function show(): void
    {
        $id = $this->request->queryInt('id');
        if ($id === null) {
            Response::abort(400, 'ID manhwa tidak valid.');
        }
        $item = $this->manhwa->find($id);
        if ($item === null) {
            Response::abort(404, 'Manhwa tidak ditemukan.');
        }

        $this->render('manhwa/show', [
            'pageTitle' => $item->title(),
            'active'    => 'collection',
            'm'         => $item,
        ]);
    }

    /** manhwa_form.php[?id=] : tambah / edit */
    public function form(): void
    {
        $id = $this->request->queryInt('id');
        $isEdit = $id !== null;
        $form = self::emptyForm();
        $errors = [];

        if ($isEdit) {
            $existing = $this->manhwa->find($id);
            if ($existing === null) {
                Response::abort(404, 'Manhwa tidak ditemukan.');
            }
            $form = $existing->toFormArray();
        }

        if ($this->request->isPost()) {
            Csrf::verify();
            $validator = new ManhwaValidator($this->folders);
            $valid = $validator->validate($this->request->allPost());
            $form = $validator->formData();
            $errors = $validator->errors();

            if ($valid) {
                if ($isEdit) {
                    $this->manhwa->update($id, $validator->dbData());
                    Session::flash('Data manhwa berhasil diperbarui.');
                } else {
                    $this->manhwa->create($validator->dbData());
                    Session::flash('Manhwa berhasil ditambahkan.');
                }
                Response::redirect('manhwa.php');
            }
        }

        $this->render('manhwa/form', [
            'pageTitle' => $isEdit ? 'Edit Manhwa' : 'Tambah Manhwa',
            'active'    => $isEdit ? 'collection' : 'add',
            'isEdit'    => $isEdit,
            'editId'    => $id,
            'form'      => $form,
            'errors'    => $errors,
            'folders'   => $this->folders->all(),
        ]);
    }

    /** manhwa_delete.php (POST) */
    public function delete(): void
    {
        if (!$this->request->isPost()) {
            Response::abort(405, 'Metode tidak diizinkan.');
        }
        Csrf::verify();
        $id = $this->request->postInt('id');
        if ($id === null) {
            Session::flash('ID manhwa tidak valid.', 'error');
        } elseif ($this->manhwa->delete($id)) {
            Session::flash('Manhwa berhasil dihapus.');
        } else {
            Session::flash('Manhwa tidak ditemukan.', 'error');
        }
        Response::redirect('manhwa.php');
    }

    private static function emptyForm(): array
    {
        return [
            'folder_id' => '', 'title' => '', 'alternative_title' => '', 'synopsis' => '',
            'genre' => '', 'author' => '', 'status' => ManhwaStatus::PLAN, 'current_chapter' => '0',
            'total_chapters' => '', 'rating' => '', 'cover_url' => '', 'personal_notes' => '',
        ];
    }
}
