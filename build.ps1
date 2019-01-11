docker build --tag sclarke81/openjdk:jdk8u192-b12-nanoserver-sac2016 .\openjdk
$openJdkCore = (docker image ls --filter "dangling=true" -q)[0]
docker tag $openJdkCore sclarke81/openjdk:jdk8u192-b12-windowsservercore-ltsc2016

docker build --tag sclarke81/jira:7.13.0-nanoserver-sac2016 .\jira
$jiraCore = (docker image ls --filter "dangling=true" -q)[0]
docker tag $jiraCore sclarke81/jira:7.13.0-windowsservercore-ltsc2016
