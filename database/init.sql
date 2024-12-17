-- Table Recommendations
CREATE TABLE Recommendations (
   Id_Recommendation SERIAL PRIMARY KEY,
   email VARCHAR(50) NOT NULL,
   name VARCHAR(25) NOT NULL,
   content VARCHAR(250) NOT NULL,
   visit_date DATE NOT NULL,
   submission_date DATE NOT NULL,
   rating DECIMAL(2,1)
);

-- Table Partnership
CREATE TABLE Partnership (
   Id_Partnership SERIAL PRIMARY KEY,
   email VARCHAR(50) NOT NULL,
   last_name VARCHAR(50) NOT NULL,
   first_name VARCHAR(50) NOT NULL,
   phone VARCHAR(50) NOT NULL,
   business_sector VARCHAR(50) NOT NULL,
   message TEXT NOT NULL,
   submission_date VARCHAR(50) NOT NULL,
   attachment_1_path VARCHAR(255),
   attachment_2_path VARCHAR(255),
   attachment_3_path VARCHAR(255)
);

-- Table Consumables
CREATE TABLE Consumables (
   Id_Consumable SERIAL PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   type VARCHAR(100) NOT NULL,
   description TEXT NOT NULL,
   temperature VARCHAR(50) NOT NULL,
   price DECIMAL(6,2) NOT NULL,
   is_vegetarian BOOLEAN NOT NULL,
   is_vegan BOOLEAN NOT NULL,
   availability BOOLEAN NOT NULL,
   allergens VARCHAR(255)
);

-- Table Users
CREATE TABLE Users (
   username VARCHAR(50) PRIMARY KEY,
   password VARCHAR(255) NOT NULL,
   permissions INT NOT NULL,
   full_name VARCHAR(255) NOT NULL,
   is_active BOOLEAN NOT NULL
);

-- Table Brunchs
CREATE TABLE Brunchs (
   Id_Brunch SERIAL PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   description TEXT NOT NULL
);

-- Table Brunch_reservations
CREATE TABLE Brunch_reservations (
   Id_Brunch_reservation SERIAL PRIMARY KEY,
   customer_name VARCHAR(50) NOT NULL,
   customer_email VARCHAR(50) NOT NULL,
   customer_phone VARCHAR(10) NOT NULL,
   company_name VARCHAR(50),
   reservation_date TIMESTAMP NOT NULL,
   number_of_people SMALLINT NOT NULL,
   created_at TIMESTAMP NOT NULL,
   table_number INT,
   Id_Brunch INT NOT NULL,
   FOREIGN KEY(Id_Brunch) REFERENCES Brunchs(Id_Brunch)
);

-- Table Consumables_orders
CREATE TABLE Consumables_orders (
   Id_Consumables_Order SERIAL PRIMARY KEY,
   table_number INT NOT NULL,
   submission_date TIMESTAMP NOT NULL
);

-- Table Brunch_orders
CREATE TABLE Brunch_orders (
   Id_Brunch_Order SERIAL PRIMARY KEY,
   submission_date TIMESTAMP NOT NULL,
   Id_Brunch_reservation INT NOT NULL,
   FOREIGN KEY(Id_Brunch_reservation) REFERENCES Brunch_reservations(Id_Brunch_reservation)
);

-- Table Brunch_items
CREATE TABLE Brunch_items (
   Id_Brunch_item SERIAL PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   course VARCHAR(50) NOT NULL,
   description TEXT,
   availability BOOLEAN NOT NULL,
   is_vegetarian BOOLEAN NOT NULL,
   is_vegan BOOLEAN NOT NULL,
   allergens TEXT,
   hidden_price DECIMAL(10,2) NOT NULL,
   Id_Brunch INT NOT NULL,
   FOREIGN KEY(Id_Brunch) REFERENCES Brunchs(Id_Brunch)
);

-- Table Consumables_ordered
CREATE TABLE Consumables_ordered (
   Id_Consumable INT NOT NULL,
   Id_Consumables_Order INT NOT NULL,
   quantity INT NOT NULL,
   PRIMARY KEY(Id_Consumable, Id_Consumables_Order),
   FOREIGN KEY(Id_Consumable) REFERENCES Consumables(Id_Consumable),
   FOREIGN KEY(Id_Consumables_Order) REFERENCES Consumables_orders(Id_Consumables_Order)
);

-- Table Brunch_orders_items
CREATE TABLE Brunch_orders_items (
   Id_Brunch_item INT NOT NULL,
   Id_Brunch_Order INT NOT NULL,
   quantity INT NOT NULL,
   PRIMARY KEY(Id_Brunch_item, Id_Brunch_Order),
   FOREIGN KEY(Id_Brunch_item) REFERENCES Brunch_items(Id_Brunch_item),
   FOREIGN KEY(Id_Brunch_Order) REFERENCES Brunch_orders(Id_Brunch_Order)
);

-- Table Brunch_items_consumables
CREATE TABLE Brunch_items_consumables (
   Id_Brunch_item INT NOT NULL,
   Id_Consumable INT NOT NULL,
   PRIMARY KEY(Id_Brunch_item, Id_Consumable),
   FOREIGN KEY(Id_Brunch_item) REFERENCES Brunch_items(Id_Brunch_item),
   FOREIGN KEY(Id_Consumable) REFERENCES Consumables(Id_Consumable)
);

-- Vue 1 : Liste des réservations avec détails du brunch et client
CREATE VIEW Reservations_Details AS
SELECT 
   br.Id_Brunch_reservation,
   br.customer_name,
   br.customer_email,
   br.reservation_date,
   br.number_of_people,
   b.name AS brunch_name,
   b.description AS brunch_description
FROM Brunch_reservations br
JOIN Brunchs b ON br.Id_Brunch = b.Id_Brunch;


-- Vue 2 : Commandes de brunch avec leurs éléments

CREATE VIEW Brunch_Orders_Details AS
SELECT 
   bo.Id_Brunch_Order,
   br.customer_name,
   br.customer_email,
   bi.name AS brunch_item_name,
   bi.course,
   bi.is_vegetarian,
   bi.is_vegan,
   bi.hidden_price,
   boi.quantity
FROM Brunch_orders bo
JOIN Brunch_orders_items boi ON bo.Id_Brunch_Order = boi.Id_Brunch_Order
JOIN Brunch_items bi ON boi.Id_Brunch_item = bi.Id_Brunch_item
JOIN Brunch_reservations br ON bo.Id_Brunch_reservation = br.Id_Brunch_reservation;

-- Vue 3 : Détails des commandes de consommables

CREATE VIEW Consumables_Orders_Details AS
SELECT 
   co.Id_Consumables_Order,
   co.table_number,
   c.name AS consumable_name,
   c.type,
   c.price,
   c.is_vegetarian,
   c.is_vegan,
   coo.quantity
FROM Consumables_orders co
JOIN Consumables_ordered coo ON co.Id_Consumables_Order = coo.Id_Consumables_Order
JOIN Consumables c ON coo.Id_Consumable = c.Id_Consumable;

