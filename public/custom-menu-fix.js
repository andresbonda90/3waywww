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
    // Initialize Swiper for Hero Sliders
    if (typeof Swiper !== 'undefined') {
        var heroSwipers = document.querySelectorAll('.elementor-slides-wrapper');
        heroSwipers.forEach(function(el) {
            new Swiper(el, {
                loop: true,
                autoplay: { delay: 5000, disableOnInteraction: false },
                effect: 'slide',
                speed: 500,
                navigation: {
                    nextEl: el.querySelector('.elementor-swiper-button-next'),
                    prevEl: el.querySelector('.elementor-swiper-button-prev'),
                },
                pagination: {
                    el: el.querySelector('.swiper-pagination'),
                    clickable: true,
                },
            });
        });

        // Initialize Swiper for Image Carousels (Clients)
        var clientSwipers = document.querySelectorAll('.elementor-image-carousel-wrapper');
        clientSwipers.forEach(function(el) {
            new Swiper(el, {
                loop: true,
                slidesPerView: 2,
                spaceBetween: 10,
                autoplay: { delay: 3000, disableOnInteraction: false },
                breakpoints: {
                    768: { slidesPerView: 4, spaceBetween: 20 },
                    1024: { slidesPerView: 6, spaceBetween: 30 }
                }
            });
        });
    }
    });
    // Initialize Swiper for Hero Sliders
    if (typeof Swiper !== 'undefined') {
        var heroSwipers = document.querySelectorAll('.elementor-slides-wrapper');
        heroSwipers.forEach(function(el) {
            new Swiper(el, {
                loop: true,
                autoplay: { delay: 5000, disableOnInteraction: false },
                effect: 'slide',
                speed: 500,
                navigation: {
                    nextEl: el.querySelector('.elementor-swiper-button-next'),
                    prevEl: el.querySelector('.elementor-swiper-button-prev'),
                },
                pagination: {
                    el: el.querySelector('.swiper-pagination'),
                    clickable: true,
                },
            });
        });

        // Initialize Swiper for Image Carousels (Clients)
        var clientSwipers = document.querySelectorAll('.elementor-image-carousel-wrapper');
        clientSwipers.forEach(function(el) {
            new Swiper(el, {
                loop: true,
                slidesPerView: 2,
                spaceBetween: 10,
                autoplay: { delay: 3000, disableOnInteraction: false },
                breakpoints: {
                    768: { slidesPerView: 4, spaceBetween: 20 },
                    1024: { slidesPerView: 6, spaceBetween: 30 }
                }
            });
        });
    }
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
    // Initialize Swiper for Hero Sliders
    if (typeof Swiper !== 'undefined') {
        var heroSwipers = document.querySelectorAll('.elementor-slides-wrapper');
        heroSwipers.forEach(function(el) {
            new Swiper(el, {
                loop: true,
                autoplay: { delay: 5000, disableOnInteraction: false },
                effect: 'slide',
                speed: 500,
                navigation: {
                    nextEl: el.querySelector('.elementor-swiper-button-next'),
                    prevEl: el.querySelector('.elementor-swiper-button-prev'),
                },
                pagination: {
                    el: el.querySelector('.swiper-pagination'),
                    clickable: true,
                },
            });
        });

        // Initialize Swiper for Image Carousels (Clients)
        var clientSwipers = document.querySelectorAll('.elementor-image-carousel-wrapper');
        clientSwipers.forEach(function(el) {
            new Swiper(el, {
                loop: true,
                slidesPerView: 2,
                spaceBetween: 10,
                autoplay: { delay: 3000, disableOnInteraction: false },
                breakpoints: {
                    768: { slidesPerView: 4, spaceBetween: 20 },
                    1024: { slidesPerView: 6, spaceBetween: 30 }
                }
            });
        });
    }
        }
    });
    // Initialize Swiper for Hero Sliders
    if (typeof Swiper !== 'undefined') {
        var heroSwipers = document.querySelectorAll('.elementor-slides-wrapper');
        heroSwipers.forEach(function(el) {
            new Swiper(el, {
                loop: true,
                autoplay: { delay: 5000, disableOnInteraction: false },
                effect: 'slide',
                speed: 500,
                navigation: {
                    nextEl: el.querySelector('.elementor-swiper-button-next'),
                    prevEl: el.querySelector('.elementor-swiper-button-prev'),
                },
                pagination: {
                    el: el.querySelector('.swiper-pagination'),
                    clickable: true,
                },
            });
        });

        // Initialize Swiper for Image Carousels (Clients)
        var clientSwipers = document.querySelectorAll('.elementor-image-carousel-wrapper');
        clientSwipers.forEach(function(el) {
            new Swiper(el, {
                loop: true,
                slidesPerView: 2,
                spaceBetween: 10,
                autoplay: { delay: 3000, disableOnInteraction: false },
                breakpoints: {
                    768: { slidesPerView: 4, spaceBetween: 20 },
                    1024: { slidesPerView: 6, spaceBetween: 30 }
                }
            });
        });
    }
});
    // Initialize Swiper for Hero Sliders
    if (typeof Swiper !== 'undefined') {
        var heroSwipers = document.querySelectorAll('.elementor-slides-wrapper');
        heroSwipers.forEach(function(el) {
            new Swiper(el, {
                loop: true,
                autoplay: { delay: 5000, disableOnInteraction: false },
                effect: 'slide',
                speed: 500,
                navigation: {
                    nextEl: el.querySelector('.elementor-swiper-button-next'),
                    prevEl: el.querySelector('.elementor-swiper-button-prev'),
                },
                pagination: {
                    el: el.querySelector('.swiper-pagination'),
                    clickable: true,
                },
            });
        });

        // Initialize Swiper for Image Carousels (Clients)
        var clientSwipers = document.querySelectorAll('.elementor-image-carousel-wrapper');
        clientSwipers.forEach(function(el) {
            new Swiper(el, {
                loop: true,
                slidesPerView: 2,
                spaceBetween: 10,
                autoplay: { delay: 3000, disableOnInteraction: false },
                breakpoints: {
                    768: { slidesPerView: 4, spaceBetween: 20 },
                    1024: { slidesPerView: 6, spaceBetween: 30 }
                }
            });
        });
    }