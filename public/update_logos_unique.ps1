$baseDir = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public"
$logosDir = "$baseDir\wp-content\uploads\logos_clientes"
$filesToUpdate = @("$baseDir\index.html", "$baseDir\en\index.html")

# Get all images
$images = Get-ChildItem -Path $logosDir -Recurse -File | Where-Object { $_.Extension -match "\.(png|jpg|jpeg|svg)$" }

# Deduplicate by BaseName (case insensitive)
$uniqueLogos = @{}
foreach ($img in $images) {
    # Some files have "Copia de " in them, let's remove it for the key just in case, but keep the file path.
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($img.Name).ToLower()
    $baseName = $baseName -replace "^copia de ", ""
    
    if (-not $uniqueLogos.ContainsKey($baseName)) {
        $uniqueLogos[$baseName] = $img
    }
}

$htmlParts = @()
foreach ($key in $uniqueLogos.Keys) {
    $img = $uniqueLogos[$key]
    $relPath = $img.FullName.Substring($baseDir.Length).Replace('\', '/')
    $altName = [System.IO.Path]::GetFileNameWithoutExtension($img.Name)
    $htmlParts += "                    <img src=`"$relPath`" alt=`"$altName`" class=`"client-logo`">"
}
$allLogosHtml = $htmlParts -join "`n"

$jsSnippet = @"
<script>
document.addEventListener("DOMContentLoaded", function() {
    const track = document.querySelector('.clients-track');
    if (track) {
        let logos = Array.from(track.children);
        for (let i = logos.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [logos[i], logos[j]] = [logos[j], logos[i]];
        }
        track.innerHTML = '';
        logos.forEach(logo => track.appendChild(logo));
        logos.forEach(logo => track.appendChild(logo.cloneNode(true)));
    }
});
</script>
"@

foreach ($file in $filesToUpdate) {
    $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

    # Replace the content of <div class="clients-track"> ... </div> with only unique logos
    $regex = [regex]::new('(<div class="clients-track">)[\s\S]*?(</div>\s*</div>\s*</div>\s*</section>)')
    
    # First, make sure we remove any previously injected <script> for this so we don't duplicate it.
    # We will inject the script right after </section>
    $replacement = "`$1`n$allLogosHtml`n                `$2`n    $jsSnippet"
    
    # If the script already exists, remove it first
    $content = $content -replace '(?s)<script>\s*document\.addEventListener\("DOMContentLoaded", function\(\) \{\s*const track = document\.querySelector\(''\.clients-track''\);.*?</script>\s*', ''

    $newContent = $regex.Replace($content, $replacement)

    [System.IO.File]::WriteAllText($file, $newContent, [System.Text.Encoding]::UTF8)
    Write-Host "Logos updated in $file"
}
