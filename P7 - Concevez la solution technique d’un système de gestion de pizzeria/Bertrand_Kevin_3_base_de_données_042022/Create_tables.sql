CREATE SCHEMA IF NOT EXISTS `ocPizza` DEFAULT CHARACTER SET utf8MB4;
use `ocPizza`;

CREATE TABLE IF NOT EXISTS `Address` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `road_type` VARCHAR(25) NOT NULL,
    `road_name` VARCHAR(100) NOT NULL,
    `street_number` VARCHAR(15) NOT NULL,
    `complement` VARCHAR(150),
    `zip_code` VARCHAR(15) NOT NULL,
    `city` VARCHAR(50) NOT NULL,
    `country` VARCHAR(50) NOT NULL,
    `comment` VARCHAR(150),
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Supplier` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `phone_number` VARCHAR(25) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `address_id` INT NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Ingredient` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `unity` VARCHAR(15),
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `OrderIngredients` (
	`supplier_id` INT NOT NULL,
    `ingredient_id` INT NOT NULL,
    `quantity` DECIMAL(10,2) NOT NULL,
    `order_date` DATETIME NOT NULL,
    PRIMARY KEY (`supplier_id`, `ingredient_id`)
);

CREATE TABLE IF NOT EXISTS `Pizzeria` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `revenue` DOUBLE NOT NULL,
    `address_id` INT NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Stock` (
	`pizzeria_id` INT NOT NULL,
    `ingredient_id` INT NOT NULL,
    `quantity` DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (`pizzeria_id`, `ingredient_id`)
);

CREATE TABLE IF NOT EXISTS `Hours` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `day` ENUM("monday","tuesday","wednesday","thursday","friday","saturday","sunday"),
    `is_open` BOOLEAN NOT NULL,
    `opening_hour`TIME NOT NULL,
    `closing_hour` TIME NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `PizzeriaHours` (
	`pizzeria_id` INT NOT NULL,
    `hours_id` INT NOT NULL,
    PRIMARY KEY (`pizzeria_id`, `hours_id`)
);

CREATE TABLE IF NOT EXISTS `Staff` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `position` ENUM("host","pizzaChef","deliverer","manager","companyLeader") NOT NULL,
    `firstname` VARCHAR(45) NOT NULL,
    `lastname` VARCHAR(45) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(50) NOT NULL,
    `gender` ENUM("man","woman","notDetermined") NOT NULL,
    `password` VARCHAR(100) NOT NULL,
    `address_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE (`email`, `phone_number`)
);

CREATE TABLE IF NOT EXISTS `WORKS` (
	`pizzeria_id` INT NOT NULL,
    `staff_id` INT NOT NULL,
    PRIMARY KEY (`staff_id`, `pizzeria_id`)
);

CREATE TABLE IF NOT EXISTS `Client` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `firstname` VARCHAR(45) NOT NULL,
    `lastname` VARCHAR(45) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `phone_number` VARCHAR(50) NOT NULL,
    `gender` ENUM("man","woman","notDetermined") NOT NULL,
    `password` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE (`email`, `phone_number`)
);

CREATE TABLE IF NOT EXISTS `ClientAddress` (
	`client_id` INT NOT NULL,
    `address_id` INT NOT NULL,
    PRIMARY KEY (`client_id`, `address_id`)
);

CREATE TABLE IF NOT EXISTS `Order` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `order_date` DATETIME NOT NULL,
    `status` ENUM("pending","cancelled","beingPrepared","ready","beingDelivered","pickedUp","delivered") NOT NULL,
	`is_paid` BOOLEAN NOT NULL,
    `payment_method` ENUM("debitCardOnline","debitCardOnRestaurant","debitCardOnDelivery","cashOnRestaurant","cashOnDelivery","other") NOT NULL,
    `staff_id` INT,
    `client_id` INT,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Billing` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `amount`DECIMAL(6,2) NOT NULL,
    `order_id`INT NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Recipe` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `comment` LONGTEXT,
    `pizza_id` INT NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Pizza`(
	`id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL,
    `price` DECIMAL(5,2) NOT NULL,
    `description` VARCHAR(250),
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `CommandLine`(
	`order_id` INT NOT NULL,
    `pizza_id` INT NOT NULL,
    `quantity`TINYINT NOT NULL,
    PRIMARY KEY (`pizza_id`, `order_id`)
);

CREATE TABLE IF NOT EXISTS `Composition` (
	`ingredient_id` INT NOT NULL,
    `pizza_id` INT NOT NULL,
    `quantity` DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (`ingredient_id`, `pizza_id`)
);

ALTER TABLE `Supplier`
ADD CONSTRAINT `supplier_address_fk`
FOREIGN KEY (`address_id`)
REFERENCES `Address`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `OrderIngredients`
ADD CONSTRAINT `order_ingredients_ingredient_fk`
FOREIGN KEY (`ingredient_id`)
REFERENCES `Ingredient`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `OrderIngredients`
ADD CONSTRAINT `order_ingredients_supplier_fk`
FOREIGN KEY (`supplier_id`)
REFERENCES `Supplier`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `Pizzeria`
ADD CONSTRAINT `pizzeria_address_fk`
FOREIGN KEY (`address_id`)
REFERENCES `Address`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `Stock`
ADD CONSTRAINT `stock_pizzeria_fk`
FOREIGN KEY (`pizzeria_id`)
REFERENCES `Pizzeria`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `Stock`
ADD CONSTRAINT `stock_ingredient_fk`
FOREIGN KEY (`ingredient_id`)
REFERENCES `Ingredient`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `PizzeriaHours`
ADD CONSTRAINT `pizzeria_hours_pizzeria_fk`
FOREIGN KEY (`pizzeria_id`)
REFERENCES `Pizzeria`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `PizzeriaHours`
ADD CONSTRAINT `pizzeria_hours_hours_fk`
FOREIGN KEY (`hours_id`)
REFERENCES `Hours`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `Staff`
ADD CONSTRAINT `staff_address_fk`
FOREIGN KEY (`address_id`)
REFERENCES `Address`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `Works`
ADD CONSTRAINT `works_pizzeria_fk`
FOREIGN KEY (`pizzeria_id`)
REFERENCES `Pizzeria`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `Works`
ADD CONSTRAINT `works_staff_fk`
FOREIGN KEY (`staff_id`)
REFERENCES `Staff`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `ClientAddress`
ADD CONSTRAINT `client_address_client_fk`
FOREIGN KEY (`client_id`)
REFERENCES `Client`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `ClientAddress`
ADD CONSTRAINT `client_address_address_fk`
FOREIGN KEY (`address_id`)
REFERENCES `Address`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `Order`
ADD CONSTRAINT `order_staff_fk`
FOREIGN KEY (`staff_id`)
REFERENCES `Staff`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `Order`
ADD CONSTRAINT `order_client_fk`
FOREIGN KEY (`client_id`)
REFERENCES `Client`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `Billing`
ADD CONSTRAINT `billing_order_fk`
FOREIGN KEY (`order_id`)
REFERENCES `Order`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `Recipe`
ADD CONSTRAINT `recipe_pizza_fk`
FOREIGN KEY (`pizza_id`)
REFERENCES `Pizza`(`id`)
ON DELETE CASCADE
ON UPDATE NO ACTION;

ALTER TABLE `CommandLine`
ADD CONSTRAINT `command_line_order_fk`
FOREIGN KEY (`order_id`)
REFERENCES `Order`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `CommandLine`
ADD CONSTRAINT `command_line_pizza_fk`
FOREIGN KEY (`pizza_id`)
REFERENCES `Pizza`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `Composition`
ADD CONSTRAINT `composition_ingredient_fk`
FOREIGN KEY (`ingredient_id`)
REFERENCES `Ingredient`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE `Composition`
ADD CONSTRAINT `composition_pizza_fk`
FOREIGN KEY (`pizza_id`)
REFERENCES `Pizza`(`id`)
ON DELETE NO ACTION
ON UPDATE NO ACTION;