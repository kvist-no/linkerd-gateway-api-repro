CLUSTER_NAME := linkerd-gateway-api-routes

KUBE_CONTEXT := "kind-$(CLUSTER_NAME)"

create-cluster:
	kind create cluster -n $(CLUSTER_NAME) --config cluster-config.yaml

delete-cluster:
	kind delete cluster --name $(CLUSTER_NAME)

bootstrap-cluster:
	linkerd install --crds --set enableHttpRoutes=false --context $(KUBE_CONTEXT) | kubectl apply --context $(KUBE_CONTEXT) -f -
	linkerd install --set licenseSecret=license-secret --set enableHttpRoutes=false --context $(KUBE_CONTEXT) | kubectl apply --context $(KUBE_CONTEXT) -f -
	helm repo add traefik https://traefik.github.io/charts --kube-context $(KUBE_CONTEXT)
	helm repo add argo https://argoproj.github.io/argo-helm --kube-context $(KUBE_CONTEXT)
	helm install traefik traefik/traefik --version 29.0.1 --values traefik-values.yaml --kube-context $(KUBE_CONTEXT)
	helm install argo-rollouts argo/argo-rollouts --values argo-rollouts-values.yaml --version 2.37.2 --kube-context $(KUBE_CONTEXT)


upgrade-cluster:
	linkerd upgrade --crds --set enableHttpRoutes=false --context $(KUBE_CONTEXT) | kubectl apply --context $(KUBE_CONTEXT) -f -
	helm upgrade traefik traefik/traefik --version 29.0.1 --values traefik-values.yaml --kube-context $(KUBE_CONTEXT)
	helm upgrade argo-rollouts argo/argo-rollouts --values argo-rollouts-values.yaml --version 2.37.2 --kube-context $(KUBE_CONTEXT)
	linkerd upgrade --set enableHttpRoutes=false --set licenseSecret=license-secret --context $(KUBE_CONTEXT) | kubectl apply --context $(KUBE_CONTEXT) -f -
