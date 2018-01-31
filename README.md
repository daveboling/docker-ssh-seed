# Docker SSH Seed

## ABOUT

Simple, base Ubuntu container with port 5000 exposed.

## RUN
start a detached docker container
1. `docker-compose up -d`
2. `gem install net-ssh`
3. `ruby worker.rb`

## SSH
- `ssh root@localhost -p 5000`
- password is: 'password'



# Docker Quick Notes

## COMMANDS
See list of images
- `docker images`

See list of containers
- `docker container list`

Remove an image
- `docker rmi <IMAGE_ID>`

See running docker processes
- `docker ps`


## CONTAINER MGMT.
Run a specific image as a container interactively
- With REPOSITORY: `docker run -i -t <REPO>:<TAG>`
- With IMAGE_ID: `docker run -i -t <IMAGE_ID>`

Run an image as a container in the background
- `docker run -d ubuntu:alpine`

Run an image as a container and shell into it
- `docker run -it --entrypoint=/bin/bash <IMAGE_ID>`
1. This is useful if you only want to SSH into a container that isn't running anything.

Running a script inside of a container
- `docker exec -it <CONTAINER_ID> ~/app/bin/etl`

Get the IP address of a container (shortcut)
- `docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <CONTAINER_ID>`


## IMAGE MGMT.
Build an image and name it
- `docker build -t etl .` 
1. The `.` will look for a `Dockerfile` in the same directory
2. Will make in image called `etl:latest`

## WORKING WITH RUNNING PROCESSES AND CONTAINERS
SSH into a container
- `docker exec -it <CONTAINER_NAME> /bin/bash`

SSH into a running contrainer to run a command
- `docker exec -it <CONTAINER_NAME> <COMMANDS>`


## DOCKER COMPOSE
Remove stopped service containers
- `docker-compose rm`

Compose a set of docker container(s) detached
- `docker-compose up -d`
1. If the container doesn't run anything, then it will not run after this command. If you only want to be able to SSH into it, see below.
2. Use `stdin_open: true` option to allow a detched container only for shell access. Leaves the stdin open so it can be a detached process.


## GENERAL ADVICE
1. Be sure to use `docker-compose up|down|rm` to manage containers so as not to create duplicates.
2. When building a container made for SSH access, ensure that an SSH server is running on the container (and setup properly). In this project, it's already handled in the `Dockerfile`. This was made from the Docker example found here: https://docs.docker.com/engine/examples/running_ssh_service/#build-an-eg_sshd-image
