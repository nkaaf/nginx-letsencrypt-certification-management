# Migrations of old versions

The project can have updates for three components:

* [Executive Scripts](#executive-scripts)
* [nginx related](#nginx-related)
* [Certbot related](#certbot-related)

For those you have to do different steps to update your setup. If you migrate to the next version, you only have to do
the steps for the component of the version. If you migrate to a newer version, than the next, it's easier to update all
three components, to be on the safe side.

## Git Migrations

To update your cloned repository, checkout the desired tag.

```bash
git checkout <tag-name>
```

### Executive Scripts

Update the Executive Scripts is quite easy, because you don't have to do anything, except from checking out the correct
tag.

### nginx related

For nginx related scripts you have to remove the nginx docker container, and the docker image (commonly). You will find
the nginx-container-name, and the nginx-image-name in the .env file.

```bash
docker container rm -f <nginx-container-name>
docker rmi <nginx-image-name>
```

### certbot related

This will be done analog to [nginx related](#nginx-related).

```bash
docker container rm -f <certbot-container-name>
docker rmi <certbot-image-name>
```

## Releases

### 1.1

* [nginx related](#nginx-related)

### 1.0

First release