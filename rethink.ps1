New-NetFirewallRule -DisplayName "Rethink 8080" -Direction Inbound -LocalPort 8080 -Protocol TCP -Action Allow

$datadir = "c:\rethinkdb\data\"
$tmpdir = "c:\rethinkdb\tmp\"
$url = "https://download.rethinkdb.com/windows/rethinkdb-2.3.6.zip"
$rootdir = "c:\rethinkdb\"
$zipfile = "$tmpdir" + "rethink.zip"
$start_time = Get-Date
$executable = "rethinkdb.exe"
$extractedfolder = "$tmpdir" + "rethinkdb-2.3.6\"

New-Item -Path $datadir -ItemType directory
New-Item -Path $tmpdir -ItemType directory

Invoke-WebRequest -Uri $url -OutFile $zipfile
Expand-Archive $zipfile -DestinationPath $tmpdir
Copy-Item -Path "$extractedfolder$executable" -Destination $rootdir
Remove-Item -Path $tmpdir -Recurse

cd $rootdir

Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

Start-Process "$rootdir$executable" -ArgumentList @('-d c:\rethinkdb\data --bind all --join') -WindowStyle Hidden
