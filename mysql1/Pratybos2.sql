--
--1.Papildykite autorių lentelę 2 įrašais. 
--

INSERT INTO `Authors`(`name`) VALUES("John Scalzi"), ("Umberto Eco");

--
--2.Papildykite knygų lentelę, 3 įrašais apie knygas, kurių autorius įrašėte prieš tai.
--

INSERT INTO `Books`(`authorID`, `title`) 
VALUES(8, "The Interdependency"), (8, "Old Man's War"), (9, "Fuc's Pendulum");

--
--3.Pakeiskite vienos knygos autorių į kitą.
--

UPDATE `Books` SET `authorId`=8 WHERE `authorID`=9;
