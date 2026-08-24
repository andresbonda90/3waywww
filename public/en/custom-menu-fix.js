// Immediate Dark Mode State Check (Prevents theme flash on load)
(function() {
    var savedTheme = localStorage.getItem('3way_theme');
    if (savedTheme === 'dark' || (!savedTheme && window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark-mode');
    } else {
        document.documentElement.classList.remove('dark-mode');
    }
})();


