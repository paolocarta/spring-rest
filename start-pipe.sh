#
#
oc delete pipelinerun basic-spring-boot-pipeline-run
sleep 1


oc apply -f ./tekton-pipe/pipelinerun.yaml -n basic-spring-boot-cicd