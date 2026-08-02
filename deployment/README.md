# Deployment

Infrastructure as Code and CI/CD for Clinical Semantic KG.

- `terraform/` — environment-specific Terraform (dev / staging / prod)
- `cloudbuild/` — Google Cloud Build configs
- `k8s/` — optional GKE manifests

Agents CLI can scaffold additional deployment files via:

```bash
agents-cli scaffold enhance --deployment-target cloud_run
```
