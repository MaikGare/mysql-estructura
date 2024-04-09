-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NULL,
  `apellido` VARCHAR(35) NULL,
  `direccion` VARCHAR(80) NULL,
  `codigo_postal` INT NULL,
  `localidad` VARCHAR(45) NULL,
  `provincia` VARCHAR(30) NULL,
  `telefono` INT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NULL,
  PRIMARY KEY (`id_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`producto` (
  `id_producto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NULL,
  `descripcion` VARCHAR(100) NULL,
  `imagen` VARCHAR(200) NULL,
  `precio` FLOAT NULL,
  `id_categoria` INT NULL,
  PRIMARY KEY (`id_producto`),
  INDEX `id_categoria_idx` (`id_categoria` ASC) VISIBLE,
  CONSTRAINT `id_categoria`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `pizzeria`.`categoria` (`id_categoria`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = '\n';


-- -----------------------------------------------------
-- Table `pizzeria`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tienda` (
  `id_tienda` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(80) NULL,
  `codigo_postal` INT NULL,
  `localidad` VARCHAR(45) NULL,
  `privincia` VARCHAR(30) NULL,
  PRIMARY KEY (`id_tienda`))
ENGINE = InnoDB
COMMENT = '			';


-- -----------------------------------------------------
-- Table `pizzeria`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedido` (
  `id_pedido` INT NOT NULL AUTO_INCREMENT,
  `fecha` TIMESTAMP NULL,
  `entrega` ENUM('reparto domicilio', 'recogida local') NULL,
  `cantidad_productos` INT NULL,
  `precio_total` FLOAT NULL,
  `id_cliente` INT NULL,
  `id_productos` INT NULL,
  `id_tienda` INT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `id_cliente_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `id_productos_idx` (`id_productos` ASC) VISIBLE,
  INDEX `id_tienda_idx` (`id_tienda` ASC) VISIBLE,
  CONSTRAINT `id_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `pizzeria`.`cliente` (`id_cliente`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `id_productos`
    FOREIGN KEY (`id_productos`)
    REFERENCES `pizzeria`.`producto` (`id_producto`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `id_tienda`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `pizzeria`.`tienda` (`id_tienda`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = '			';


-- -----------------------------------------------------
-- Table `pizzeria`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleado` (
  `id_empleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(30) NULL,
  `apellido` VARCHAR(35) NULL,
  `NIF` VARCHAR(9) NULL,
  `telefono` INT NULL,
  `rol` ENUM('reparto', 'cocina') NULL,
  `id_tienda` INT NULL,
  PRIMARY KEY (`id_empleado`),
  INDEX `id_tienda_idx` (`id_tienda` ASC) VISIBLE,
  CONSTRAINT `id_tienda`
    FOREIGN KEY (`id_tienda`)
    REFERENCES `pizzeria`.`tienda` (`id_tienda`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`entregas_domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`entregas_domicilio` (
  `id_empleado` INT NULL,
  `id_pedido` INT NULL,
  `hora_entrega` TIMESTAMP NULL,
  INDEX `id_empleado_idx` (`id_empleado` ASC) VISIBLE,
  INDEX `id_pedido_idx` (`id_pedido` ASC) VISIBLE,
  CONSTRAINT `id_empleado`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `pizzeria`.`empleado` (`id_empleado`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `id_pedido`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `pizzeria`.`pedido` (`id_pedido`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
