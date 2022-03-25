for n in $(kubectl get -o=name configmap,secret,ingress,service,deployment,statefulset)
do
    mkdir -p $(dirname $n)
    #kubectl get -o yaml $n > $n.yaml | /usr/local/sbin/kubectl-neat > /dev/null 2>&1
    /usr/local/sbin/kubectl-neat get -- $n -oyaml > $n.yaml
    echo "generated $n.yaml file"
done
