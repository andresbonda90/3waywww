$content = [System.IO.File]::ReadAllText("c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\logging\index.html", [System.Text.Encoding]::UTF8)

$newWrapper = @"
      <div class="formats-table-wrapper">
        <!-- Top Row -->
        <div class="formats-row">
          <div class="format-card card-base">
            <div class="format-header">BASE BAND</div>
            <div class="format-body">
              <ul class="format-list top-list">
                <li>SDI</li><li>HD-SDI</li><li>3G-SDI</li><li>HDMI</li><li>NTSC</li><li>PAL</li><li>RF</li>
              </ul>
            </div>
          </div>
          <div class="format-card card-ip">
            <div class="format-header">IP / STREAMING</div>
            <div class="format-body">
              <ul class="format-list top-list">
                <li>SRT</li><li>NDI</li><li>HLS</li><li>RTMP</li><li>RTSP</li><li>MPEG-DASH</li><li>TS over IP</li>
              </ul>
            </div>
          </div>
          <div class="format-card card-broadcast">
            <div class="format-header">BROADCAST</div>
            <div class="format-body">
              <ul class="format-list top-list">
                <li>ASI</li><li>DVB-S2</li><li>DVB-C</li><li>ISDBT</li><li>ATSC</li><li>DVB-T2</li><li>AM/FM</li><li>SMPTE 2110</li><li>SMPTE 2022-6</li>
              </ul>
            </div>
          </div>
        </div>
        
        <!-- Bottom Row -->
        <div class="formats-row">
          <div class="format-card card-codecs" style="flex: 1;">
            <div class="format-header">CODECS AND CONTAINERS</div>
            <div class="format-body">
              <div class="codecs-columns">
                <ul class="format-list">
                  <li>H.264</li><li>HEVC</li><li>XDCAM</li><li style="border-bottom: none;">AVI</li>
                </ul>
                <ul class="format-list">
                  <li>TS</li><li>MP4</li><li>MOV</li><li style="border-bottom: none;">MXF</li>
                </ul>
                <ul class="format-list">
                  <li>DV</li><li style="border-bottom: none;">XAVC</li>
                </ul>
              </div>
            </div>
          </div>
          <div class="format-card card-ott" style="flex: 1;">
            <div class="format-header">OTT PLATFORMS</div>
            <div class="format-body" style="display: flex; align-items: center;">
              <div class="ott-columns" style="width: 100%;">
                <ul class="format-list">
                  <li>Disney+</li><li>HBO Max</li><li>Flow</li>
                </ul>
                <ul class="format-list">
                  <li>DTV Go</li><li>YouTube</li><li>Facebook</li>
                </ul>
                <ul class="format-list">
                  <li>Vimeo</li><li>Web Pages</li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
"@

$newContent = [regex]::Replace($content, '(?s)<div class="formats-table-wrapper">.*?</div>\s*</div>\s*</section>', $newWrapper + "`n    </div>`n  </section>")

if ($content -ne $newContent) {
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText("c:\Users\gmass\.gemini\antigravity\scratch\3wayWWW\3waywww\public\en\logging\index.html", $newContent, $utf8NoBom)
    Write-Host "Updated formats table in en/logging/index.html"
} else {
    Write-Host "Failed to match formats table in en/logging/index.html"
}
