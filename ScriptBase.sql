-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Countries-Reto
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Countries-Reto` ;

-- -----------------------------------------------------
-- Schema Countries-Reto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Countries-Reto` DEFAULT CHARACTER SET utf8 ;
USE `Countries-Reto` ;

-- -----------------------------------------------------
-- Table `Countries-Reto`.`Translation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Countries-Reto`.`Translation` (
  `Translation_ID` INT NOT NULL,
  `Translations` LONGTEXT NOT NULL,
  PRIMARY KEY (`Translation_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Countries-Reto`.`Region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Countries-Reto`.`Region` (
  `Region_ID` INT(250) NOT NULL,
  `Name` ENUM('Asia', 'Europe', 'Africa', 'Oceania', 'Americas', 'Polar') NULL,
  PRIMARY KEY (`Region_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Countries-Reto`.`Subregion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Countries-Reto`.`Subregion` (
  `Subregion_ID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Region_ID` INT(250) NOT NULL,
  PRIMARY KEY (`Subregion_ID`),
  INDEX `fk_Subregion_Region1_idx` (`Region_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Subregion_Region1`
    FOREIGN KEY (`Region_ID`)
    REFERENCES `Countries-Reto`.`Region` (`Region_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Countries-Reto`.`Countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Countries-Reto`.`Countries` (
  `Numeric_Code` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `TopLevelDomain` VARCHAR(45) NULL,
  `Alpha2Code` VARCHAR(4) NULL,
  `Alpha3Code` VARCHAR(4) NULL,
  `CallingCodes` INT UNSIGNED NULL,
  `Capital` VARCHAR(45) NULL,
  `Area` INT UNSIGNED NULL,
  `Gini` DECIMAL(2,1) NULL,
  `Population` INT UNSIGNED NULL,
  `Denonym` VARCHAR(60) NULL,
  `Native name` VARCHAR(45) NULL,
  `CIOC` VARCHAR(3) NULL,
  `Flag` VARCHAR(100) NULL,
  `Translation_ID` INT NULL,
  `Subregion_ID` INT NULL,
  PRIMARY KEY (`Numeric_Code`),
  INDEX `fk_Countries_Translation1_idx` (`Translation_ID` ASC) VISIBLE,
  INDEX `fk_Countries_Subregion1_idx` (`Subregion_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Countries_Translation1`
    FOREIGN KEY (`Translation_ID`)
    REFERENCES `Countries-Reto`.`Translation` (`Translation_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Countries_Subregion1`
    FOREIGN KEY (`Subregion_ID`)
    REFERENCES `Countries-Reto`.`Subregion` (`Subregion_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Countries-Reto`.`Currencies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Countries-Reto`.`Currencies` (
  `currencies_ID` INT NOT NULL,
  `Code` VARCHAR(3) NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Symbol` VARCHAR(45) NULL,
  PRIMARY KEY (`currencies_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Countries-Reto`.`Countries_has_Currencies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Countries-Reto`.`Countries_has_Currencies` (
  `Countries_Numeric_Code` INT NOT NULL,
  `currencies_ID` INT NOT NULL,
  PRIMARY KEY (`Countries_Numeric_Code`, `currencies_ID`),
  INDEX `fk_Countries_has_Currencies_Currencies1_idx` (`currencies_ID` ASC) VISIBLE,
  INDEX `fk_Countries_has_Currencies_Countries1_idx` (`Countries_Numeric_Code` ASC) VISIBLE,
  CONSTRAINT `fk_Countries_has_Currencies_Countries1`
    FOREIGN KEY (`Countries_Numeric_Code`)
    REFERENCES `Countries-Reto`.`Countries` (`Numeric_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Countries_has_Currencies_Currencies1`
    FOREIGN KEY (`currencies_ID`)
    REFERENCES `Countries-Reto`.`Currencies` (`currencies_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Countries-Reto`.`Languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Countries-Reto`.`Languages` (
  `Languages_ID` INT NOT NULL AUTO_INCREMENT,
  `ISO639_1` VARCHAR(2) NULL,
  `ISO639_2` VARCHAR(3) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Native_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Languages_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Countries-Reto`.`Countries_has_Languages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Countries-Reto`.`Countries_has_Languages` (
  `Countries_Numeric_Code` INT NOT NULL,
  `Languages_ID` INT NOT NULL,
  PRIMARY KEY (`Countries_Numeric_Code`, `Languages_ID`),
  INDEX `fk_Countries_has_Languages_Languages1_idx` (`Languages_ID` ASC) VISIBLE,
  INDEX `fk_Countries_has_Languages_Countries1_idx` (`Countries_Numeric_Code` ASC) VISIBLE,
  CONSTRAINT `fk_Countries_has_Languages_Countries1`
    FOREIGN KEY (`Countries_Numeric_Code`)
    REFERENCES `Countries-Reto`.`Countries` (`Numeric_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Countries_has_Languages_Languages1`
    FOREIGN KEY (`Languages_ID`)
    REFERENCES `Countries-Reto`.`Languages` (`Languages_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Countries-Reto`.`Regional_Blocs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Countries-Reto`.`Regional_Blocs` (
  `Regional_Blocs_ID` INT NOT NULL,
  `Acronym` MEDIUMTEXT NULL,
  `Name` MEDIUMTEXT NULL,
  PRIMARY KEY (`Regional_Blocs_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Countries-Reto`.`Countries_has_Regional Blocs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Countries-Reto`.`Countries_has_Regional Blocs` (
  `Countries_Numeric_Code` INT NOT NULL,
  `Regional_Blocs_ID` INT NOT NULL,
  PRIMARY KEY (`Countries_Numeric_Code`, `Regional_Blocs_ID`),
  INDEX `fk_Countries_has_Regional Blocs_Regional Blocs1_idx` (`Regional_Blocs_ID` ASC) VISIBLE,
  INDEX `fk_Countries_has_Regional Blocs_Countries1_idx` (`Countries_Numeric_Code` ASC) VISIBLE,
  CONSTRAINT `fk_Countries_has_Regional Blocs_Countries1`
    FOREIGN KEY (`Countries_Numeric_Code`)
    REFERENCES `Countries-Reto`.`Countries` (`Numeric_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Countries_has_Regional Blocs_Regional Blocs1`
    FOREIGN KEY (`Regional_Blocs_ID`)
    REFERENCES `Countries-Reto`.`Regional_Blocs` (`Regional_Blocs_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Countries-Reto`.`LatLng`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Countries-Reto`.`LatLng` (
  `LatLng_ID` VARCHAR(45) NOT NULL,
  `Latitud` DECIMAL(12,4) NOT NULL,
  `Longitud` DECIMAL(12,4) NOT NULL,
  `Countries_Numeric_Code` INT NOT NULL,
  PRIMARY KEY (`LatLng_ID`),
  INDEX `fk_LatLng_Countries1_idx` (`Countries_Numeric_Code` ASC) VISIBLE,
  CONSTRAINT `fk_LatLng_Countries1`
    FOREIGN KEY (`Countries_Numeric_Code`)
    REFERENCES `Countries-Reto`.`Countries` (`Numeric_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Countries-Reto`.`AltSpelling`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Countries-Reto`.`AltSpelling` (
  `AltSpelling_ID` INT NOT NULL,
  `AltSpell` VARCHAR(13) NULL,
  `Countries_Numeric_Code` INT NOT NULL,
  PRIMARY KEY (`AltSpelling_ID`),
  INDEX `fk_AltSpelling_Countries1_idx` (`Countries_Numeric_Code` ASC) VISIBLE,
  CONSTRAINT `fk_AltSpelling_Countries1`
    FOREIGN KEY (`Countries_Numeric_Code`)
    REFERENCES `Countries-Reto`.`Countries` (`Numeric_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Countries-Reto`.`TimeZone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Countries-Reto`.`TimeZone` (
  `TimeZone_Id` INT NOT NULL,
  `name` VARCHAR(10) NULL,
  PRIMARY KEY (`TimeZone_Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Countries-Reto`.`Countries_has_TimeZone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Countries-Reto`.`Countries_has_TimeZone` (
  `Countries_Numeric_Code` INT NOT NULL,
  `TimeZone_Id` INT NOT NULL,
  PRIMARY KEY (`Countries_Numeric_Code`, `TimeZone_Id`),
  INDEX `fk_Countries_has_TimeZone_TimeZone1_idx` (`TimeZone_Id` ASC) VISIBLE,
  INDEX `fk_Countries_has_TimeZone_Countries1_idx` (`Countries_Numeric_Code` ASC) VISIBLE,
  CONSTRAINT `fk_Countries_has_TimeZone_Countries1`
    FOREIGN KEY (`Countries_Numeric_Code`)
    REFERENCES `Countries-Reto`.`Countries` (`Numeric_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Countries_has_TimeZone_TimeZone1`
    FOREIGN KEY (`TimeZone_Id`)
    REFERENCES `Countries-Reto`.`TimeZone` (`TimeZone_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
