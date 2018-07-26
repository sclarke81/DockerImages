FROM sclarke81/nanoserver-jre:10.0.2

ADD 'https://product-downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-7.11.1.zip' .

EXPOSE 8080

RUN Write-Host 'Moving files...'; \
    $jiraPath = 'C:\tools\jira'; \
    $dir = Get-ChildItem -Directory -Filter 'atlassian-jira-software*'; \
    New-Item -ItemType Directory -Path $jiraPath; \
    Move-Item -Path ($dir.FullName + '\*') -Destination $jiraPath; \
    Remove-Item -Path $dir.FullName;