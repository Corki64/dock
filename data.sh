#!/usr/bin/bash


psql -U postgres
create user admin login password $PW;
grant admin to postgres;
create database image_gallery owner admin;
\c image_gallery
create extension if not exists "uuid-ossp";
select uuid_generate_v1();

\q
psql -d image_gallery -U admin
create table users (id uuid default uuid_generate_v1 (), user_name varchar(100) not null unique, password varchar(100), full_name varchar(200), primary key (id));# docker run -p 80:80 -p 443:443 -d --link postgres gradle:latest
insert into users (id, user_name, password, full_name) values (uuid_generate_v1(), 'lui', 'luipass', 'and more luis');
insert into users (id, user_name, password, full_name) values (uuid_generate_v1(), 'mui', 'muipass', 'y mas luis');
insert into users (id, user_name, password, full_name) values (uuid_generate_v1(), 'hijo', 'de', 'su pinchi madre lui!');