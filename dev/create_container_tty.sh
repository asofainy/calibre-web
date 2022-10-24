
name="calibre-web"
image="asofainy/calibre-web:ci"

port=8083

echo -n "stopping container : "
docker stop $name

echo -n "removing container : "
docker rm -v $name

echo "creating container : "

docker run \
    --name=$name \
    --hostname calibre.olympus.local \
    --publish $port:8083 \
    --volume /books:/books \
    --restart unless-stopped \
    $image

container_id="$(docker container ls -f name=$name -q)"

echo "Pour se connecter :  docker exec -it $container_id /bin/bash"
