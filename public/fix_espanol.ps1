$publicDir = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public"
$files = Get-ChildItem -Path $publicDir -Filter "*.html" -Recurse

$n_tilde = [char]0x00F1
$correct_word = "Espa" + $n_tilde + "ol"

foreach ($file in $files) {
    $filePath = $file.FullName
    $content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
    
    $newContent = [regex]::Replace($content, 'title="Espa[^"]+"', 'title="' + $correct_word + '"')
    
    if ($content -ne $newContent) {
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($filePath, $newContent, $utf8NoBom)
        Write-Host "Fixed Espanol in $($file.Name)"
    }
}
