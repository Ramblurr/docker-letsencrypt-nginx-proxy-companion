
#load container name from rancher meta-data
CONTAINER_NAME="r-$(curl -s rancher-metadata/latest/self/container/name)"
NGINX_DOCKER_GEN_CONTAINER=${CONTAINER_NAME/letsencrypt/nginx-gen}
NGINX_DOCKER_CONTAINER=${CONTAINER_NAME/letsencrypt/nginx}

export NGINX_DOCKER_GEN_CONTAINER
export NGINX_DOCKER_CONTAINER


#download docker-gen nginx-template
curl https://raw.githubusercontent.com/jwilder/nginx-proxy/master/nginx.tmpl > /etc/nginx/docker-gen/nginx.tmpl

#create docker-gen config file
echo "$NGINX_DOCKER_CONTAINER = 1" >> /app/docker-gen.cfg
cp /app/docker-gen.cfg /etc/nginx/docker-gen/docker-gen.cfg
