$content = Get-Content 'public\casos-exito-broadcast\index.html' -Raw
$content = $content -replace '</style>', "`n.elementor-element-5c687468 { margin-top: 100px !important; padding-top: 80px !important; }`n</style>"
Set-Content -Path 'public\casos-exito-broadcast\index.html' -Value $content
Write-Host "Margin fixed on Casos de Exito"
