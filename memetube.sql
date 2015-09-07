drop database memetube;

create database memetube;

\c memetube

drop table videos;

create table videos (
  id serial8 primary key,
  title varchar(50),
  url varchar(200) UNIQUE NOT NULL,
  description varchar(200),
  genre varchar (100) NOT NULL
);

INSERT INTO memetubes (title, url, description, genre) VALUES ('Best Andy Dwyer Scenes', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ', 'Music video by Rick Astley performing Never Gonna Give You Up. YouTube view counts pre-VEVO: 2,573,462', 'Comedy');