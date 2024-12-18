-- Table Logs
CREATE TABLE Logs(
   Id_Log COUNTER,
   level VARCHAR(50) NOT NULL,
   category VARCHAR(50) NOT NULL,
   short_msg VARCHAR(255) NOT NULL,
   long_msg TEXT,
   created_at DATETIME NOT NULL,
   user_id VARCHAR(50),
   PRIMARY KEY(Id_Log)
);

-- Table Recommendations
CREATE TABLE Recommendations (
   Id_Recommendation UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
   email VARCHAR(50) NOT NULL,
   name VARCHAR(25) NOT NULL,
   content VARCHAR(250) NOT NULL,
   visit_date DATE NOT NULL,
   submission_date DATE NOT NULL,
   rating DECIMAL(2,1)
);

-- Table Partnership
CREATE TABLE Partnership (
   Id_Partnership UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
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
   Id_Consumable UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
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
   Id_User UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
   username VARCHAR(50) NOT NULL,
   password VARCHAR(255) NOT NULL,
   permissions INT NOT NULL,
   full_name VARCHAR(255) NOT NULL,
   is_active BOOLEAN NOT NULL
);

-- Table Brunchs
CREATE TABLE Brunchs (
   Id_Brunch UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   description TEXT NOT NULL
);

-- Table Brunch_reservations
CREATE TABLE Brunch_reservations (
   Id_Brunch_reservation UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
   customer_name VARCHAR(50) NOT NULL,
   customer_email VARCHAR(50) NOT NULL,
   customer_phone VARCHAR(10) NOT NULL,
   company_name VARCHAR(50),
   reservation_date TIMESTAMP NOT NULL,
   number_of_people SMALLINT NOT NULL,
   created_at TIMESTAMP NOT NULL,
   table_number INT,
   Id_Brunch UUID NOT NULL,
   FOREIGN KEY(Id_Brunch) REFERENCES Brunchs(Id_Brunch)
);

-- Table Consumables_orders
CREATE TABLE Consumables_orders (
   Id_Consumables_Order UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
   table_number INT NOT NULL,
   submission_date TIMESTAMP NOT NULL
);

-- Table Brunch_orders
CREATE TABLE Brunch_orders (
   Id_Brunch_Order UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
   submission_date TIMESTAMP NOT NULL,
   Id_Brunch_reservation UUID NOT NULL,
   FOREIGN KEY(Id_Brunch_reservation) REFERENCES Brunch_reservations(Id_Brunch_reservation)
);

-- Table Brunch_items
CREATE TABLE Brunch_items (
   Id_Brunch_item UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   course VARCHAR(50) NOT NULL,
   description TEXT,
   availability BOOLEAN NOT NULL,
   is_vegetarian BOOLEAN NOT NULL,
   is_vegan BOOLEAN NOT NULL,
   allergens TEXT,
   hidden_price DECIMAL(10,2) NOT NULL,
   Id_Brunch UUID NOT NULL,
   FOREIGN KEY(Id_Brunch) REFERENCES Brunchs(Id_Brunch)
);

-- Table Consumables_ordered
CREATE TABLE Consumables_ordered (
   Id_Consumable UUID NOT NULL,
   Id_Consumables_Order UUID NOT NULL,
   quantity INT NOT NULL,
   PRIMARY KEY(Id_Consumable, Id_Consumables_Order),
   FOREIGN KEY(Id_Consumable) REFERENCES Consumables(Id_Consumable),
   FOREIGN KEY(Id_Consumables_Order) REFERENCES Consumables_orders(Id_Consumables_Order)
);

-- Table Brunch_orders_items
CREATE TABLE Brunch_orders_items (
   Id_Brunch_item UUID NOT NULL,
   Id_Brunch_Order UUID NOT NULL,
   quantity INT NOT NULL,
   PRIMARY KEY(Id_Brunch_item, Id_Brunch_Order),
   FOREIGN KEY(Id_Brunch_item) REFERENCES Brunch_items(Id_Brunch_item),
   FOREIGN KEY(Id_Brunch_Order) REFERENCES Brunch_orders(Id_Brunch_Order)
);

-- Table Brunch_items_consumables
CREATE TABLE Brunch_items_consumables (
   Id_Brunch_item UUID NOT NULL,
   Id_Consumable UUID NOT NULL,
   PRIMARY KEY(Id_Brunch_item, Id_Consumable),
   FOREIGN KEY(Id_Brunch_item) REFERENCES Brunch_items(Id_Brunch_item),
   FOREIGN KEY(Id_Consumable) REFERENCES Consumables(Id_Consumable)
);

-- Table Posts
CREATE TABLE Posts(
   Id_Post UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
   title VARCHAR(255) NOT NULL,
   slug VARCHAR(10) NOT NULL,
   content TEXT NOT NULL,
   created_at DATETIME NOT NULL,
   updated_at DATETIME,
   PRIMARY KEY(Id_Post),
   UNIQUE(slug)
);

-- Table Categories
CREATE TABLE Post_Categories(
   Id_Categorie COUNTER,
   name VARCHAR(50) NOT NULL,
   description VARCHAR(160) NOT NULL,
   slug VARCHAR(10) NOT NULL,
   PRIMARY KEY(Id_Categorie),
   UNIQUE(name),
   UNIQUE(slug)
);

-- Table Images
CREATE TABLE Post_Images(
   Id_Image UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
   img_path VARCHAR(50) NOT NULL,
   alt_text VARCHAR(155),
   PRIMARY KEY(Id_Image)
);


CREATE TABLE Posts_categories(
   Id_Post UUID,
   Id_Categorie UUID,
   PRIMARY KEY(Id_Post, Id_Categorie),
   FOREIGN KEY(Id_Post) REFERENCES Posts(Id_Post),
   FOREIGN KEY(Id_Categorie) REFERENCES Categories(Id_Categorie)
);

CREATE TABLE Posts_images(
   Id_Post UUID,
   Id_Image UUID,
   PRIMARY KEY(Id_Post, Id_Image),
   FOREIGN KEY(Id_Post) REFERENCES Posts(Id_Post),
   FOREIGN KEY(Id_Image) REFERENCES Images(Id_Image)
);
