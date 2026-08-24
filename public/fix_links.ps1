Add-Type -Path "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\hap\lib\Net45\HtmlAgilityPack.dll"

$targetDir = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en"
$files = Get-ChildItem -Path $targetDir -Filter "*.html" -Recurse

$count = 0
foreach ($file in $files) {
    $htmlContent = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    $doc = New-Object HtmlAgilityPack.HtmlDocument
    $doc.LoadHtml($htmlContent)
    
    $changed = $false
    
    # Rewrite internal links
    $links = $doc.DocumentNode.SelectNodes("//a[@href]")
    if ($links) {
        foreach ($link in $links) {
            $href = $link.GetAttributeValue("href", "")
            
            # Fix root logo links
            if ($href -eq "/") {
                $link.SetAttributeValue("href", "/en/")
                $changed = $true
            }
            # Fix links in index.html that were skipped by the bot
            elseif ($file.FullName -match "en\\index\.html$") {
                if ($href -match "^/([a-zA-Z0-9-_\.]+/?.*)$" -and $href -notmatch "^/en/" -and $href -notmatch "^/wp-content/" -and $href -notmatch "\.css$") {
                    $link.SetAttributeValue("href", "/en$href")
                    $changed = $true
                }
            }
        }
    }
    
    if ($changed) {
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        $doc.Save($file.FullName, $utf8NoBom)
        $count++
    }
}

Write-Host "Link fixing finished. Updated $count files."
