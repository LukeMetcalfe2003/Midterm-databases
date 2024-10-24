-- Tables

CREATE TABLE movies(
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INT NOT NULL,
    genre VARCHAR(50) NOT NULL,
    director VARCHAR(50) NOT NULL,
);

CREATE TABLE customers(
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone_number VARCHAR(50) NOT NULL,
);

CREATE TABLE rentals(
    rental_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    movie_id INT REFERENCES movies(movie_id),
    rental_date DATE NOT NULL,
    return_date DATE NOT NULL,
)

-- INserting the data into tables

INSERT INTO movies (title, release_year, genre, director) VALUES
('The Shawshank Redemption', 1994, 'Drama', 'Frank Darabont'),
('The Godfather', 1972, 'Crime', 'Francis Ford Coppola'),
('The Dark Knight', 2008, 'Action', 'Christopher Nolan'),
('The Lord of the Rings: The Return of the King', 2003, 'Adventure', 'Peter Jackson'),
('Pulp Fiction', 1994, 'Crime', 'Quentin Tarantino'),
('The Matrix', 1999, 'Action', 'Lana Wachowski, Lilly Wachowski');

INSERT INTO customers (first_name, last_name, email, phone_number) VALUES
('John', 'Doe', 'jdoe@gmail.com', '123-456-7890'),
('Jane', 'Doe', 'janedoe@hotmail.com', '098-765-4321'),
('Alice', 'Smith', 'asmith@gmail.com', '111-222-3333'),
('Bob', 'Johnson', 'bjohnson@gmail.com', '444-555-6666'),
('Luke', 'Metcalfe', 'ljmet@hotmail.com', '709-770-7610');

INSERT INTO rentals (customer_id, movie_id, rental_date, return_date) VALUES
(1, 1, '2021-01-01', '2021-01-08'),
(2, 2, '2021-01-02', '2021-01-09'),
(3, 3, '2021-01-03', '2021-01-10'),
(4, 4, '2021-01-04', '2021-01-11'),
(5, 5, '2021-01-05', '2021-01-12'),
(1, 5, '2021-02-06', '2021-02-13'),
(2, 4, '2021-03-05', '2021-03-12'),
(3, 1, '2021-04-04', '2021-04-11'),
(4, 2, '2021-05-03', '2021-05-10'),
(5, 3, '2021-06-02', '2021-06-09');

-- Queries
-- Get all movies rented by a certain customer, given their email

SELECT movies.title 
FROM rentals
JOIN rentals ON customers.customer_id = rentals.customer_id
JOIN movies ON rentals.movie_id = movies.movie_id
WHERE customers.email = 'jdoe@gmail.com';

-- When given a movie title, list all the customers that have rented it

SELECT customers.first_name, customers.last_name
FROM rentals
JOIN customers ON rentals.customer_id = customers.customer_id
JOIN movies ON rentals.movie_id = movies.movie_id
WHERE movies.title = 'The Shawshank Redemption';

-- Get rental history for a certain movie

SELECT customers.first_name, customers.last_name, rentals.rental_date, rentals.return_date
FROM rentals
JOIN customers ON rentals.customer_id = customers.customer_id
JOIN movies ON rentals.movie_id = movies.movie_id
WHERE movies.title = 'The Dark Knight';

-- For a specific director, get the name of the customer, the date of the rental and title of the movie, each time a movie by that director was rented

SELECT customers.first_name, customers.last_name, rentals.rental_date, movies.title
FROM rentals
JOIN customers ON rentals.customer_id = customers.customer_id
JOIN movies ON rentals.movie_id = movies.movie_id
WHERE movies.director = 'Christopher Nolan';

-- List all the current rented movies

SELECT movies.title
FROM rentals
JOIN movies ON rentals.movie_id = movies.movie_id
WHERE rentals.return_date > CURRENT_DATE;