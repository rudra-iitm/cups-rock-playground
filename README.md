# Setting Up and Running CUPS locally

## Prerequisites

1. **Docker Installed**: Ensure Docker is installed on your system. You can download it from the [official Docker website](https://www.docker.com/get-started).

2. **Rockcraft**: Rockcraft should be installed

3. **Skopeo**: Skopeo should be installed to compile *.rock into docker image

## Step-by-Step Guide

### 1. Build CUPS rock

The first step is to build the Rock from the `rockcraft.yaml`. This image will contain all the configurations and dependencies required to run CUPS.

Open your terminal and navigate to the directory containing your `rockcraft.yaml`, then run the following command:

```bash
    rockcraft pack
```

### 2. Compile to Docker Image

Once the rock is built, you need to compile docker image from it.

```bash
    sudo skopeo --insecure-policy copy oci-archive:<rock_image> docker-daemon:cups-rock:latest
```

### 3. Run the docker container

```bash
    docker run -p <PORT>:631 cups-rock
```