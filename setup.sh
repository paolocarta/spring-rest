#
#
oc apply -f tekton-pipeline/ocp-projects
sleep 1




helm upgrade --install tekton-helm-pipeline ./tekton-pipeline -n basic-spring-boot-cicd --values values.yaml

sleep 1

# start pipe
oc apply -f ./tekton-pipeline/pipelinerun.yaml -n basic-spring-boot-cicd

oc project basic-spring-boot-cicd