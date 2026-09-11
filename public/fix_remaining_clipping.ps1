$file = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\clipping\index.html"
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# The Spanglish one
$content = $content -replace 'PUBLICAR MAS RAPIDO', 'PUBLISH FASTER'
# The CTA mojibake one
$content = [regex]::Replace($content, '(?s)<h3.*?>.*?Quer.*?s saber m.*?\?</h3>', '<h3 style="font-size: 1.8rem; margin-bottom: 25px; font-weight: 600; color: #0f172a;">Want to know more?</h3>')

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
Write-Host "Fixed remaining strings in en/clipping/index.html"
