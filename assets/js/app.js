document.addEventListener('DOMContentLoaded', () => {
    // Konfirmasi sebelum hapus
    document.querySelectorAll('form[data-confirm]').forEach((form) => {
        form.addEventListener('submit', (event) => {
            if (!window.confirm(form.getAttribute('data-confirm') || 'Yakin ingin melanjutkan?')) {
                event.preventDefault();
            }
        });
    });

    // Carousel "Sedang dibaca"
    const carousel = document.querySelector('[data-carousel]');
    if (carousel) {
        const step = () => {
            const first = carousel.firstElementChild;
            return first ? first.getBoundingClientRect().width + 24 : 300;
        };
        document.querySelector('[data-carousel-prev]')?.addEventListener('click', () => carousel.scrollBy({ left: -step(), behavior: 'smooth' }));
        document.querySelector('[data-carousel-next]')?.addEventListener('click', () => carousel.scrollBy({ left: step(), behavior: 'smooth' }));
    }

    // Tombol cari di header
    const toggle = document.getElementById('searchToggle');
    const searchForm = document.getElementById('searchForm');
    if (toggle && searchForm) {
        toggle.addEventListener('click', () => {
            searchForm.classList.toggle('hidden');
            if (!searchForm.classList.contains('hidden')) searchForm.querySelector('input').focus();
        });
    }

    // Grid / List pada halaman koleksi
    const grid = document.querySelector('[data-collection-grid]');
    const buttons = document.querySelectorAll('[data-view]');
    if (grid && buttons.length) {
        let saved = 'grid';
        try { saved = localStorage.getItem('dailyscroll-view') || 'grid'; } catch (_) {}
        const apply = (view) => {
            grid.classList.toggle('list-view', view === 'list');
            buttons.forEach((b) => b.setAttribute('aria-pressed', String(b.dataset.view === view)));
            try { localStorage.setItem('dailyscroll-view', view); } catch (_) {}
        };
        buttons.forEach((b) => b.addEventListener('click', () => apply(b.dataset.view)));
        apply(saved === 'list' ? 'list' : 'grid');
    }
});
