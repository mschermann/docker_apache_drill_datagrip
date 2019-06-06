# Docker Image for Apache Drill

This will create a Docker image of Apache Drill for analyzing file-based data (e.g., parquet files). The image will generate a `/data` folder for the data files. Also this image will extract the jdbc driver jar to connect SQL user interfaces (e.g. Data Grip) to the Drill container.

## Prerequisites

### Docker Environment

Install Docker by following the instructions [here](https://www.docker.com/products/docker-desktop). If you do not have an account with Docker, you may be asked to create one. 

Ensure that Docker is correctly running using the following command:
```
docker version
```
You should see a result similar to the following:
```
Client: Docker Engine - Community
 Version:           18.09.2
 API version:       1.39
 Go version:        go1.10.8
 Git commit:        6247962
 Built:             Sun Feb 10 04:12:39 2019
 OS/Arch:           darwin/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.2
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.6
  Git commit:       6247962
  Built:            Sun Feb 10 04:13:06 2019
  OS/Arch:          linux/amd64
  Experimental:     false
```
