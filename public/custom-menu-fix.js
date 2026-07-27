document.addEventListener('DOMContentLoaded', function() {
    var toggles = document.querySelectorAll('.elementor-menu-toggle');
    toggles.forEach(function(toggle) {
        toggle.addEventListener('click', function() {
            var isExpanded = this.getAttribute('aria-expanded') === 'true';
            this.setAttribute('aria-expanded', !isExpanded);
            this.classList.toggle('elementor-active');
            var nav = this.nextElementSibling;
            if (nav && nav.classList.contains('elementor-nav-menu__container')) {
                nav.style.display = isExpanded ? 'none' : 'block';
            }
        });
    });
    var parentItems = document.querySelectorAll('.elementor-nav-menu--dropdown .menu-item-has-children');
    parentItems.forEach(function(item) {
        var link = item.querySelector('a');
        if (link) {
            link.addEventListener('click', function(e) {
                if (window.innerWidth <= 1024) {
                    e.preventDefault();
                    item.classList.toggle('mobile-expanded');
                }
            });
        }
    });
});