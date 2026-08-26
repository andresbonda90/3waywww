Add-Type -AssemblyName System.Drawing

$dir = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\wp-content\uploads"
$maxSize = 800KB

$images = Get-ChildItem -Path $dir -Filter "*.png" | Where-Object { $_.Name -match "clipping" -and $_.Length -gt $maxSize }

foreach ($img in $images) {
    Write-Host "Processing $($img.Name) ($($img.Length) bytes)"
    
    $currentLength = $img.Length
    
    while ($currentLength -gt $maxSize) {
        $scale = 0.8 # Reduce by 20% each iteration
        $original = [System.Drawing.Image]::FromFile($img.FullName)
        $newWidth = [int]($original.Width * $scale)
        $newHeight = [int]($original.Height * $scale)
        
        $bitmap = New-Object System.Drawing.Bitmap $newWidth, $newHeight
        $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.DrawImage($original, 0, 0, $newWidth, $newHeight)
        
        $original.Dispose()
        $graphics.Dispose()
        
        $tempPath = $img.FullName + ".tmp"
        $bitmap.Save($tempPath, [System.Drawing.Imaging.ImageFormat]::Png)
        $bitmap.Dispose()
        
        Move-Item -Path $tempPath -Destination $img.FullName -Force
        
        $currentLength = (Get-Item $img.FullName).Length
        Write-Host "New size for $($img.Name): $currentLength"
    }
}
