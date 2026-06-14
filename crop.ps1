Add-Type -AssemblyName System.Drawing
$srcPath = 'C:\Users\DELL\.gemini\antigravity\brain\a995f7bf-91ce-48fd-a3e4-b2365b93b486\.tempmediaStorage\media_a995f7bf-91ce-48fd-a3e4-b2365b93b486_1781433798456.jpg'
$img = [System.Drawing.Image]::FromFile($srcPath)

$targetW = 700
$targetH = 900
$canvas = New-Object System.Drawing.Bitmap($targetW, $targetH)
$g = [System.Drawing.Graphics]::FromImage($canvas)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

$srcAspect = $img.Width / $img.Height
$dstAspect = $targetW / $targetH

if ($srcAspect -gt $dstAspect) {
    $srcH = $img.Height
    $srcW = [int]($srcH * $dstAspect)
    $srcX = [int](($img.Width - $srcW) / 2)
    $srcY = 0
} else {
    $srcW = $img.Width
    $srcH = [int]($srcW / $dstAspect)
    $srcX = 0
    $srcY = 0
}

$srcRect = New-Object System.Drawing.Rectangle($srcX, $srcY, $srcW, $srcH)
$dstRect = New-Object System.Drawing.Rectangle(0, 0, $targetW, $targetH)
$g.DrawImage($img, $dstRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)
$g.Dispose()

$jpegPath = 'e:\Pandi\hero_couple.jpg'
$encoder = [System.Drawing.Imaging.Encoder]::Quality
$encParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter($encoder, 85L)
$codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
$canvas.Save($jpegPath, $codec, $encParams)

$canvas.Dispose()
$img.Dispose()
