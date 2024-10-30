-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Personal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Personal` (
  `idPersonal` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `APaterno` VARCHAR(45) NOT NULL,
  `AMaterno` VARCHAR(45) NOT NULL,
  `fechaNac` DATE NOT NULL,
  `RFC` VARCHAR(13) NOT NULL,
  `Telefono` VARCHAR(10) NOT NULL,
  `Departamento` VARCHAR(10) NOT NULL,
  `Puesto` CHAR NOT NULL,
  `salario` FLOAT NOT NULL,
  `Usuario` VARCHAR(10) NOT NULL,
  `Clave` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`idPersonal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(60) NOT NULL,
  `Correo` VARCHAR(45) NOT NULL,
  `Clave` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Producto` (
  `idProducto` INT NOT NULL,
  `Nombre` VARCHAR(60) NOT NULL,
  `Precio` FLOAT NOT NULL,
  `Descuento` FLOAT NULL,
  `ProveedorNombre` VARCHAR(45) NOT NULL,
  `ProveedorTel` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Paciente` (
  `idPaciente` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NOT NULL,
  `Direccion` VARCHAR(75) NOT NULL,
  `Telefono` VARCHAR(10) NOT NULL,
  `Pacientecol` VARCHAR(45) NULL,
  PRIMARY KEY (`idPaciente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Consulta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Consulta` (
  `idConsulta` INT UNSIGNED NOT NULL,
  `idDoctor` INT NOT NULL,
  `idPaciente` INT NOT NULL,
  `Fecha` DATE NOT NULL,
  `Receta` LONGTEXT NOT NULL,
  `Costo` FLOAT NOT NULL,
  PRIMARY KEY (`idConsulta`),
  INDEX `fk_Consulta_Personal_idx` (`idDoctor` ASC) VISIBLE,
  INDEX `fk_Consulta_Paciente1_idx` (`idPaciente` ASC) VISIBLE,
  CONSTRAINT `fk_Consulta_Personal`
    FOREIGN KEY (`idDoctor`)
    REFERENCES `mydb`.`Personal` (`idPersonal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consulta_Paciente1`
    FOREIGN KEY (`idPaciente`)
    REFERENCES `mydb`.`Paciente` (`idPaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ventaTurno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ventaTurno` (
  `idventaTurno` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idCajero` INT NOT NULL,
  `fondo` FLOAT NOT NULL,
  `montoFinal` FLOAT NOT NULL,
  `apertura` DATETIME NOT NULL,
  `cierre` DATETIME NOT NULL,
  PRIMARY KEY (`idventaTurno`),
  INDEX `fk_ventaTurno_Personal1_idx` (`idCajero` ASC) VISIBLE,
  CONSTRAINT `fk_ventaTurno_Personal1`
    FOREIGN KEY (`idCajero`)
    REFERENCES `mydb`.`Personal` (`idPersonal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ventaProducto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ventaProducto` (
  `idventaProducto` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `cant` INT NOT NULL,
  `subtotal` FLOAT NOT NULL,
  PRIMARY KEY (`idventaProducto`),
  INDEX `fk_ventaProducto_Producto1_idx` (`idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_ventaProducto_Producto1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ticket` (
  `idticket` INT NOT NULL AUTO_INCREMENT,
  `fechaHora` DATETIME NOT NULL,
  `idCajero` INT NOT NULL,
  `idventaProducto` INT NOT NULL,
  `total` FLOAT NOT NULL,
  PRIMARY KEY (`idticket`),
  INDEX `fk_ticket_Personal1_idx` (`idCajero` ASC) VISIBLE,
  INDEX `fk_ticket_ventaProducto1_idx` (`idventaProducto` ASC) VISIBLE,
  CONSTRAINT `fk_ticket_Personal1`
    FOREIGN KEY (`idCajero`)
    REFERENCES `mydb`.`Personal` (`idPersonal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_ventaProducto1`
    FOREIGN KEY (`idventaProducto`)
    REFERENCES `mydb`.`ventaProducto` (`idventaProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`carrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`carrito` (
  `idcarrito` INT NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `idventaProducto` INT NOT NULL,
  `sucursal` VARCHAR(15) NOT NULL,
  `total` FLOAT NOT NULL,
  PRIMARY KEY (`idcarrito`),
  INDEX `fk_carrito_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_carrito_ventaProducto1_idx` (`idventaProducto` ASC) VISIBLE,
  CONSTRAINT `fk_carrito_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_carrito_ventaProducto1`
    FOREIGN KEY (`idventaProducto`)
    REFERENCES `mydb`.`ventaProducto` (`idventaProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`semana`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`semana` (
  `idsemana` INT NOT NULL AUTO_INCREMENT,
  `idPersonal` INT NOT NULL,
  `lunes` INT NOT NULL,
  `martes` INT NOT NULL,
  `miercoles` INT NOT NULL,
  `jueves` INT NOT NULL,
  `viernes` INT NOT NULL,
  `sabado` INT NOT NULL,
  `domingo` INT NOT NULL,
  PRIMARY KEY (`idsemana`),
  INDEX `fk_semana_Personal1_idx` (`idPersonal` ASC) VISIBLE,
  CONSTRAINT `fk_semana_Personal1`
    FOREIGN KEY (`idPersonal`)
    REFERENCES `mydb`.`Personal` (`idPersonal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`historial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`historial` (
  `idhistorial` INT NOT NULL AUTO_INCREMENT,
  `idPaciente` INT NOT NULL,
  `diagnostico` VARCHAR(45) NOT NULL,
  `descripcion` TEXT NULL,
  `fecha` DATE NOT NULL,
  `receta` TEXT NOT NULL,
  PRIMARY KEY (`idhistorial`),
  INDEX `fk_historial_Paciente1_idx` (`idPaciente` ASC) VISIBLE,
  CONSTRAINT `fk_historial_Paciente1`
    FOREIGN KEY (`idPaciente`)
    REFERENCES `mydb`.`Paciente` (`idPaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
