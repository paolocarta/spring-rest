#
#
oc apply -f ocp-projects
sleep 1


helm upgrade --install tekton-helm-pipeline . -n basic-spring-boot-cicd