ARG SERVER_VERSION=ltsc2016

FROM microsoft/windowsservercore:${SERVER_VERSION}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG TOOL_DIR='C:\tools\OpenJDK'
ARG ZIP_FILE='jdk.zip'
ARG TEMP_DIR='C:\temp'
ARG URL='https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u192-b12/OpenJDK8U-jdk_x64_windows_hotspot_8u192b12.zip'

# Ideall I'd use Invoke-WebRequest inside the RUN statement, but it doesn't work behind my proxy.
ADD ${URL} ${ZIP_FILE}

RUN Expand-Archive -Path $Env:ZIP_FILE -DestinationPath $Env:TEMP_DIR ; \
    New-Item -ItemType "Directory" -Path $Env:TOOL_DIR ; \
    Get-ChildItem $Env:TEMP_DIR | Get-ChildItem | Move-Item -Destination $Env:TOOL_DIR ; \
    Remove-Item $Env:TOOL_DIR\demo -Force -Recurse ; \
    Remove-Item $Env:TOOL_DIR\sample -Force -Recurse ; \
    Remove-Item $Env:TOOL_DIR\src.zip -Force ; \
    Remove-Item $Env:TEMP_DIR -Force -Recurse ; \
    Remove-Item $Env:ZIP_FILE -Force ; \
    [Environment]::SetEnvironmentVariable('PATH', ($Env:TOOL_DIR + '\bin;' + $Env:PATH), [EnvironmentVariableTarget]::Machine) ; \
    [Environment]::SetEnvironmentVariable('JAVA_HOME', $Env:TOOL_DIR, [EnvironmentVariableTarget]::Machine) ; \
    [Environment]::SetEnvironmentVariable('JRE_HOME', ($Env:TOOL_DIR + '\jre'), [EnvironmentVariableTarget]::Machine)
