# Defined in /tmp/fish.yyhdC0/get_pod.fish @ line 1
function get_pod
	set -g deploy_name (helm list|tail -n 1|cut -f1)
    set -g pod_name (kubectl get pods --namespace default -l "app.kubernetes.io/name=kooldjak,app.kubernetes.io/instance=$deploy_name" -o jsonpath="{.items[0].metadata.name}")
end
