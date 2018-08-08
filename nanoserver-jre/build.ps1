$scriptDir = Split-Path $script:MyInvocation.MyCommand.Path
$javaFile = "$scriptDir\java.tar.gz"
. $scriptDir\download-java.ps1 $javaFile
docker build --build-arg JAVA_FILE=$javaFile $scriptDir