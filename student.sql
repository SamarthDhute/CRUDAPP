DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS users;

CREATE TABLE student (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  mobile VARCHAR(10)NOT NULL
);

INSERT INTO student(name,email,mobile) VALUES('samarth','samarth@gmail.com',1234567890);
INSERT INTO student(name,email,mobile) VALUES('gaurav','gaurav@gmail.com',7654567890);
INSERT INTO student(name,email,mobile) VALUES('vivek','vivek@gmail.com',9876567890);


SELECT * FROM student;

 create table users(
  id serial primary key,
  name varchar(200)  not null,
  email varchar(100) not null,
  useName varchar(100) unique not null,
  password varchar(100)not null
  );



