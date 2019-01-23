Param(
    [string]$ServerVersion='ltsc2016'
)

docker build --tag sclarke81/openjdk:jdk8u192-b12-windowsservercore-$ServerVersion --build-arg SERVER_VERSION=$ServerVersion .
