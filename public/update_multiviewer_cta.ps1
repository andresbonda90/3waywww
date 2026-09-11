$content = [System.IO.File]::ReadAllText("c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\multiviewer\index.html", [System.Text.Encoding]::UTF8)

$newCTA = @"
  <!-- QUERES SABER MAS -->
  <section class="download-brochure-section" style="padding: 60px 20px; background-color: #ffffff; border-top: 1px solid #e2e8f0; margin-top: 20px;">
    <div style="text-align: center; max-width: 800px; margin: 0 auto;">
        <h3 style="font-size: 1.8rem; margin-bottom: 25px; font-weight: 600; color: #0f172a;">¿Querés saber más?</h3>
        <div style="display: flex; gap: 20px; justify-content: center; flex-wrap: wrap;">
            <a href="/wp-content/uploads/ViDeus_Multiviewer_Folleto.pdf" download="3Way_ViDeus_Multiviewer_Folleto.pdf" target="_blank" class="catalog-v2-btn-primary" style="gap: 10px; display: inline-flex; align-items: center;">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                Descargar Folleto PDF
            </a>
            <a href="javascript:void(0)" onclick="openDemoModal('Multiviewer')" class="catalog-v2-btn-secondary" style="gap: 10px; margin-left: 0; display: inline-flex; align-items: center;">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                Solicitar Demo
            </a>
        </div>
    </div>
  </section>
"@

# The existing CTA is wrapped in a section with class "catalog-v2-section" and style "background-color: #ffffff !important;"
# We will replace that whole section.
$pattern = '(?s)<section class="catalog-v2-section" style="background-color: #ffffff !important;">\s*<div class="catalog-v2-container">\s*<div class="catalog-v2-cta".*?</section>'
$newContent = [regex]::Replace($content, $pattern, $newCTA)

if ($content -ne $newContent) {
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText("c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\multiviewer\index.html", $newContent, $utf8NoBom)
    Write-Host "Updated CTA in multiviewer/index.html"
} else {
    Write-Host "Failed to find the CTA pattern in multiviewer/index.html"
}
