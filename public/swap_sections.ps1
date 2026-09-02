$content = Get-Content "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\multiviewer\index.html"

# Array is 0-indexed.
# Lines 1 to 583 -> Indices 0 to 582
$part1 = $content[0..582]

# Lines 584 to 642 (Funcionalidades) -> Indices 583 to 641
$funcionalidades = $content[583..641]

# Lines 643 to 716 (Fuentes y formatos + empty line) -> Indices 642 to 715
$formatos = $content[642..715]

# Lines 717 to end -> Indices 716 to end
$part2 = $content[716..($content.Length - 1)]

$newContent = $part1 + $formatos + $funcionalidades + $part2
$newContent | Set-Content "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\multiviewer\index.html"
