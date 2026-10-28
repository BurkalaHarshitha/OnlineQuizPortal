
$tomcat = "F:\Tools\apache-tomcat-9.0.123\bin\catalina.bat"
$url = "http://localhost:8080/OnlineQuizPortal/"

Write-Host "`nStarting OnlineQuizPortal..." -ForegroundColor Yellow

# Start Tomcat in a separate process
$process = Start-Process -FilePath $tomcat `
    -ArgumentList "run" `
    -PassThru `
    -NoNewWindow

# Wait for the web application to respond
$ready = $false
for ($i = 0; $i -lt 60; $i++) {
    Start-Sleep -Seconds 2
    try {
        $response = Invoke-WebRequest -Uri $url -TimeoutSec 2 -UseBasicParsing
        if ($response.StatusCode -eq 200) {
            $ready = $true
            break
        }
    } catch {
        # Tomcat may still be starting
    }
}

if ($ready) {
    Write-Host "`n====================================" -ForegroundColor Green
    Write-Host " OnlineQuizPortal is running!" -ForegroundColor Green
    Write-Host " Website: $url" -ForegroundColor Cyan
    Write-Host "====================================" -ForegroundColor Green
} else {
    Write-Host "`nThe website did not respond within 2 minutes." -ForegroundColor Red
    Write-Host "Check the Tomcat startup logs for errors."
}
