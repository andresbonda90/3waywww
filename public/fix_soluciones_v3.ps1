$utf8NoBom = New-Object System.Text.UTF8Encoding($False)

function Fix-MojibakeAndStyle($file) {
    $content = [System.IO.File]::ReadAllText($file, $utf8NoBom)
    
    # Fix layout
    $content = $content -replace 'padding: 150px 20px 80px;', 'padding: 250px 20px 80px;'
    $content = $content -replace '\.modern-product-icon \{ height: 80px;', '.modern-product-icon { max-height: 80px; width: auto; max-width: 100%;'
    
    # Fix Mojibake
    $content = $content.Replace("MÃ³dulos", "Módulos")
    $content = $content.Replace("EspaÃ±ol", "Español")
    $content = $content.Replace("auditorÃa", "auditoría")
    $content = $content.Replace("grabaciÃ³n", "grabación")
    $content = $content.Replace("producciÃ³n", "producción")
    $content = $content.Replace("distribuciÃ³n", "distribución")
    $content = $content.Replace("seÃ±ales", "señales")
    $content = $content.Replace("InnovaciÃ³n", "Innovación")
    $content = $content.Replace("Ã©xito", "éxito")
    $content = $content.Replace("TecnologÃa", "Tecnología")
    $content = $content.Replace("SoluciÃ³n", "Solución")
    $content = $content.Replace("PRODUCTOS Â-¾", "PRODUCTOS ▾")
    $content = $content.Replace("IA Â-¾", "IA ▾")
    $content = $content.Replace("Módulos Â-¾", "Módulos ▾")
    $content = $content.Replace("EMPRESA Â-¾", "EMPRESA ▾")
    $content = $content.Replace("MÃ³dulos Â-¾", "Módulos ▾")
    
    [System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
}

Fix-MojibakeAndStyle 'c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\soluciones\index.html'
Fix-MojibakeAndStyle 'c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\soluciones\index.html'
