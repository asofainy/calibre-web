#!/bin/bash

app="calibre-web"
context="/data/applications/$app/build"
image="asofainy/$app"
version="local"
tag="$image:$version"

nocache=$1

docker build $nocache \
-t $tag $context 

