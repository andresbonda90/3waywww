$targetDir = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en"
$files = Get-ChildItem -Path $targetDir -Filter "*.html" -Recurse

$pattern = '(?s)<li class="lang-switch">.*?</li>'
$replacement = '<li class="lang-switch"><a href="/" style="padding: 0 5px;">ES</a>|<a href="/en/" style="padding: 0 5px;">EN</a></li>'

$count = 0
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    if ($content -match $pattern) {
        $newContent = [regex]::Replace($content, $pattern, $replacement)
        if ($newContent -ne $content) {
            $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
            [System.IO.File]::WriteAllText($file.FullName, $newContent, $utf8NoBom)
            $count++
        }
    }
}
Write-Host "Fixed global language switcher in $count files."
