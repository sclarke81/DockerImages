FROM microsoft/nanoserver:sac2016

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV ZIP_FILE 'jdk.zip'
ENV TOOLS_DIR 'C:\tools'
ENV JDK_NAME 'OpenJDK'
ENV JDK_DIR ${TOOLS_DIR}\\${JDK_NAME}

ADD 'https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u192-b12/OpenJDK8U-jdk_x64_windows_hotspot_8u192b12.zip' ${ZIP_FILE}

RUN Write-Host 'Expanding and moving files...'; \
    Expand-Archive $Env:ZIP_FILE -DestinationPath $Env:TOOLS_DIR ; \
    Get-ChildItem $Env:TOOLS_DIR | Rename-Item -NewName $Env:JDK_NAME ; \
    Remove-Item $Env:JDK_DIR\demo -Force -Recurse ; \
    Remove-Item $Env:JDK_DIR\sample -Force -Recurse ; \
    Remove-Item $Env:JDK_DIR\src.zip -Force ; \
    Remove-Item $Env:ZIP_FILE -Force ; \
    setx /M PATH ('{0};{1}\bin' -f $env:PATH, $env:JDK_DIR)
