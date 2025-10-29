// Show a specific page and update URL without reloading
function navigateTo(id) {
    // Hide all other sections
    document.querySelectorAll('.section').forEach(s => s.classList.remove('active'));

    const section = document.getElementById(id);
    if (section) {
        // Show only the selected section
        section.classList.add('active');

        if (location.hash !== `#${id}`) {
            history.pushState(null, '', `#${id}`);
        }

        hljs.highlightAll();
    }
}

function handleRoute() {
    const hash = location.hash.substring(1) || 'readme';
    navigateTo(hash);
}

window.addEventListener('DOMContentLoaded', handleRoute);
window.addEventListener('hashchange', handleRoute);
