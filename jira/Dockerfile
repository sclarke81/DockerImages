ARG SERVER_VERSION=ltsc2016

FROM sclarke81/openjdk:jdk8u192-b12-windowsservercore-${SERVER_VERSION}

ARG TOOL_DIR='C:\tools\jira'
ARG DATA_DIR='C:\data\jira'
ARG EXTERNAL_TOOL_DIR
ARG ZIP_FILE='jira.zip'
ARG TEMP_DIR='C:\temp'
ARG URL='https://product-downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-7.13.0.zip'

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

WORKDIR ${TOOL_DIR}

VOLUME ${TOOL_DIR}\\logs ${DATA_DIR}

EXPOSE 8080

CMD ["%TOOL_TO_START%", "/fg"]

COPY 'Entrypoint.ps1' .
ENTRYPOINT [ "Entrypoint.ps1" ]

ADD ${URL} ${ZIP_FILE}

RUN Expand-Archive -Path $Env:ZIP_FILE -DestinationPath $Env:TEMP_DIR ; \
    New-Item -ItemType "Directory" -Path $Env:TOOL_DIR ; \
    Get-ChildItem $Env:TEMP_DIR | Get-ChildItem | Move-Item -Destination $Env:TOOL_DIR ; \
    Remove-Item $Env:TEMP_DIR -Force -Recurse ; \
    Remove-Item $Env:ZIP_FILE -Force ; \
    [Environment]::SetEnvironmentVariable('PATH', ($Env:TOOL_DIR + '\bin;' + $Env:PATH), [EnvironmentVariableTarget]::Machine) ; \
    [Environment]::SetEnvironmentVariable('JIRA_HOME', $Env:DATA_DIR, [EnvironmentVariableTarget]::Machine) ; \
    [Environment]::SetEnvironmentVariable('TOOL_TO_START', ($Env:TOOL_DIR + '\bin\start-jira.bat'), [EnvironmentVariableTarget]::Machine)
