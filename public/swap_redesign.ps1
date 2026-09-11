$prods = @("clipping", "multiviewer")
foreach ($prod in $prods) {
    $esFile = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\$prod\index.html"
    $enFile = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\$prod\index.html"

    $esContent = [System.IO.File]::ReadAllText($esFile, [System.Text.Encoding]::UTF8)
    $enContent = [System.IO.File]::ReadAllText($enFile, [System.Text.Encoding]::UTF8)

    # Extract en header
    $enHeader = ""
    if ($enContent -match "(?s)^(.*?</header>)") {
        $enHeader = $matches[1]
    }

    # Extract en footer
    $enFooter = ""
    if ($enContent -match "(?s)(<footer.*)$") {
        $enFooter = $matches[1]
    }

    # Extract es body
    $esBody = ""
    if ($esContent -match "(?s)</header>(.*?)<footer") {
        $esBody = $matches[1]
    } elseif ($esContent -match "(?s)</header>(.*?)<!-- FOOTER -->") {
        $esBody = $matches[1]
    }

    if ($enHeader -and $esBody -and $enFooter) {
        $newEnContent = $enHeader + "`n" + $esBody + "`n" + $enFooter
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($enFile, $newEnContent, $utf8NoBom)
        Write-Host "Successfully merged structure for $prod"
    } else {
        Write-Host "Failed to extract parts for $prod. enHeader:$([bool]$enHeader), esBody:$([bool]$esBody), enFooter:$([bool]$enFooter)"
    }
}
