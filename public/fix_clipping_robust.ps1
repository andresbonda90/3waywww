$file = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\clipping\index.html"
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# The replacements list with '.' for accented/mojibake characters
$replacements = @{
    # Feature intro
    'Recib. y monitore. se.ales de TV en vivo directamente desde plataformas OTT, incluso contenidos protegidos con DRM.' = 'Receive and monitor live TV signals directly from OTT platforms, including DRM-protected content.'
    'La plataforma accede al streaming desde su origen digital, sin necesidad de decodificadores, set-top boxes ni hardware de recepci.n dedicado por canal.' = 'The platform accesses streaming from its digital origin, without the need for decoders, set-top boxes, or dedicated receiving hardware per channel.'
    'Menos equipos. Menos infraestructura. Una integraci.n m.s simple.' = 'Fewer devices. Less infrastructure. Simpler integration.'
    'Conoce m.s de esta soluci.n aqu.' = 'Learn more about this solution here'
    
    # Feature 1-9 descriptions
    'Navegaci.n visual sobre la se.al grabada, selecci.n de puntos IN/OUT y creaci.n de clips en segundos.' = 'Visual navigation over the recorded signal, selection of IN/OUT points, and clip creation in seconds.'
    'Speech-to-Text autom.tico, detecci.n de entidades y personas, y generaci.n autom.tica de t.tulos, categor.as, etiquetas y descripciones.' = 'Automatic Speech-to-Text, detection of entities and people, and automatic generation of titles, categories, tags, and descriptions.'
    'Encontr. r.pidamente personas, marcas, temas o palabras dentro de grandes vol.menes de programaci.n.' = 'Quickly find people, brands, topics, or words within large volumes of programming.'
    'Generaci.n de clips en MP4, diferentes resoluciones y calidades, preparados para TV, web, redes sociales y otras plataformas digitales.' = 'Generation of MP4 clips in different resolutions and qualities, ready for TV, web, social networks, and other digital platforms.'
    'Incorporaci.n de logos y marcas de agua, adaptaci.n a diferentes relaciones de aspecto —horizontal, vertical o cuadrado— y generaci.n de clips con subt.tulos quemados.' = 'Addition of logos and watermarks, adaptation to different aspect ratios —horizontal, vertical, or square— and generation of clips with burned-in subtitles.'
    'Continuous recording de m.ltiples canales para volver atr.s, buscar, visualizar, recortar y recuperar cualquier contenido emitido.' = 'Continuous recording of multiple channels to go back, search, view, trim, and recover any broadcast content.'
    'Sin l.mite de licencias por usuario. Periodistas, productores, editores y operadores pueden trabajar simult.neamente sobre la misma plataforma.' = 'No user license limits. Journalists, producers, editors, and operators can work simultaneously on the same platform.'
    'API para integrar ViDeus Clipping con CMS, MAM, sistemas de noticias, automatizaci.n y otras plataformas del cliente.' = 'API to integrate ViDeus Clipping with CMS, MAM, newsroom systems, automation, and other client platforms.'
    'Cuando el formato y el flujo lo permiten, ViDeus extrae el segmento directamente del material grabado, sin procesos innecesarios de edici.n o reencoding, acelerando la generaci.n del clip y permitiendo publicar m.s r.pido.' = 'When the format and workflow allow it, ViDeus extracts the segment directly from the recorded material, without unnecessary editing or re-encoding processes, accelerating clip generation and allowing faster publishing.'
    
    # AI Features
    'NUEVA FUNCIONALIDAD' = 'NEW FEATURE'
    'Automatiza procesos, acelera los tiempos de publicaci.n y extrae informaci.n valiosa de tus transmisiones en tiempo real.' = 'Automate processes, accelerate publishing times, and extract valuable information from your broadcasts in real time.'
    'Highlights Autom.ticos:' = 'Automatic Highlights:'
    'Res.menes instant.neos.' = 'Instant summaries.'
    'Transcripci.n:' = 'Transcription:'
    'B.squeda exacta de texto en audio.' = 'Exact text search in audio.'
    'Oradores:' = 'Speakers:'
    'Identificaci.n de voces.' = 'Voice identification.'
    'Rostros:' = 'Faces:'
    'Detecci.n de figuras p.blicas.' = 'Detection of public figures.'
    'Asistencia LLM:' = 'LLM Assistance:'
    'Conclusiones contextuales.' = 'Contextual insights.'
    'Alarmas:' = 'Alarms:'
    'Notificaciones inteligentes.' = 'Smart notifications.'
    'Sentimientos:' = 'Sentiments:'
    'Evaluaci.n de menciones.' = 'Mention evaluation.'
    'Autotagging:' = 'Autotagging:'
    'Metadatos SEO autom.ticos.' = 'Automatic SEO metadata.'
}

foreach ($key in $replacements.Keys) {
    # Using Regex replace to handle '.' wildcards correctly
    $content = [regex]::Replace($content, $key, $replacements[$key])
}

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
Write-Host "Re-applied translations with wildcard regex to handle encoding issues in en/clipping/index.html"
