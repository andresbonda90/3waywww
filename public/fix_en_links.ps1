Add-Type -Path "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\hap\lib\Net45\HtmlAgilityPack.dll"

$files = @(
    "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\catalog\index.html",
    "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\logging\index.html",
    "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\clipping\index.html",
    "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\multiviewer\index.html"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        $htmlContent = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        $doc = New-Object HtmlAgilityPack.HtmlDocument
        $doc.LoadHtml($htmlContent)
        
        $links = $doc.DocumentNode.SelectNodes("//a[@href]")
        $changed = $false
        if ($links) {
            foreach ($link in $links) {
                $href = $link.GetAttributeValue("href", "")
                if ($href -match "^/([a-zA-Z0-9-_\.]+/?.*)$" -and $href -notmatch "^/en/" -and $href -notmatch "^/wp-content/") {
                    $link.SetAttributeValue("href", "/en$href")
                    $changed = $true
                }
            }
        }
        
        if ($changed) {
            $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
            $doc.Save($file, $utf8NoBom)
            Write-Host "Fixed links in $file"
        }
    }
}
