$path = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public"
$files = Get-ChildItem -Path $path -Filter "*.html" -Recurse

$pattern = '(<a[^>]*>IA ▾</a>\s*<ul[^>]*>\s*)<li><a href="/catalog/">Catalog</a></li>[ \t]*\r?\n?'

$count = 0
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $newContent = [regex]::Replace($content, $pattern, '$1', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    
    if ($content -ne $newContent) {
        [System.IO.File]::WriteAllText($file.FullName, $newContent, [System.Text.Encoding]::UTF8)
        $count++
        Write-Host "Updated $($file.FullName)"
    }
}
Write-Host "Total files updated: $count"
