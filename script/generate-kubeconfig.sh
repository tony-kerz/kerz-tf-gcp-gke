#!/bin/bash -x
set -o nounset
set -o errexit

kubeRoot=${KUBEROOT:-~/.kube}
sa=${SA:-admin}
cluster=${CLUSTER}
region=${REGION:-us-east4-a}
ns=${NS:-tk-system}

# gcloud will generate to location specified in KUBECONFIG
#
KUBECONFIG=${kubeRoot}/${cluster}

# generate initial kubeconfig via gcloud (kubeconfig will require gcloud)
#
gcloud container clusters get-credentials ${cluster} --region ${region}

# insure namespace
#
kubectl create namespace ${ns} | true

# insure sa
#
kubectl --namespace=${ns} create serviceaccount ${sa} | true

# insure cluster-role-binding
#
bindingType=clusterrolebinding
role=cluster-admin
bindingName=${ns}:${sa}:${role}
kubectl create ${bindingType} ${bindingName} --clusterrole ${role} --serviceaccount ${ns}:${sa} --namespace ${ns} | true

# generate kubeconfig that doesn't require gcloud
#
server=$(yq e .clusters[0].cluster.server ${KUBECONFIG})
_cluster=$(yq e .contexts[0].context.cluster ${KUBECONFIG})
secret=$(kubectl get sa ${sa} -n ${ns} -o yaml | yq e .secrets[0].name -)
# for some reason the following command doesn't work with $() syntax
# but does with `` syntax, some nuance of escapes in jsonpath...
#
cert=`kubectl get secret/${secret} -n ${ns} -o jsonpath='{.data.ca\\.crt}'`
token=$(kubectl get secret/${secret} -n ${ns} -o jsonpath='{.data.token}' | base64 -d)
#
# now that we have values, call helm template
#
helm template \
  --repo https://nexus.mgmt.ai.aetna.com/repository/helm-hosted \
  --set-string server=${server} \
  --set-string cluster=${_cluster} \
  --set-string namespace=${ns} \
  --set-string cert=${cert} \
  --set-string token=${token} \
  --set-string user=${sa} \
  kubeconfig > ${KUBECONFIG}
