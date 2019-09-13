-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dejabrewdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `dejabrewdb` ;

-- -----------------------------------------------------
-- Schema dejabrewdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dejabrewdb` DEFAULT CHARACTER SET utf8 ;
USE `dejabrewdb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `enabled` TINYINT NULL DEFAULT 1,
  `role` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(100) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `brewery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brewery` ;

CREATE TABLE IF NOT EXISTS `brewery` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address_id` INT NOT NULL,
  `createdby_user` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `active` TINYINT NOT NULL DEFAULT 1,
  `description` VARCHAR(5000) NULL,
  `url` VARCHAR(500) NULL,
  `menu` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_brewery_address_idx` (`address_id` ASC),
  INDEX `fk_brewery_user1_idx` (`createdby_user` ASC),
  CONSTRAINT `fk_brewery_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_brewery_user1`
    FOREIGN KEY (`createdby_user`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `review` ;

CREATE TABLE IF NOT EXISTS `review` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `brewery_id` INT NOT NULL,
  `rating` INT NULL,
  `details` VARCHAR(750) NULL,
  `date_reviewed` DATE NULL,
  INDEX `fk_review_user1_idx` (`user_id` ASC),
  INDEX `fk_review_brewery1_idx` (`brewery_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_review_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_brewery1`
    FOREIGN KEY (`brewery_id`)
    REFERENCES `brewery` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beer` ;

CREATE TABLE IF NOT EXISTS `beer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `brewery_id` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_beer_brewery_idx` (`brewery_id` ASC),
  CONSTRAINT `fk_beer_brewery`
    FOREIGN KEY (`brewery_id`)
    REFERENCES `brewery` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beer_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beer_type` ;

CREATE TABLE IF NOT EXISTS `beer_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `beer_has_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `beer_has_type` ;

CREATE TABLE IF NOT EXISTS `beer_has_type` (
  `beer_id` INT NOT NULL,
  `beer_type_id` INT NOT NULL,
  PRIMARY KEY (`beer_id`, `beer_type_id`),
  INDEX `fk_beer_has_beer_type_beer_type1_idx` (`beer_type_id` ASC),
  INDEX `fk_beer_has_beer_type_beer1_idx` (`beer_id` ASC),
  CONSTRAINT `fk_beer_has_beer_type_beer1`
    FOREIGN KEY (`beer_id`)
    REFERENCES `beer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_beer_has_beer_type_beer_type1`
    FOREIGN KEY (`beer_type_id`)
    REFERENCES `beer_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS dejabrew@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'dejabrew'@'localhost' IDENTIFIED BY 'dejabrew';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'dejabrew'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `dejabrewdb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`) VALUES (1, 'fred', 'password', true, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `dejabrewdb`;
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (1, '136 East Second Street', 'Salida', 'Colorado', 81201);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (2, '5763 Arapahoe Avenue', 'Boulder', 'Colorado', 80303);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (3, '720 Main Street', 'Frisco', 'Colorado', 80443);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (5, '2880 Wilderness Place', 'Boulder', 'Colorado', 80301);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (6, '471 Kalamath Street', 'Denver', 'Colorado', 80204);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (7, '1647 South Tejon Street', 'Colorado Springs', 'Colorado', 80906);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (8, '4700 Cherry Creek Drive South', 'Denver', 'Colorado', 80246);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (9, '1022 Main Ave.', 'Durango', 'Colorado', 81301);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (10, '7803 Ralston Road', 'Arvada', 'Colorado', 80002);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (11, '311 Tenth Street', 'Golden', 'Colorado', 80401);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (12, '625 3rd St. #D', 'Greeley', 'Colorado', 80631);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (13, '226 Elk Avenue', 'Crested Butte', 'Colorado', 81224);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (14, '1735 19th Street #100', 'Denver', 'Colorado', 80202);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (15, '100 Little Dam Road', 'Dillon', 'Colorado', 80435);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (17, '1 Dostal Alley', 'Central City', 'Colorado', 80427);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (18, '470 Prospect Village Dr.', 'Estes Park', 'Colorado', 80517);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (19, '2401 Blake St.', 'Denver', 'Colorado', 80205);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (20, '1900-B East Lincoln Avenue', 'Fort Collins', 'Colorado', 80524);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (21, '402 Seventh Street', 'Glenwood Springs', 'Colorado', 81601);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (22, '920 Twelfth Street', 'Golden', 'Colorado', 80401);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (23, '105 Edwards Village Boulevard', 'Edwards', 'Colorado', 81632);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (24, '915 Grand Avenue', 'Grand Lake', 'Colorado', 80447);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (25, '2201 Arapahoe Street', 'Denver', 'Colorado', 80205);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (29, '149 Steele Street', 'Denver', 'Colorado', 80206);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (32, '1265 Boston Avenue', 'Longmont', 'Colorado', 80501);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (33, '5798 South Rapp Street', 'Littleton', 'Colorado', 80120);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (34, '1535 Pearl Street', 'Boulder', 'Colorado', 80302);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (36, '500 Linden Street', 'Fort Collins', 'Colorado', 80524);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (39, '800 East Lincoln Avenue', 'Fort Collins', 'Colorado', 80524);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (40, '303 Main Street', 'Lyons', 'Colorado', 80540);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (41, '211 West 13th Avenue', 'Denver', 'Colorado', 80204);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (42, '104 Village Place', 'Dillon', 'Colorado', 80435);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (43, '540 Main Street', 'Longmont', 'Colorado', 80501);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (44, '2027 13th Street', 'Boulder', 'Colorado', 80302);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (45, '1001 16th Street #A-100', 'Denver', 'Colorado', 80202);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (46, '9627 East County Line Road', 'Englewood', 'Colorado', 80112);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (47, '880 West Castleton Road', 'Castle Rock', 'Colorado', 80109);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (48, '2145 Blake Street', 'Denver', 'Colorado', 80205);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (49, '545 Turner Drive', 'Durango', 'Colorado', 81301);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (50, '801 East Second Avenue', 'Durango', 'Colorado', 81301);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (53, '1401 Miner Street', 'Idaho Springs', 'Colorado', 80452);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (54, '1446 Garden of the Gods', 'Colorado Springs', 'Colorado', 80907);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (55, '3201 Walnut Street Ste A', 'Boulder', 'Colorado', 80301);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (57, '35 E. First St.', 'Nederland', 'Colorado', null);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (58, '1634 18th Street', 'Denver', 'Colorado', 80202);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (59, '555 North Mill Street', 'Aspen', 'Colorado', 81611);
INSERT INTO `address` (`id`, `street`, `city`, `state`, `zip`) VALUES (60, '1123 Walnut Street', 'Boulder', 'Colorado', 80302);

COMMIT;


-- -----------------------------------------------------
-- Data for table `brewery`
-- -----------------------------------------------------
START TRANSACTION;
USE `dejabrewdb`;
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (1, 1, 1, 'Amicas Pizza, Microbrews and More', 1, '', '', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (2, 2, 1, 'Avery Brewing Company', 1, 'Established in 1993, Avery Brewing Co. is a family owned and operated micro-brewery dedicated to brewing the finest quality English and Belgian style ales.. From humble beginnings, brewing 800 barrels of three different beers in 1994, we have progressed to brewing 13,000 barrels of twenty different beers in 2007. We attribute this success to beer drinkers gravitating to beers with more interesting flavor profiles. The unique flavor complexity of Avery beers occurs through a combination of sparing no expense with regard to ingredients and our hopping methods. Sparing no expense means using lots of specialty malts, imported hops, such as Styrian Goldings, and imported Belgian candy sugar.', 'http://www.averybrewing.com/', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (3, 3, 1, 'Backcountry Brewery', 1, '', '', 0);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (5, 5, 1, 'Boulder Beer Company', 1, '', 'http://boulderbeer.com/', 0);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (6, 6, 1, 'Breckenridge Brewery', 1, '', 'http://www.breckbrew.com/', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (7, 7, 1, 'Bristol Brewing', 1, '', '', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (8, 8, 1, 'Bull & Bush Pub & Brewery', 1, '', '', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (9, 9, 1, 'Carver Brewing Co.', 1, 'Carver Brothers Bakery first opened on June 1, 1983, in Winter Park, Colorado. It started with Jim, Bill, Sara and Eleanor Carver. In 1986 Jim, Bill and Barb Wynne opened Carvers Bakery / CafÃ© in Durango and the Winter Park Bakery was sold.   In 1988 Carvers opened the brewery  making it the first brewery in the four corners region since prohibition. Although still known affectionately by the locals as Carvers, Carvers then became Carver Brewing Company.  Since then Carvers has seen many exciting changes: opening it\'s outdoor Beer Garden in 1994 and undergoing dramatic remodels in the restaurant and on the patio in \'98 and \'02. In April of \'07 it was deemed necessary to expand the brewery.  The brewery is now housed in the area previously occupied by the bakery.  After 20 years of serving Colorado\'s mountain folk, Carvers continues to provide the very best in food and beer.', 'http://www.carverbrewing.com/_/home.htm', 0);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (10, 10, 1, 'Cheshire Cat Brewery', 1, '', '', 0);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (11, 11, 1, 'Coors Brewing - Golden Brewery', 1, 'In 1873, as the United States approached its centennial year, its people were busy building a new kind of nation. It was thirsty work. And that\'s where Coors Brewing Company came in. When we began in that same year, we were a small, family-owned brewery, located at the foot of the Rocky Mountains. We were busy creating the same kind of crisp, refreshing beer we\'re known for today. While hundreds of such family-owned breweries have come and gone in the years since, we believe the reasons for our success are simple. We\'ve never compromised on quality in producing our award-winning brews and we\'ve never lost sight of our rich Rocky Mountain heritage. Just as important, we\'ve always believed in doing well by doing good. We treat our employees with respect, we support the local communities where we do business, and we strive to protect the environment. That\'s just how we do business.', 'http://www.coors.com', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (12, 12, 1, 'Crabtree Brewery', 1, 'The Crabtree Brewing Company is dedicated to serving the environment, the community, our customers, and our valued employees.  Requiring the best ingredients to support unique premium beers.  Keeping a dynamic business mind while remaining modestly profitable.   Employing technology, embracing ethics, growing to meet the needs of our customers and employees, and having fun doing what we loveï¿½.Making Great Beer.', 'http://www.crabtreebrewing.com', 0);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (13, 13, 1, 'Crested Butte Brewery &  Pub', 1, '', '', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (14, 14, 1, 'Denver ChopHouse and Brewery', 1, '', '', 0);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (15, 15, 1, 'Dillon Dam Brewery', 1, '', '', 0);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (17, 17, 1, 'Dostal Alley', 1, '', '', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (18, 18, 1, 'Estes Park Brewery', 1, 'The original Brewing equipment which consisted of a 4 1/4  Barrel Brewhouse was moved to Estes. For the first summer the Event Center kept the main floor as a stage and dance floor. For the first summer we offered four beers:  Estes Park Porter, Estes Park Renegade, Longs Peak Raspberry Wheat and Estes Park Pale Ale.  In the fall of 1994, Gordon Knight decided to sell his half of the business. When Gordon left, Eric Bratrud took over as the head Brewer. The Brewery also expanded to a 14 BBL Brewhouse and moved out onto the main floor where is now located. In 1995 we started packaging our beers in 12 oz bottles, which expanded our market. By this time we had added a number of beers including Trail Ridge Red, Estes Park Gold, Stinger Wild Honey Wheat and Samson Stout. 1995 was also the first year of the Best of the West Brewfest held in the Brewery parking lot. Since \'95 we\'ve continued to evolve both in our restaurant and with our brewing operations. In 2003 Tyler Lemirande and Eric Bratrud took over as owners.', 'http://www.epbrewery.net/', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (19, 19, 1, 'Flying Dog Brewery', 1, '', 'http://www.flyingdogales.com/', 0);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (20, 20, 1, 'Fort Collins Brewery', 1, '', 'http://www.fortcollinsbrewery.com', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (21, 21, 1, 'Glenwood Canyon Brewing Company', 1, '', '', 0);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (22, 22, 1, 'Golden City Brewery', 1, '', '', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (23, 23, 1, 'Gore Range Brewery', 1, '', '', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (24, 24, 1, 'Grand Lake Brewing', 1, '', '', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (25, 25, 1, 'Great Divide Brewing', 1, 'Since 1994, Great Divide has brewed the most balanced yet assertive and flavorful beers possible.  This commitment has not gone unrewarded  Great Divide has racked up 12 Great American Beer Festival Medals and four World Beer Cup awards, and was recently honored as the 23rd Best Brewer in the World in Ratebeer.com\'s World\'s Top 100 Brewers, (2007). See for yourself what the excitement is about  and then introduce your friends to the new frontier of beer. --http://www.greatdivide.com', 'http://www.greatdivide.com/', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (29, 29, 1, 'Hops Grillhouse & Brewery - Cherry Creek', 1, '', '', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (32, 32, 1, 'Left Hand Brewing Company', 1, '', 'http://www.lefthandbrewing.com/', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (33, 33, 1, 'Mill Steakhouse', 1, '', '', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (34, 34, 1, 'Mountain Sun Pub & Brewery', 1, '', '', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (36, 36, 1, 'New Belgium Brewing', 1, 'We\'ll set the scene: 1989. Belgium. Boy on bike. (OK, make that a young man of 32). As our aspiring young homebrewer rides his mountain bike with fat tires through European villages famous for beer, New Belgium Brewing Company was but a glimmer in his eye. Or basement. For Jeff Lebesch would return to Fort Collins with a handful of ingredients and an imagination full of recipes. And then there was beer. Jeff\'s first two basement-brewed creations? A brown dubbel with earthy undertones named Abbey and a remarkably well-balanced amber he named Fat Tire. To say the rest was history would be to overlook his wife\'s involvement. Kim Jordan was New Belgium\'s first bottler, sales rep, distributor, marketer and financial planner. And now, she\'s our CEO.', 'http://www.newbelgium.com/', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (39, 39, 1, 'Odell Brewing', 1, '', '', 0);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (40, 40, 1, 'Oskar Blues Grill and Brew', 1, '', 'http://www.oskarblues.com/', 0);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (41, 41, 1, 'Pint\'s Pub Brewery and Freehouse', 1, '', '', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (42, 42, 1, 'Pug Ryan\'s Steakhouse and Brewery', 1, '', '', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (43, 43, 1, 'Pumphouse Brewery & Restaurant', 1, '', '', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (44, 44, 1, 'RedFish New Orleans Brewhouse', 1, '', '', 0);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (45, 45, 1, 'Rock Bottom Restaurant & Brewery - Denver', 1, '', '', 0);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (46, 46, 1, 'Rock Bottom Restaurant & Brewery - South Denver', 1, '', '', 0);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (47, 47, 1, 'Rockyard Brewing', 1, '', '', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (48, 48, 1, 'SandLot Brewery at Coors Field', 1, '', '', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (49, 49, 1, 'Ska Brewing Company', 1, '', 'http://www.skabrewing.com/', 0);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (50, 50, 1, 'Steamworks Brewing - Durango', 1, '', '', 0);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (53, 53, 1, 'Tommyknocker Brewery and Pub', 1, '', 'http://www.tommyknocker.com/', 0);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (54, 54, 1, 'Trinity Brewing Company', 1, '', 'http://trinitybrew.com/', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (55, 55, 1, 'Twisted Pine Brewing Company', 1, 'Established in 1995, Twisted Pine Brewing Company produces only 100% natural, unpasteurized pure malt ales, batch brewed and hand-crafted. Because we believe that craft beer is best enjoyed fresh, Twisted Pine ales can only be found throughout Colorado. By maintaining only a local presence we feel proud that our beers capture the full flavor and variety of style found at our brewery. It is our intention to bring to you a select family of individually distinctive ales that we as brewers would enjoy drinking ourselves. That is our final measure. We ignore costs, fads, and difficulty in creating our ales. And, while we are very serious about the art and business of beer making, we try to avoid taking ourselves too seriously. After all, we realize brewing a fine beer isn\'t exactly nuclear physics. It\'s something far more important. -Twistedpine.com', 'http://www.twistedpinebrewing.com/', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (57, 57, 1, 'Wolf Tongue Brewery', 1, 'Closed.', '', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (58, 58, 1, 'Wynkoop Brewing', 1, '', 'http://www.wynkoop.com/', 0);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (59, 59, 1, 'Aspen Brewing Company', 1, '', 'http://aspenbrewingcompany.com', 1);
INSERT INTO `brewery` (`id`, `address_id`, `createdby_user`, `name`, `active`, `description`, `url`, `menu`) VALUES (60, 60, 1, 'Walnut Brewery', 1, '', 'http://www.walnutbrewery.com/', 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `review`
-- -----------------------------------------------------
START TRANSACTION;
USE `dejabrewdb`;
INSERT INTO `review` (`id`, `user_id`, `brewery_id`, `rating`, `details`, `date_reviewed`) VALUES (1, 1, 1, 4, 'great beer, avg service', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `beer`
-- -----------------------------------------------------
START TRANSACTION;
USE `dejabrewdb`;
INSERT INTO `beer` (`id`, `brewery_id`, `name`) VALUES (1, 1, 'HeadwatersI.P.A');
INSERT INTO `beer` (`id`, `brewery_id`, `name`) VALUES (2, 1, 'Rex\'s Amber');
INSERT INTO `beer` (`id`, `brewery_id`, `name`) VALUES (3, 1, 'Bomber Blond');
INSERT INTO `beer` (`id`, `brewery_id`, `name`) VALUES (4, 1, 'Big S Brown Ale');
INSERT INTO `beer` (`id`, `brewery_id`, `name`) VALUES (5, 1, 'Green Chile Ale');

COMMIT;


-- -----------------------------------------------------
-- Data for table `beer_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `dejabrewdb`;
INSERT INTO `beer_type` (`id`, `name`, `description`) VALUES (1, 'I.P.A', NULL);
INSERT INTO `beer_type` (`id`, `name`, `description`) VALUES (2, 'A.P.A.', NULL);
INSERT INTO `beer_type` (`id`, `name`, `description`) VALUES (3, 'Ale', NULL);
INSERT INTO `beer_type` (`id`, `name`, `description`) VALUES (4, 'Lager', NULL);
INSERT INTO `beer_type` (`id`, `name`, `description`) VALUES (5, 'Porter', NULL);
INSERT INTO `beer_type` (`id`, `name`, `description`) VALUES (6, 'Stout', NULL);
INSERT INTO `beer_type` (`id`, `name`, `description`) VALUES (7, 'Pilsner', NULL);
INSERT INTO `beer_type` (`id`, `name`, `description`) VALUES (8, 'Bock', NULL);
INSERT INTO `beer_type` (`id`, `name`, `description`) VALUES (9, 'E.S.B.', NULL);
INSERT INTO `beer_type` (`id`, `name`, `description`) VALUES (10, 'Brown', NULL);
INSERT INTO `beer_type` (`id`, `name`, `description`) VALUES (11, 'Gose', NULL);
INSERT INTO `beer_type` (`id`, `name`, `description`) VALUES (12, 'Saison', NULL);
INSERT INTO `beer_type` (`id`, `name`, `description`) VALUES (13, 'Belgian', NULL);
INSERT INTO `beer_type` (`id`, `name`, `description`) VALUES (14, 'Wheat/Weisse/Hefeweizen', NULL);
INSERT INTO `beer_type` (`id`, `name`, `description`) VALUES (15, 'Blond', NULL);
INSERT INTO `beer_type` (`id`, `name`, `description`) VALUES (16, 'Amber', NULL);
INSERT INTO `beer_type` (`id`, `name`, `description`) VALUES (17, 'Other', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `beer_has_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `dejabrewdb`;
INSERT INTO `beer_has_type` (`beer_id`, `beer_type_id`) VALUES (1, 1);
INSERT INTO `beer_has_type` (`beer_id`, `beer_type_id`) VALUES (2, 16);
INSERT INTO `beer_has_type` (`beer_id`, `beer_type_id`) VALUES (3, 15);
INSERT INTO `beer_has_type` (`beer_id`, `beer_type_id`) VALUES (4, 3);
INSERT INTO `beer_has_type` (`beer_id`, `beer_type_id`) VALUES (5, 3);

COMMIT;
