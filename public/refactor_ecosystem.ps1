$baseDir = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public"
$indexFile = "$baseDir\index.html"
$styleFile = "$baseDir\style_v2.css"

$newEcosystemHtml = @"
    <!-- 3. Ecosistema -->
    <section class="home-ecosystem">
        <div class="container">
            <h2>Una arquitectura. Múltiples posibilidades.</h2>
            <p class="ecosystem-subtitle">Cada operación es diferente. Las soluciones ViDeus pueden implementarse de forma independiente o integrarse entre sí según las necesidades de cada proyecto.</p>
            
            <div class="ecosystem-radial">
                <div class="radial-center">
                    <span class="radial-center-title">ViDeus</span>
                </div>
                
                <div class="radial-node node-top">
                    <div class="node-icon"><svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 14.899A7 7 0 1 1 15.71 8h1.79a4.5 4.5 0 0 1 2.5 8.242"></path><path d="M12 12v9"></path><path d="m8 17 4-4 4 4"></path></svg></div>
                    <h4>MONITOREAR</h4>
                    <p>Señales y servicios en tiempo real.</p>
                </div>
                
                <div class="radial-node node-top-right">
                    <div class="node-icon"><svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><circle cx="12" cy="12" r="3"></circle></svg></div>
                    <h4>GRABAR</h4>
                    <p>TV, radio, SDI, IP y OTT.</p>
                </div>
                
                <div class="radial-node node-bottom-right">
                    <div class="node-icon"><svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2v20"></path><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path></svg></div>
                    <h4>ANALIZAR</h4>
                    <p>Contenido, calidad, metadata e IA.</p>
                </div>
                
                <div class="radial-node node-bottom">
                    <div class="node-icon"><svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg></div>
                    <h4>ENCONTRAR</h4>
                    <p>Contenido en vivo e histórico.</p>
                </div>
                
                <div class="radial-node node-bottom-left">
                    <div class="node-icon"><svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="17 8 12 3 7 8"></polyline><line x1="12" y1="3" x2="12" y2="15"></line></svg></div>
                    <h4>PUBLICAR</h4>
                    <p>Clips y contenido listo para utilizar.</p>
                </div>
                
                <div class="radial-node node-top-left">
                    <div class="node-icon"><svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 22h14a2 2 0 0 0 2-2V7.5L14.5 2H6a2 2 0 0 0-2 2v4"></path><polyline points="14 2 14 8 20 8"></polyline><path d="M2 15h10"></path><path d="m9 18 3-3-3-3"></path></svg></div>
                    <h4>ARCHIVAR</h4>
                    <p>Preservación y catalogación.</p>
                </div>
            </div>

            <p class="ecosystem-closing">Usalas por separado. Integralas cuando lo necesites.</p>
        </div>
    </section>
"@

$content = [System.IO.File]::ReadAllText($indexFile, [System.Text.Encoding]::UTF8)

# Replace the entire <section class="home-ecosystem"> ... </section>
$regex = [regex]::new('(?s)<!-- 3\. Ecosistema -->\s*<section class="home-ecosystem">.*?</section>')
$newContent = $regex.Replace($content, $newEcosystemHtml)

[System.IO.File]::WriteAllText($indexFile, $newContent, [System.Text.Encoding]::UTF8)
Write-Host "Updated index.html ecosystem section"

# CSS Updates
$cssContent = [System.IO.File]::ReadAllText($styleFile, [System.Text.Encoding]::UTF8)

# We can append the new CSS and remove the old .ecosystem-flow stuff, or just append it and override.
# Let's cleanly remove .ecosystem-flow and .flow-step if we can.
$cssContent = $cssContent -replace '(?s)\.ecosystem-flow\s*\{.*?\}', ''
$cssContent = $cssContent -replace '(?s)\.flow-step\s*\{.*?\}', ''
$cssContent = $cssContent -replace '(?s)\.flow-icon\s*\{.*?\}', ''
$cssContent = $cssContent -replace '(?s)\.flow-step span\s*\{.*?\}', ''
$cssContent = $cssContent -replace '(?s)\.flow-arrow\s*\{.*?\}', ''

# In media queries, we also had:
# .ecosystem-flow { flex-direction: column; gap: 20px; }
# .flow-arrow { transform: rotate(90deg); margin: 5px 0; }
$cssContent = $cssContent -replace '(?s)\.ecosystem-flow\s*\{\s*flex-direction:\s*column;\s*gap:\s*20px;\s*\}', ''
$cssContent = $cssContent -replace '(?s)\.flow-arrow\s*\{\s*transform:\s*rotate\(90deg\);\s*margin:\s*5px\s*0;\s*\}', ''

$newCss = @"

/* NEW ECOSYSTEM RADIAL */
.ecosystem-radial {
    position: relative;
    width: 100%;
    max-width: 800px;
    height: 500px;
    margin: 60px auto;
}

.ecosystem-radial::before {
    content: '';
    position: absolute;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    width: 65%; height: 65%;
    border: 2px dashed rgba(59, 130, 246, 0.2);
    border-radius: 50%;
    z-index: 1;
}

.radial-center {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 140px;
    height: 140px;
    background: linear-gradient(135deg, #1e3a8a, #3b82f6);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 15px 35px rgba(30, 58, 138, 0.2);
    z-index: 10;
}

.radial-center-title {
    color: white;
    font-size: 1.8rem;
    font-weight: 800;
    letter-spacing: 1px;
}

.radial-node {
    position: absolute;
    width: 200px;
    text-align: center;
    background: white;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.05);
    border: 1px solid rgba(0,0,0,0.05);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    z-index: 5;
}

.radial-node:hover {
    transform: translateY(-5px);
    box-shadow: 0 15px 35px rgba(59, 130, 246, 0.15);
    border-color: rgba(59, 130, 246, 0.3);
}

.radial-node .node-icon {
    color: #3b82f6;
    margin-bottom: 12px;
}

.radial-node h4 {
    font-size: 1rem;
    font-weight: 700;
    color: #0f172a;
    margin-bottom: 8px;
    letter-spacing: 1px;
}

.radial-node p {
    font-size: 0.85rem;
    color: #475569;
    margin: 0;
    line-height: 1.4;
}

/* Base Positioning */
.node-top { top: 0; left: 50%; margin-left: -100px; }
.node-bottom { bottom: 0; left: 50%; margin-left: -100px; }
.node-top-right { top: 15%; right: 0; }
.node-bottom-right { bottom: 15%; right: 0; }
.node-top-left { top: 15%; left: 0; }
.node-bottom-left { bottom: 15%; left: 0; }

.ecosystem-closing {
    font-size: 1.2rem;
    font-weight: 600;
    color: #0f172a;
    margin-top: 50px;
}

@media (max-width: 992px) {
    .ecosystem-radial {
        height: auto;
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
        margin: 40px auto;
        padding: 0 15px;
    }
    .ecosystem-radial::before { display: none; }
    
    .radial-center {
        position: static;
        transform: none;
        width: 100%;
        height: auto;
        padding: 25px 0;
        border-radius: 12px;
        grid-column: 1 / -1;
        margin-bottom: 20px;
    }
    
    .radial-node {
        position: static;
        width: 100%;
        margin-left: 0;
    }
}
@media (max-width: 576px) {
    .ecosystem-radial { grid-template-columns: 1fr; }
}
"@

$cssContent += $newCss
[System.IO.File]::WriteAllText($styleFile, $cssContent, [System.Text.Encoding]::UTF8)
Write-Host "Updated style_v2.css with new ecosystem styles"
