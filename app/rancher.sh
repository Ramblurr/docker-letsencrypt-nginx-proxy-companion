
#load container name from rancher meta-data
STACK_NAME="$(curl -s rancher-metadata/2015-12-19/self/stack/name)"

NGINX_DOCKER_GEN_CONTAINER="$(curl -s rancher-metadata/2015-12-19/stacks/$STACK_NAME/services/nginx-gen/containers/0/external_id)"
NGINX_DOCKER_CONTAINER="$(curl -s rancher-metadata/2015-12-19/stacks/$STACK_NAME/services/nginx/containers/0/external_id)"

export NGINX_DOCKER_GEN_CONTAINER
export NGINX_DOCKER_CONTAINER

#cause of Rancher 1.2 we need an special nginx.tmpl file
cp /app/nginx.tmpl /etc/nginx/docker-gen/nginx.tmpl

#create docker-gen config file
cp /app/docker-gen.cfg /etc/nginx/docker-gen/docker-gen.cfg
echo "$NGINX_DOCKER_CONTAINER = 1" >> /etc/nginx/docker-gen/docker-gen.cfg
