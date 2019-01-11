ARG TOOL_DIR='C:\tools\jira'
ARG DATA_DIR='C:\data\jira'

FROM sclarke81/openjdk:jdk8u192-b12-windowsservercore-ltsc2016 as core

ARG TOOL_DIR
ARG DATA_DIR
ARG ZIP_FILE='jira.zip'
ARG TEMP_DIR='C:\temp'

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ADD 'https://product-downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-7.13.0.zip' ${ZIP_FILE}

RUN Expand-Archive -Path $Env:ZIP_FILE -DestinationPath $Env:TEMP_DIR ; \
    New-Item -ItemType "Directory" -Path $Env:TOOL_DIR ; \
    Get-ChildItem $Env:TEMP_DIR | Get-ChildItem | Move-Item -Destination $Env:TOOL_DIR ; \
    Remove-Item $Env:TEMP_DIR -Force -Recurse ; \
    Remove-Item $Env:ZIP_FILE -Force ; \
    [Environment]::SetEnvironmentVariable('PATH', ($Env:TOOL_DIR + '\bin;' + $Env:PATH), [EnvironmentVariableTarget]::Machine) ; \
    [Environment]::SetEnvironmentVariable('JIRA_HOME', $Env:DATA_DIR, [EnvironmentVariableTarget]::Machine) ; \
    [Environment]::SetEnvironmentVariable('TOOL_TO_START', ($Env:TOOL_DIR + '\bin\start-jira.bat'), [EnvironmentVariableTarget]::Machine)

WORKDIR ${TOOL_DIR}

VOLUME ${TOOL_DIR}\\logs ${DATA_DIR}

EXPOSE 8080

CMD ["%TOOL_TO_START%", "/fg"]

FROM sclarke81/openjdk:jdk8u192-b12-nanoserver-sac2016 as nano

ARG TOOL_DIR
ARG DATA_DIR

COPY --from=core ${TOOL_DIR} ${TOOL_DIR}

RUN setx PATH "%PATH%;%TOOL_DIR%\bin" && \
    setx JIRA_HOME "%DATA_DIR%" && \
    setx TOOL_TO_START "%TOOL_DIR%\bin\start-jira.bat"

WORKDIR ${TOOL_DIR}

VOLUME ${TOOL_DIR}\\logs ${DATA_DIR}

EXPOSE 8080

CMD ["%TOOL_TO_START%", "/fg"]