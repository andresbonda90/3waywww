$file = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\clipping\index.html"
$content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)

# Define translations (Spanish to English)
$replacements = @{
    # Value props titles
    'Grabaci.n continua' = 'Continuous recording'
    'Clipping inmediato' = 'Immediate clipping'
    'Operaci.n web' = 'Web operation'
    'Publicaci.n r.pida' = 'Fast publishing'

    # Value props desc
    'Graba 24/7 en alta o baja resoluci.n de forma ininterrumpida.' = 'Records 24/7 in high or low resolution without interruptions.'
    'Gener. clips instant.neamente, mientras el evento sigue en vivo.' = 'Create clips instantly, while the event is still live.'
    'Acced. desde cualquier navegador web sin instalar software adicional.' = 'Access from any web browser without installing additional software.'
    'Export. y compart. clips en m.ltiples formatos y resoluciones.' = 'Export and share clips in multiple formats and resolutions.'

    # Section titles
    'Todo el proceso de clipping, en una sola plataforma' = 'The entire clipping process, on a single platform'
    'Recib. se.ales desde cualquier fuente' = 'Receive signals from any source'
    'Potencia tu Clipping con Inteligencia Artificial' = 'Boost your Clipping with Artificial Intelligence'
    '.Para qui.n es ViDeus Clipping\?' = 'Who is ViDeus Clipping for?'

    # Features titles
    'Clipping inmediato de TV en vivo' = 'Immediate clipping of live TV'
    'IA para entender el contenido' = 'AI to understand the content'
    'B.squeda inteligente sobre lo emitido' = 'Smart search on broadcast content'
    'Exportaci.n y publicaci.n multiformato' = 'Multi-format export and publishing'
    'Personalizaci.n y adaptaci.n para publicaci.n' = 'Customization and adaptation for publishing'
    'Monitoreo y archivo 24/7' = '24/7 monitoring and archiving'
    'Usuarios ilimitados' = 'Unlimited users'
    'API e integraci.n con otros sistemas' = 'API and integration with other systems'
    'Extracci.n directa sin reencoding' = 'Direct extraction without re-encoding'

    # Features desc
    'Recort. segmentos exactos mientras la transmisi.n a.n est. sucediendo.' = 'Trim exact segments while the broadcast is still happening.'
    'Analiz. el audio y video para generar metadatos autom.ticos y transcripciones.' = 'Analyze audio and video to generate automatic metadata and transcriptions.'
    'Encontr. r.pidamente los momentos clave usando palabras clave y filtros avanzados.' = 'Quickly find key moments using keywords and advanced filters.'
    'Envi. tus clips a redes sociales, VOD, o tu CMS en el formato correcto.' = 'Send your clips to social networks, VOD, or your CMS in the correct format.'
    'Agreg. marca de agua, gr.ficos, y ajust. la relaci.n de aspecto antes de publicar.' = 'Add watermarks, graphics, and adjust the aspect ratio before publishing.'
    'Manten. un registro completo de todas tus se.ales para auditor.a y cumplimiento.' = 'Keep a complete record of all your signals for auditing and compliance.'
    'Permit. que todo tu equipo colabore simult.neamente sin costos extra por licencia.' = 'Allow your whole team to collaborate simultaneously without extra license costs.'
    'Conect. ViDeus con tu flujo de trabajo actual mediante nuestra potente API.' = 'Connect ViDeus with your current workflow through our powerful API.'
    'Extra. los clips originales r.pidamente, preservando la calidad m.xima.' = 'Extract the original clips quickly, preserving maximum quality.'

    # Inputs section
    'Admite streaming IP, entradas de banda base y la mayor.a de los est.ndares de transmisi.n tradicionales.' = 'Supports IP streaming, baseband inputs, and most traditional broadcast standards.'

    # AI section features
    'Reconocimiento de logos' = 'Logo recognition'
    'Reconocimiento Facial' = 'Facial recognition'
    'Traducci.n de Audio' = 'Audio translation'
    'Speech to text' = 'Speech to text'
    'Identifica marcas y logotipos de patrocinadores o competidores en pantalla de forma autom.tica.' = 'Automatically identifies brands and sponsor logos on screen.'
    'Detecta y etiqueta figuras p.blicas o personajes clave presentes en el video.' = 'Detects and tags public figures or key characters present in the video.'
    'Genera subt.tulos o traducciones en tiempo real para alcanzar a audiencias globales.' = 'Generates subtitles or translations in real time to reach global audiences.'
    'Convierte todo el di.logo en texto indexable para que puedas buscar palabras exactas pronunciadas al aire.' = 'Converts all dialogue into indexable text so you can search for exact words spoken on air.'

    # Use Cases section
    'CANALES DE TV' = 'TV CHANNELS'
    'AGENCIAS DE NOTICIAS' = 'NEWS AGENCIES'
    'MEDIOS DIGITALES' = 'DIGITAL MEDIA'
    'CENTROS DE MONITOREO' = 'MONITORING CENTERS'
    
    'Recort. las noticias m.s importantes y publicalas en redes o portal web al instante, ganando la primicia.' = 'Trim the most important news and publish them on social networks or web portal instantly, breaking the news first.'
    'Acced. a material en vivo de m.ltiples fuentes para armar res.menes informativos en tiempo r.cord.' = 'Access live material from multiple sources to create news summaries in record time.'
    'Transform. la transmisi.n lineal en contenido bajo demanda \(VOD\) optimizado para consumo en tel.fonos y tablets.' = 'Transform linear broadcasting into video on demand (VOD) optimized for consumption on phones and tablets.'
    'Audit. las menciones de marca o las pautas publicitarias con b.squeda inteligente sobre todo lo emitido.' = 'Audit brand mentions or advertising guidelines with smart search across all broadcast content.'

    # CTA and bottom
    'PUBLICAR MA.S RA.PIDO' = 'PUBLISH FASTER'
    '¿Quer.s saber m.s\?' = 'Want to know more?'
    'Descargar Folleto PDF' = 'Download PDF Brochure'
    'Solicitar Demo' = 'Request Demo'
}

# The mojibake is annoying so we just use regex matching . for the special chars
foreach ($key in $replacements.Keys) {
    $pattern = '(?s)' + $key
    $replacement = $replacements[$key]
    $content = [regex]::Replace($content, $pattern, $replacement)
}

# Fix demo form placeholders
$content = $content -replace 'Nombre completo', 'Full name'
$content = $content -replace 'Correo electr.nico', 'Email address'
$content = $content -replace '.Cu.nto es X \+ Y\?', 'How much is X + Y?'
$content = $content -replace 'Enviar Solicitud', 'Send Request'
$content = $content -replace 'Ej: Juan P.rez', 'e.g. John Doe'
$content = $content -replace 'Complet. tus datos y nos pondremos en contacto.', 'Fill in your details and we will contact you.'

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($file, $content, $utf8NoBom)
Write-Host "Translated en/clipping/index.html"
