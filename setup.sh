#
#
oc apply -f tekton-pipe/ocp-projects
sleep 1


helm upgrade --install tekton-helm-pipeline ./tekton-pipe -n basic-spring-boot-cicd --values values.yaml

sleep 1

oc project basic-spring-boot-cicd