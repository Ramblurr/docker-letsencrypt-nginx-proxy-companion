
#load container name from rancher meta-data
CONTAINER_NAME=$(curl -s rancher-metadata/latest/self/container/name)
export NGINX_DOCKER_GEN_CONTAINER=${CONTAINER_NAME/letsencrypt/nginx-gen}
