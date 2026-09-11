$file = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\clipping\index.html"
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# Translations for AI Features and other missed descriptions
$replacements = @{
    # Feature intro
    'Recibí y monitoreá señales de TV en vivo directamente desde plataformas OTT, incluso contenidos protegidos con DRM.' = 'Receive and monitor live TV signals directly from OTT platforms, including DRM-protected content.'
    'La plataforma accede al streaming desde su origen digital, sin necesidad de decodificadores, set-top boxes ni hardware de recepción dedicado por canal.' = 'The platform accesses streaming from its digital origin, without the need for decoders, set-top boxes, or dedicated receiving hardware per channel.'
    'Menos equipos. Menos infraestructura. Una integración más simple.' = 'Fewer devices. Less infrastructure. Simpler integration.'
    'Conoce más de esta solución aquí' = 'Learn more about this solution here'
    
    # Feature 1-9 descriptions
    'Navegación visual sobre la señal grabada, selección de puntos IN/OUT y creación de clips en segundos.' = 'Visual navigation over the recorded signal, selection of IN/OUT points, and clip creation in seconds.'
    'Speech-to-Text automático, detección de entidades y personas, y generación automática de títulos, categorías, etiquetas y descripciones.' = 'Automatic Speech-to-Text, detection of entities and people, and automatic generation of titles, categories, tags, and descriptions.'
    'Encontrá rápidamente personas, marcas, temas o palabras dentro de grandes volúmenes de programación.' = 'Quickly find people, brands, topics, or words within large volumes of programming.'
    'Generación de clips en MP4, diferentes resoluciones y calidades, preparados para TV, web, redes sociales y otras plataformas digitales.' = 'Generation of MP4 clips in different resolutions and qualities, ready for TV, web, social networks, and other digital platforms.'
    'Incorporación de logos y marcas de agua, adaptación a diferentes relaciones de aspecto —horizontal, vertical o cuadrado— y generación de clips con subtítulos quemados.' = 'Addition of logos and watermarks, adaptation to different aspect ratios —horizontal, vertical, or square— and generation of clips with burned-in subtitles.'
    'Continuous recording de múltiples canales para volver atrás, buscar, visualizar, recortar y recuperar cualquier contenido emitido.' = 'Continuous recording of multiple channels to go back, search, view, trim, and recover any broadcast content.'
    'Sin límite de licencias por usuario. Periodistas, productores, editores y operadores pueden trabajar simultáneamente sobre la misma plataforma.' = 'No user license limits. Journalists, producers, editors, and operators can work simultaneously on the same platform.'
    'API para integrar ViDeus Clipping con CMS, MAM, sistemas de noticias, automatización y otras plataformas del cliente.' = 'API to integrate ViDeus Clipping with CMS, MAM, newsroom systems, automation, and other client platforms.'
    'Cuando el formato y el flujo lo permiten, ViDeus extrae el segmento directamente del material grabado, sin procesos innecesarios de edición o reencoding, acelerando la generación del clip y permitiendo publicar más rápido.' = 'When the format and workflow allow it, ViDeus extracts the segment directly from the recorded material, without unnecessary editing or re-encoding processes, accelerating clip generation and allowing faster publishing.'
    
    # AI Features
    'NUEVA FUNCIONALIDAD' = 'NEW FEATURE'
    'Automatiza procesos, acelera los tiempos de publicación y extrae información valiosa de tus transmisiones en tiempo real.' = 'Automate processes, accelerate publishing times, and extract valuable information from your broadcasts in real time.'
    'Highlights Automáticos:' = 'Automatic Highlights:'
    'Resúmenes instantáneos.' = 'Instant summaries.'
    'Transcripción:' = 'Transcription:'
    'Búsqueda exacta de texto en audio.' = 'Exact text search in audio.'
    'Oradores:' = 'Speakers:'
    'Identificación de voces.' = 'Voice identification.'
    'Rostros:' = 'Faces:'
    'Detección de figuras públicas.' = 'Detection of public figures.'
    'Asistencia LLM:' = 'LLM Assistance:'
    'Conclusiones contextuales.' = 'Contextual insights.'
    'Alarmas:' = 'Alarms:'
    'Notificaciones inteligentes.' = 'Smart notifications.'
    'Sentimientos:' = 'Sentiments:'
    'Evaluación de menciones.' = 'Mention evaluation.'
    'Autotagging:' = 'Autotagging:'
    'Metadatos SEO automáticos.' = 'Automatic SEO metadata.'
}

foreach ($key in $replacements.Keys) {
    # Escape regex special characters just in case, though standard Replace is literal in .NET
    $content = $content.Replace($key, $replacements[$key])
}

# Fix PUBLISH FASTER Mojibake
$content = [regex]::Replace($content, 'PUBLICAR MA\?S RA\?PIDO', 'PUBLISH FASTER')

# Replace formats-table-wrapper entirely with the one from logging
$loggingFile = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\logging\index.html"
$loggingContent = [System.IO.File]::ReadAllText($loggingFile, [System.Text.Encoding]::UTF8)

$tableMatch = [regex]::Match($loggingContent, '(?s)<div class="formats-table-wrapper">.*?</div>\s*</div>\s*</section>')
if ($tableMatch.Success) {
    $tableHtml = $tableMatch.Value
    # Replace in clipping
    $content = [regex]::Replace($content, '(?s)<div class="formats-table-wrapper">.*?</div>\s*</div>\s*</section>', $tableHtml)
}

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
Write-Host "Completed translation fix for en/clipping/index.html"
