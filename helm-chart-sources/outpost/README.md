![Cribl Logo](../../images/Cribl_Logo_Color_TM.png)

# Cribl Outpost Helm Chart

This chart deploys Cribl Outpost in a Kubernetes Cluster.

## Deployment

As built, this chart will creates a Deployment on one or more instances of
Outpost and a Service for access from other Cribl instances in the Cluster. A
Secret is created for the upstream Cribl Leader connection settings.  
Optionally, a Service Account, Cluster Role, Cluster Role Binding can be created
to allow Outpost access to the Cluster API so it can provide information on the
local runtime environment to the upstream Cribl Leader for mapping.

## Prerequisites

1. Helm v3 installed; see https://helm.sh/docs/intro/install/.
2. Cribl's helm-charts repo added;<br/>
    `helm repo add cribl https://criblio.github.io/helm-charts/`

## Support/Feedback

If you use this helm chart, we'd love to hear any feedback you might have on
this chart. Join us on our [Slack Community](https://cribl.io/community) and
navigate to the `#containers` channel.

## Values to Override

This section covers the most likely values to override. To see the full scope of
values available, run `helm show values cribl/outpost`.

| Key | Default Value | Description |
|-----|---------------|-------------|
| image.repository | `cribl/cribl` | Docker image repository to pull images from |
| image.pullPolicy | `Always` | When will the Node pull the image |
| image.tag | `4.10.1` | The version of Cribl to deploy |
| imagePullSecrets | `[]` | Credentials used to pull container images |
| nameOverride | | Overrides the chart name |
| fullNameOverride | | Overrides the Helm deployment name |
| replicaCount | 1 | Number of Outpost instances to run |
| [extraEnv] | `{}` | Additional static environment variables |
| [extraEnvFrom] | `{}` | Environment variables to be exposed from the Downward API|
| [extraConfigMaps] | `[]` | Pre-existing configmaps to mount within the container |
| [extraSecretMounts] | `[]` | Pre-existing secrets to mount within the container |
| [extraVolumeMounts] | see `values.yaml` | Additional Volumes to mount in the container |
| [extraContainers] | `{}` | Additional containers to run as sidecars of the primary container in the pod |
| [extraInitContainers] | `{}` | Additional containers to run ahead of the primary container in the pod |
| cribl.home | `/opt/cribl` | default Cribl directory |
| cribl.existingSecretForLeader | | Name of an existing Secret that contains the value for the `CRIBL_DIST_LEADER_URL` environment variable |
| cribl.leader | | The value for the `CRIBL_DIST_LEADER_URL` environment variable to use when `existingSecretForLeader` isn't set |
| cribl.existingSecretForConfig | | Name of an existing Secret that contains the `CRIBL_BOOTSTRAP` environment variable value to use |
| cribl.config | | The value for the `CRIBL_BOOTSTRAP` environment variable when `existingSecretForConfig` is not set |
| cribl.readinessProbe | see `values.yaml` | readiness probe config |
| cribl.livenessProbe | see `values.yaml` | liveness probe config |
| serviceAccount.create | `false` | Specifies whether a service account should be created |
| serviceAccount.annotations | `{}` | Annotations to add to the service account |
| serviceAccount.name | | Override the default generated service account name |
| serviceAccount.automountServiceAccountToken | `true` | Whether the service account token should be auto-mounted into the container |
| rbac.create | `false` | Specifies whether a role should be created |
| rbac.annotations | `{}` | Annotations to add to the Role |
| rbac.extraRules | `[]` | Additional rules to add to the Role |
| podAnnotations | `{}` | Annotations to add to the Pod |
| podSecurityContext | `{}` | Security context for the pod |
| securityContext | `{}` | Security context for the Cribl container |
| service.enable | `true` | Specifies whether a service should be created |
| service.type | `ClusterIP` | The type of service deployed |
| service.externalTrafficPolicy | `Cluster` | IP address visibility |
| service.annotations | `{}` | Annotations to add to the service |
| service.ports | see `values.yaml` | Ports configured for the service |
| ingress.enable | `false` | Specifies if an ingress should be created |
| ingress.className | | The ingress class name |
| ingress.annotations | `{}` | Annotations to be added to all ingresses |
| ingress.ingress | see `values.yaml` | Ingress resources to be created |
| resources.limits | see `values.yaml` | Limits for the Edge Pod |
| resources.requests | see `values.yaml` | Reserved resources for the Edge Pod |
| nodeSelector | `{}` | Node selection for Pod deployment |
| tolerations | see `values.yaml` | Node tolerations/taints allowed for deploying the Edge Pods |
| extraObjects | `{}` | Ability to add custom Kubernetes objects into this deployment as part of this chart |

[extraEnv]: ../../common_docs/EXTRA_EXAMPLES.md#env
[extraEnvFrom]: ../../common_docs/EXTRA_EXAMPLES.md#extraEnvFrom
[extraConfigMaps]: ../../common_docs/EXTRA_EXAMPLES.md#extraConfigmapMounts
[extraSecretMounts]: ../../common_docs/EXTRA_EXAMPLES.md#extraSecretMounts
[extraVolumeMounts]: ../../common_docs/EXTRA_EXAMPLES.md#extraVolumeMounts
[extraContainers]: ../../common_docs/EXTRA_EXAMPLES.md#extraContainers
[extraInitContainers]: ../../common_docs/EXTRA_EXAMPLES.md#extraInitContainers