
set-Alias Sqlpackage "C:\Program Files (x86)\Microsoft SQL Server\140\DAC\bin\SqlPackage.exe"

$dacPath = "D:\local-workspace\Mail\Mail\bin\Debug\Mail.dacpac"
$TargetServerConnString="`"Data Source=wl-x05.tw01.ppanggu.com;User ID=CCWLCI;Password=y9VhQ8L6d0a83ivt7aqQgw==;Pooling=False`""
$publishFile = "uat.publish.xml"

Invoke-Expression "Sqlpackage /SourceFile:$dacPath /Action:publish /tcs:$TargetServerConnString /Profile:$publishFile /Quiet:True /p:ScriptDatabaseOptions=False"  -ErrorVariable ErrorOutput -Verbose:$false

if ($LASTEXITCODE -ne 0) {
    Write-Host "Publish Mail failed"
    exit 1
}


