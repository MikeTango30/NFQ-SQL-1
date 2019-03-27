--
--Papildyti duomenų bazę kad būtų galima:
--1. Knygos gali turėti vieną ir daugiau autorių.
--

ALTER TABLE `Authors` ENGINE=InnoDB;

CREATE TABLE `AuthorsBooks` (
`bookId` int(11) NOT NULL, 
`authorId` int(11) NOT NULL, 
CONSTRAINT `PK_AuthorsBooks` PRIMARY KEY (`authorId`, `bookId`), 
FOREIGN KEY (`bookId`) REFERENCES `Books`(`bookId`) ON DELETE CASCADE ON UPDATE CASCADE , 
FOREIGN KEY (`authorId`) REFERENCES `Authors`(`authorId`) ON DELETE CASCADE ON UPDATE CASCADE) 
ENGINE=InnoDb DEFAULT CHARSET=utf8;

--
--2. Sutvarkyti duomenų bazės duomenis, jei reikia papildykite naujais.
--
INSERT INTO `Authors`(`name`) 
VALUES("Tim Berglund"), ("Matthew McCullough"),  ("Jon Loeliger"), ("Mark Lutz"), ("John Scalzi"), ("Umberto Eco");

UPDATE `Books` SET `authorId`=14 WHERE `bookId` IN(9, 10);
UPDATE `Books` SET `authorId`=15 WHERE `bookId`=11;
UPDATE `Books` SET `authorId`=12 WHERE `bookId`=7;
UPDATE `Books` SET `authorId`=13 WHERE `bookId`=8;
UPDATE `Books` SET `authorId`=11 WHERE `bookId`=6;

UPDATE `Books` SET `year`=2012 WHERE `bookId`=6;
UPDATE `Books` SET `year`=2017 WHERE `bookId`=9;
UPDATE `Books` SET `year`=2005 WHERE `bookId`=10;
UPDATE `Books` SET `year`=1988 WHERE `bookId`=11;

INSERT INTO `AuthorsBooks` (`bookId`, `authorId`) 
SELECT `Books`.`bookId` as `bookId`, `Authors`.`authorId` as `authorId` 
FROM `Authors` INNER JOIN `Books` 
WHERE `Authors`.`authorId`=`Books`.`authorId`;

INSERT INTO `AuthorsBooks` (`bookId`, `authorId`) VALUES(6, 10);
INSERT INTO `AuthorsBooks` (`bookId`, `authorId`) VALUES(7, 11);

--
--3. Išrinkite visas knygas su jų autoriais. (autorius, jei jų daugiau nei vienas atskirkite kableliais).
--

SELECT `Books`.`title` as `Title`, GROUP_CONCAT(DISTINCT `Authors`.`name` SEPARATOR ", ") AS `Authors` 
FROM `Books` 
JOIN `AuthorsBooks` ON `Books`.`bookId`=`AuthorsBooks`.`bookId` 
JOIN `Authors` ON `AuthorsBooks`.`authorId`=`Authors`.`authorId` 
GROUP BY `Books`.`title`;

--
--4. Sutvarkykite  knygų lentelę, kad galėtumėte išsaugoti originalų knygos pavadinimą. 
--(Pavadinime išsaugokite, lietuviškas raides kaip ą,ė,š ir pan.)
--

ALTER TABLE `Authors` 
MODIFY `name` varchar(255) 
CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL, 
DEFAULT CHARSET=utf8;

ALTER TABLE `Books` 
MODIFY `title` varchar(255) 
CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL, 
DEFAULT CHARSET=utf8;

--
--Čia reiktų panaudoti TRANSACTION ar PROCEDURE vietoje atskirų Insert'ų
--

INSERT INTO `Authors`(`name`) VALUES ("Žemaitė");
INSERT INTO `Books`(`authorId`, `title`, `year`) VALUES(16, "Raštai, 4 tomas", 2004);
INSERT INTO `AuthorsBooks`(`bookId`, `authorId`) VALUES (12, 16);

