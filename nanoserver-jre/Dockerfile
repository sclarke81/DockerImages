FROM microsoft/nanoserver:sac2016

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG JAVA_FILE=java.tar.gz

ENV JAVA_HOME=C:\\tools\\java

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
