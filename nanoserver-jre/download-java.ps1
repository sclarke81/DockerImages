param([string]$OutFile)

$ErrorActionPreference = "Stop"

$JAVA_SHA256="d54f57d574a0eaac231f486d6b15fe6d3d3857d3df74789675f08eb13b61076f"
$JAVA_URL="http://download.oracle.com/otn-pub/java/jdk/10.0.2+13/19aef61b38124481863b1413dce1855f/serverjre-10.0.2_windows-x64_bin.tar.gz"
$JAVA_URL2="https://edelivery.oracle.com/otn-pub/java/jdk/10.0.2+13/19aef61b38124481863b1413dce1855f/serverjre-10.0.2_windows-x64_bin.tar.gz"

Function Test-Hash {
    Param (
        [string]$Path,
        [string]$Hash
    )
    Process {
        If (Test-Path -Path $Path) {
            $hash = (Get-FileHash $Path -Algorithm sha256).Hash

            If ($hash -ne $Hash) {
                Write-Host 'Hashes do not match.'
                Write-Host ('Expected: {0}' -f $Hash)
                Write-Host ('Found:    {0}' -f $hash)

                Return $False
            }
            Else {
                Return $True
            }
        }
        Else {
            Return $False
        }
    }
}

Function Get-FileFromUrl {
    Param (
        [string]$OutFile
    )
    Process {
        $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
        $session.MaximumRedirection = 5
        $cookie = New-Object System.Net.Cookie
        $cookie.Name = "oraclelicense"
        $cookie.Value = "accept-securebackup-cookie"
        $session.Cookies.Add($JAVA_URL, $cookie)
        $session.Cookies.Add($JAVA_URL2, $cookie)

        Invoke-WebRequest -Uri $JAVA_URL -OutFile $OutFile -WebSession $session -UseBasicParsing
    }
}

If (Test-Hash -Path $Outfile -Hash $JAVA_SHA256) {
    Write-Host 'File with matching hash already downloaded.'
}
Else {
    Write-Host 'Downloading...'
    Get-FileFromUrl -OutFile $OutFile

    Write-Host 'Verifying hash...'
    If (!(Test-Hash -Path $OutFile -Hash $JAVA_SHA256)) {
        Exit 1
    }
}