-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bfhfjzo1sfttytwzxc3i
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bfhfjzo1sfttytwzxc3i
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bfhfjzo1sfttytwzxc3i` DEFAULT CHARACTER SET utf8 ;
USE `bfhfjzo1sfttytwzxc3i` ;

-- -----------------------------------------------------
-- Table `bfhfjzo1sfttytwzxc3i`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bfhfjzo1sfttytwzxc3i`.`departamento` (
  `iddepartamento` INT NOT NULL AUTO_INCREMENT,
  `codigo` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iddepartamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bfhfjzo1sfttytwzxc3i`.`municipio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bfhfjzo1sfttytwzxc3i`.`municipio` (
  `idmunicipio` INT NOT NULL AUTO_INCREMENT,
  `codigo` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `departamento_iddepartamento` INT NOT NULL,
  PRIMARY KEY (`idmunicipio`),
  INDEX `fk_municipio_departamento1_idx` (`departamento_iddepartamento` ASC) VISIBLE,
  CONSTRAINT `fk_municipio_departamento1`
    FOREIGN KEY (`departamento_iddepartamento`)
    REFERENCES `bfhfjzo1sfttytwzxc3i`.`departamento` (`iddepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bfhfjzo1sfttytwzxc3i`.`ubicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bfhfjzo1sfttytwzxc3i`.`ubicacion` (
  `idubicacion` INT NOT NULL AUTO_INCREMENT,
  `latitud` DECIMAL(9,6) NOT NULL,
  `longitud` DECIMAL(9,6) NOT NULL,
  `country_name` VARCHAR(45) NOT NULL,
  `municipio_idmunicipio` INT NOT NULL,
  PRIMARY KEY (`idubicacion`),
  INDEX `fk_ubicacion_municipio1_idx` (`municipio_idmunicipio` ASC) VISIBLE,
  CONSTRAINT `fk_ubicacion_municipio1`
    FOREIGN KEY (`municipio_idmunicipio`)
    REFERENCES `bfhfjzo1sfttytwzxc3i`.`municipio` (`idmunicipio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bfhfjzo1sfttytwzxc3i`.`estacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bfhfjzo1sfttytwzxc3i`.`estacion` (
  `idestacion` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `WHID` VARCHAR(45) NOT NULL,
  `internal_ip` VARCHAR(45) NULL,
  `external_ip` VARCHAR(45) NULL,
  `url_connection` VARCHAR(45) NULL,
  `ubicacion_idubicacion` INT NOT NULL,
  PRIMARY KEY (`idestacion`),
  INDEX `fk_estacion_ubicacion1_idx` (`ubicacion_idubicacion` ASC) VISIBLE,
  CONSTRAINT `fk_estacion_ubicacion1`
    FOREIGN KEY (`ubicacion_idubicacion`)
    REFERENCES `bfhfjzo1sfttytwzxc3i`.`ubicacion` (`idubicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bfhfjzo1sfttytwzxc3i`.`historial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bfhfjzo1sfttytwzxc3i`.`historial` (
  `idhistorial` INT NOT NULL AUTO_INCREMENT,
  `SO2` DECIMAL(6,2) NOT NULL,
  `NO2` DECIMAL(6,2) NOT NULL,
  `PM` DECIMAL(6,2) NOT NULL,
  `O3` DECIMAL(6,2) NOT NULL,
  `CO` DECIMAL(6,2) NOT NULL,
  `IGE` DECIMAL(6,2) NOT NULL,
  `fecha` DATE NOT NULL,
  `hora` TIME NOT NULL,
  `estacion_idestacion` INT NOT NULL,
  `temp` INT NULL,
  `pressure` DECIMAL(5,1) NULL,
  `humidity` INT NULL,
  `wind` INT NULL,
  PRIMARY KEY (`idhistorial`),
  INDEX `fk_historial_estacion1_idx` (`estacion_idestacion` ASC) VISIBLE,
  CONSTRAINT `fk_historial_estacion1`
    FOREIGN KEY (`estacion_idestacion`)
    REFERENCES `bfhfjzo1sfttytwzxc3i`.`estacion` (`idestacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bfhfjzo1sfttytwzxc3i`.`error`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bfhfjzo1sfttytwzxc3i`.`error` (
  `iderrores` INT NOT NULL AUTO_INCREMENT,
  `codigo` INT NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iderrores`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bfhfjzo1sfttytwzxc3i`.`registro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bfhfjzo1sfttytwzxc3i`.`registro` (
  `idregistro` INT NOT NULL AUTO_INCREMENT,
  `fecha_hora` DATETIME NOT NULL,
  `error_iderrores` INT NOT NULL,
  `estacion_idestacion` INT NOT NULL,
  PRIMARY KEY (`idregistro`),
  INDEX `fk_registro_error1_idx` (`error_iderrores` ASC) VISIBLE,
  INDEX `fk_registro_estacion1_idx` (`estacion_idestacion` ASC) VISIBLE,
  CONSTRAINT `fk_registro_error1`
    FOREIGN KEY (`error_iderrores`)
    REFERENCES `bfhfjzo1sfttytwzxc3i`.`error` (`iderrores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_registro_estacion1`
    FOREIGN KEY (`estacion_idestacion`)
    REFERENCES `bfhfjzo1sfttytwzxc3i`.`estacion` (`idestacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
