USE sakila;
 #1a
SELECT first_name, last_name FROM actor;
#1b
SELECT concat(upper(first_name), ' ', upper(last_name)) FROM actor as  actorName;
#2a
SELECT actor_id FROM actor WHERE first_name ='JOE';
#2b
SELECT first_name, last_name FROM actor WHERE last_name like '%GEN%';
#2c
SELECT first_name, last_name FROM actor WHERE last_name like '%LI%'
	 ORDER BY last_name, first_name;
#2d
SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh',  'China');
#3a
ALTER TABLE actor
	ADD COLUMN description blob;
#3b
ALTER TABLE actor
	DROP column description;
#4a
SELECT last_name , count(*) FROM actor
	GROUP BY last_name;
#4b
SELECT last_name , count(*) FROM actor
	GROUP BY last_name
    HAVING count(*)>1;
#4c
SELECT * FROM actor WHERE upper(first_name)='GROUCHO' AND upper(last_name)='WILLIAMS';
UPDATE actor 
	SET first_name = 'HARPO'
    WHERE first_name='GROUCHO' AND last_name='WILLIAMS';
#4d
UPDATE actor 
	SET first_name = 'GROUCHO'
    WHERE first_name='HARPO' AND last_name='WILLIAMS';

#5a
begin;
CREATE TABLE IF NOT EXISTS address (
    address_id SMALLINT(5) NOT NULL AUTO_INCREMENT,
    address VARCHAR(50) NOT NULL,
    address2 VARCHAR(50) DEFAULT NULL,
    district VARCHAR(20) NOT NULL,
    city_id SMALLINT(5) UNSIGNED NOT NULL,
    postal_code VARCHAR(10) DEFAULT NULL,
    phone VARCHAR(20) NOT NULL,
    location GEOMETRY NOT NULL,
    last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (address_id)
) SELECT * FROM
    address rollback;


# 6a
SELECT first_name, last_name, address FROM staff s
JOIN address a ON s.address_id=a.address_id;

#6b
SELECT first_name, last_name, SUM(amount) as totalAmount  FROM staff s
JOIN payment p ON s.staff_id=p.staff_id
GROUP BY first_name, Last_name
;
#6c
SELECT 
    f.title, COUNT( distinct actor_id) AS actorCount
	FROM  film f
	JOIN  film_actor a ON f.film_id = a.film_id
	GROUP BY f.title;

#6d
SELECT count(*) FROM film
WHERE title ='Hunchback Impossible';

 #6e
 SELECT 
    first_name, last_name, SUM(amount)
FROM
    customer c
        JOIN
    payment p ON c.customer_id = p.payment_id;
 
 #7a
SELECT   title,original_language_id
FROM     film
WHERE    (title LIKE 'K%' OR title LIKE 'Q%')
AND original_language_id IN 
						(SELECT  original_language_id  
                        FROM  language 
                        WHERE name = 'English');
;
#7b
SELECT * FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE film_id in ( SELECT film_id FROM film WHERE title ='Alone Trip'); 

#7c
SELECT co.first_name, co.last_name, co.email FROM customer co
JOIN address a ON co.address_id=a.address_id
JOIN city c ON a.city_id=c.city_id
JOIN country p ON c.country_id=p.country_id
WHERE p.country='Canada';

#7d
SELECT title, description,rating FROM film
WHERE rating in ('G', 'PG');

#7e
SELECT * FROM film f 
JOIN inventory i ON f.film_id=i.film_id
JOIN rental r ON i.inventory_id=r.inventory_id
 ORDER BY rental_date desc;

#7f
SELECT s.store_id, SUM(amount) FROM store s
JOIN customer c ON s.store_id=c.store_id
JOIN payment p ON c.customer_id=p.customer_id
GROUP BY s.store_id;

#7g
SELECT store_id, city,country FROM store s
JOIN address a ON s.address_id=a.address_id
JOIN city c ON a.city_id=c.city_id
JOIN country p ON c.country_id=p.country_id
;
#7h
SELECT c.name as geners, SUM(p.amount) as revenue  FROM film f
JOIN film_category fc ON f.film_id=fc.film_id
JOIN category c ON fc.category_id=c.category_id
JOIN  inventory i ON f.film_id=i.film_id
JOIN  rental r ON i.inventory_id=r.inventory_id
JOIN  payment p ON r.rental_id=p.rental_id
GROUP BY c.name
 ORDER BY SUM(p.amount)
limit 5
;

#8a
create view Top5Genera as 
SELECT c.name as geners, SUM(p.amount) as revenue  FROM film f
JOIN film_category fc ON f.film_id=fc.film_id
JOIN category c ON fc.category_id=c.category_id
JOIN  inventory i ON f.film_id=i.film_id
JOIN  rental r ON i.inventory_id=r.inventory_id
JOIN  payment p ON r.rental_id=p.rental_id
GROUP BY c.name
ORDER BY SUM(p.amount)
limit 5
;

#8b
SELECT * FROM Top5Genera
;
#8c
drop view Top5Genera;

 