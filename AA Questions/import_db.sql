PRAGMA foreign_keys = ON;
DROP TABLE question_likes;
DROP TABLE replies; 
DROP TABLE question_follows; 
DROP TABLE questions; 
DROP TABLE users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(50),
  lname VARCHAR(50)
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(50),
  body VARCHAR(250),
  associated_author_id REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id REFERENCES users(id),
  question_id REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body VARCHAR(250),
  subject_question_id REFERENCES questions(id),
  user_id REFERENCES users(id),
  parent_reply_id REFERENCES replies(id)
);

CREATE TABLE question_likes (
  user_id REFERENCES users(id),
  question_id REFERENCES questions(id)
);

INSERT INTO users (fname, lname)
VALUES 
  ( 'John', 'Smith'), 
  ('James', 'Bond'),
  ('Petr', 'Cech'),
  ('Mehmet', 'Bartels'),
  ('Oscar', 'Oscarson');

INSERT INTO questions (title, body, associated_author_id)
VALUES 
  ('How are babies made?', 'I need to know', 5),
  ('How many stars are there in the sky?', 'I am not sure', 1),
  ('How many miles is it from embaracadero to Milbrae?', 'I am planning a trip', 3);


INSERT INTO question_follows (user_id, question_id)
VALUES 
  (1, 1),
  (2, 1),
  (3, 1),
  (5, 1),
  (1, 2),
  (4, 2),
  (3, 3),
  (5, 3),
  (4, 3);

INSERT INTO replies (body, subject_question_id, user_id, parent_reply_id) 
VALUES 
  ('I don''t know', 3, 4, null),
  ('20 miles!', 3, 5, 1),
  ('A lot', 2, 2, null);

INSERT INTO question_likes (user_id, question_id)
VALUES
  (2, 3),
  (3, 2);







