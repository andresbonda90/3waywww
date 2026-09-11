$files = @("public\en\clipping\index.html", "public\en\multiviewer\index.html")
$all = @()
foreach ($f in $files) {
    $content = Get-Content $f -Encoding UTF8 -Raw
    $matches = [regex]::Matches($content, '(?s)>([^<]{2,})<')
    foreach ($m in $matches) {
        $val = $m.Groups[1].Value.Trim()
        if ($val -match '[a-záéíóúñ]' -and $val -notmatch '^\s*$' -and $val -notmatch '(&bull;|#|▾)' -and $val -notmatch '^\s*var\s+' -and $val -notmatch '^\s*function') {
            if ($val -match '^[A-Z]') {
                $all += $val
            }
        }
    }
}
$all | Select-Object -Unique | ConvertTo-Json
