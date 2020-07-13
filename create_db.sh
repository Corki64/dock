#!/usr/bin/bash

# docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

USER=post
PW=firefly
HOST=$PG_HOST
DATABASE=$DB_DATABASE

docker pull gradle:jdk11

docker build . -t gradle:latest

# docker pull postgres:alpine

# docker volume create data
# docker run --name $USER -e POSTGRES_PASSWORD=$PW -d -v data:/var/lib/postgresql/data postgres:alpine
# # pause pause for 1 second so db can initialize
# read -p "Pause Time 1 seconds" -t 1
# docker exec -it post psql -U postgres -c 'create user admin login;'
# docker exec -it post psql -U postgres -c 'grant admin to postgres;'
# docker exec -it post psql -U postgres -c 'create database image_gallery owner admin;'
# docker exec -it post psql -U postgres -a image_gallery -c 'create extension if not exists "uuid-ossp";'
# docker exec -it post psql -U postgres -a image_gallery -c 'select uuid_generate_v4();'
# docker exec -it post psql -U admin -a image_gallery -c 'CREATE TABLE users (
#     id uuid DEFAULT uuid_generate_v4 (),
#     user_name VARCHAR(100) NOT NULL,
#     password VARCHAR(100) NOT NULL,
#     full_name VARCHAR(100) NOT NULL,
#     PRIMARY KEY (id)
# );'
# docker exec -it 'post' psql -U 'admin' -d 'image_gallery' --command "INSERT INTO users (
#                                                         user_name,
#                                                         password,
#                                                         full_name
#                                                         )
#                                                         VALUES
#                                                             (
#                                                                 'lui',
#                                                                 'luipass',
#                                                                 'and more luis'
#                                                             ),
#                                                             (
#                                                                 'mui',
#                                                                 'otrapass',
#                                                                 'y mas luis'
#                                                             ),
#                                                             (
#                                                                 'ymas',
#                                                                 'laultima',
#                                                                 'hijo de su picnch madre'
#                                                             );"
                                                            
                                                            


# db debugger
# docker exec -it post bash

# app debugger
# docker run --name ig-app -p 80:80 -p 443:443 -it -d --link post gradle:latest /bin/bash

# when docker db is running or commented out to linke both in the same network
# docker run --name ig-app -p 80:80 -p 443:443 -d --link post gradle:latest


docker run --name ig-app -p 80:80 -p 443:443 -d gradle:latest