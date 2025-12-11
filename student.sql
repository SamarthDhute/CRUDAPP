DROP DATABASE IF EXISTS cruddb;
CREATE DATABASE cruddb;

\c cruddb
DROP TABLE IF EXISTS student;
CREATE TABLE student (
  id SERIAL PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  email VARCHAR(20) UNIQUE NOT NULL,
  mobile VARCHAR(10)NOT NULL
);

INSERT INTO student(name,email,mobile) VALUES('samarth','samarth@gmail.com',1234567890);
INSERT INTO student(name,email,mobile) VALUES('gaurav','gaurav@gmail.com',7654567890);
INSERT INTO student(name,email,mobile) VALUES('vivek','vivek@gmail.com',9876567890);

SELECT * FROM student;


