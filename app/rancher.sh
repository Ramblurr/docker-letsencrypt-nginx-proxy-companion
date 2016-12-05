
#load container name from rancher meta-data
STACK_NAME="r-$(curl -s rancher-metadata/latest/self/stack/name)"
SCALE="$(curl -s rancher-metadata/latest/self/service/scale)"

NGINX_DOCKER_GEN_CONTAINER=$STACK_NAME"_nginx_nginx-gen_"$SCALE
NGINX_DOCKER_CONTAINER=$STACK_NAME"_nginx_"$SCALE

export NGINX_DOCKER_GEN_CONTAINER
export NGINX_DOCKER_CONTAINER

#cause of Rancher 1.2 we need an special nginx.tmpl file
cp /app/nginx.tmpl /etc/nginx/docker-gen/nginx.tmpl

#create docker-gen config file
if [ ! -f /etc/nginx/docker-gen/docker-gen.cfg ]; then
    cp /app/docker-gen.cfg /etc/nginx/docker-gen/docker-gen.cfg
    echo "$NGINX_DOCKER_CONTAINER = 1" >> /etc/nginx/docker-gen/docker-gen.cfg
fi
