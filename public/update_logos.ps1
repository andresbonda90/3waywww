$baseDir = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public"
$logosDir = "$baseDir\wp-content\uploads\logos_clientes"
$indexFile = "$baseDir\en\index.html"

# Get all images
$images = Get-ChildItem -Path $logosDir -Recurse -File | Where-Object { $_.Extension -match "\.(png|jpg|jpeg|svg)$" }

$htmlParts = @()
foreach ($img in $images) {
    # Get relative path starting from /wp-content/...
    $relPath = $img.FullName.Substring($baseDir.Length).Replace('\', '/')
    # Replace backslashes just in case, though Substring does this.
    $altName = [System.IO.Path]::GetFileNameWithoutExtension($img.Name)
    $htmlParts += "                    <img src=`"$relPath`" alt=`"$altName`" class=`"client-logo`">"
}

# Duplicate the list so it scrolls infinitely without gaps
$allLogosHtml = ($htmlParts -join "`n") + "`n" + ($htmlParts -join "`n")

# Read index.html
$content = [System.IO.File]::ReadAllText($indexFile, [System.Text.Encoding]::UTF8)

# Replace the content of <div class="clients-track">
$regex = [regex]::new('(<div class="clients-track">)[\s\S]*?(</div>\s*</div>\s*</div>\s*</section>)')
$replacement = "`$1`n$allLogosHtml`n                `$2"

$newContent = $regex.Replace($content, $replacement)

[System.IO.File]::WriteAllText($indexFile, $newContent, [System.Text.Encoding]::UTF8)

Write-Host "Logos updated in index.html"
