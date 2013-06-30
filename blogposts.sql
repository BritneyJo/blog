CREATE TABLE posts(
  id serial4 primary key,
  title varchar(50) NOT NULL,
  content text,
  creation_date date,
  author varchar(50)
  );