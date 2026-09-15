$baseDir = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public"
$indexFile = "$baseDir\index.html"

# Use UTF-8 without BOM to be completely safe
$utf8NoBom = New-Object System.Text.UTF8Encoding $False
$content = [System.IO.File]::ReadAllText($indexFile, $utf8NoBom)

$content = $content -replace '<h2>Una arquitectura.*?posibilidades\.</h2>', '<h2>Una arquitectura. Múltiples posibilidades.</h2>'
$content = $content -replace '<p class="ecosystem-subtitle">Cada operaci.*?proyecto\.</p>', '<p class="ecosystem-subtitle">Cada operación es diferente. Las soluciones ViDeus pueden implementarse de forma independiente o integrarse entre sí según las necesidades de cada proyecto.</p>'
$content = $content -replace '<p>Se.*?ales y servicios en tiempo real\.</p>', '<p>Señales y servicios en tiempo real.</p>'
$content = $content -replace '<p>Contenido en vivo e hist.*?rico\.</p>', '<p>Contenido en vivo e histórico.</p>'
$content = $content -replace '<p>Preservaci.*?n y catalogaci.*?n\.</p>', '<p>Preservación y catalogación.</p>'

[System.IO.File]::WriteAllText($indexFile, $content, $utf8NoBom)
Write-Host "Accents fixed in ecosystem section"
