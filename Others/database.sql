CREATE DATABASE movie_db;
use movie_db;

CREATE TABLE publications(
    name VARCHAR(250) primary key, 
    avatar VARCHAR(250)
);

CREATE TABLE reviewers(
    name VARCHAR(255) primary key,
    publication VARCHAR(250),
    foreign key (publication) references publications(name),
    avatar VARCHAR(250)
);


CREATE TABLE movies(
    title VARCHAR(250) primary key,
    release_year VARCHAR(250),
    score INT(11),
    reviewer VARCHAR(250),
    foreign key (reviewer) references reviewers(name),
    publication VARCHAR(250)
);