#!/usr/bin/env bash
set -e
set -o pipefail

ARGO_PORT="${ARGOPORT:-"8080"}"
# support podman or any other non-docker gateway
CRI_GATEWAY="${CRI_GATEWAY:-"host.docker.internal"}"

# login
# https://docs.docker.com/desktop/networking/#i-want-to-connect-from-a-container-to-a-service-on-the-host
argocd login "$CRI_GATEWAY:$ARGO_PORT" --skip-test-tls --username "$ARGOUSER" --password "$ARGOPASSWD" $ARGOFLAGS

# don't quote $1 so it globs
argocd cluster add -y --upsert "$CONTEXT" --name "$CLUSTER" --kubeconfig "$KUBECONFIG" $ARGOFLAGS $1