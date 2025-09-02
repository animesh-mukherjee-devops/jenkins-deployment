kubectl label node controlplane jenkins=controller
kubectl label node node01 jenkins=agent
kubectl label node node02 jenkins=agent

kubectl create namespace jenkins

helm repo add jenkinsci https://charts.jenkins.io
helm repo update

kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml

kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'


helm install jenkins jenkinsci/jenkins -n jenkins -f values.yaml

kubectl get pods -n jenkins

kubectl get secret jenkins -n jenkins -o jsonpath='{.data.jenkins-admin-password}' | base64 -d; echo
