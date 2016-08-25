
#load container name from rancher meta-data
STACK_NAME="r-$(curl -s rancher-metadata/latest/self/stack/name)"
SCALE="$(curl -s rancher-metadata/latest/self/service/scale)"

NGINX_DOCKER_GEN_CONTAINER=$STACK_NAME"_nginx_nginx-gen_"$SCALE
NGINX_DOCKER_CONTAINER=$STACK_NAME"_nginx_"$SCALE

export NGINX_DOCKER_GEN_CONTAINER
export NGINX_DOCKER_CONTAINER

#download docker-gen nginx-template
if [ ! -f /etc/nginx/docker-gen/nginx.tmpl ]; then
    curl https://raw.githubusercontent.com/jwilder/nginx-proxy/master/nginx.tmpl > /etc/nginx/docker-gen/nginx.tmpl
fi

#create docker-gen config file
if [ ! -f /etc/nginx/docker-gen/docker-gen.cfg ]; then
    cp /app/docker-gen.cfg /etc/nginx/docker-gen/docker-gen.cfg
    echo "$NGINX_DOCKER_CONTAINER = 1" >> /etc/nginx/docker-gen/docker-gen.cfg
fi
