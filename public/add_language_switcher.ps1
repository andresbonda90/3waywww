$path = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public"
$files = Get-ChildItem -Path $path -Filter "*.html" -Recurse

$pattern = '</ul>\s*</nav>'
$replacement = '    <li class="lang-switch"><a href="/" style="padding: 0 5px;">ES</a>|<a href="/en/" style="padding: 0 5px;">EN</a></li>
                </ul>
            </nav>'

$count = 0

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    
    # Check if already added to avoid double adding
    if ($content -notmatch 'lang-switch') {
        $newContent = [regex]::Replace($content, $pattern, $replacement, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        
        if ($content -ne $newContent) {
            $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
            [System.IO.File]::WriteAllText($file.FullName, $newContent, $utf8NoBom)
            $count++
        }
    }
}
Write-Host "Added language switcher to $count files."
