# README to Docker Hub

===

This is a quick hack to push README.md files to Docker hub.


## How to use?

If you are using my scripts then

```shell
dockermgr readme FILE USERNAME REPONAME HUB_USERNAME HUB_PASSWORD
```

or run it with all needed parameter:

```shell
docker run --rm \
    -e DOCKERHUB_USERNAME=myhubuser \
    -e DOCKERHUB_PASSWORD=myhubpassword \
    -e DOCKERHUB_REPO_PREFIX=myorga \
    -e DOCKERHUB_REPO_NAME=myrepo \
    -v $PWD/readme.md:/data/README.md:ro \
     casjaysdevdocker/readme-to-dockerhub
```

That's it.


## Environment variables

This image uses environment variables for configuration.

| Available variables     | Default value         | Description                                          |
| ----------------------- | --------------------- | ---------------------------------------------------- |
| `DOCKERHUB_USERNAME`    | no default            | The Username (not mail address) used to authenticate |
| `DOCKERHUB_PASSWORD`    | no default            | Password of the `DOCKERHUB_USERNAME`-user            |
| `DOCKERHUB_REPO_PREFIX` | `$DOCKERHUB_USERNAME` | Organization or username for the repository          |
| `DOCKERHUB_REPO_NAME`   | no default            | Name of the repository you want to push to           |
| `README_PATH`           | `/data/README.md`     | Path to the README.me to push                        |
| `SHORT_DESCRIPTION`     | no default            | Short description for the Dockerhub repo             |

## Mount the README.md

By default, if the `README_PATH` environment variable is not set, this image always pushes the file
`/data/README.md` as full description to Docker Hub.

For GitHub repositories you can use `-v /path/to/repository:/data/`.

If your description is not named `README.md` mount the file directory using `-v /path/to/description.md:/data/README.md`.

*Notice that the filename is case sensitive. If your readme is called `readme.md` you have to mount the file directly, not the directory*


## Additional Information

The user you use to push the README.md need to be admin of the repository.


## Updates and updating

To update your setup simply pull the newest image version from docker hub and run it.


## Deprecated features

We provide information about features we remove in future.

* `DOCKERHUB_REPO` - is renamed to `DOCKERHUB_REPO_NAME` to be not mixed up with `DOCKERHUB_REPO_PREFIX`


### Build

```shell
git clone "https://github.com/casjaysdevdocker/readme-to-dockerhub"
```

Simply build the image using

```shell
docker build -t readme-to-dockerhub .
```


### Base on

This is based on the code from <https://github.com/SISheogorath/readme-to-dockerhub>
