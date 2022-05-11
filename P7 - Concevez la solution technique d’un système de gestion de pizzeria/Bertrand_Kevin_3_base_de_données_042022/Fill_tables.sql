use `ocPizza`;

INSERT INTO `Address` (`road_type`, `road_name`, `street_number`, `complement`, `zip_code`, `city`, `country`, `comment`)
VALUES
("Place", "De la Pizza", "5", NULL, "75015", "Paris", "France", NULL),
("Rue", "De la gare", "245", "2ème étage", "77017", "Paris", "France", "Digicode 4453"),
("Street", "Margarita", "19", NULL, "56273", "London", "United Kingdom", NULL),
("Boulevard", "Bolognese", "55A", "1st floor", "10012", "New York", "United States", NULL),
("Corridoio", "Mozzarella", "149", NULL, "00186", "Roma", "Itala", NULL),
("Chemin", "Du bout du monde", "1", NULL, "77700", "Chessy", "France", NULL);

INSERT INTO `Supplier` (`name`, `phone_number`, `email`, `address_id`)
VALUES
("Pizz'ingredients", "+1 202-555-0432", "contact@pizz-ingredients.com", 4),
("Fruttivendoli e altro", "+32 321 3180191 ", "sales@fruttivendoli.it", 5);

INSERT INTO `Ingredient` (`name`, `unity`) 
VALUES
("eggs", NULL),
("Mozzarella", "gr"),
("Tomato", NULL),
("Peperoni", "gr"),
("Flour", "kg"),
("Emental", "kg"),
("Fromage de chèvre", "gr");

INSERT INTO `OrderIngredients` (`supplier_id`, `ingredient_id`, `quantity`, `order_date`)
VALUES
(1, 1, 300, NOW()),
(1, 4, 1000, NOW()),
(1, 5, 50, NOW()),
(2, 2, 1000, NOW()),
(2,3, 30, NOW());
 
INSERT INTO `Pizzeria`(`name`, `revenue`, `address_id`)
VALUES
("The place to eat", 52342.23, 3),
("A la bonne pizza", 34029.12, 1);

INSERT INTO `Stock`(`pizzeria_id`, `ingredient_id`, `quantity`) 
VALUES
(1, 1, 40),
(2, 5, 14.4);

INSERT INTO `Hours` (`day`, `is_open`, `opening_hour`, `closing_hour`)
VALUES
("monday", true, "11:30:00", "22:00:00"),
("tuesday", true, "11:30:00", "22:00:00"),
("wednesday", true, "11:30:00", "22:00:00"),
("thursday", true, "11:30:00", "22:00:00"),
("friday", true, "11:30:00", "23:00:00"),
("saturday", true, "11:30:00", "23:00:00"),
("sunday", false, "00:00:00", "00:00:00"),
("sunday", true, "11:00:00", "14:00:00");

INSERT INTO `PizzeriaHours` (`pizzeria_id`, `hours_id`)
VALUES
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),
(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,8);

INSERT INTO `Staff` (`position`, `firstname`, `lastname`, `email`, `phone_number`, `gender`, `password`, `address_id`)
VALUES
("manager", "Marc", "Louis", "m.louis@ocpizza.fr", "+33812738192", "man", "1234567890", 6),
("host", "Louise", "Marchal", "l.marchal@ocpizza.fr", "+33718273849", "woman", "0987654321", 2);

INSERT INTO `Works` (`pizzeria_id`, `staff_id`) 
VALUES
(1, 1),
(1, 2);

INSERT INTO `Client`(`firstname`, `lastname`, `email`, `phone_number`, `gender`, `password`)
VALUES
("Justine", "Jacques", "jus.jac@outlook.com", "+33456789012", "woman", "azerty"),
("Mathieu", "Vandervelde", "mat@gmail.com", "+33412345678", "man", "password");

INSERT INTO `ClientAddress` (`client_id`, `address_id`)
VALUES
(1, 2),
(2, 6);

INSERT INTO `Order`(`order_date`, `status`, `is_paid`, `payment_method`, `staff_id`, `client_id`)
VALUES
(NOW(), "pending", false, "cashOnDelivery", NULL, 1),
(NOW(), "delivered", false, "debitCardOnline", 2, NULL);

INSERT INTO `Billing`(`amount`, `order_id`) 
VALUES
(25.9, 2);

INSERT INTO `Pizza`(`name`, `price`, `description`)
VALUES
("Vulcano", 15.5, "Pizza base tomate et aux piments"),
("Chèvre", 14.4, "Pizza à base crème et chèvre"),
("Quatre fromages", 12.9, "Pizza base crème et 4 fromages"),
("Calzone", 13.9, "Pizza à base tomate garnie de jambon, mozzarella repliée sur elle-même");

INSERT INTO `Recipe`(`comment`, `pizza_id`)
VALUES
("Etape 1: Etaler la pâte. Etape 2: Etaler la sauce tomate. Etape 3: Placer des morceaux de piments. Etape 4: Soupoudrer de mozzarella.", 1),
("Etape 1: Etaler la pâte. Etape 2: Etaler la crème. Etape 3: Placer des morceaux chèvre.", 2),
("Etape 1: Etaler la pâte. Etape 2: Etaler la crème. Etape 3: Placer des morceaux de fromage sur l'ensemble de la pizza.", 3),
("Etape 1: Etaler la pâte. Etape 2: Etaler la sauce tomate. Etape 3: Placer des morceaux de jambon. Etape 4: Soupoudrer de mozzarella. Etape 5: Replier la pizza.", 4);

INSERT INTO `CommandLine` (`order_id`, `pizza_id`, `quantity`) 
VALUES
(1, 3, 1),
(2, 1, 1),
(2, 2, 1); 

INSERT INTO `Composition`(`pizza_id`, `ingredient_id`, `quantity`)
VALUES
(1, 2, 10),
(1, 3, 30),
(2, 7, 25),
(3, 6, 50),
(4, 3, 14);