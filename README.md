- bootstrap cluster using Makefile

- create secret called `license-secret` in `linkerd` namespace with your 
  Bouyant license key under the key `license`

- install manifests in `manifests/`

- port-forward 8000 from the load balancer and call `/` to see it in action, 
  or `/status/500` to see linkerd retrying