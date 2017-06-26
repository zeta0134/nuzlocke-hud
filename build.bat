del nuzlocke-hud.love
powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::CreateFromDirectory('love', 'nuzlocke-hud.love'); }"
