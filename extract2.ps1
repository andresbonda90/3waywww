$files = @("public\en\catalog\index.html", "public\en\logging\index.html", "public\en\clipping\index.html", "public\en\multiviewer\index.html")
foreach ($f in $files) {
    Write-Host "--- $f ---"
    $content = Get-Content $f -Encoding UTF8 -Raw
    $matches = [regex]::Matches($content, '(?s)>([^<]{2,})<')
    foreach ($m in $matches) {
        $val = $m.Groups[1].Value.Trim()
        if ($val -match '[a-záéíóúñ]' -and $val -notmatch '^\s*$' -and $val -notmatch '(&bull;|#|▾)' -and $val -notmatch '^\s*var\s+' -and $val -notmatch '^\s*function') {
            Write-Host $val
        }
    }
}
