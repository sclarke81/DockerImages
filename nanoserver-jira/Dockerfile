ARG TOOL_DIR='C:\tools\jira'

FROM microsoft/windowsservercore:1803 as builder

ARG TOOL_DIR
ARG ZIP_FILE='jira.zip'
ARG TEMP_DIR='C:\temp'

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ADD 'https://product-downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-7.13.0.zip' ${ZIP_FILE}

RUN Expand-Archive -Path $Env:ZIP_FILE -DestinationPath $Env:TEMP_DIR ; \
    New-Item -ItemType "Directory" -Path $Env:TOOL_DIR ; \
    Get-ChildItem $Env:TEMP_DIR | Get-ChildItem | Move-Item -Destination $Env:TOOL_DIR

FROM sclarke81/openjdk8:nanoserver

ARG TOOL_DIR
ARG DATA_DIR='C:\data\jira'

COPY --from=builder ${TOOL_DIR} ${TOOL_DIR}

RUN setx PATH "%PATH%;%TOOL_DIR%\bin" && \
    setx JIRA_HOME "%DATA_DIR%"

WORKDIR ${TOOL_DIR}

VOLUME ${TOOL_DIR}\\logs ${DATA_DIR}

EXPOSE 8080

# Hard-coded TOOL_DIR as ARG expansion doesn't seemt to work
CMD C:\tools\jira\bin\start-jira.bat