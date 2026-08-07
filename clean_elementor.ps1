$ErrorActionPreference = "Stop"

$publicDir = Join-Path $PSScriptRoot "public"
$targetFiles = @(Join-Path $publicDir "index.html") # Just testing on index.html first

foreach ($file in $targetFiles) {
    if (Test-Path $file) {
        Write-Host "Processing $file"
        $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

        # 1. Remove elementor stylesheets (regex)
        $content = $content -replace '(?i)<link[^>]+href=["''][^>]*elementor[^>]+>', ''
        $content = $content -replace '(?i)<link[^>]+id=["'']elementor-[^>]+>', ''

        # 2. Remove elementor scripts
        $content = $content -replace '(?is)<script[^>]*src=["''][^>]*elementor[^>]+>.*?</script>', ''
        $content = $content -replace '(?is)<script[^>]*id=["'']elementor-[^>]+>.*?</script>', ''

        # 3. Replace elementor classes with custom classes to keep structure but remove elementor dependency
        $content = $content -replace '\belementor-container\b', 'custom-container'
        $content = $content -replace '\belementor-row\b', 'custom-row'
        $content = $content -replace '\belementor-column\b', 'custom-column'
        $content = $content -replace '\belementor-widget-wrap\b', 'custom-widget-wrap'
        $content = $content -replace '\belementor-section\b', 'custom-section'
        $content = $content -replace '\belementor-widget\b', 'custom-widget'
        
        # Strip all other elementor-* classes (best effort)
        $content = $content -replace '\belementor-[a-zA-Z0-9_-]+\b', ''

        # 4. Inject custom CSS
        $customCssTag = '<link rel="stylesheet" href="/styles/custom-layout.css">'
        if ($content -notmatch 'custom-layout.css') {
            $content = $content -replace '</head>', "`n    $customCssTag`n</head>"
        }

        [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Finished processing $file"
    } else {
        Write-Host "File not found: $file"
    }
}
