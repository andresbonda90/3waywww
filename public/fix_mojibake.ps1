$content = [System.IO.File]::ReadAllText("c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\multiviewer\index.html", [System.Text.Encoding]::UTF8)

# Find the h3 tag containing 'saber' in the CTA section
$pattern = '(?s)<h3 style="font-size: 1\.8rem; margin-bottom: 25px; font-weight: 600; color: #0f172a;">.*?saber.*?\?</h3>'
$replacement = '<h3 style="font-size: 1.8rem; margin-bottom: 25px; font-weight: 600; color: #0f172a;">' + [char]0x00BF + 'Quer' + [char]0x00E9 + 's saber m' + [char]0x00E1 + 's?</h3>'

$newContent = [regex]::Replace($content, $pattern, $replacement)

if ($content -ne $newContent) {
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText("c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\multiviewer\index.html", $newContent, $utf8NoBom)
    Write-Host "Fixed mojibake in multiviewer/index.html"
} else {
    Write-Host "Pattern not found in multiviewer/index.html"
}
