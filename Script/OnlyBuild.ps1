param( 
    [string] $hash="version",
    [string] $env="STG"
)
function CreateRandFolder {

    $tmpFoldername=$hash

    $path = 'F:\DBRelease\'+$tmpFoldername
    
    mkdir $path
    (Resolve-Path $path)
}

Write-Host "Directory: "+(pwd).ToString()
Write-Host "MSBUILD Gandalf.sln building"

C:\"Program Files (x86)"\"Microsoft Visual Studio"\2022\BuildTools\MSBuild\Current\Bin\MSBuild.exe $env:CI_PROJECT_DIR\Gandalf\Gandalf.sln /consoleloggerparameters:ErrorsOnly # build the project	

if($LASTEXITCODE -ne 0) {
    Write-Host "MSBUILD Gandalf.sln failed"
    exit 1
}

Write-Host "MSBUILD Gandalf.sln successed"
$tmpFolder=CreateRandFolder
Get-ChildItem -Path . -File -filter "*.dacpac" -Recurse|? { $_.FullName -match 'debug'}| % { 

    Copy-Item $_.FullName -Destination $tmpFolder.Path 
}
