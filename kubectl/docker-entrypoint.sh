#!/bin/bash -eu

NS=${NS:-"kube-system"}

getPod() {
	local podFilterPattern="$@"
	kubectl get po -n kube-system | grep $podFilterPattern | awk '{print $1}'
}

main() {
	local cmd=$1 && shift
	case "$cmd" in
		# forward [ports] [podFilterPattern]
		forward)
			local ports="$1" && shift
			local podFilterPattern="$@"
			exec kubectl port-forward --namespace $NS $(getPod "$podFilterPattern") $ports
		;;
		# normal kubectl command
		*)
			exec kubectl $cmd $@
		;;
	esac
}

main "$@"