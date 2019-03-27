--
--1. Išrinkite visus įrašus, tiek iš knygų tiek iš autorių lentelių, 
--išrinkdami pasirinktinai du stulpelius.
--

SELECT `Authors`.`authorId` as `authorIdsAndBookTitles` FROM `Authors` 
UNION 
SELECT `Books`.`title` FROM `Books`;
