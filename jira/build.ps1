Param(
    [string]$ServerVersion='ltsc2016'
)

docker build --tag sclarke81/jira:7.13.0-windowsservercore-$ServerVersion --build-arg SERVER_VERSION=$ServerVersion .
