--
--1. Straipsniai saugomi lentelėje News (newsId, text, date), 
--straipsnio komentarai saugomi lentelėje 
--Comments (commentId, text, date, newsId).
--

--
-- Database: `Bonus`
--


--
-- Table structure for table `News`
--

CREATE TABLE IF NOT EXISTS `News` (
  `newsId` int(11) NOT NULL AUTO_INCREMENT,
  `text` text CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`newsId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


--
-- Dumping data for table `News`
--

INSERT INTO `News` (`newsId`, `text`, `date`) VALUES
(1, "1. Good News, Everyone!", "2019-01-01 10"),
(2, "2. Good News, Everyone!", "2019-01-02 11"),
(3, "3. Good News, Everyone!", "2019-01-03 12"),
(4, "4. Good News, Everyone!", "2019-01-04 13"),
(5, "5. Good News, Everyone!", "2019-01-05 14"),
(6, "6. Good News, Everyone!", "2019-01-06 15"),
(7, "7. Good News, Everyone!", "2019-01-07 16"),
(8, "8. Good News, Everyone!", "2019-01-08 17"),
(9, "9. Good News, Everyone!", "2019-01-09 18"),
(10, "10. Good News, Everyone!", "2019-03-01 19"),
(11, "11. Good News, Everyone!", "2019-03-02 11"),
(12, "12. Good News, Everyone!", "2019-03-03 12"),
(13, "13. Good News, Everyone!", "2019-03-04 13"),
(14, "14. Good News, Everyone!", "2019-03-05 14"),
(15, "15. Good News, Everyone!", "2019-03-06 15");

--
--Table structure for table `Comments`
--

CREATE TABLE IF NOT EXISTS `Comments` (
  `commentId` int(11) NOT NULL AUTO_INCREMENT,
  `text` text CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL,
  `date` datetime NOT NULL,
  `newsId` int(11) NOT NULL,
  PRIMARY KEY (`commentId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Comments`
--

INSERT INTO `Comments` (`commentId`, `text`, `date`, `newsId`) VALUES
(1, "1. Nonsense!", "2019-01-01 11", 1),
(2, "1. Make's Sense!", "2019-01-01 12", 1 ),
(3, "2. Nonsense!", "2019-01-02 12", 2),
(4, "2. Make's Sense!", "2019-01-02 13", 2 ),
(5, "3. Nonsense!", "2019-01-03 13", 3),
(6, "3. Make's Sense!", "2019-01-03 14", 3 ),
(7, "4. Nonsense!", "2019-01-04 14", 4),
(8, "4. Make's Sense!", "2019-01-04 15", 4 ),
(9, "5. Nonsense!", "2019-01-05 15", 5),
(10, "5. Make's Sense!", "2019-01-05 16", 5 ),
(11, "6. Nonsense!", "2019-01-06 16", 6),
(12, "6. Make's Sense!", "2019-01-06 17", 6 ),
(13, "7. Nonsense!", "2019-01-07 17", 7),
(14, "7. Make's Sense!", "2019-01-07 18", 7 ),
(15, "8. Nonsense!", "2019-01-08 18", 8),
(16, "8. Make's Sense!", "2019-01-08 19", 8 ),
(17, "9. Nonsense!", "2019-01-09 19", 9),
(18, "9. Make's Sense!", "2019-01-09 20", 9 ),
(19, "10. Nonsense!", "2019-03-01 20", 10),
(20, "10. Make's Sense!", "2019-03-01 21", 10 ),
(21, "11. Nonsense!", "2019-03-02 12", 11),
(22, "11. Make's Sense!", "2019-03-02 13", 11),
(23, "12. Nonsense!", "2019-03-03 13", 12),
(24, "12. Make's Sense!", "2019-03-03 14", 12 ),
(25, "13. Nonsense!", "19-03-04 14", 13),
(26, "13. Make's Sense!", "2019-03-04 15", 13 ),
(27, "14. Nonsense!", "2019-03-05 14", 14),
(28, "14. Make's Sense!", "2019-03-05 15", 14 ),
(29, "15. Nonsense!", "2019-03-06 15", 15),
(30, "15. Make's Sense!", "2019-03-06 16", 15);

--
--Alter Comments table to add Foreign Key
--

ALTER TABLE `Comments`
ADD FOREIGN KEY (`newsId`) REFERENCES `News`(`newsId`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

--
--Išrinkite 10 naujausių straipsnių su paskutiniu parašytu komentaru 
--(newsId, newsDate, newsText, commentDate, commentText).
--

SELECT `newsId`, `newsDate`, `newsText`, `commentDate`, `commentText` 
FROM (
    SELECT `News`.`newsId`, `News`.`date` AS `newsDate`, `News`.`text` AS `newsText`, 
	   `Comments`.`text` AS `commentText`, `Comments`.`date` AS `commentDate`, 
            @currentRank := CASE WHEN `News`.`newsId` = @currentNewsId THEN @currentRank + 1 ELSE 1 END AS `rank`,
            @currentNewsId := `News`.`newsId`
    FROM `News`
    INNER JOIN `Comments` ON `News`.`newsId` = `Comments`.`newsId`, (
	SELECT @currentNewsId := 0, @currentRank := 0) AS `Comments`
    	ORDER BY `News`.`date` DESC, `Comments`.`date` DESC
) AS `News` 
WHERE `rank` = 2
ORDER BY `newsDate` DESC
LIMIT 10;
