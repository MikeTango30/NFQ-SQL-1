--
--1. Suskaičiuokite kiek knygų kiekvieno autoriaus yra duomenų bazėje 
--(įtraukdami autorius, kurie neturi knygų, bei neįtraukdami šių autorių).
--

--Su autoriais, kuries neturi knygų
	
SELECT `Authors`.`name`, 
COUNT(`Books`.`bookId`) AS `bookCount` 
FROM `Authors` LEFT JOIN `Books` 
ON `Authors`.`authorId` = `Books`.`authorId` 
GROUP BY `Authors`.`name`;

--Be autorių, kurie neturi knygų

SELECT `Authors`.`name`, 
COUNT(`Books`.`bookId`) AS `bookCount` 
FROM `Authors` INNER JOIN `Books` 
ON `Authors`.`authorId` = `Books`.`authorId` 
GROUP BY `Authors`.`name`;

--
--2. Pašalinkite autorius, kurie neturi knygų.
--

DELETE `Authors` FROM `Authors` 
WHERE `Authors`.`name` IN 
(SELECT `Authors`.`name` FROM (SELECT * FROM `Authors`) as `Authors` 
LEFT JOIN `Books` ON `Authors`.`authorId` = `Books`.`authorId` 
GROUP BY `Authors`.`name` 
HAVING COUNT(`Books`.`authorId`) = 0);

--
--parašius:
--mysql>...SELECT `Authors`.`name` FROM `Authors`... meta klaidą: 
--
--Table 'Authors' is specified twice, 
--both as a target for 'DELETE' 
--and as a separate source for data.
--
--iš StackOverflow(https://stackoverflow.com/questions/44970574/table-is-specified-twice-both-as-a-target-for-update-and-as-a-separate-source/44971214):
--
--"This is a typical MySQL thing and can usually be circumvented by 		
--selecting from the table derived,...'  
--
--Taigi,
--mysql>...SELECT `Authors`.`name` FROM (SELECT * FROM `Authors`) as `Authors`...
--išsprendė šitą klausimą.
--

	
	
