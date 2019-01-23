$serverFile = Join-Path $Env:DATA_DIR "conf\server.xml"
$doc = [xml](Get-Content $serverFile)

if ($Env:ProxyName) {
    $doc.Server.Service.Connector.SetAttribute('proxyName', $Env:ProxyName)
}
if ($Env:ProxyPort) {
    $doc.Server.Service.Connector.SetAttribute('proxyPort', $Env:ProxyPort)
}
if ($Env:ProxyScheme) {
    $doc.Server.Service.Connector.SetAttribute('scheme', $Env:ProxyScheme)
}

$doc.Save($serverFile)
