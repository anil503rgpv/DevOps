# Basic java build pipeline stages

stage-1
mvn clean deploy -->building java code using maven and send your code to maven artifacotry, here only unit testing

stage-2
mvn sonar:sonar --> send code coverage report to sonar server and vernebiliti

stage-3
docker build --> create docker image, and scanning docker image

stage-4
docker push --> push image artifactory

stage-5
deploy your container in dev server --> ecs or eks

stage-6
smoke testing vai any tool like smart-spec --> basic functionality testing

stage-7
deploy your container in SIT server

stage-8
waiting for testing team to complete their manual testing and update their integration testing scripts

once they approved pipeline

statge -9
integration test run

stage 10
deploy your container to performance testing

stage 11
smoke testing and wait for performance testing report

stage 12
deploy your code to CT env --> client testing env

stage 13
smoke testing

stage 14
deploy your code to prod and dr