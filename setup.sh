#
#
sed "s/REPLACEME/$GITHUB_USER/g" tekton-pipeline/ocp-projects/projects.input.yaml > tekton-pipeline/ocp-projects/projects.yaml

oc apply -f tekton-pipeline/ocp-projects
sleep 1


helm upgrade --install tekton-helm-pipeline ./tekton-pipeline -n basic-spring-boot-cicd-$GITHUB_USER --values values.yaml

sleep 1

oc project basic-spring-boot-cicd-$GITHUB_USER