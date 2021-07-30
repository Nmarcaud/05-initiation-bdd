-- Insertion de données dans notre bdd
-- User
INSERT INTO user (firstname, lastname, age) VALUES ('Nicolas', 'Marcaud', 23);
INSERT INTO user (firstname, lastname, age) VALUES ('Nicolas', 'Mormiche', 35);
INSERT INTO user (firstname, lastname, age) VALUES ('Nicolas', 'Brondin-Bernard', 12);
INSERT INTO user (firstname, lastname, age) VALUES ('Leandro', 'Nicolas', 30);
INSERT INTO user (firstname, lastname, age) VALUES ('Romain', 'Duris', 28);


-- Store
INSERT INTO store (name, address) VALUES ('Biocoop', 'Tours');
INSERT INTO store (name, address) VALUES ('Sur le Branche', 'Tours');
INSERT INTO store (name, address) VALUES ('Le Marché de Léopold', 'Saint-cy-sur-loire');
INSERT INTO store (name, address) VALUES ('Aurélie Fabre Institut', 'Tours');

-- Food
INSERT INTO food (name, description) VALUES ('Graines de Chia', 'Des graines de ouf !');
INSERT INTO food (name, description) VALUES ('Bananes', 'Jaune');
INSERT INTO food (name, description) VALUES ('Kiwi', 'Poilus');
INSERT INTO food (name, description) VALUES ('Brocoli', 'Mini arbre vert');


-- Tableau associatifs
-- Stock
INSERT INTO stock (food_id, store_id, quantity, price) VALUES (1,2,2,10.00);
INSERT INTO stock (food_id, store_id, quantity, price) VALUES (2,2,20,1.00);
INSERT INTO stock (food_id, store_id, quantity, price) VALUES (3,4,52,20.00);
INSERT INTO stock (food_id, store_id, quantity, price) VALUES (2,3,4,100.00);
INSERT INTO stock (food_id, store_id, quantity, price) VALUES (4,3,12,20.00);
INSERT INTO stock (food_id, store_id, quantity, price) VALUES (4,2,8,100.00);
INSERT INTO stock (food_id, store_id, quantity, price) VALUES (3,3,5,32.00);
INSERT INTO stock (food_id, store_id, quantity, price) VALUES (3,2,2,40.00);

-- Shopping cart
INSERT INTO shopping_cart (user_id, food_id, store_id, quantity) VALUES (1,1,2,2);
INSERT INTO shopping_cart (user_id, food_id, store_id, quantity) VALUES (2,2,2,20);
INSERT INTO shopping_cart (user_id, food_id, store_id, quantity) VALUES (3,3,4,52);
INSERT INTO shopping_cart (user_id, food_id, store_id, quantity) VALUES (4,2,3,4);
-- Ligne erreur (Shop n'éxiste pas)
INSERT INTO shopping_cart (user_id, food_id, store_id, quantity) VALUES (2,2,8,4);
