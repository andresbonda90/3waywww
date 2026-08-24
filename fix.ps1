$casosCSS = @"
<style>
/* Mejorar márgenes y emprolijar la página de casos de éxito y novedades */
.elementor-post__card {
    margin: 20px;
    border-radius: 12px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.08);
    overflow: hidden;
    transition: transform 0.3s ease;
    background-color: #fff;
    display: flex;
    flex-direction: column;
    height: 100%;
}
.elementor-post__card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}
.elementor-post__thumbnail {
    padding-bottom: 0 !important;
}
.elementor-post__thumbnail img {
    width: 100%;
    height: auto;
    object-fit: cover;
    display: block;
}
.elementor-post__text {
    padding: 25px !important;
    flex-grow: 1;
}
.elementor-post__title {
    margin-bottom: 15px !important;
    font-size: 1.25rem !important;
}
.elementor-posts-container {
    padding: 40px 20px !important;
    gap: 40px !important;
    max-width: 1200px;
    margin: 0 auto;
}
</style>
"@

$isoCSS = @"
<style>
/* Achicar imagen de certificado ISO */
img[src*="Image_20230927_101013_008"] {
    max-width: 150px !important;
    height: auto !important;
    display: block;
    margin: 0 auto;
}
</style>
"@

Function Append-CSS {
    param($Path, $CSS)
    if (Test-Path $Path) {
        $content = Get-Content $Path -Raw
        if ($content -notmatch "<!-- Custom Fixes -->") {
            $content = $content -replace '</body>', "`n<!-- Custom Fixes -->`n$CSS`n</body>"
            Set-Content -Path $Path -Value $content
            Write-Host "Patched $Path"
        } else {
            Write-Host "Already patched $Path"
        }
    } else {
        Write-Host "File not found: $Path"
    }
}

Append-CSS "public\casos-exito-broadcast\index.html" $casosCSS
Append-CSS "public\novedades\index.html" $casosCSS
Append-CSS "public\recursos-tecnologia-broadcast\index.html" $casosCSS
Append-CSS "public\empresa-tecnologia-broadcast\index.html" $isoCSS
