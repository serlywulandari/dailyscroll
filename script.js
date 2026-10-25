document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('form[data-confirm]').forEach((form) => {
        form.addEventListener('submit', (event) => {
            const message = form.getAttribute('data-confirm') || 'Yakin ingin melanjutkan?';
            if (!window.confirm(message)) event.preventDefault();
        });
    });

    const collectionGrid = document.querySelector('[data-collection-grid]');
    const viewButtons = document.querySelectorAll('[data-view]');
    if (collectionGrid && viewButtons.length) {
        let savedView = 'grid';
        try { savedView = localStorage.getItem('dailyscroll-view') || 'grid'; } catch (_) {}
        const applyView = (view) => {
            collectionGrid.classList.toggle('list-view', view === 'list');
            viewButtons.forEach((button) => button.setAttribute('aria-pressed', String(button.dataset.view === view)));
            try { localStorage.setItem('dailyscroll-view', view); } catch (_) {}
        };
        viewButtons.forEach((button) => button.addEventListener('click', () => applyView(button.dataset.view)));
        applyView(savedView === 'list' ? 'list' : 'grid');
    }

    document.querySelectorAll('img.cover, img.detail-cover').forEach((img) => {
        img.addEventListener('error', () => {
            img.style.display = 'none';
            const placeholder = document.createElement('div');
            placeholder.className = 'cover cover-placeholder';
            placeholder.innerHTML = '<span>DS</span><small>NO COVER</small>';
            img.parentNode.insertBefore(placeholder, img.nextSibling);
        }, { once: true });
    });
});
