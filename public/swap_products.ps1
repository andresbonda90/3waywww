$prod = "catalog"

$esFile = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\$prod\index.html"
$enFile = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\$prod\index.html"

$esContent = [System.IO.File]::ReadAllText($esFile, [System.Text.Encoding]::UTF8)
$enContent = [System.IO.File]::ReadAllText($enFile, [System.Text.Encoding]::UTF8)

# Extract en header (everything before and including </header>)
$enHeader = ""
if ($enContent -match "(?s)^(.*?</header>)") {
    $enHeader = $matches[1]
}

# Extract en footer (everything from <footer onwards, or <!-- FOOTER -->)
$enFooter = ""
if ($enContent -match "(?s)(<!-- FOOTER -->.*)$") {
    $enFooter = $matches[1]
} elseif ($enContent -match "(?s)(<footer.*)$") {
    $enFooter = $matches[1]
}

# Extract es main
$esMain = ""
if ($esContent -match "(?s)(<main[^>]*>.*?</main>)") {
    $esMain = $matches[1]
}

if ($enHeader -and $esMain -and $enFooter) {
    $newEnContent = $enHeader + "`n" + $esMain + "`n" + $enFooter
    
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($enFile, $newEnContent, $utf8NoBom)
    Write-Host "Successfully merged structure for $prod"
} else {
    Write-Host "Failed to extract parts for $prod. enHeader:$([bool]$enHeader), esMain:$([bool]$esMain), enFooter:$([bool]$enFooter)"
}
