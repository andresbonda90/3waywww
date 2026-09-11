Add-Type -Path "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\hap\lib\Net45\HtmlAgilityPack.dll"

$files = @(
    "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\catalog\index.html",
    "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\logging\index.html",
    "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\clipping\index.html",
    "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\multiviewer\index.html"
)

$allStrings = @()

foreach ($file in $files) {
    if (Test-Path $file) {
        $htmlContent = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        $doc = New-Object HtmlAgilityPack.HtmlDocument
        $doc.LoadHtml($htmlContent)
        
        $nodes = $doc.DocumentNode.SelectNodes("//text()[not(ancestor::script) and not(ancestor::style) and not(ancestor::noscript) and not(ancestor::header) and not(ancestor::footer) and not(ancestor::nav)]")
        
        if ($nodes) {
            foreach ($node in $nodes) {
                $originalText = $node.InnerHtml
                if ($originalText -match "^\s*<" -or $originalText -notmatch "\p{L}") {
                    continue
                }
                $decoded = [System.Net.WebUtility]::HtmlDecode($originalText).Trim()
                if ($decoded.Length -gt 2 -and $decoded -match "[a-zA-Z]" -and $decoded -match "[áéíóúñÁÉÍÓÚÑ¿¡]|( de )|( la )|( el )|( y )") {
                    if ($allStrings -notcontains $decoded) {
                        $allStrings += $decoded
                    }
                }
            }
        }
    }
}

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText("c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\pending_translations.txt", ($allStrings -join "`n"), $utf8NoBom)
Write-Host "Done"
