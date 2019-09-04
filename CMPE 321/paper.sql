-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 16 May 2019, 06:01:18
-- Sunucu sürümü: 10.1.39-MariaDB
-- PHP Sürümü: 7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `paper`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `admins`
--

CREATE TABLE `admins` (
  `a_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `author`
--

CREATE TABLE `author` (
  `id` int(20) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `author`
--

INSERT INTO `author` (`id`, `first_name`, `last_name`) VALUES
(16, 'mete', 'kurtt'),
(17, 'meric', 'deser'),
(18, 'bekir', 'burak');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `paper`
--

CREATE TABLE `paper` (
  `id` int(20) NOT NULL,
  `author_id` int(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `result` int(255) NOT NULL,
  `topic` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `paper`
--

INSERT INTO `paper` (`id`, `author_id`, `title`, `description`, `result`, `topic`) VALUES
(41, 16, 'Good Games', 'Opening', 6, 'Chess'),
(42, 16, 'Bad Games', 'Endgame', 10, 'Chess'),
(43, 17, 'Computers', 'high performance', 74, 'pc'),
(44, 18, 'Machines', 'expensive ', 90, 'Cars'),
(45, 18, 'Mercedes', 'Fast', 98, 'Cars');

--
-- Tetikleyiciler `paper`
--
DELIMITER $$
CREATE TRIGGER `event_delete` AFTER DELETE ON `paper` FOR EACH ROW BEGIN
    DECLARE  record_num int(20);
    DECLARE old_value int(20);
    DECLARE state int(20);

    select count(*) into record_num from paper where topic = OLD.topic;

    IF record_num > 0 Then
    	UPDATE topic set sota = (select max(result) as result from paper where topic = OLD.topic) where name = OLD.topic;
    ELSE
    	DELETE FROM topic where name = OLD.topic;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `event_insert` AFTER INSERT ON `paper` FOR EACH ROW BEGIN
    DECLARE  record_num int(20);
    DECLARE val int(20);

    set val = NEW.result;
    select count(*) into record_num from topic where name = NEW.topic;

    IF record_num > 0 Then
    	update topic set sota = (select max(result) as result from paper where topic = NEW.topic) where name = NEW.topic;
    ELSE
        insert into topic (name, sota) values(NEW.topic, val);
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `event_update` AFTER UPDATE ON `paper` FOR EACH ROW BEGIN
    DECLARE  record_num int(20);
    DECLARE val int(20);
    DECLARE old_value int(20);

    set val = NEW.result;
    select count(*) into record_num from topic where name = NEW.topic;

    IF record_num > 0 Then
    	update topic set sota = (select max(result) as result from paper where topic = NEW.topic) where name = NEW.topic;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `topic`
--

CREATE TABLE `topic` (
  `id` int(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `author_id` int(20) NOT NULL,
  `sota` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Tablo döküm verisi `topic`
--

INSERT INTO `topic` (`id`, `name`, `author_id`, `sota`) VALUES
(26, 'Chess', 0, 10),
(27, 'pc', 0, 74),
(28, 'Cars', 0, 98);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `u_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`a_id`);

--
-- Tablo için indeksler `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `paper`
--
ALTER TABLE `paper`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `topic`
--
ALTER TABLE `topic`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`u_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `admins`
--
ALTER TABLE `admins`
  MODIFY `a_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `author`
--
ALTER TABLE `author`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- Tablo için AUTO_INCREMENT değeri `paper`
--
ALTER TABLE `paper`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- Tablo için AUTO_INCREMENT değeri `topic`
--
ALTER TABLE `topic`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `u_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
