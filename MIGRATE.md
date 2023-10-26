# Migrations of old versions

The project can have updates for three components:

* [Executive Scripts](#executive-scripts)
* [nginx related](#nginx-related)
* [Certbot related](#certbot-related)

For those, you have to do different steps to update your setup. If you migrate to the next version, you only have to do
the steps for the component of the version. If you migrate to a newer version than the next, it's easier to update all
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
the nginx-container-name, and the nginx-image-name in the .env file. If the release contains a version update for the
component, you have to replace the version, in the .env, with the new one.

```bash
docker container rm -f <nginx-container-name>
docker rmi <nginx-image-name>
# For updated version
__new_version=$(cat .env.example | awk '$0 ~ /^NGINX_IMAGE_VERSION=/' | cut -d "=" -f2)
sed -i "s/NGINX_IMAGE_VERSION.*/NGINX_IMAGE_VERSION=${__new_version}/" ".env"
```

### certbot related

This will be done analog to [nginx related](#nginx-related).

```bash
docker container rm -f <certbot-container-name>
docker rmi <certbot-image-name>
# For updated version
__new_version=$(cat .env.example | awk '$0 ~ /^CERTBOT_IMAGE_VERSION=/' | cut -d "=" -f2)
sed -i "s/CERTBOT_IMAGE_VERSION.*/CERTBOT_IMAGE_VERSION=${__new_version}/" ".env"
```

## Releases

### 1.4

* [Executive Scripts](#executive-scripts)
* [certbot related](#certbot-related)
  * update version from v1.17.0 to 1.32.0
* [nginx related](#nginx-related)
  * update version from 1.21.1-alpine to 1.25.3-alpine-slim

### 1.3

* [Executive Scripts](#executive-scripts)

### 1.2

* [Executive Scripts](#executive-scripts)
  
* [nginx related](#nginx-related)
    * update version from 1.21.0-alpine to 1.21.1-alpine
* [certbot related](#certbot-related)
    * update version from v1.16.0 to v1.17.0

### 1.1

* [nginx related](#nginx-related)

### 1.0

First release