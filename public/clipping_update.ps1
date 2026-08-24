$html = Get-Content "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\clipping\index.html" -Raw -Encoding UTF8

# 1. Remove the broken image container below the hero section
$brokenImageRegex = '(?s)<div class="container text-center" style="margin-top: 3rem; position: relative; z-index: 10;">\s*<img src="/wp-content/uploads/2026/08/videus_clipping_hero_real.png"[^>]*>\s*</div>'
$html = $html -replace $brokenImageRegex, ''

# 2. Replace the value-prop-section with the side-by-side layout
$oldPropSectionRegex = '(?s)<section class="value-prop-section">.*?</section>'
$newPropSection = @'
  <!-- 2. PROPUESTA DE VALOR -->
  <section class="value-prop-section" style="padding-top: 6rem;">
    <div class="container" style="display: flex; gap: 4rem; align-items: center; flex-wrap: wrap;">
      <div style="flex: 1; min-width: 300px;">
        <h2 class="section-title" style="text-align: left; margin-bottom: 1.5rem;">Todo lo que sale al aire, listo para convertirse en contenido</h2>
        <p class="section-desc" style="text-align: left; margin: 0 0 2rem 0; max-width: 100%;">ViDeus Clipping centraliza la grabación, búsqueda, selección y publicación de contenidos de TV, radio y streaming. Los operadores pueden acceder al material desde un navegador, encontrar el momento necesario y generar un clip mientras la señal continúa grabándose.</p>
        
        <div class="benefits-grid" style="grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); margin-top: 2rem;">
          <div class="benefit-card" style="padding: 1.5rem; text-align: left;">
            <div class="icon" style="margin: 0 0 1rem 0; width: 40px; height: 40px;">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><path d="M12 8v4l3 3"></path></svg>
            </div>
            <h3 style="font-size: 1.1rem; margin-bottom: 0.5rem;">Grabación continua</h3>
            <p style="font-size: 0.95rem; color: #64748b; margin: 0;">acceder al contenido mientras todavía está saliendo al aire.</p>
          </div>
          <div class="benefit-card" style="padding: 1.5rem; text-align: left;">
            <div class="icon" style="margin: 0 0 1rem 0; width: 40px; height: 40px;">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
            </div>
            <h3 style="font-size: 1.1rem; margin-bottom: 0.5rem;">Clipping inmediato</h3>
            <p style="font-size: 0.95rem; color: #64748b; margin: 0;">marcar IN y OUT directamente desde el navegador.</p>
          </div>
          <div class="benefit-card" style="padding: 1.5rem; text-align: left;">
            <div class="icon" style="margin: 0 0 1rem 0; width: 40px; height: 40px;">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect><line x1="8" y1="21" x2="16" y2="21"></line><line x1="12" y1="17" x2="12" y2="21"></line></svg>
            </div>
            <h3 style="font-size: 1.1rem; margin-bottom: 0.5rem;">Operación web</h3>
            <p style="font-size: 0.95rem; color: #64748b; margin: 0;">sin estación de edición dedicada.</p>
          </div>
          <div class="benefit-card" style="padding: 1.5rem; text-align: left;">
            <div class="icon" style="margin: 0 0 1rem 0; width: 40px; height: 40px;">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>
            </div>
            <h3 style="font-size: 1.1rem; margin-bottom: 0.5rem;">Publicación rápida</h3>
            <p style="font-size: 0.95rem; color: #64748b; margin: 0;">exportar hacia storage, playout u otros destinos.</p>
          </div>
        </div>
      </div>
      
      <div style="flex: 1; min-width: 300px; display: flex; justify-content: flex-end; align-items: center;">
        <img src="/wp-content/uploads/clipping1.png" alt="ViDeus Clipping Interface" style="max-width: 100%; border-radius: 12px; filter: drop-shadow(0 20px 40px rgba(0,0,0,0.15));">
      </div>
    </div>
  </section>
'@

$html = $html -replace $oldPropSectionRegex, $newPropSection

$html | Set-Content "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\clipping\index.html" -Encoding UTF8
