-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema aestudante_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `aestudante_db` ;

-- -----------------------------------------------------
-- Schema aestudante_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `aestudante_db` ;
USE `aestudante_db` ;

-- -----------------------------------------------------
-- Table `aestudante_db`.`tb_produtos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `aestudante_db`.`tb_produtos` ;

CREATE TABLE IF NOT EXISTS `aestudante_db`.`tb_produtos` (
  `id_produtos` INT NOT NULL AUTO_INCREMENT,
  `nome_produtos` VARCHAR(50) NOT NULL,
  `preco_produtos` DOUBLE NOT NULL,
  `descricao_produtos` VARCHAR(250) NOT NULL,
  `categoria_produtos` VARCHAR(50) NOT NULL,
  `quantidade_produtos` INT NOT NULL,
  `imagem_produtos` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`id_produtos`),
  UNIQUE INDEX `nome_produtos_UNIQUE` (`nome_produtos` ASC) VISIBLE,
  UNIQUE INDEX `descricao_produtos_UNIQUE` (`descricao_produtos` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `aestudante_db`.`tb_vendas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `aestudante_db`.`tb_vendas` ;

CREATE TABLE IF NOT EXISTS `aestudante_db`.`tb_vendas` (
  `tb_produtos_has_tb_produtos_tb_produtos_id_produtos` INT NOT NULL,
  `tb_produtos_has_tb_produtos_tb_produtos_id_produtos1` INT NOT NULL,
  `id_vendas` INT NOT NULL AUTO_INCREMENT,
  `homologar_vendas` TINYINT NOT NULL,
  PRIMARY KEY (`id_vendas`, `tb_produtos_has_tb_produtos_tb_produtos_id_produtos`, `tb_produtos_has_tb_produtos_tb_produtos_id_produtos1`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `aestudante_db`.`tb_produtos_has_tb_vendas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `aestudante_db`.`tb_produtos_has_tb_vendas` ;

CREATE TABLE IF NOT EXISTS `aestudante_db`.`tb_produtos_has_tb_vendas` (
  `tb_produtos_id_produtos` INT NOT NULL,
  `tb_vendas_id_vendas` INT NOT NULL,
  `tb_vendas_tb_produtos_has_tb_produtos_tb_produtos_id_produtos` INT NOT NULL,
  `tb_vendas_tb_produtos_has_tb_produtos_tb_produtos_id_produtos1` INT NOT NULL,
  PRIMARY KEY (`tb_produtos_id_produtos`, `tb_vendas_id_vendas`, `tb_vendas_tb_produtos_has_tb_produtos_tb_produtos_id_produtos`, `tb_vendas_tb_produtos_has_tb_produtos_tb_produtos_id_produtos1`),
  INDEX `fk_tb_produtos_has_tb_vendas_tb_vendas1_idx` (`tb_vendas_id_vendas` ASC, `tb_vendas_tb_produtos_has_tb_produtos_tb_produtos_id_produtos` ASC, `tb_vendas_tb_produtos_has_tb_produtos_tb_produtos_id_produtos1` ASC) VISIBLE,
  INDEX `fk_tb_produtos_has_tb_vendas_tb_produtos_idx` (`tb_produtos_id_produtos` ASC) VISIBLE,
  CONSTRAINT `fk_tb_produtos_has_tb_vendas_tb_produtos`
    FOREIGN KEY (`tb_produtos_id_produtos`)
    REFERENCES `aestudante_db`.`tb_produtos` (`id_produtos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_produtos_has_tb_vendas_tb_vendas1`
    FOREIGN KEY (`tb_vendas_id_vendas` , `tb_vendas_tb_produtos_has_tb_produtos_tb_produtos_id_produtos` , `tb_vendas_tb_produtos_has_tb_produtos_tb_produtos_id_produtos1`)
    REFERENCES `aestudante_db`.`tb_vendas` (`id_vendas` , `tb_produtos_has_tb_produtos_tb_produtos_id_produtos` , `tb_produtos_has_tb_produtos_tb_produtos_id_produtos1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
