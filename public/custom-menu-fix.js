document.addEventListener('DOMContentLoaded', function() {
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
                speed: 7000,
                autoplay: {
                    delay: 0,
                    disableOnInteraction: false,
                    pauseOnMouseEnter: false
                },
                allowTouchMove: false,
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

    ensureHeaderSearchBar();
});