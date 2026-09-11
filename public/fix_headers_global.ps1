$esHeaderFile = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\multiviewer\index.html"
$enHeaderFile = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\multiviewer\index.html"
$publicDir = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public"

$esContent = [System.IO.File]::ReadAllText($esHeaderFile, [System.Text.Encoding]::UTF8)
$enContent = [System.IO.File]::ReadAllText($enHeaderFile, [System.Text.Encoding]::UTF8)

# Extract headers
$esHeader = ""
if ($esContent -match '(?s)(<header class="site-header">.*?</header>)') {
    $esHeader = $matches[1]
}

$enHeader = ""
if ($enContent -match '(?s)(<header class="site-header">.*?</header>)') {
    $enHeader = $matches[1]
}

# Fix encoding issues in the language switcher title (if any)
$esHeader = [regex]::Replace($esHeader, 'title="Espa[^"]+"', 'title="Español"')
$enHeader = [regex]::Replace($enHeader, 'title="Espa[^"]+"', 'title="Español"')

$files = Get-ChildItem -Path $publicDir -Filter "*.html" -Recurse

foreach ($file in $files) {
    $filePath = $file.FullName
    $content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
    
    $isEnglish = $filePath.StartsWith("$publicDir\en\") -or $filePath.StartsWith("$publicDir\en/")
    
    $headerToUse = if ($isEnglish) { $enHeader } else { $esHeader }
    
    $newContent = $content -replace '(?s)<header class="site-header">.*?</header>', $headerToUse
    
    if ($content -ne $newContent) {
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($filePath, $newContent, $utf8NoBom)
        Write-Host "Updated header in $($file.Name)"
    }
}
