# Pranai file
# Run only one cmd at once, one after the other

kubectl create ns argocd
kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml -n argocd

# Expose Argo cd

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type":"LoadBalancer"}}'
yum install jq -y
export ARGOCD_SERVER='kubectl get svc argocd-server -n argocd -o json | jq --raw-output '.status.loadBalancer.ingress[0].hostname''
echo $ARGOCD_SERVER
kubectl get svc argocd-server -n argocd -o json | jq --raw-output .status.loadBalancer.ingress[0].hostname # This will give ArgocdUI
kubectl get svc -n argocd

# Pwd conf
export ARGO_PWD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
echo $ARGO_PWD
