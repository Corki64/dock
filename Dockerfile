# Step 1: pull application from github repo compile code with shadowJar
FROM gradle:6.5.1-jdk11 AS build

# to COPY from local directory
# COPY --chown=gradle:gradle . /home/gradle/src

RUN apt-get install git -y

RUN mkdir /home/gradle/src/

WORKDIR /home/gradle/src/

RUN git clone https://github.com/Corki64/image-gallery.git

WORKDIR /home/gradle/src/image-gallery/

RUN gradle build shadowJar

WORKDIR /home/gradle/src/image-gallery/build/libs/

# debugging tool
# ENTRYPOINT [ "java", "-jar", "adminJava-all.jar" ]


# Step 2: pull openjdk:11 image copy over web app shadowJar launch web application listening on port 80 and 443
FROM openjdk:11-jre-slim



EXPOSE 80:80
EXPOSE 443:443

COPY --from=build /home/gradle/src/image-gallery/build/libs/adminJava-all.jar /image-gallery-jar/adminJava-all.jar

WORKDIR /image-gallery-jar/


# ! comment for docker debugging
ENTRYPOINT [ "java", "-jar", "adminJava-all.jar" ]

















# Step 2: build db
# todo at the time I am just going to have a manual instructions to run the script at that is pulled
# ENV PGDATA=/var/lib/postgresql/data/pgdata
# ENV PG_PORT=5432
# ENV DB_DATABASE=image-gallery
# ENV DB_USER=admin
# ENV DB_PASSWD=1nsecure

# RUN mkdir -p /scripts/
# WORKDIR /scripts/

# COPY ./create_db.sh create_db.sh

# RUN chmod +x create_db.sh
# RUN ./create_db.sh

# RUN mkdir /image-gallery-jar