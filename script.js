document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('form[data-confirm]').forEach((form) => {
        form.addEventListener('submit', (event) => {
            const message = form.getAttribute('data-confirm') || 'Yakin ingin melanjutkan?';
            if (!window.confirm(message)) event.preventDefault();
        });
    });

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
