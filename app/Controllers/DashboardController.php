<?php
declare(strict_types=1);

namespace DailyScroll\Controllers;

use DailyScroll\Models\ManhwaStatus;

final class DashboardController extends Controller
{
    public function index(): void
    {
        $counts = $this->manhwa->countsByStatus();

        $this->render('dashboard/index', [
            'pageTitle'   => 'Dashboard',
            'active'      => 'dashboard',
            'counts'      => $counts,
            'reading'     => $this->manhwa->latest(8, ManhwaStatus::READING),
            'recent'      => $this->manhwa->latest(10),
            'topFolders'  => $this->folders->topWithCount(5),
            'folderCount' => $this->folders->count(),
        ]);
    }
}
