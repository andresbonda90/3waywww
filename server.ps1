$port = 8081
$root = Join-Path $PSScriptRoot "public"
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()
Write-Host "Servidor web local iniciado!"
Write-Host "Por favor, abre tu navegador y visita: http://localhost:$port"

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        $localPath = $request.Url.LocalPath
        if ($localPath -eq "/") { $localPath = "/index.html" }
        if ($localPath.EndsWith("/")) { $localPath += "index.html" }
        
        # Security: Prevent directory traversal
        $localPath = $localPath -replace '\.\.', ''
        
        $filePath = Join-Path $root $localPath.Replace('/', '\')
        
        if (Test-Path $filePath -PathType Leaf) {
            $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
            switch ($ext) {
                ".html" { $response.ContentType = "text/html; charset=utf-8" }
                ".css"  { $response.ContentType = "text/css" }
                ".js"   { $response.ContentType = "application/javascript" }
                ".png"  { $response.ContentType = "image/png" }
                ".jpg"  { $response.ContentType = "image/jpeg" }
                ".jpeg" { $response.ContentType = "image/jpeg" }
                ".svg"  { $response.ContentType = "image/svg+xml" }
                ".woff" { $response.ContentType = "font/woff" }
                ".woff2"{ $response.ContentType = "font/woff2" }
                ".ttf"  { $response.ContentType = "font/ttf" }
                ".json" { $response.ContentType = "application/json" }
                default { $response.ContentType = "application/octet-stream" }
            }
            try {
                $content = [System.IO.File]::ReadAllBytes($filePath)
                $response.ContentLength64 = $content.Length
                $response.OutputStream.Write($content, 0, $content.Length)
            } catch {
                $response.StatusCode = 500
                Write-Host "500 ERROR for $($filePath): $($_.Exception.Message)" -ForegroundColor Red
            }
        } else {
            $response.StatusCode = 404
        }
        $response.Close()
    }
} finally {
    $listener.Stop()
}
