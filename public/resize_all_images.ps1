Add-Type -AssemblyName System.Drawing

$logosDir = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\wp-content\uploads\logos_clientes"
$homeImages = @(
    "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\wp-content\uploads\logging4.png",
    "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\wp-content\uploads\clipping1.png",
    "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\wp-content\uploads\multiviewer1.png",
    "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\wp-content\uploads\hero_monitor_transparent.png"
)

function Resize-ImageToMaxHeight {
    param(
        [string]$Path,
        [int]$MaxHeight
    )
    
    if (-not (Test-Path $Path)) {
        Write-Host "File not found: $Path"
        return
    }

    $original = [System.Drawing.Image]::FromFile($Path)
    if ($original.Height -le $MaxHeight) {
        $original.Dispose()
        return
    }

    $scale = $MaxHeight / $original.Height
    $newWidth = [int]($original.Width * $scale)
    $newHeight = $MaxHeight

    Write-Host "Resizing $($Path) from $($original.Width)x$($original.Height) to $($newWidth)x$($newHeight)"

    $bitmap = New-Object System.Drawing.Bitmap $newWidth, $newHeight
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.DrawImage($original, 0, 0, $newWidth, $newHeight)
    
    $original.Dispose()
    $graphics.Dispose()
    
    $tempPath = $Path + ".tmp"
    if ($Path.EndsWith(".png")) {
        $bitmap.Save($tempPath, [System.Drawing.Imaging.ImageFormat]::Png)
    } else {
        $bitmap.Save($tempPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    }
    $bitmap.Dispose()
    
    Move-Item -Path $tempPath -Destination $Path -Force
}

# 1. Resize logos
$logos = Get-ChildItem -Path $logosDir -Recurse -Include "*.png", "*.jpg", "*.jpeg"
foreach ($logo in $logos) {
    Resize-ImageToMaxHeight -Path $logo.FullName -MaxHeight 150
}

# 2. Resize home images
foreach ($img in $homeImages) {
    Resize-ImageToMaxHeight -Path $img -MaxHeight 700
}

Write-Host "Image resizing completed."
