
$env:PATH=$env:PATH + ';C:\Program Files (x86)\MSBuild\12.0\Bin;%systemroot%\system32\inetsrv\;C:\Windows\System32\inetsrv;C:\Program Files\MySQL\MySQL Server 5.1\bin';
$schema = "/p:mode=SchemaOnly"
$rebuild = "/t:rebuild"

MSBUILD ".\Mail.sln" /m /p:VisualStudioVersion=12.0 $schema $rebuild /consoleloggerparameters:ErrorsOnly

if ($LASTEXITCODE -ne 0) {
    Write-Host "MSBUILD Mail.sln failed"
    exit 1
}