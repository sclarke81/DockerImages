ARG TOOL_DIR='C:\tools\OpenJDK'

FROM microsoft/windowsservercore:1803 as builder

ARG TOOL_DIR
ARG ZIP_FILE='jdk.zip'
ARG TEMP_DIR='C:\temp'

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ADD 'https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u192-b12/OpenJDK8U-jdk_x64_windows_hotspot_8u192b12.zip' ${ZIP_FILE}

RUN Expand-Archive -Path $Env:ZIP_FILE -DestinationPath $Env:TEMP_DIR ; \
    New-Item -ItemType "Directory" -Path $Env:TOOL_DIR ; \
    Get-ChildItem $Env:TEMP_DIR | Get-ChildItem | Move-Item -Destination $Env:TOOL_DIR ; \
    Remove-Item $Env:TOOL_DIR\demo -Force -Recurse ; \
    Remove-Item $Env:TOOL_DIR\sample -Force -Recurse ; \
    Remove-Item $Env:TOOL_DIR\src.zip -Force

FROM microsoft/nanoserver:1803

ARG TOOL_DIR

COPY --from=builder ${TOOL_DIR} ${TOOL_DIR}

RUN setx PATH "%PATH%;%TOOL_DIR%\bin" && \
    setx JAVA_HOME "%TOOL_DIR%"