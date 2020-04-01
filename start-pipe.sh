#
#
oc delete pipelinerun basic-spring-boot-pipeline-run
sleep 1


oc apply -f ./1-tekton-helm-pipeline/pipelinerun.yaml