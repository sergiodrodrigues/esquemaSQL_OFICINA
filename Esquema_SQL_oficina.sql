-- -----------------------------------------------------
-- Schema oficina
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oficina`;
USE `oficina` ;

-- -----------------------------------------------------
-- Tabela `oficina`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nomeCliente` VARCHAR(255) NOT NULL,
  `enderecoCliente` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`idCliente`)
);


-- -----------------------------------------------------
-- Tabela `oficina`.`Mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Mecanico` (
  `idMecanico` INT NOT NULL AUTO_INCREMENT,
  `nomeMecanico` VARCHAR(255) NOT NULL,
  `enderecoMecanico` VARCHAR(255) NULL DEFAULT NULL,
  `especialidadeMecanico` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idMecanico`)
);


-- -----------------------------------------------------
-- Tabela `oficina`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Veiculo` (
  `idVeiculo` INT NOT NULL AUTO_INCREMENT,
  `placaVeiculo` VARCHAR(20) NOT NULL,
  `modeloVeiculo` VARCHAR(100) NULL DEFAULT NULL,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idVeiculo`),
  INDEX `idCliente` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `veiculo_ibfk_1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `oficina`.`Cliente` (`idCliente`)
);


-- -----------------------------------------------------
-- Tabela `oficina`.`Ordem_Serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Ordem_Serviço` (
  `idOrdem_Serviço` INT NOT NULL AUTO_INCREMENT,
  `dataEmissao_Ordem_Serviço` DATE NOT NULL,
  `valor_Ordem_Serviço` DECIMAL(10,2) NULL DEFAULT NULL,
  `status_Ordem_Serviço` VARCHAR(100) NULL DEFAULT NULL,
  `dataConclusao_Ordem_Serviço` DATE NULL DEFAULT NULL,
  `idVeiculo` INT NOT NULL,
  PRIMARY KEY (`idOrdem_Serviço`),
  INDEX `idVeiculo` (`idVeiculo` ASC) VISIBLE,
  CONSTRAINT `ordemservico_ibfk_1`
    FOREIGN KEY (`idVeiculo`)
    REFERENCES `oficina`.`Veiculo` (`idVeiculo`)
);


-- -----------------------------------------------------
-- Tabela `oficina`.`Peça`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Peça` (
  `idPeça` INT NOT NULL AUTO_INCREMENT,
  `nomePeça` VARCHAR(255) NOT NULL,
  `valorPeça` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`idPeça`)
);

-- -----------------------------------------------------
-- Tabela `oficina`.`Ordem_Serviço_Peça`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Ordem_Serviço_Peça` (
  `idOrdem_Serviço` INT NOT NULL,
  `idPeça` INT NOT NULL,
  PRIMARY KEY (`idOrdem_Serviço`, `idPeça`),
  INDEX `idPeça` (`idPeça` ASC) VISIBLE,
  CONSTRAINT `ospeca_ibfk_1`
    FOREIGN KEY (`idOrdem_Serviço`)
    REFERENCES `oficina`.`Ordem_Serviço` (`idOrdem_Serviço`),
  CONSTRAINT `ospeca_ibfk_2`
    FOREIGN KEY (`idPeça`)
    REFERENCES `oficina`.`Peça` (`idPeça`)
);

-- -----------------------------------------------------
-- Tabela `oficina`.`Serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Serviço` (
  `idServiço` INT NOT NULL AUTO_INCREMENT,
  `descricaoServiço` VARCHAR(255) NOT NULL,
  `valor_Mao_Obra` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`idServiço`)
);

-- -----------------------------------------------------
-- Tabela `oficina`.`Ordem_Serviço_Serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Ordem_Serviço_Serviço` (
  `idOrdem_Serviço` INT NOT NULL,
  `idServiço` INT NOT NULL,
  PRIMARY KEY (`idOrdem_Serviço`, `idServiço`),
  INDEX `idServico` (`idServiço` ASC) VISIBLE,
  CONSTRAINT `osservico_ibfk_1`
    FOREIGN KEY (`idOrdem_Serviço`)
    REFERENCES `oficina`.`Ordem_Serviço` (`idOrdem_Serviço`),
  CONSTRAINT `osservico_ibfk_2`
    FOREIGN KEY (`idServiço`)
    REFERENCES `oficina`.`Serviço` (`idServiço`)
);

-- -----------------------------------------------------
-- Tabela `oficina`.`Ordem_Serviço_Mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Ordem_Serviço_Mecanico` (
  `idOrdem_Serviço` INT NOT NULL,
  `idMecanico` INT NOT NULL,
  PRIMARY KEY (`idOrdem_Serviço`, `idMecanico`),
  INDEX `idMecanico` (`idMecanico` ASC) VISIBLE,
  CONSTRAINT `osmecanico_ibfk_1`
    FOREIGN KEY (`idOrdem_Serviço`)
    REFERENCES `oficina`.`Ordem_Serviço` (`idOrdem_Serviço`),
  CONSTRAINT `osmecanico_ibfk_2`
    FOREIGN KEY (`idMecanico`)
    REFERENCES `oficina`.`Mecanico` (`idMecanico`)
);
 
