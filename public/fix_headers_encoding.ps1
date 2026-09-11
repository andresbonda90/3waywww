$files = @(
    'c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\header_es.html',
    'c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\header_en.html'
)

$utf8NoBom = New-Object System.Text.UTF8Encoding($False)

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText($file, $utf8NoBom)
        
        $content = $content.Replace("â–¾", "▾")
        $content = $content.Replace("MÃ³dulos", "Módulos")
        $content = $content.Replace("EspaÃ±ol", "Español")
        $content = $content.Replace("ComparaciÃ³n", "Comparación")
        $content = $content.Replace("DetecciÃ³n", "Detección")
        $content = $content.Replace("CentralizaciÃ³n", "Centralización")
        $content = $content.Replace("SubtÃ­tulos", "Subtítulos")
        $content = $content.Replace("Ã©xito", "éxito")
        $content = $content.Replace("TecnologÃ­a", "Tecnología")
        $content = $content.Replace("auditorÃ­a", "auditoría")
        $content = $content.Replace("grabaciÃ³n", "grabación")
        $content = $content.Replace("producciÃ³n", "producción")
        $content = $content.Replace("distribuciÃ³n", "distribución")
        $content = $content.Replace("seÃ±ales", "señales")
        $content = $content.Replace("InnovaciÃ³n", "Innovación")
        
        [System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
    }
}
