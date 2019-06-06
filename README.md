# Docker Image for Apache Drill

* This will create a [Docker](https://www.docker.com) container of [Apache Drill](https://drill.apache.org) for analyzing file-based data (e.g., parquet files). 
* While creating the container, the image will also generate a `/data` folder for the data files. 
* This image will also extract the jdbc driver jar of Apache Drill to connect SQL user interfaces (e.g. Data Grip) to the Drill container.

## Docker Environment

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

## The docker image

The docker image contains the following files:

* The `docker-compose.yml` file contains the description of how to build and configure the container that will run Apache Drill.
* The `.env` file contains the parameter `DRILL_VERSION` that is determines which version of Apache Drill is being built and run. Currently, the `DRILL_VERSION` is set to `1.16.0`. If you need to change this, adapt the `.env` file.
* The `/build/Dockerfile` contains the build descriptions for the container.
* The `run_drill.sh` contains the startup script for Apache Drill. 
* The `.gitignore` prevents that anything in the data folder or any parquet/csv files will be added to the repository.

## Get the docker image

Use the [GitHub Desktop](https://desktop.github.com) or run the following commands (assuming that you have git installed):

1. Check for git
```
git version
```
You should see a result similar to the following:
```
git version 2.20.1 (Apple Git-117)
```

2. Check out the repo into a directory of your choice:
```
git clone https://github.com/mschermann/docker_apache_drill_datagrip.git
```

## Build and start the container

1. Check the configuration:
```
docker-compose config
```
You should see a result similar to the following:
```
services:
  drill:
    build:
      args:
        DRILL_VERSION: 1.16.0
      context: /<YOUR PATH>/build
      dockerfile: Dockerfile
    command: ./run_drill.sh
    container_name: drill
    environment:
      DRILL_VERSION: 1.16.0
    hostname: drill
    ports:
    - 8047:8047/tcp
    - 31010:31010/tcp
    restart: on-failure
    tty: true
    volumes:
    - /<YOUR PATH>/data:/data:rw
```

2. Build the container
```
docker-compose build
```

You should see that docker starts to build the container. This will take a while depending on your internet speed and machine configuration.
```
Building drill
Step 1/13 : FROM centos:latest
...
```

3. Start and stop the container
```
docker-compose up
```
You should see that docker starts the container. When you see the Drill message of the day, Drill is up and running:
```
Attaching to e382a3c16e10_drill
e382a3c16e10_drill | Apache Drill 1.16.0
e382a3c16e10_drill | "There are two types of analysts in the world: those who use Drill and those who don't."
```

Additionally, this step has also extracted the JDBC driver for Apache Drill (e.g., `drill-jdbc-all-1.16.0.jar`) into the `/build` folder.

You can stop the container with `Control+C`, which should result in the following output:
```
Gracefully stopping... (press Ctrl+C again to force)
Stopping e382a3c16e10_drill ... done
```

## Explore Drill

Drill is starting a web GUI at [http://localhost:8047](http://localhost:8047).

![Drill Overview](https://github.com/mschermann/docker_apache_drill_datagrip/blob/master/assets/drill_overview.png)

If you click on `Query`, you can run SQL queries directly from the broswer (Do not use this for any heavy-load querying). 

![Drill Overview Query](https://github.com/mschermann/docker_apache_drill_datagrip/blob/master/assets/drill_overview_query.png)

Just to make sure that everything works fine, enter the example query `SELECT * FROM cp.`employee.json` LIMIT 20`.

![Drill Example Query](https://github.com/mschermann/docker_apache_drill_datagrip/blob/master/assets/drill_query_example.png)

It will show you a waiting screen and, if everything works fine, the results.

![Drill Example Query Results](https://github.com/mschermann/docker_apache_drill_datagrip/blob/master/assets/drill_query_example_results.png)

Now, head over to the [Drill Documentation](https://drill.apache.org/docs/query-data/) and start learning how to use Drill.

## Connect to the Drill container with a SQL tool
Let's connect [Data Grip](http://www.jetbrains.com/datagrip) to the Drill container.

1. Create a new Driver in Data Grip by pointing towards the JDBC driver for Apache Drill in the `/build` folder.

![Data Grip Driver](https://github.com/mschermann/docker_apache_drill_datagrip/blob/master/assets/data_grip_drill_driver.png)

2. Create a data source using the Drill driver. Test the connection and make sure you get the green checkmark.

![Data Grip Datasource](https://github.com/mschermann/docker_apache_drill_datagrip/blob/master/assets/data_grip_drill_connection.png)

3. Run a Sample Query

Using the same query as above (`SELECT * FROM cp.`employee.json` LIMIT 20`), you should see the following output.

![Data Grip Sample Query](https://github.com/mschermann/docker_apache_drill_datagrip/blob/master/assets/data_grip_sample_query.png)

At this point you are all set. Add your data files to the `/data` folder and you should be able to query them.

If you use [parquet data files](https://drill.apache.org/docs/querying-parquet-files/), the following command will give you the five rows of the data.
```
SELECT * FROM dfs.`/data` LIMIT 5;
```

Head over to the [Drill documentation](https://drill.apache.org/docs/query-data-introduction/) for more in-depth explanation and help.

## Access the Drill container

If you want to access the Drill container.

1. Find the name of your container.
```
docker ps
```
This should result in an output like this:
```
CONTAINER ID  IMAGE  COMMAND  CREATED  STATUS  PORTS  NAMES
e382a3c16e10  docker_drill_parquet_datagrip_drill  "./run_drill.sh"  About an hour ago  Up 47 seconds  0.0.0.0:8047->8047/tcp, 0.0.0.0:31010->31010/tcp e382a3c16e10_drill
```

2. Access the container
From the `NAMES` column, you can see that this container is called `e382a3c16e10_drill`. You can connect to this container using the following command:
```
docker exec -it e382a3c16e10_drill bash
```
This will result in a prompt inside the container:
```
[root@drill drill]#
```







