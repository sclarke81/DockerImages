FROM microsoft/nanoserver:sac2016

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG DOWNLOAD_SCRIPT=download-java.ps1
ARG JAVA_FILE=java.tar.gz

ENV JAVA_HOME=C:\\tools\\java

# Can't get the download to work, so downloaded manually.
# ADD $DOWNLOAD_SCRIPT .
# RUN $file = Get-ChildItem -File -Filter $env:DOWNLOAD_SCRIPT; \
#     & $file.FullName -OutFile $env:JAVA_FILE; \
#     Remove-Item -Path $DOWNLOAD_SCRIPT

ADD $JAVA_FILE .

RUN Write-Host 'Moving files...'; \
    $dir = Get-ChildItem -Directory -Filter 'jdk*'; \
    New-Item -ItemType Directory -Path $env:JAVA_HOME; \
    Move-Item -Path ($dir.FullName + '\*') -Destination $env:JAVA_HOME; \
    Remove-Item -Path $dir.FullName; \
    \
    Write-Host 'Setting environment variables...'; \
    $newPath = ('{0}\bin;{1}' -f  $env:JAVA_HOME, $env:PATH); \
    setx /M PATH $newPath; \
    \
    Write-Host 'Complete.';
