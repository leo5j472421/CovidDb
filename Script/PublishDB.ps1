param(
      [bool] $IsSchemaOnly=1,
      [string] $hash="version",
      [string] $env="STG"
)

function PublishDbToServer{
    param(
      [Parameter(Position=0,Mandatory=$True)]
      [string] $tmpFolder,
      [string] $env
    )
    
    # $commonPath = Resolve-Path $PSScriptRoot
    # Write-host "CommonPath = $($commonPath)"
    # cd "$commonPath"
    if ( $env -eq "STG") {
        $TargetServerConnString="`"Data Source=kh-z10.aw02.pbodia.com;user=sa;password=P@ssword;Pooling=False`""
    } elseif ( $env -eq "UAT" ) {
        $TargetServerConnString="`"Data Source=kh-x10.aw02.pbodia.com;user=sa;password=P@ssword;Pooling=False`""
    } elseif ($env -eq "PROD") {
         $TargetServerConnString="`"Data Source=kh-db111.aw02.pbodia.com;user=sa;password=P@ssw0rd1234;Pooling=False`""
    }

    write-host $TargetServerConnString

    $jobs=@()
    
    $projects | %{
      $jobs+=Start-Job $ScriptBlock -ArgumentList $_,$tmpFolder,$TargetServerConnString
    }
  
    Wait-Job -Job $jobs| Receive-Job
        
    write-host "Job finished."
    $errorCode=0
    $jobs|?{ $_.State  -eq 'Failed'}|% {
            Write-Host ($_.ChildJobs[0].JobStateInfo.Reason.Message) -ForegroundColor Red
            $errorCode=1
    }
    exit $errorCode
}

$ScriptBlock = {
    param($project,$tmpFolder,$TargetServerConnString) 
    Write-host (get-Date).ToString("HH:mm:ss fff")
    set-Alias mSqlpackage "C:\Program Files (x86)\Microsoft SQL Server\140\DAC\bin\SqlPackage.exe"
    cd "$env:CI_PROJECT_DIR\Gandalf\"
    cd ..
    $path=$project.path
    write-host "Project Path => $($path)"
    #cd $path
    # $sqlProj=$project.sqlproj

    $folder = 'F:\DBRelease\'+$tmpFolder

    if(""+$project.dacpac -eq ""){
        $dacPath=$folder + '\' + $path+".dacpac";
    }
    write-output "dacpac path  $dacPath"
    $dacPath=$dacPath.replace(' ','')

    $newPublishFile = "$env:CI_PROJECT_DIR\$($project.name)\$($project.path)\Staging.xml"

    $publishFile = "staging.schemaOnly.publish.xml"

    (cat "$env:CI_PROJECT_DIR\$($project.name)\$($project.path)\$($publishFile)" ).replace("{user}","sa").replace("{password}","P@ss0wrd").replace("{dbName}","Mail") | out-file $newPublishFile -Encoding ascii

    $retry=1
    
    while($retry -lt 3){
        write-output "Invoke-Expression mSqlpackage /SourceFile:$dacPath /Action:publish /tcs:$TargetServerConnString /Profile:$newPublishFile /Quiet:True /p:ScriptDatabaseOptions=False /p:IgnoreColumnOrder=True -ErrorVariable ErrorOutput -Verbose:$false"
        Invoke-Expression "mSqlpackage /SourceFile:$dacPath /Action:publish /tcs:$TargetServerConnString /Profile:$newPublishFile /Quiet:True /p:ScriptDatabaseOptions=False /p:IgnoreColumnOrder=True"  -ErrorVariable ErrorOutput -Verbose:$false
        if ($LASTEXITCODE -ne 0){
            $retry++
        }else{
            break;
        }
    }
    
    if ($LASTEXITCODE -ne 0) {
        throw "Job failed. The error was: project={0},Error={1}" -f ($project.name),([string] $ErrorOutput)
    }
    
    Write-host (get-Date).ToString("HH:mm:ss fff")
}

$projects =(
	@{name="Gandalf";path="Mail";sqlproj="Gandalf.sqlproj"}
)

write-host "preparing to publish db schema env : " + $env

Publishdbtoserver -tmpfolder $hash -env $env