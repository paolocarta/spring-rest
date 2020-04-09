if [[ "$OSTYPE" == "linux-gnu" ]]; then
    ###
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh

elif [[ "$OSTYPE" == "darwin"* ]]; then
    ##
    brew install helm
    # Mac OSX
fi