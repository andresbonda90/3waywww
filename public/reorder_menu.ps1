$path = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public"
$files = Get-ChildItem -Path $path -Filter "*.html" -Recurse

$pattern = '(?i)(<li><a href="/cableoperador/">Cable TV operador</a></li>)(\s*)(<li><a href="/catalog/">Catalog</a></li>)'
$count = 0

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $newContent = [regex]::Replace($content, $pattern, '$3$2$1', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    
    if ($content -ne $newContent) {
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($file.FullName, $newContent, $utf8NoBom)
        $count++
    }
}
Write-Host "Updated menus in $count files."
