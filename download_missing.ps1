$logFile = "C:\Users\gmass\.gemini\antigravity-ide\brain\870188c7-e861-4b8c-8fb2-97ef02e674da\.system_generated\tasks\task-285.log"
$publicDir = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public"

$logContent = Get-Content $logFile
$failedUrls = @()
foreach ($line in $logContent) {
    if ($line -match '^Failed to download (https://i[0-2]\.wp\.com/.+)') {
        $failedUrls += $matches[1]
    }
}

$uniqueFailedUrls = $failedUrls | Sort-Object -Unique
Write-Host "Found $($uniqueFailedUrls.Count) failed URLs to retry."

$count = 0
foreach ($url in $uniqueFailedUrls) {
    $count++
    $url = $url.Trim()
    $relativePath = $url -replace '^https://i[0-2]\.wp\.com/3way\.com\.ar', ''
    $relativePath = $relativePath -replace '^https://i[0-2]\.wp\.com/www\.3way\.com\.ar', ''
    if ($relativePath -match '^https://') {
        $relativePath = $url.Substring($url.IndexOf('/wp-content/uploads/'))
    }
    
    $localPath = Join-Path $publicDir $relativePath
    $localDir = Split-Path $localPath
    if (-not (Test-Path $localDir)) {
        New-Item -ItemType Directory -Force -Path $localDir | Out-Null
    }
    
    if (-not (Test-Path $localPath)) {
        $downloadUrl = $url + "?w=1920&quality=80&strip=all"
        Write-Host "[$count / $($uniqueFailedUrls.Count)] Downloading: $relativePath"
        try {
            Invoke-WebRequest -Uri $downloadUrl -OutFile $localPath -UseBasicParsing -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" -ErrorAction Stop
            Start-Sleep -Milliseconds 150 # Prevent rate limiting
        } catch {
            Write-Host "Failed again: $url - Error: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}
Write-Host "Done downloading missing files."
