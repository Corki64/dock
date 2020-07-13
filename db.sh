#!/usr/bin/bash

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

USER=post
PW=firefly

docker pull postgres:alpine

docker volume rm data

docker volume create data

docker run --name $USER -e POSTGRES_PASSWORD=$PW -d -v data:/var/lib/postgresql/data postgres:alpine

# pause pause for 1 second so db can initialize
read -p "Pause Time 1 seconds" -t 1

docker exec -it post psql -U postgres -c 'create user admin login;'
docker exec -it post psql -U postgres -c 'grant admin to postgres;'
docker exec -it post psql -U postgres -c 'create database image_gallery owner admin;'
docker exec -it post psql -U postgres -a image_gallery -c 'create extension if not exists "uuid-ossp";'
docker exec -it post psql -U postgres -a image_gallery -c 'select uuid_generate_v4();'


docker exec -it post psql -U admin -a image_gallery -c 'CREATE TABLE users (
    id uuid DEFAULT uuid_generate_v4 (),
    user_name VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    full_name VARCHAR(100) NOT NULL,

    PRIMARY KEY (id)
);'

docker exec -it 'post' psql -U 'admin' -d 'image_gallery' --command "INSERT INTO users (
                                                        user_name,
                                                        password,
                                                        full_name
                                                        )
                                                        VALUES
                                                            (
                                                                'lui',
                                                                'luipass',
                                                                'and more luis'
                                                            ),
                                                            (
                                                                'mui',
                                                                'otrapass',
                                                                'y mas luis'
                                                            ),
                                                            (
                                                                'ymas',
                                                                'laultima',
                                                                'hijo de su picnch madre'
                                                            );"
                                                            