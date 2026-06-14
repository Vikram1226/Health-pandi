$content = Get-Content 'e:\Pandi\index.html_9.html'
for ($i=0; $i -lt $content.Length; $i++) {
    if ($content[$i] -match '<img src=" hero_couple') {
        $content[$i] = ''
    }
}
$content[398] = '        <img src="8.jpg" alt="Your Coaches" class="block w-full h-auto"/>'
$content | Set-Content 'e:\Pandi\index.html_9.html'
