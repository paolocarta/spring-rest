#
#
oc apply -f ocp-projects
sleep 1


helm upgrade --install tekton-helm-pipeline ./1-tekton-helm-pipeline -n basic-spring-boot-cicd

sleep 1

# start pipe
oc apply -f ./1-tekton-helm-pipeline/pipelinerun.yaml