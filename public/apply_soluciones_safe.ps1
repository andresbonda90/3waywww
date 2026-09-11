$utf8NoBom = New-Object System.Text.UTF8Encoding($False)

function Update-Soluciones($file, $isEng) {
    $content = [System.IO.File]::ReadAllText($file, $utf8NoBom)
    $lines = $content -split "`r?`n"
    
    $newLines = @()
    for ($i=0; $i -lt 548; $i++) { $newLines += $lines[$i] }
    
    $title = if ($isEng) { "Our Solutions" } else { "Nuestras Soluciones" }
    $desc = if ($isEng) { "Professional grade systems for auditing, recording, production and distribution of TV and radio signals. Innovation and reliability for the broadcast industry." } else { "Sistemas de grado profesional para auditoría, grabación, producción y distribución de señales de TV y radio. Innovación y confiabilidad para la industria broadcast." }
    
    $m_desc = if ($isEng) { "Multiviewer IP and Baseband software for technical and visual monitoring of multiple signals." } else { "Software de Multiviewer IP y Banda Base para monitoreo técnico y visual de múltiples señales." }
    $c_desc = if ($isEng) { "Radio and TV recording software for quick clip extraction and content creation." } else { "Software de grabación de Radio y TV para extracción rápida de clips y creación de contenidos." }
    $l_desc = if ($isEng) { "Continuous legal registration and quality audit systems for broadcasters." } else { "Sistemas de registro continuo legal y auditoría de calidad para emisoras." }
    $co_title = if ($isEng) { "Cable Operator" } else { "Cable Operador" }
    $co_desc = if ($isEng) { "Comprehensive monitoring solutions for distribution networks and cable headends." } else { "Soluciones integrales de monitoreo para redes de distribución y cabeceras de cable." }
    $ca_desc = if ($isEng) { "Media Asset Management with integrated on-premise AI." } else { "Media Asset Management con IA on-premise integrada." }
    
    $linkPrefix = if ($isEng) { "/en" } else { "" }

    $newLines += '    <!-- STYLES FOR PRODUCTS -->'
    $newLines += '    <style>'
    $newLines += '        .modern-hero { padding: 150px 20px 80px; text-align: center; background: linear-gradient(135deg, #0f172a 0%, #1e3a8a 100%); color: white; font-family: "Open Sans", sans-serif; }'
    $newLines += '        .modern-hero h1 { font-size: 3.5rem; font-weight: 800; margin-bottom: 20px; color: white; }'
    $newLines += '        .modern-hero p { font-size: 1.25rem; color: #cbd5e1; max-width: 700px; margin: 0 auto; line-height: 1.6; }'
    $newLines += '        .modern-products-section { padding: 80px 20px; background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%); font-family: "Open Sans", sans-serif; }'
    $newLines += '        .modern-products-container { max-width: 1200px; margin: 0 auto; }'
    $newLines += '        .modern-products-grid { display: flex; flex-wrap: wrap; gap: 30px; justify-content: center; padding: 20px; }'
    $newLines += '        .modern-product-card { width: 320px; background: rgba(255, 255, 255, 0.7); backdrop-filter: blur(10px); border: 1px solid rgba(255, 255, 255, 0.5); border-radius: 16px; padding: 40px 30px; text-align: center; text-decoration: none; color: #1e293b; transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275); box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05); display: flex; flex-direction: column; align-items: center; }'
    $newLines += '        .modern-product-card:hover { transform: translateY(-10px); box-shadow: 0 20px 40px rgba(59, 130, 246, 0.15); background: rgba(255, 255, 255, 0.95); border-color: rgba(59, 130, 246, 0.3); }'
    $newLines += '        .modern-product-icon { height: 80px; margin-bottom: 25px; transition: transform 0.4s ease; }'
    $newLines += '        .modern-product-card:hover .modern-product-icon { transform: scale(1.1); }'
    $newLines += '        .modern-product-title { font-size: 1.5rem; font-weight: 700; margin-bottom: 15px; color: #0f172a; }'
    $newLines += '        .modern-product-desc { font-size: 1rem; color: #475569; line-height: 1.6; margin: 0; }'
    $newLines += '    </style>'
    $newLines += '    <section class="modern-hero">'
    $newLines += '        <h1>' + $title + '</h1>'
    $newLines += '        <p>' + $desc + '</p>'
    $newLines += '    </section>'
    $newLines += '    <section class="modern-products-section">'
    $newLines += '        <div class="modern-products-container">'
    $newLines += '            <div class="modern-products-grid">'
    $newLines += '                <a href="' + $linkPrefix + '/multiviewer/" class="modern-product-card">'
    $newLines += '                    <img src="/wp-content/uploads/2024/01/multiviewer-05.png" alt="Multiviewer" class="modern-product-icon">'
    $newLines += '                    <h3 class="modern-product-title">Multiviewer</h3>'
    $newLines += '                    <p class="modern-product-desc">' + $m_desc + '</p>'
    $newLines += '                </a>'
    $newLines += '                <a href="' + $linkPrefix + '/clipping/" class="modern-product-card">'
    $newLines += '                    <img src="/wp-content/uploads/2024/01/mas-06.png" alt="Clipping" class="modern-product-icon">'
    $newLines += '                    <h3 class="modern-product-title">Clipping</h3>'
    $newLines += '                    <p class="modern-product-desc">' + $c_desc + '</p>'
    $newLines += '                </a>'
    $newLines += '                <a href="' + $linkPrefix + '/logging/" class="modern-product-card">'
    $newLines += '                    <img src="/wp-content/uploads/2024/01/logging-03.png" alt="Logging" class="modern-product-icon">'
    $newLines += '                    <h3 class="modern-product-title">Logging</h3>'
    $newLines += '                    <p class="modern-product-desc">' + $l_desc + '</p>'
    $newLines += '                </a>'
    $newLines += '                <a href="' + $linkPrefix + '/cableoperador/" class="modern-product-card">'
    $newLines += '                    <img src="/wp-content/uploads/2024/01/cableoperador-04.png" alt="Cable TV" class="modern-product-icon">'
    $newLines += '                    <h3 class="modern-product-title">' + $co_title + '</h3>'
    $newLines += '                    <p class="modern-product-desc">' + $co_desc + '</p>'
    $newLines += '                </a>'
    $newLines += '                <a href="' + $linkPrefix + '/catalog/" class="modern-product-card">'
    $newLines += '                    <img src="/wp-content/uploads/2024/02/mosaic-02.png" alt="Catalog" class="modern-product-icon">'
    $newLines += '                    <h3 class="modern-product-title">ViDeus Catalog</h3>'
    $newLines += '                    <p class="modern-product-desc">' + $ca_desc + '</p>'
    $newLines += '                </a>'
    $newLines += '            </div>'
    $newLines += '        </div>'
    $newLines += '    </section>'
    for ($i=675; $i -lt $lines.Length; $i++) { $newLines += $lines[$i] }
    
    $finalContent = $newLines -join "`n"
    [System.IO.File]::WriteAllText($file, $finalContent, $utf8NoBom)
}

Update-Soluciones 'c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\soluciones\index.html' $false
Update-Soluciones 'c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\soluciones\index.html' $true
