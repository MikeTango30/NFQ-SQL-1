--
--Alter default schema charset and collation
--

ALTER DATABASE `Books` DEFAULT CHARACTER SET = utf8 DEFAULT COLLATE = utf8_lithuanian_ci;

--
--Alter existing tables to use same engine, charset and collation 
--

ALTER TABLE `Authors` 
MODIFY `name` varchar(255) 
CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL, 
ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `Books` 
MODIFY `title` varchar(255) 
CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL, 
DEFAULT CHARSET=utf8;

--
--Create Junction table for book and authors Ids
--

CREATE TABLE IF NOT EXISTS `AuthorsBooks` (
`bookId` int(11) NOT NULL, 
`authorId` int(11) NOT NULL, 
CONSTRAINT `PK_AuthorsBooks` PRIMARY KEY (`authorId`, `bookId`), 
FOREIGN KEY (`bookId`) REFERENCES `Books`(`bookId`) ON DELETE CASCADE ON UPDATE CASCADE , 
FOREIGN KEY (`authorId`) REFERENCES `Authors`(`authorId`) ON DELETE CASCADE ON UPDATE CASCADE) 
ENGINE=InnoDB DEFAULT CHARSET=utf8;
