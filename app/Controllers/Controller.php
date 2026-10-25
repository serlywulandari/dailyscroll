<?php
declare(strict_types=1);

namespace DailyScroll\Controllers;

use DailyScroll\Core\Database;
use DailyScroll\Core\Request;
use DailyScroll\Core\View;
use DailyScroll\Repositories\FolderRepository;
use DailyScroll\Repositories\ManhwaRepository;

/**
 * Controller dasar: menyediakan request, view, dan repository.
 */
abstract class Controller
{
    protected Request $request;
    protected View $view;
    protected ManhwaRepository $manhwa;
    protected FolderRepository $folders;

    public function __construct()
    {
        $db = Database::getInstance();
        $this->request = new Request();
        $this->view    = new View();
        $this->manhwa  = new ManhwaRepository($db);
        $this->folders = new FolderRepository($db);
    }

    protected function render(string $template, array $data = []): void
    {
        $this->view->render($template, $data);
    }
}
