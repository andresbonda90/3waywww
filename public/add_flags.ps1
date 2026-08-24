$targetDir = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public"
$files = Get-ChildItem -Path $targetDir -Filter "*.html" -Recurse

$pattern = '(?s)<li class="lang-switch">.*?</li>'
$replacement = '<li class="lang-switch" style="display: flex; align-items: center; justify-content: center; padding-top: 2px;"><a href="/" title="Español" style="padding: 0 5px; display: flex;"><img src="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.5.0/flags/4x3/ar.svg" alt="ES" style="width: 20px; height: 15px; border-radius: 2px;"></a><span style="margin: 0 2px;">|</span><a href="/en/" title="English" style="padding: 0 5px; display: flex;"><img src="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.5.0/flags/4x3/us.svg" alt="EN" style="width: 20px; height: 15px; border-radius: 2px;"></a></li>'

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
Write-Host "Replaced ES/EN with flags in $count files."
