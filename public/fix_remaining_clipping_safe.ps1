$file = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\clipping\index.html"
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# Replace the Spanglish title
$content = $content -replace 'PUBLICAR MAS RAPIDO', 'PUBLISH FASTER'

# Replace the specific h3 without a greedy regex!
# I will use regex but make it NOT match across lines by escaping properly or just targeting the exact string structure
$pattern = '<h3 style="font-size: 1\.8rem; margin-bottom: 25px; font-weight: 600; color: #0f172a;">.*?saber.*?\?</h3>'
$replacement = '<h3 style="font-size: 1.8rem; margin-bottom: 25px; font-weight: 600; color: #0f172a;">Want to know more?</h3>'

$content = [regex]::Replace($content, $pattern, $replacement)

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
Write-Host "Fixed remaining strings safely in en/clipping/index.html"
