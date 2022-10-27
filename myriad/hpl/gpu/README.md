# HPL on Myriad GPUs

These instructions explain how to get NVIDIA's HPL benchmarks running on Myriad GPUs. It follows [NVIDIA's set of instructions](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/hpc-benchmarks).

1. Register for a NVIDIA account using the [registration instructions](https://docs.nvidia.com/ngc/ngc-catalog-user-guide/index.html#registering-activating-ngc-account)
2. Generate an API key at https://ngc.nvidia.com/setup/api-key
3. Pull the singularity container using
`singularity pull --docker-login hpc-benchmarks:21.4-hpl.sif docker://nvcr.io/nvidia/hpc-benchmarks:21.4-hpl`. When prompted for a username enter `$oauthtoken` and for the password enter the API key generated above.
