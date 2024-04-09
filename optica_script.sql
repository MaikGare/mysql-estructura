-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8 ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveedor` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NULL,
  `dirección` VARCHAR(80) NULL,
  `ciudad` VARCHAR(45) NULL,
  `codigo_postal` INT NULL,
  `pais` VARCHAR(45) NULL,
  `telefono` INT NULL,
  `fax` INT NULL,
  `nif` VARCHAR(9) NULL,
  PRIMARY KEY (`id_proveedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`gafas` (
  `id_gafas` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NULL,
  `graduación_izquierda` FLOAT NULL,
  `graduacion_derecha` FLOAT NULL,
  `tipo_montura` ENUM('flotante', 'pasta', 'metalica') NULL,
  `color_montura` VARCHAR(30) NULL,
  `color_viz` VARCHAR(30) NULL,
  `color_vder` VARCHAR(30) NULL,
  `precio` FLOAT NULL,
  `id_proveedor` INT NULL,
  PRIMARY KEY (`id_gafas`),
  INDEX `id_proveedor_idx` (`id_proveedor` ASC) VISIBLE,
  CONSTRAINT `id_proveedor`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `optica`.`proveedor` (`id_proveedor`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`clientes` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(25) NULL,
  `apellido` VARCHAR(25) NULL,
  `direccion` VARCHAR(90) NULL,
  `telefono` INT NULL,
  `mail` VARCHAR(45) NULL,
  `fecha_registro` DATE NULL,
  `id_cliente_recomendacion` INT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `id_cliente_recomendación_idx` (`id_cliente_recomendacion` ASC) VISIBLE,
  CONSTRAINT `id_cliente_recomendación`
    FOREIGN KEY (`id_cliente_recomendacion`)
    REFERENCES `optica`.`clientes` (`id_cliente`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`empleados` (
  `id_empleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id_empleado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`ventas` (
  `id_venta` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NULL,
  `id_empleado` INT NULL,
  `id_cliente` INT NULL,
  `id_gafas` INT NULL,
  PRIMARY KEY (`id_venta`),
  INDEX `id_empleado_idx` (`id_empleado` ASC) VISIBLE,
  INDEX `id_cliente_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `id_gafas_idx` (`id_gafas` ASC) VISIBLE,
  CONSTRAINT `id_empleado`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `optica`.`empleados` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `optica`.`clientes` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_gafas`
    FOREIGN KEY (`id_gafas`)
    REFERENCES `optica`.`gafas` (`id_gafas`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;