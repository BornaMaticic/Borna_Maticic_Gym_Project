DROP TABLE bookings;
DROP TABLE sessions;
DROP TABLE members;
DROP TABLE instructors;




CREATE TABLE members
(
  id SERIAL8 primary key,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  membership_type VARCHAR(255)
);


CREATE TABLE instructors
(
  id SERIAL8 primary key,
  name VARCHAR(255)
);


CREATE TABLE sessions
(
  id SERIAL8 primary key,
  session_name VARCHAR(255),
  session_time VARCHAR(255),
  membership_type VARCHAR(255),
  capacity VARCHAR(255),
  instructor_id INT8 references instructors(id) ON DELETE CASCADE
);


CREATE TABLE bookings
(
  id SERIAL8 primary key,
  member_id INT8 references members(id) ON DELETE CASCADE,
  session_id INT8 references sessions(id) ON DELETE CASCADE
);
