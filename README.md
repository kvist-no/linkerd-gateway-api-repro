- update `argo-rollouts-values.yaml` `location` key to point to a binary 
  with the argo rollouts gateway api plugin that suits your needs.
  if you need grpc support you need to build it yourself and host it.
  we host it in s3 and it works very well:)
- bootstrap cluster using Makefile

- create secret called `license-secret` in `linkerd` namespace with your 
  Bouyant license key under the key `license`

- install manifests in `manifests/`

- port-forward 8000 from the load balancer and call `/` to see it in action, 
  or `/status/500` to see linkerd retrying