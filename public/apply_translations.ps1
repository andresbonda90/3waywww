$files = @(
    "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\catalog\index.html",
    "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\logging\index.html",
    "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\clipping\index.html",
    "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\multiviewer\index.html"
)

$jsonStr = Get-Content -Path "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\replacements.json" -Raw -Encoding UTF8
$replacements = ConvertFrom-Json $jsonStr

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
        foreach ($replacement in $replacements) {
            $es = $replacement[0]
            $en = $replacement[1]
            $content = $content.Replace($es, $en)
        }
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
        Write-Host "Replaced text in $file"
    }
}
