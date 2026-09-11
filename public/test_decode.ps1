$text = "seÃ±ales mÃºltiples tÃ©cnico grabaciÃ³n auditorÃ­a EspaÃ±ol MÃ³dulos IA Â-¾"
$bytes = [System.Text.Encoding]::GetEncoding("Windows-1252").GetBytes($text)
$correct = [System.Text.Encoding]::UTF8.GetString($bytes)
Write-Output $correct
