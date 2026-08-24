$path = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public"
$files = Get-ChildItem -Path $path -Filter "*.html" -Recurse

$pattern = '(<a[^>]*>IA[^<]*</a>\s*<ul[^>]*>\s*)<li><a href="/catalog/">Catalog</a></li>[ \t]*\r?\n?'
$count = 0

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $newContent = [regex]::Replace($content, $pattern, '$1', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    
    if ($content -ne $newContent) {
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($file.FullName, $newContent, $utf8NoBom)
        $count++
    }
}
Write-Host "Updated menus in $count files."
