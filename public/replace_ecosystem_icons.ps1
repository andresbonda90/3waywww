$file = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\index.html"
$utf8NoBom = New-Object System.Text.UTF8Encoding $False
$content = [System.IO.File]::ReadAllText($file, $utf8NoBom)

# 1. Monitorear
$svgMonitorear = '<div class="node-icon"><svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect><line x1="8" y1="21" x2="16" y2="21"></line><line x1="12" y1="17" x2="12" y2="21"></line><line x1="12" y1="3" x2="12" y2="17"></line><line x1="2" y1="10" x2="22" y2="10"></line></svg></div>'
$content = $content -replace '<div class="node-icon">.*?</div>\s*<h4>MONITOREAR</h4>', "$svgMonitorear`n                    <h4>MONITOREAR</h4>"

# 2. Grabar
$svgGrabar = '<div class="node-icon"><svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="4" width="20" height="16" rx="2" ry="2"></rect><circle cx="18" cy="8" r="2" fill="currentColor" stroke="none"></circle><line x1="2" y1="15" x2="22" y2="15"></line><line x1="7" y1="15" x2="7" y2="20"></line><line x1="12" y1="15" x2="12" y2="20"></line><line x1="17" y1="15" x2="17" y2="20"></line></svg></div>'
$content = $content -replace '<div class="node-icon">.*?</div>\s*<h4>GRABAR</h4>', "$svgGrabar`n                    <h4>GRABAR</h4>"

# 3. Analizar
$svgAnalizar = '<div class="node-icon"><svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="4" width="20" height="16" rx="2" ry="2"></rect><circle cx="8" cy="13" r="1.5" fill="currentColor" stroke="none"></circle><circle cx="16" cy="13" r="1.5" fill="currentColor" stroke="none"></circle><circle cx="12" cy="8" r="1.5" fill="currentColor" stroke="none"></circle><line x1="8" y1="13" x2="12" y2="8"></line><line x1="12" y1="8" x2="16" y2="13"></line><line x1="8" y1="13" x2="16" y2="13"></line></svg></div>'
$content = $content -replace '<div class="node-icon">.*?</div>\s*<h4>ANALIZAR</h4>', "$svgAnalizar`n                    <h4>ANALIZAR</h4>"

# 4. Encontrar
$svgEncontrar = '<div class="node-icon"><svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="4" width="20" height="16" rx="2" ry="2"></rect><circle cx="11" cy="11" r="3"></circle><line x1="13.12" y1="13.12" x2="17" y2="17"></line></svg></div>'
$content = $content -replace '<div class="node-icon">.*?</div>\s*<h4>ENCONTRAR</h4>', "$svgEncontrar`n                    <h4>ENCONTRAR</h4>"

# 5. Publicar
$svgPublicar = '<div class="node-icon"><svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="6" width="16" height="14" rx="2" ry="2"></rect><polygon points="7 10 12 13 7 16 7 10"></polygon><path d="M12 13L21 4"></path><polyline points="15 4 21 4 21 10"></polyline></svg></div>'
$content = $content -replace '<div class="node-icon">.*?</div>\s*<h4>PUBLICAR</h4>', "$svgPublicar`n                    <h4>PUBLICAR</h4>"

# 6. Archivar
$svgArchivar = '<div class="node-icon"><svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><ellipse cx="12" cy="5" rx="9" ry="3"></ellipse><path d="M21 12c0 1.66-4 3-9 3s-9-1.34-9-3"></path><path d="M3 5v14c0 1.66 4 3 9 3s9-1.34 9-3V5"></path><rect x="7" y="12" width="10" height="7" rx="1" ry="1" fill="white"></rect><polygon points="10 13.5 14 15.5 10 17.5 10 13.5"></polygon></svg></div>'
$content = $content -replace '<div class="node-icon">.*?</div>\s*<h4>ARCHIVAR</h4>', "$svgArchivar`n                    <h4>ARCHIVAR</h4>"

[System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
Write-Host "Icons updated in index.html"
