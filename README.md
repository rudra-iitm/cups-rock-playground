# Setting Up and Running CUPS locally

## Prerequisites

1. **Docker Installed**: Ensure Docker is installed on your system. You can download it from the [official Docker website](https://www.docker.com/get-started).

2. **Rockcraft**: Rockcraft should be installed. You can install Rockcraft using the following command:
```sh
sudo snap install rockcraft --classic
```

3. **Skopeo**: Skopeo should be installed to compile `.rock` files into Docker images. <br>
**Note**: It comes bundled with Rockcraft.

## Step-by-Step Guide

### 1. Build CUPS rock:

The first step is to build the Rock from the `rockcraft.yaml`. This image will contain all the configurations and dependencies required to run CUPS.

Open your terminal and navigate to the directory containing your `rockcraft.yaml`, then run the following command:

```sh
rockcraft pack -v
```

### 2. Compile to Docker Image:

Once the rock is built, you need to compile docker image from it.

```sh
sudo rockcraft.skopeo --insecure-policy copy oci-archive:<rock_image> docker-daemon:cups:latest
```

### Run the CUPS Docker Container:

```sh
sudo docker run --rm -d --name cups -p <port>:631 \
    -e CUPS_ADMIN="${CUPS_ADMIN}" -e CUPS_PASSWORD="${CUPS_PASSWORD}" \
    cups:latest
```

## Note: 
- `CUPS_ADMIN` and `CUPS_PASSWORD` are administrative credentials for accessing CUPS.
- If credentials are not provided, you can view the randomly generated administrative credentials for your container using the following command:
    ```sh
    sudo docker exec cups cat /etc/cups/cups-credentials
    ```