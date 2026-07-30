// Immediate Dark Mode State Check (Prevents theme flash on load)
(function() {
    var savedTheme = localStorage.getItem('3way_theme');
    if (savedTheme === 'dark' || (!savedTheme && window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark-mode');
    } else {
        document.documentElement.classList.remove('dark-mode');
    }
})();

document.addEventListener('DOMContentLoaded', function() {
    // Sync body class with documentElement class
    if (document.documentElement.classList.contains('dark-mode')) {
        document.body.classList.add('dark-mode');
    }

    // 1. Mobile Menu Toggle Fix
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

    // 2. Initialize Swipers (once)
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

        var clientSwipers = document.querySelectorAll('.elementor-image-carousel-wrapper');
        clientSwipers.forEach(function(el) {
            new Swiper(el, {
                loop: true,
                slidesPerView: 2,
                spaceBetween: 20,
                speed: 1000,
                autoplay: {
                    delay: 3500,
                    disableOnInteraction: false,
                    pauseOnMouseEnter: true
                },
                breakpoints: {
                    768: { slidesPerView: 4, spaceBetween: 30 },
                    1024: { slidesPerView: 6, spaceBetween: 40 }
                }
            });
        });
    }

    // 3. Search Index of all 3Way Solutions tools & features
    var SITE_SEARCH_INDEX = [
        { title: "Logging", category: "Producto", url: "/logging/", keywords: "logging grabacion auditoria tv radio contenido monitoreo almacenamiento", desc: "Grabación para auditoría y gestión inteligente de contenidos de Radio y TV." },
        { title: "Clipping", category: "Producto", url: "/clipping/", keywords: "clipping edicion clips extraccion noticias recortes radio tv video", desc: "Software de grabación de Radio y TV para extracción de clips y creación de contenidos." },
        { title: "Multiviewer", category: "Producto", url: "/multiviewer/", keywords: "multiviewer mosaico pantallas alarmas qoe qos canales monitoreo video", desc: "Visualización de múltiples señales de Radio y TV en una o varias pantallas con alarmas." },
        { title: "Cableoperador / Cable TV", category: "Producto", url: "/cableoperador/", keywords: "cableoperador cable tv barrido canales monitoreo senales 150 streaming", desc: "Monitoree más de 150 señales con sistema de barrido automático de canales." },
        { title: "Catalog (ViDeus MAM)", category: "Producto", url: "/catalog/", keywords: "catalog mam videus catalogacion ia metadatos gestion archivos busqueda", desc: "Sistema MAM local que combina catalogación tradicional con inteligencia artificial on-premise." },
        { title: "Plataformas OTT / Streaming", category: "Producto", url: "/plataformas/", keywords: "plataformas ott streaming drm transmisiones en vivo sin hardware directo", desc: "Grabación y monitoreo de señales OTT en vivo directamente desde plataformas sin hardware." },
        
        { title: "LLM (Modelos de Lenguaje)", category: "IA", url: "/llm/", keywords: "llm lenguaje inteligencia artificial resumenes transcripcion chat ai preguntas respuestas", desc: "Modelos de Lenguaje Inteligentes para análisis y generación de resúmenes de video/audio." },
        { title: "Speech to Text", category: "IA", url: "/transcripcion-automatica/", keywords: "speech to text transcripcion automatica voz audio subtitulos inteligencia artificial dictado", desc: "Transcripción automática de audio a texto con IA para programas de TV y Radio." },
        { title: "Reconocimiento Facial", category: "IA", url: "/reconocimiento-facial/", keywords: "reconocimiento facial personas famosos rostros cara identificacion ia actores politicos", desc: "Identificación automática de personas, famosos y figuras políticas en transmisiones." },
        { title: "Reconocimiento de Logos", category: "IA", url: "/reconocimiento-de-logos/", keywords: "reconocimiento logos marcas auspiciantes publicidad auditoria ia marcas sponsors", desc: "Detección y auditoría de marcas y auspiciantes en video en tiempo real." },
        { title: "Comparación de Contenido", category: "IA", url: "/comparacion-contenido/", keywords: "comparacion contenido duplicados coincidencias matching ia video audio", desc: "Verificación automática de coincidencia de contenido entre transmisiones." },
        { title: "Audio & Video Fingerprint", category: "IA", url: "/audio-video-fingerprint/", keywords: "audio video fingerprint huella digital copyright derechos autor ia coincidencias", desc: "Huella digital de audio y video para detección de coincidencias y derechos." },
        { title: "Detección de Desnudos", category: "IA", url: "/deteccion-desnudos/", keywords: "deteccion desnudos contenido explicito moderacion filtro censura ia clasificacion", desc: "Filtro e identificación de contenido explícito para moderación y clasificación." },
        { title: "Detección de Objetos", category: "IA", url: "/deteccion-objetos/", keywords: "deteccion objetos vision artificial imagenes streaming ia analisis", desc: "Clasificación e identificación visual de objetos en imágenes y streams de video." },
        { title: "Auto Highlight", category: "IA", url: "/creacion-automatica-de-highlights/", keywords: "auto highlight resumenes momentos destacados deportes goles noticias ia automatizacion", desc: "Generación instantánea de resúmenes y momentos destacados mediante IA." },
        { title: "CG OCR (Texto en Pantalla)", category: "IA", url: "/reconocimiento-de-texto-sobre-imagenes/", keywords: "cg ocr zocalo texto imagenes zocalos caracteres lectura pantalla ia impreso", desc: "Extracción e indexación de texto zócalo en pantalla y gráficos." },

        { title: "File Mover", category: "Módulo", url: "/automatizacion-flujos-archivos-media/", keywords: "file mover automatizacion flujos archivos transferencia media mover copiar", desc: "Movimiento y procesamiento automático de archivos de medios." },
        { title: "Centralización de Sistemas", category: "Módulo", url: "/centralizacion-de-sistemas/", keywords: "centralizacion sistemas gestion unificada servidores redundancia nodos red", desc: "Gestión unificada de múltiples equipamientos y servidores de grabación." },
        { title: "Analizador QoE QoS", category: "Módulo", url: "/analizador-qoe-qos/", keywords: "analizador qoe qos calidad experiencia senal broadcast alarmas calidad", desc: "Análisis de calidad de experiencia y señal broadcast en tiempo real." },
        { title: "Asrunlog & SCTE-35 / SCTE-104", category: "Módulo", url: "/scte35-scte104-y-asrunlog/", keywords: "asrunlog scte-35 scte-104 pauta comercial insercion publicidad marcadores", desc: "Auditoría de pauta comercial, inserción de publicidad y metadatos SCTE." },
        { title: "Closed Caption y Subtítulos", category: "Módulo", url: "/closed-caption-y-subtitulos/", keywords: "closed caption subtitulos cc transcripcion accesibilidad 608 708", desc: "Captura, extracción y generación de subtítulos CC." },
        { title: "Hotfolders", category: "Módulo", url: "/hotfolders/", keywords: "hotfolders carpetas calientes procesamiento automatico vigilante vigilar", desc: "Monitoreo automático de carpetas calientes para procesamiento de archivos." },

        { title: "Calculador de Almacenamiento", category: "Herramienta", url: "/calculador-de-almacenamiento/", keywords: "calculador almacenamiento disco espacio gigabytes terabytes bitrate horas dias calcular", desc: "Herramienta interactiva para calcular espacio en disco necesario para grabación de canales." },
        { title: "Casos de Éxito", category: "Empresa", url: "/casos-exito-broadcast/", keywords: "casos exito clientes disney artear blu radio arsat tigo sports historia clientes", desc: "Historias de clientes y proyectos implementados en todo el mundo." },
        { title: "Blog de Tecnología", category: "Empresa", url: "/blogdetecnologia/", keywords: "blog tecnologia noticias articulos broadcasting novedades publicaciones", desc: "Artículos técnicos e innovaciones en tecnología audiovisual." },
        { title: "Empresa / Quiénes somos", category: "Empresa", url: "/empresa-tecnologia-broadcast/", keywords: "empresa quienes somos historia trayectoria 3way solutions equipo", desc: "Más de 20 años de experiencia brindando soluciones broadcast." },
        { title: "Contacto", category: "Contacto", url: "/empresa/#contacto", keywords: "contacto soporte ventas cotizacion email telefono atencion comercial", desc: "Comunícate con nuestro equipo comercial y técnico." }
    ];

    function normalizeText(str) {
        return (str || "").toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");
    }

    function searchTools(query) {
        var cleanQuery = normalizeText(query).trim();
        if (!cleanQuery) return [];

        var queryWords = cleanQuery.split(/\s+/);

        var results = [];
        SITE_SEARCH_INDEX.forEach(function(item) {
            var normTitle = normalizeText(item.title);
            var normCat = normalizeText(item.category);
            var normKw = normalizeText(item.keywords);
            var normDesc = normalizeText(item.desc);

            var fullText = normTitle + " " + normCat + " " + normKw + " " + normDesc;

            var matchScore = 0;

            if (normTitle === cleanQuery) {
                matchScore += 100;
            } else if (normTitle.indexOf(cleanQuery) === 0) {
                matchScore += 70;
            } else if (normTitle.indexOf(cleanQuery) !== -1) {
                matchScore += 50;
            }

            var allWordsMatch = true;
            queryWords.forEach(function(word) {
                if (fullText.indexOf(word) !== -1) {
                    matchScore += 15;
                } else {
                    allWordsMatch = false;
                }
            });

            if (matchScore > 0 && allWordsMatch) {
                results.push({ item: item, score: matchScore });
            }
        });

        results.sort(function(a, b) { return b.score - a.score; });
        return results.map(function(r) { return r.item; });
    }

    // 4. Attach Live Autocomplete to any search form
    function setupLiveSearchForm(form) {
        if (form.dataset.liveSearchSetup) return;
        form.dataset.liveSearchSetup = "true";

        var input = form.querySelector('.nav-search-input');
        if (!input) return;

        var dropdown = document.createElement('div');
        dropdown.className = 'nav-search-results-dropdown';
        form.appendChild(dropdown);

        var selectedIndex = -1;

        function renderResults(query) {
            var matches = searchTools(query);
            dropdown.innerHTML = '';
            selectedIndex = -1;

            if (matches.length === 0) {
                if (query.trim().length > 0) {
                    dropdown.innerHTML = `
                        <div class="nav-search-no-results">
                            Sin resultados para "<strong>${escapeHtml(query)}</strong>"
                        </div>
                    `;
                    dropdown.classList.add('visible');
                } else {
                    dropdown.classList.remove('visible');
                }
                return;
            }

            matches.slice(0, 5).forEach(function(item) {
                var a = document.createElement('a');
                a.className = 'nav-search-item';
                a.href = item.url;

                a.innerHTML = `
                    <div class="nav-search-item-left">
                        <span class="nav-search-item-title">${escapeHtml(item.title)}</span>
                        <span class="nav-search-item-desc">${escapeHtml(item.desc)}</span>
                    </div>
                    <span class="nav-search-item-category">${escapeHtml(item.category)}</span>
                `;

                a.addEventListener('click', function(e) {
                    window.location.href = item.url;
                });

                dropdown.appendChild(a);
            });

            dropdown.classList.add('visible');
        }

        function escapeHtml(text) {
            return (text || '').replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
        }

        input.addEventListener('input', function() {
            renderResults(this.value);
        });

        input.addEventListener('focus', function() {
            if (this.value.trim()) {
                renderResults(this.value);
            }
        });

        input.addEventListener('keydown', function(e) {
            var items = dropdown.querySelectorAll('.nav-search-item');
            if (!dropdown.classList.contains('visible') || items.length === 0) return;

            if (e.key === 'ArrowDown') {
                e.preventDefault();
                selectedIndex = (selectedIndex + 1) % items.length;
                updateSelection(items);
            } else if (e.key === 'ArrowUp') {
                e.preventDefault();
                selectedIndex = (selectedIndex - 1 + items.length) % items.length;
                updateSelection(items);
            } else if (e.key === 'Enter') {
                if (selectedIndex >= 0 && items[selectedIndex]) {
                    e.preventDefault();
                    items[selectedIndex].click();
                } else if (items.length > 0) {
                    e.preventDefault();
                    items[0].click();
                }
            } else if (e.key === 'Escape') {
                dropdown.classList.remove('visible');
            }
        });

        function updateSelection(items) {
            items.forEach(function(el, i) {
                if (i === selectedIndex) {
                    el.classList.add('active');
                    el.scrollIntoView({ block: 'nearest' });
                } else {
                    el.classList.remove('active');
                }
            });
        }

        form.addEventListener('submit', function(e) {
            e.preventDefault();
            var matches = searchTools(input.value);
            if (matches.length > 0) {
                window.location.href = matches[0].url;
            } else {
                window.location.href = '/catalog/';
            }
        });

        document.addEventListener('click', function(e) {
            if (!form.contains(e.target)) {
                dropdown.classList.remove('visible');
            }
        });
    }

    // 5. Inject & Setup Search Form everywhere
    function ensureHeaderSearchBar() {
        var desktopMenus = document.querySelectorAll('.elementor-nav-menu--main .elementor-nav-menu');
        desktopMenus.forEach(function(menu) {
            if (!menu.querySelector('.menu-item-search-wrapper')) {
                var searchLi = document.createElement('li');
                searchLi.className = 'menu-item menu-item-search-wrapper';
                searchLi.innerHTML = `
                    <form action="/" method="get" class="nav-search-form">
                        <input type="text" name="s" class="nav-search-input" placeholder="Buscar" aria-label="Buscar en el sitio" autocomplete="off">
                        <button type="submit" class="nav-search-button" aria-label="Ejecutar búsqueda">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </button>
                    </form>
                `;
                menu.appendChild(searchLi);
            }
        });

        var mobileMenus = document.querySelectorAll('.elementor-nav-menu--dropdown .elementor-nav-menu');
        mobileMenus.forEach(function(menu) {
            if (!menu.querySelector('.menu-item-search-wrapper')) {
                var searchLi = document.createElement('li');
                searchLi.className = 'menu-item menu-item-search-wrapper';
                searchLi.innerHTML = `
                    <form action="/" method="get" class="nav-search-form">
                        <input type="text" name="s" class="nav-search-input" placeholder="Buscar" aria-label="Buscar en el sitio" autocomplete="off" tabindex="-1">
                        <button type="submit" class="nav-search-button" aria-label="Ejecutar búsqueda" tabindex="-1">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </button>
                    </form>
                `;
                menu.appendChild(searchLi);
            }
        });

        var forms = document.querySelectorAll('.nav-search-form');
        forms.forEach(setupLiveSearchForm);
    }

    // 6. Inject & Setup Sun/Moon Dark-Light Mode Switch Toggle
    function createSwitchHTML(idPrefix) {
        return `
            <div class="theme-switch-container" id="${idPrefix}-container">
                <button type="button" class="theme-toggle-switch" id="${idPrefix}-btn" aria-label="Cambiar modo de luz u oscuridad" title="Cambiar modo de luz">
                    <span class="theme-toggle-track">
                        <span class="theme-toggle-icon theme-toggle-sun" aria-hidden="true">
                            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                <circle cx="12" cy="12" r="5"></circle>
                                <line x1="12" y1="1" x2="12" y2="3"></line>
                                <line x1="12" y1="21" x2="12" y2="23"></line>
                                <line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line>
                                <line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line>
                                <line x1="1" y1="12" x2="3" y2="12"></line>
                                <line x1="21" y1="12" x2="23" y2="12"></line>
                                <line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line>
                                <line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line>
                            </svg>
                        </span>
                        <span class="theme-toggle-icon theme-toggle-moon" aria-hidden="true">
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
                            </svg>
                        </span>
                        <span class="theme-toggle-thumb">
                            <span class="thumb-icon sun-icon" aria-hidden="true">
                                <svg width="13" height="13" viewBox="0 0 24 24" fill="currentColor">
                                    <circle cx="12" cy="12" r="4"></circle>
                                    <path stroke="currentColor" stroke-width="2" stroke-linecap="round" d="M12 2v2M12 20v2M4.93 4.93l1.41 1.41M17.66 17.66l1.41 1.41M2 12h2M20 12h2M4.93 19.07l1.41-1.41M17.66 6.34l1.41-1.41"/>
                                </svg>
                            </span>
                            <span class="thumb-icon moon-icon" aria-hidden="true">
                                <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path>
                                </svg>
                            </span>
                        </span>
                    </span>
                </button>
            </div>
        `;
    }

    function toggleTheme() {
        var isDark = document.documentElement.classList.toggle('dark-mode');
        document.body.classList.toggle('dark-mode', isDark);
        localStorage.setItem('3way_theme', isDark ? 'dark' : 'light');
        updateAllSwitches();
    }

    function updateAllSwitches() {
        var isDark = document.documentElement.classList.contains('dark-mode');
        var buttons = document.querySelectorAll('.theme-toggle-switch');
        buttons.forEach(function(btn) {
            if (isDark) {
                btn.classList.add('is-dark');
                btn.setAttribute('title', 'Cambiar a modo claro');
                btn.setAttribute('aria-label', 'Cambiar a modo claro');
            } else {
                btn.classList.remove('is-dark');
                btn.setAttribute('title', 'Cambiar a modo oscuro');
                btn.setAttribute('aria-label', 'Cambiar a modo oscuro');
            }
        });
    }

    function ensureThemeToggle() {
        // 1. Header Nav Desktop
        var desktopMenus = document.querySelectorAll('.elementor-nav-menu--main .elementor-nav-menu');
        desktopMenus.forEach(function(menu) {
            if (!menu.querySelector('.menu-item-theme-toggle')) {
                var toggleLi = document.createElement('li');
                toggleLi.className = 'menu-item menu-item-theme-toggle';
                toggleLi.innerHTML = createSwitchHTML('nav-theme-toggle');
                menu.appendChild(toggleLi);
            }
        });

        // 2. Header Nav Mobile
        var mobileMenus = document.querySelectorAll('.elementor-nav-menu--dropdown .elementor-nav-menu');
        mobileMenus.forEach(function(menu) {
            if (!menu.querySelector('.menu-item-theme-toggle')) {
                var toggleLi = document.createElement('li');
                toggleLi.className = 'menu-item menu-item-theme-toggle';
                toggleLi.innerHTML = createSwitchHTML('mobile-nav-theme-toggle');
                menu.appendChild(toggleLi);
            }
        });

        // 3. Floating Bottom-Right Corner Toggle Widget (Always accessible)
        if (!document.getElementById('floating-theme-toggle-wrapper')) {
            var floatingDiv = document.createElement('div');
            floatingDiv.id = 'floating-theme-toggle-wrapper';
            floatingDiv.className = 'floating-theme-toggle';
            floatingDiv.innerHTML = createSwitchHTML('floating-theme-toggle');
            document.body.appendChild(floatingDiv);
        }

        // Attach listeners to all switches
        document.querySelectorAll('.theme-toggle-switch').forEach(function(btn) {
            btn.removeEventListener('click', toggleTheme);
            btn.addEventListener('click', toggleTheme);
        });

        updateAllSwitches();
    }

    ensureHeaderSearchBar();
    ensureThemeToggle();

    // ==========================================================================
    // 6. TRILINGUAL I18N TRANSLATION ENGINE (ES 🇦🇷 / EN 🇺🇸 / PT 🇧🇷)
    // ==========================================================================
    function ensureHeaderLanguageSwitcher() {
        var langSwitcherHTML = '<div class="lang-switcher-container">' +
            '<span class="lang-option es-option active" data-lang="es" title="Español"><span class="lang-flag">🇦🇷</span></span>' +
            '<span class="lang-divider">|</span>' +
            '<span class="lang-option en-option" data-lang="en" title="English"><span class="lang-flag">🇺🇸</span></span>' +
            '<span class="lang-divider">|</span>' +
            '<span class="lang-option pt-option" data-lang="pt" title="Português"><span class="lang-flag">🇧🇷</span></span>' +
            '</div>';

        var menus = document.querySelectorAll('.elementor-nav-menu--main .elementor-nav-menu, .elementor-nav-menu--dropdown .elementor-nav-menu');
        menus.forEach(function(menu) {
            if (!menu.querySelector('.menu-item-lang-wrapper')) {
                var langLi = document.createElement('li');
                langLi.className = 'menu-item menu-item-lang-wrapper';
                langLi.innerHTML = langSwitcherHTML;
                var searchItem = menu.querySelector('.menu-item-search-wrapper');
                if (searchItem && searchItem.nextSibling) {
                    menu.insertBefore(langLi, searchItem.nextSibling);
                } else {
                    menu.appendChild(langLi);
                }
            }
        });
    }

    ensureHeaderLanguageSwitcher();

    var DICTIONARY = {
        "PRODUCTOS": { es: "PRODUCTOS", en: "PRODUCTS", pt: "PRODUTOS" },
        "RECURSOS": { es: "RECURSOS", en: "RESOURCES", pt: "RECURSOS" },
        "CONTACTO": { es: "CONTACTO", en: "CONTACT", pt: "CONTATO" },
        "Soluciones": { es: "Soluciones", en: "Solutions", pt: "Soluções" },
        "Blog de Tecnología": { es: "Blog de Tecnología", en: "Tech Blog", pt: "Blog de Tecnologia" },
        "Quienes somos": { es: "Quienes somos", en: "About Us", pt: "Quem somos" },
        "Recursos Humanos": { es: "Recursos Humanos", en: "Human Resources", pt: "Recursos Humanos" },
        "Novedades": { es: "Novedades", en: "News", pt: "Novidades" },
        "Calculador de Almacenamiento": { es: "Calculador de Almacenamiento", en: "Storage Calculator", pt: "Calculadora de Armazenamento" },
        "Contacto": { es: "Contacto", en: "Contact", pt: "Contato" },

        "Nuestras soluciones": { es: "Nuestras soluciones", en: "Our Solutions", pt: "Nossas soluções" },
        "Módulos Adicionales": { es: "Módulos Adicionales", en: "Additional Modules", pt: "Módulos Adicionais" },
        "Clientes que confían en nosotros": { es: "Clientes que confían en nosotros", en: "Clients Who Trust Us", pt: "Clientes que confiam em nós" },
        "Casos de éxito": { es: "Casos de éxito", en: "Success Stories", pt: "Casos de sucesso" },
        "Casos de éxito y novedades": { es: "Casos de éxito y novedades", en: "Success Stories & News", pt: "Casos de sucesso e novidades" },

        "Visualización de múltiples señales de Radio y TV en una o varias pantallas con alarmas de QoE y QoS.": {
            es: "Visualización de múltiples señales de Radio y TV en una o varias pantallas con alarmas de QoE y QoS.",
            en: "Multi-channel Radio and TV signal visualization across single or multiple screens with QoE and QoS alarms.",
            pt: "Visualização de múltiplos sinais de Rádio e TV em uma ou várias telas com alarmes de QoE e QoS."
        },
        "Software de grabación de Radio y TV para extracción de clips y creación de contenidos.": {
            es: "Software de grabación de Radio y TV para extracción de clips y creación de contenidos.",
            en: "Radio and TV recording software for clip extraction and content creation.",
            pt: "Software de gravação de Rádio e TV para extração de clipes e criação de conteúdos."
        },
        "Grabación para auditoría y gestión inteligente de contenidos de Radio y TV.": {
            es: "Grabación para auditoría y gestión inteligente de contenidos de Radio y TV.",
            en: "Recording for auditing and smart content management of Radio and TV.",
            pt: "Gravação para auditoria e gestão inteligente de conteúdos de Rádio e TV."
        },
        "Monitoree más de 150 señales con sistema de barrido automático de canales.": {
            es: "Monitoree más de 150 señales con sistema de barrido automático de canales.",
            en: "Monitor over 150 signals with an automated channel sweep system.",
            pt: "Monitore mais de 150 sinais com sistema de varredura automática de canais."
        },
        "Conoce más soluciones": { es: "Conoce más soluciones", en: "Discover more solutions", pt: "Conheça mais soluções" },
        "Ver más": { es: "Ver más", en: "See more", pt: "Ver mais" },

        "Detección de objetos": { es: "Detección de objetos", en: "Object Detection", pt: "Detecção de objetos" },
        "La IA esta entrenada con una base de datos grande y variada de imágenes, tanto de objetos como de imágenes que no lo son, para evitar falsas detecciones, y puede detectar cualquier objeto previamente cargado.": {
            es: "La IA esta entrenada con una base de datos grande y variada de imágenes, tanto de objetos como de imágenes que no lo son, para evitar falsas detecciones, y puede detectar cualquier objeto previamente cargado.",
            en: "AI trained on large and varied image databases to prevent false positives and accurately detect pre-loaded objects.",
            pt: "A IA é treinada com um banco de dados amplo de imagens para evitar falsos positivos e detectar qualquer objeto pré-carregado."
        },
        "Detección de desnudos": { es: "Detección de desnudos", en: "Nudity Detection", pt: "Detecção de nudes" },
        "El software es capaz de analizar las transmisiones en vivo o grabadas en tiempo real para identificar imágenes de desnudos o contenido inapropiado.": {
            es: "El software es capaz de analizar las transmisiones en vivo o grabadas en tiempo real para identificar imágenes de desnudos o contenido inapropiado.",
            en: "Real-time software analysis for live or recorded broadcasts to detect nudity or inappropriate content.",
            pt: "O software analisa transmissões ao vivo ou gravadas em tempo real para identificar conteúdo inadequado."
        },
        "Auto Highlight Clipping": { es: "Auto Highlight Clipping", en: "Auto Highlight Clipping", pt: "Auto Highlight Clipping" },
        "Es una solución innovadora que permite la creación automática de highlights a partir de grabaciones de canales de radio y televisión. Utilizando avanzados algoritmos de inteligencia artificial y análisis de contenido.": {
            es: "Es una solución innovadora que permite la creación automática de highlights a partir de grabaciones de canales de radio y televisión. Utilizando avanzados algoritmos de inteligencia artificial y análisis de contenido.",
            en: "Innovative solution for automated highlight creation from radio and TV recordings using AI and content analysis algorithms.",
            pt: "Solução inovadora que permite a criação automática de destaques a partir de gravações de rádio e TV usando IA."
        },
        "Reconocimiento de rostros": { es: "Reconocimiento de rostros", en: "Face Recognition", pt: "Reconhecimento facial" },
        "Permite tener una detección automática de personas en las diferentes señales de televisión y/o streamings que estamos recibiendo.": {
            es: "Permite tener una detección automática de personas en las diferentes señales de televisión y/o streamings que estamos recibiendo.",
            en: "Enables automated person detection across incoming TV signals and streaming feeds.",
            pt: "Permite a detecção automática de pessoas nos diferentes sinais de TV e transmissões de streaming."
        },

        "Leer Más >>": { es: "Leer Más >>", en: "Read More >>", pt: "Leia Mais >>" },
        "Leer más": { es: "Leer más", en: "Read more", pt: "Leia mais" },

        "Productos": { es: "Productos", en: "Products", pt: "Produtos" },
        "Empresa": { es: "Empresa", en: "Company", pt: "Empresa" },
        "TV Cable Operador": { es: "TV Cable Operador", en: "TV Cable Operator", pt: "Operador de TV a Cabo" },

        // Header Carousel Slides
        "Estaremos presentes en SET 2026 Stand #37 Foccus, del 18 al 20 de Agosto, en Sao Paulo, Brasil.": {
            es: "Estaremos presentes en SET 2026 Stand #37 Foccus, del 18 al 20 de Agosto, en Sao Paulo, Brasil.",
            en: "We will be present at SET 2026 Booth #37 Foccus, from August 18 to 20, in Sao Paulo, Brazil.",
            pt: "Estaremos presentes no SET 2026 Estande #37 Foccus, de 18 a 20 de Agosto, em São Paulo, Brasil."
        },
        "ViDeus Catalog es el sistema MAM local que combina catalogación tradicional con inteligencia artificial on-premise para transformar grandes volúmenes de video, audio e imágenes en información buscable, indexada y lista para producción.": {
            es: "ViDeus Catalog es el sistema MAM local que combina catalogación tradicional con inteligencia artificial on-premise para transformar grandes volúmenes de video, audio e imágenes en información buscable, indexada y lista para producción.",
            en: "ViDeus Catalog is the local MAM system combining traditional cataloging with on-premise AI to transform high volumes of video, audio, and images into searchable, indexed, production-ready data.",
            pt: "ViDeus Catalog é o sistema MAM local que combina catalogação tradicional com inteligência artificial on-premise para transformar grandes volumes de vídeo, áudio e imagens em dados pesquisáveis, indexados e prontos para produção."
        },
        "Software y Soluciones Innovadoras para la Grabación, Auditoría Comercial, Monitoreo Técnico y Gestión de Contenidos de Radio y Televisión.": {
            es: "Software y Soluciones Innovadoras para la Grabación, Auditoría Comercial, Monitoreo Técnico y Gestión de Contenidos de Radio y Televisión.",
            en: "Innovative Software and Solutions for Recording, Commercial Auditing, Technical Monitoring, and Radio & TV Content Management.",
            pt: "Software e Soluções Inovadoras para Gravação, Auditoria Comercial, Monitoramento Técnico e Gestão de Conteúdos de Rádio e TV."
        },
        "Recibí señales de TV en vivo directamente desde plataformas OTT con DRM. Sin hardware. Sin complicaciones.": {
            es: "Recibí señales de TV en vivo directamente desde plataformas OTT con DRM. Sin hardware. Sin complicaciones.",
            en: "Receive live TV signals directly from OTT platforms with DRM. No hardware. No complications.",
            pt: "Receba sinais de TV ao vivo diretamente de plataformas OTT com DRM. Sem hardware. Sem complicações."
        },
        "Conectá tus cuentas de streaming y empezá a grabar, monitorear y clipear contenido en vivo sin usar decodificadores, placas adicionales ni infraestructura física.": {
            es: "Conectá tus cuentas de streaming y empezá a grabar, monitorear y clipear contenido en vivo sin usar decodificadores, placas adicionales ni infraestructura física.",
            en: "Connect your streaming accounts and start recording, monitoring, and clipping live content without set-top boxes, extra cards, or physical infrastructure.",
            pt: "Conecte suas contas de streaming e comece a gravar, monitorar e criar clipes de conteúdo ao vivo sem decodificadores, placas adicionais ou infraestrutura física."
        },
        "Nuestro Software Utiliza Inteligencia Artificial para Detectar Rostros, logos, objetos, desnudos, Crear Clips automáticos y mucho más.": {
            es: "Nuestro Software Utiliza Inteligencia Artificial para Detectar Rostros, logos, objetos, desnudos, Crear Clips automáticos y mucho más.",
            en: "Our Software Uses Artificial Intelligence to Detect Faces, logos, objects, nudity, Create automatic Clips, and much more.",
            pt: "Nosso Software Utiliza Inteligência Artificial para Detectar Rostos, logotipos, objetos, nudes, Criar Clipes automáticos e muito mais."
        },
        "Más de 20 Años Brindando Soluciones de Monitoreo de Alta Calidad y un Servicio Excepcional a Nuestros Valiosos Clientes.": {
            es: "Más de 20 Años Brindando Soluciones de Monitoreo de Alta Calidad y un Servicio Excepcional a Nuestros Valiosos Clientes.",
            en: "Over 20 Years Providing High Quality Monitoring Solutions and Exceptional Service to Our Valued Clients.",
            pt: "Mais de 20 Anos Oferecendo Soluções de Monitoramento de Alta Qualidade e um Serviço Excepcional aos Nossos Valiosos Clientes."
        },
        "Lee más": { es: "Lee más", en: "Read more", pt: "Leia mais" },
        "Conoce más": { es: "Conoce más", en: "Learn more", pt: "Saiba mais" },

        // Subpages Common Elements
        "Inicio": { es: "Inicio", en: "Home", pt: "Início" },
        "Descargar PDF": { es: "Descargar PDF", en: "Download PDF", pt: "Baixar PDF" },
        "Solicitar Demo": { es: "Solicitar Demo", en: "Request Demo", pt: "Solicitar Demonstração" },
        "Ver Soluciones": { es: "Ver Soluciones", en: "View Solutions", pt: "Ver Soluções" },
        "Volver": { es: "Volver", en: "Back", pt: "Voltar" },
        "Buscador": { es: "Buscador", en: "Search", pt: "Buscador" },
        "Monitoreo y Auditoría de Medios": { es: "Monitoreo y Auditoría de Medios", en: "Media Monitoring and Auditing", pt: "Monitoramento e Auditoria de Mídia" },
        "Soluciones para Radio y Televisión": { es: "Soluciones para Radio y Televisión", en: "Solutions for Radio and Television", pt: "Soluções para Rádio e Televisão" },
        "Descarga de Folletos y Documentación Técnica": { es: "Descarga de Folletos y Documentación Técnica", en: "Download Brochures and Technical Documentation", pt: "Download de Brochuras e Documentação Técnica" },
        "Calcule el espacio de almacenamiento necesario para sus grabaciones de radio y TV.": {
            es: "Calcule el espacio de almacenamiento necesario para sus grabaciones de radio y TV.",
            en: "Calculate required storage space for your radio and TV recordings.",
            pt: "Calcule o espaço de armazenamento necessário para suas gravações de rádio e TV."
        },
        "Nuestra Historia": { es: "Nuestra Historia", en: "Our Story", pt: "Nossa História" },
        "Sobre 3Way Solutions": { es: "Sobre 3Way Solutions", en: "About 3Way Solutions", pt: "Sobre a 3Way Solutions" }
    };

    function applyLanguage(lang) {
        localStorage.setItem('3way_lang', lang);
        document.documentElement.setAttribute('lang', lang === 'en' ? 'en-US' : (lang === 'pt' ? 'pt-BR' : 'es-AR'));

        ensureHeaderLanguageSwitcher();

        // Update active class on flag options
        document.querySelectorAll('.lang-option').forEach(function(opt) {
            if (opt.getAttribute('data-lang') === lang) {
                opt.classList.add('active');
            } else {
                opt.classList.remove('active');
            }
        });

        // Update search placeholder
        document.querySelectorAll('.nav-search-input').forEach(function(input) {
            if (lang === 'en') {
                input.placeholder = "Search tool or solution...";
            } else if (lang === 'pt') {
                input.placeholder = "Buscar ferramenta ou solução...";
            } else {
                input.placeholder = "Buscar herramienta o solución...";
            }
        });

        // Translate text elements
        var selectors = 'a, h1, h2, h3, h4, h5, p, span.elementor-icon-list-text, span.elementor-button-text, div.elementor-slide-description, div.elementor-slide-button';
        document.querySelectorAll(selectors).forEach(function(el) {
            var currentText = el.innerText ? el.innerText.trim() : '';
            Object.keys(DICTIONARY).forEach(function(key) {
                var entry = DICTIONARY[key];
                if (currentText === entry.es || currentText === entry.en || currentText === entry.pt) {
                    var targetText = entry[lang];
                    if (targetText && el.childNodes.length <= 1) {
                        el.innerText = targetText;
                    }
                }
            });
        });
    }

    function initLanguageSwitcher() {
        ensureHeaderLanguageSwitcher();
        var currentLang = localStorage.getItem('3way_lang') || 'es';
        applyLanguage(currentLang);

        document.querySelectorAll('.lang-option').forEach(function(opt) {
            opt.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                var targetLang = this.getAttribute('data-lang');
                if (targetLang) {
                    applyLanguage(targetLang);
                }
            });
        });
    }

    initLanguageSwitcher();
});