Add-Type -Path "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\hap\lib\Net45\HtmlAgilityPack.dll"

$targetDir = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en"
$files = Get-ChildItem -Path $targetDir -Filter "*.html" -Recurse

function Translate-Text {
    param([string]$text)
    
    if ([string]::IsNullOrWhiteSpace($text) -or $text -notmatch "[a-zA-Z]") {
        return $text
    }
    
    # Rate limit protection
    Start-Sleep -Milliseconds 50
    
    $trimmed = $text.Trim()
    $encoded = [System.Uri]::EscapeDataString($trimmed)
    $url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=es&tl=en&dt=t&q=$encoded"
    
    try {
        $response = Invoke-RestMethod -Uri $url -Method Get
        $translated = ""
        foreach ($sentence in $response[0]) {
            $translated += $sentence[0]
        }
        
        $prefix = ""
        $suffix = ""
        if ($text -match "^(\s+)") { $prefix = $matches[1] }
        if ($text -match "(\s+)$") { $suffix = $matches[1] }
        
        return $prefix + $translated + $suffix
    }
    catch {
        Write-Host "Error translating text '$($trimmed)': $($_.Exception.Message)"
        return $text
    }
}

$count = 0
foreach ($file in $files) {
    if ($file.FullName -match "en\\index\.html$") {
        Write-Host "Skipping manually translated index: $($file.FullName)"
        continue
    }
    
    Write-Host "Translating file: $($file.FullName)"
    
    $htmlContent = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    $doc = New-Object HtmlAgilityPack.HtmlDocument
    $doc.LoadHtml($htmlContent)
    
    $nodes = $doc.DocumentNode.SelectNodes("//text()[not(ancestor::script) and not(ancestor::style) and not(ancestor::noscript)]")
    
    if ($nodes) {
        $nodeCount = 0
        foreach ($node in $nodes) {
            $originalText = $node.InnerHtml
            
            if ($originalText -match "^\s*<" -or $originalText -notmatch "\p{L}") {
                continue
            }
            if ($originalText.Trim() -eq "&nbsp;") { continue }
            
            $decoded = [System.Net.WebUtility]::HtmlDecode($originalText)
            $translatedDecoded = Translate-Text -text $decoded
            
            if ($translatedDecoded -ne $decoded) {
                $encodedTranslated = [System.Net.WebUtility]::HtmlEncode($translatedDecoded)
                $node.InnerHtml = $encodedTranslated
                $nodeCount++
            }
        }
        Write-Host "   -> Translated $nodeCount text nodes."
    }
    
    # Rewrite internal links
    $links = $doc.DocumentNode.SelectNodes("//a[@href]")
    if ($links) {
        foreach ($link in $links) {
            $href = $link.GetAttributeValue("href", "")
            if ($href -match "^/([a-zA-Z0-9-_\.]+/?.*)$" -and $href -notmatch "^/en/" -and $href -notmatch "^/wp-content/") {
                $link.SetAttributeValue("href", "/en$href")
            }
        }
    }
    
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    $doc.Save($file.FullName, $utf8NoBom)
    $count++
}

Write-Host "Translation finished. Processed $count files."
