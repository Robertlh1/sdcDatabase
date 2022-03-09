DROP TABLE IF EXISTS questions CASCADE;
DROP TABLE IF EXISTS answers CASCADE;
DROP TABLE IF EXISTS answers_photos CASCADE;

CREATE TABLE questions(
id SERIAL PRIMARY KEY,
product_id INT,
body VARCHAR (1000),
date_written VARCHAR(24),
asker_name VARCHAR(60),
asker_email VARCHAR(60),
reported BOOLEAN,
helpful INT
);

CREATE INDEX questionsIndex ON questions (product_id);

COPY questions(id, product_id, body, date_written, asker_name, asker_email, reported, helpful)
FROM '/home/ubuntu/sdcDatabase/db/csv/questions_date_adjusted.csv'
DELIMITER ','
HEADER CSV;

UPDATE questions SET date_written = null;

CREATE TABLE answers(
id SERIAL PRIMARY KEY,
question_id INT,
body VARCHAR (1000),
date_written VARCHAR(24),
answerer_name VARCHAR(60),
answerer_email VARCHAR(60),
reported BOOLEAN,
helpful INT,
CONSTRAINT fk_question
  FOREIGN KEY(question_id)
    REFERENCES questions(id)
);

CREATE INDEX answersIndex ON answers (question_id);

COPY answers(id, question_id, body, date_written, answerer_name, answerer_email, reported, helpful)
FROM '/home/ubuntu/sdcDatabase/db/csv/answers_date_adjusted.csv'
DELIMITER ','
HEADER CSV;

UPDATE answers SET date_written = null;

CREATE TABLE answers_photos(
id SERIAL PRIMARY KEY,
answer_id INT,
url VARCHAR (200),
CONSTRAINT fk_answer
  FOREIGN KEY(answer_id)
    REFERENCES answers(id)
);

CREATE INDEX photosIndex ON answers_photos (answer_id);

COPY answers_photos(id, answer_id, url)
FROM '/home/ubuntu/sdcDatabase/db/csv/answers_photos.csv'
DELIMITER ','
HEADER CSV;