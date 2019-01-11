# DockerImages

Use the following to run Jira. Once running, it can be accessed at http://localhost:8080

```powershell
docker volume create --name jiraDataVolume
docker volume create --name jiraLogVolume
docker run -d --name jira -p 8080:8080 -v jiraLogVolume:C:\tools\jira\logs -v jiraDataVolume:C:\data\jira sclarke81/jira:7.13.0-nanoserver-1803
```