$prods = @("clipping", "multiviewer")

$modalHtml = @"
      <!-- Demo Modal -->
      <div id="demoModal" class="demo-modal-overlay" style="display: none;">
          <div class="demo-modal-container">
              <button class="demo-modal-close" onclick="closeDemoModal()">&times;</button>
              <h3 class="demo-modal-title">Request Demo</h3>
              <p class="demo-modal-subtitle">Fill in your details and we will contact you.</p>
              <form id="demoForm" onsubmit="submitDemoForm(event)">
                  <div class="demo-form-group">
                      <label for="demoName">Full Name</label>
                      <input type="text" id="demoName" required placeholder="Ex: John Doe">
                  </div>
                  <div class="demo-form-group">
                      <label for="demoEmail">Email Address</label>
                      <input type="email" id="demoEmail" required placeholder="you@company.com">
                  </div>
                  <div class="demo-form-group demo-captcha-group">
                      <label for="demoCaptcha" id="demoCaptchaLabel">What is X + Y?</label>
                      <input type="number" id="demoCaptcha" required placeholder="Answer">
                  </div>
                  <button type="submit" class="catalog-v2-btn-primary" id="demoSubmitBtn" style="width: 100%; margin-top: 10px;">Send Request</button>
                  <p id="demoStatusMessage" class="demo-status-message"></p>
              </form>
          </div>
      </div>
      <script src="/catalog-modal.js"></script>
"@

foreach ($prod in $prods) {
    $esFile = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\$prod.1.html"
    $enFile = "c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\$prod\index.html"

    $esContent = [System.IO.File]::ReadAllText($esFile, [System.Text.Encoding]::UTF8)
    $enContent = [System.IO.File]::ReadAllText($enFile, [System.Text.Encoding]::UTF8)

    # Extract en header (up to </header>)
    $enHeader = ""
    if ($enContent -match "(?s)^(.*?</header>)") {
        $enHeader = $matches[1]
    }

    # Extract en footer (from <footer class="site-footer"> to the end of the file)
    $enFooter = ""
    if ($enContent -match "(?s)(<footer class=`"site-footer`".*)$") {
        $enFooter = $matches[1]
    }

    # Extract es body (between </header> and <footer class="site-footer">)
    $esBody = ""
    if ($esContent -match "(?s)</header>(.*?)<footer class=`"site-footer`"") {
        $esBody = $matches[1]
    }

    if ($enHeader -and $esBody -and $enFooter) {
        # Combine
        $newEnContent = $enHeader + "`n" + $esBody + "`n" + $enFooter
        
        # Inject modal before </body>
        $newEnContent = $newEnContent -replace '(?s)</body>', ($modalHtml + "`n</body>")

        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($enFile, $newEnContent, $utf8NoBom)
        Write-Host "Successfully merged structure and injected modal for $prod"
    } else {
        Write-Host "Failed to extract parts for $prod. enHeader:$([bool]$enHeader), esBody:$([bool]$esBody), enFooter:$([bool]$enFooter)"
    }
}
