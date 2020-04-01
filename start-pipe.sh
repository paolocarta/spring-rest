#
#
oc delete pipelinerun basic-spring-boot-pipeline-run
sleep 1


oc apply -f ./tekton-pipeline/pipelinerun.yaml -n basic-spring-boot-cicd