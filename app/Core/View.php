<?php
declare(strict_types=1);

namespace DailyScroll\Core;

/**
 * Render template PHP dari folder /views dengan layout.
 * Di dalam template tersedia: $this (View) dan $e() untuk escape HTML.
 */
final class View
{
    private string $basePath;

    public function __construct()
    {
        $this->basePath = BASE_PATH . '/views';
    }

    public function render(string $template, array $data = [], string $layout = 'layouts/main'): void
    {
        $content = $this->capture($template, $data);
        echo $this->capture($layout, $data + ['content' => $content, 'flash' => Session::pullFlash()]);
    }

    public function partial(string $template, array $data = []): void
    {
        echo $this->capture($template, $data);
    }

    public function e(mixed $value): string
    {
        return htmlspecialchars((string)($value ?? ''), ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
    }

    private function capture(string $__template, array $__data): string
    {
        $e = fn($value): string => $this->e($value);
        extract($__data, EXTR_SKIP);
        ob_start();
        include $this->basePath . '/' . $__template . '.php';
        return (string)ob_get_clean();
    }
}
