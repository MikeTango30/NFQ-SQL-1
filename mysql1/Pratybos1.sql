--
--1. Išrinkite visus įrašus iš Knygų lentelės.
--

SELECT * FROM `Books`;

--
--2. Išrinkite tik Knygų pavadinimus abėcėles tvarka.
--

SELECT `Books`.`title` FROM `Books` ORDER BY `title`; --By default yra ASC

--
--3. Suskaičiuokite, kiek knygų kiekvieno autoriaus yra knygų lentelėje.
--

SELECT COUNT(`Books`.`bookId`) FROM `Books` GROUP BY `authorId`;

