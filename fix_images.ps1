$Utf8NoBom = New-Object System.Text.UTF8Encoding $False
$publicDir = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public"

Write-Host "Finding all HTML and CSS files..."
$files = Get-ChildItem -Path $publicDir -Include "*.html", "*.css" -Recurse

# 1. Extract all unique base URLs
$regex = '(https://i[0-2]\.wp\.com/[^"''\s\?]+)'
$urls = @{}

Write-Host "Extracting Jetpack URLs..."
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, $Utf8NoBom)
    $matches = [regex]::Matches($content, $regex)
    foreach ($match in $matches) {
        $baseUrl = $match.Groups[1].Value
        # Filter out anything that doesn't look like an image upload
        if ($baseUrl -match '/wp-content/uploads/') {
            $urls[$baseUrl] = $true
        }
    }
}

$uniqueUrls = $urls.Keys | Sort-Object
Write-Host "Found $($uniqueUrls.Count) unique image URLs to download."

# 2. Download and compress images
$count = 0
foreach ($url in $uniqueUrls) {
    $count++
    # Get relative path: e.g. /wp-content/uploads/2026/05/catalog.png
    $relativePath = $url -replace '^https://i[0-2]\.wp\.com/3way\.com\.ar', ''
    $relativePath = $relativePath -replace '^https://i[0-2]\.wp\.com/www\.3way\.com\.ar', ''
    
    # If the URL is from another domain, skip or just put it in a generic folder
    if ($relativePath -match '^https://') {
        $relativePath = $url.Substring($url.IndexOf('/wp-content/uploads/'))
    }
    
    $localPath = Join-Path $publicDir $relativePath
    $localDir = Split-Path $localPath
    
    if (-not (Test-Path $localDir)) {
        New-Item -ItemType Directory -Force -Path $localDir | Out-Null
    }
    
    # Skip if already downloaded
    if (-not (Test-Path $localPath)) {
        # Create Jetpack compressed URL
        $downloadUrl = "$url?w=1920&quality=80&strip=all"
        Write-Host "[$count / $($uniqueUrls.Count)] Downloading: $relativePath"
        try {
            Invoke-WebRequest -Uri $downloadUrl -OutFile $localPath -UseBasicParsing -ErrorAction Stop
        } catch {
            Write-Host "Failed to download $url" -ForegroundColor Red
        }
    }
}

# 3. Clean HTML/CSS and replace URLs
Write-Host "Cleaning HTML/CSS files..."
foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, $Utf8NoBom)
    $originalContent = $content
    
    if ($file.Extension -eq '.html') {
        # Remove srcset and sizes attributes entirely
        $content = $content -replace '(?is)\s+srcset="[^"]*"', ''
        $content = $content -replace '(?is)\s+sizes="[^"]*"', ''
        $content = $content -replace '(?is)\s+data-orig-file="[^"]*"', ''
        $content = $content -replace '(?is)\s+data-large-file="[^"]*"', ''
        $content = $content -replace '(?is)\s+data-image-meta="[^"]*"', ''
    }
    
    # Replace the Jetpack base URLs with relative URLs, including any query parameters attached to them
    # Because we removed srcset, we only need to clean up src and css backgrounds
    # We replace: https://iX.wp.com/3way.com.ar/wp-content/uploads/...[?args] -> /wp-content/uploads/...
    # Regex to match the full jetpack url with optional query params
    $jetpackRegex = 'https://i[0-2]\.wp\.com/(?:www\.)?3way\.com\.ar(/wp-content/uploads/[^"''\s\?]+)(?:\?[^"''\s]*)?'
    $content = [regex]::Replace($content, $jetpackRegex, '$1')
    
    if ($content -cne $originalContent) {
        [System.IO.File]::WriteAllText($file.FullName, $content, $Utf8NoBom)
    }
}

Write-Host "Done! All images processed and files updated."
