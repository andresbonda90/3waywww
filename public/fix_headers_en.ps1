$publicDir = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en"
$files = Get-ChildItem -Path $publicDir -Filter "*.html" -Recurse

$enHeader = [System.IO.File]::ReadAllText("c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\header_en.html", [System.Text.Encoding]::UTF8)

foreach ($file in $files) {
    $filePath = $file.FullName
    $content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
    
    # Replace the existing header block with the English header
    $newContent = [regex]::Replace($content, '(?s)<header class="site-header">.*?</header>', $enHeader)
    
    if ($content -ne $newContent) {
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($filePath, $newContent, $utf8NoBom)
        Write-Host "Updated English header in $($file.Name)"
    }
}
