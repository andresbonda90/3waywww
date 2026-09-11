$files = @(
    "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\multiviewer\index.html",
    "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\multiviewer\index.html"
)

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
    
    # We want to change the catalog-v2-section background to white
    $newContent = $content -replace '<section class="catalog-v2-section" style="background: #f8fafc;">', '<section class="catalog-v2-section" style="background: #ffffff;">'
    
    if ($content -ne $newContent) {
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($file, $newContent, $utf8NoBom)
        Write-Host "Updated background colors in $($file)"
    } else {
        Write-Host "No changes needed or pattern not found in $($file)"
    }
}
