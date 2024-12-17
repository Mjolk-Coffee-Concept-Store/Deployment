# Récap'

## 0. Tables de la base de données

- [Recommendations](#1-recommendations)
- [Partnership](#2-partnership)
- [Users](#3-users)
- [Consumables](#4-consumables)
- [Consumables_Orders](#5-consumables_orders)
- [Consumables_ordered](#6-consumables_ordered)
- [Brunch_items](#7-brunch_items)
- [Brunchs](#8-brunchs)
- [Brunch_reservations](#9-brunch_reservations)
- [Brunchs_Orders](#10-brunchs_orders)
- [Brunchs_ordered](#11-brunchs_ordered)

## 1. Recommendations

### 1.1. Description

La table `Recommendations` permet de stocker les recommandations des utilisateurs.

| Colonnes          | Type         | Nullable | Commentaire                                           |
| ----------------- | ------------ | -------- | ----------------------------------------------------- |
| Id_Recommendation | COUNTER      | NO       | Clé primaire                                          |
| email             | VARCHAR(50)  | NO       | Permettre de contacter un appelant en cas de problème |
| name              | VARCHAR(25)  | NO       | Nom de l'appelant                                     |
| content           | VARCHAR(250) | NO       | Contenu de la recommandation                          |
| visit_date        | DATE         | NO       | Date de la visite                                     |
| submission_date   | DATE         | NO       | Date de soumission de la recommandation (automatique) |
| rating            | DECIMAL(2,1) | YES      | Note de la recommandation                             |

### 1.2. Script de création

```sql
CREATE TABLE Recommendations(
   Id_Recommendation COUNTER,
   email VARCHAR(50) NOT NULL,
   name VARCHAR(25) NOT NULL,
   content VARCHAR(250) NOT NULL,
   visit_date DATE NOT NULL,
   submission_date DATE NOT NULL,
   rating DECIMAL(2,1),
   PRIMARY KEY(Id_Recommendations)
);
```

---

## 2. Partnership

### 2.1. Description

La table `Partnership` permet de stocker les demandes de partenariat pour le café. L'appelant peut joindre jusqu'à trois fichiers à sa demande.

| Colonnes          | Type         | Nullable | Commentaire                                           |
| ----------------- | ------------ | -------- | ----------------------------------------------------- |
| Id_Partnership    | COUNTER      | NO       | Clé primaire                                          |
| email             | VARCHAR(50)  | NO       | Permettre de contacter un appelant en cas de problème |
| last_name         | VARCHAR(50)  | NO       | Nom de famille de l'appelant                          |
| first_name        | VARCHAR(50)  | NO       | Prénom de l'appelant                                  |
| phone             | VARCHAR(50)  | NO       | Numéro de téléphone de l'appelant                     |
| business_sector   | VARCHAR(50)  | NO       | Secteur d'activité de l'appelant                      |
| message           | VARCHAR(500) | NO       | Message de l'appelant                                 |
| submission_date   | DATE         | NO       | Date de soumission de la demande (automatique)        |
| attachment_1_path | VARCHAR(50)  | YES      | Chemin du premier fichier joint                       |
| attachment_2_path | VARCHAR(50)  | YES      | Chemin du deuxième fichier joint                      |
| attachment_3_path | VARCHAR(50)  | YES      | Chemin du troisième fichier joint                     |

### 2.2. Script de création

```sql
CREATE TABLE Partnership(
   Id_Partnership COUNTER,
   email VARCHAR(50) NOT NULL,
   last_name VARCHAR(50) NOT NULL,
   first_name VARCHAR(50) NOT NULL,
   phone VARCHAR(50) NOT NULL,
   business_sector VARCHAR(50) NOT NULL,
   message VARCHAR(500) NOT NULL,
   submission_date VARCHAR(50) NOT NULL,
   attachment_1_path VARCHAR(50),
   attachment_2_path VARCHAR(50),
   attachment_3_path VARCHAR(50),
   PRIMARY KEY(Id_Partnership)
);
```

---

## 3. Users

### 3.1. Description

La table `Users` permet de stocker les utilisateurs du staff du café.

| Colonnes    | Type         | Nullable | Commentaire                                                    |
| ----------- | ------------ | -------- | -------------------------------------------------------------- |
| username    | VARCHAR(50)  | NO       | Nom d'utilisateur                                              |
| password    | VARCHAR(255) | NO       | Mot de passe (hashé)                                           |
| permissions | INT          | NO       | Droits de l'utilisateur                                        |
| full_name   | VARCHAR(255) | NO       | Nom complet de l'utilisateur pour affichage dans le backoffice |
| is_active   | LOGICAL      | NO       | Permet de désactiver un utilisateur rapidement                 |

### 3.2. Script de création

```sql
CREATE TABLE users(
   username VARCHAR(50),
   password VARCHAR(255) NOT NULL,
   permissions INT NOT NULL,
   full_name VARCHAR(255) NOT NULL,
   is_active LOGICAL NOT NULL,
   PRIMARY KEY(username)
);
```

---

## 4. Consumables

### 4.1. Description

La table `Consumables` est un aglomérat de tous les produits consommables du café **excepté pour les brunchs**. Tout est envoyé dans cette table, que ce soit les boissons, les plats, les desserts qui sont catégorisés par le champ `type`.

| Colonnes      | Type          | Nullable | Commentaire                                                            |
| ------------- | ------------- | -------- | ---------------------------------------------------------------------- |
| Id_Consumable | COUNTER       | NO       | Clé primaire                                                           |
| name          | VARCHAR(255)  | NO       | Nom du produit                                                         |
| type          | VARCHAR(100)  | NO       | Type du produit (Boisson, Sucré....)                                   |
| description   | TEXT          | NO       | Description du produit                                                 |
| temperature   | VARCHAR(50)   | NO       | Température de consommation (Chaud / Froid / Les deux)                 |
| price         | DECIMAL(10,2) | NO       | Prix du produit 0.00€ à 9999.99€                                       |
| is_vegetarian | LOGICAL       | NO       | Produit végétarien                                                     |
| is_vegan      | LOGICAL       | NO       | Produit végan                                                          |
| availability  | LOGICAL       | NO       | Disponibilité du produit (Permet de le retirer de la liste facilement) |
| allergens     | VARCHAR(255)  | YES      | Description faculative des allergènes du produit                       |

### 4.2. Script de création

```sql
CREATE TABLE Consumables(
   Id_Consumable COUNTER,
   name VARCHAR(255) NOT NULL,
   type VARCHAR(100) NOT NULL,
   description TEXT NOT NULL,
   temperature VARCHAR(50) NOT NULL,
   price DECIMAL(6,2) NOT NULL,
   is_vegetarian LOGICAL NOT NULL,
   is_vegan LOGICAL NOT NULL,
   availability LOGICAL NOT NULL,
   allergens VARCHAR(255),
   PRIMARY KEY(Id_Consumables)
);
```

---

## 5. Consumables_Orders

### 5.1. Description

La table `Consumables_orders` permet de stocker les commandes de produits consommables du café. Les commandes sont faisable depuis le backoffice par le staff. Les commandes peuvent également être faites par les clients à la seule condition d'y avoir accédé depuis le QR Code de la table.

| Colonnes             | Type     | Nullable | Commentaire                                        |
| -------------------- | -------- | -------- | -------------------------------------------------- |
| Id_Consumables_Order | COUNTER  | NO       | Clé primaire                                       |
| table_number         | INT      | NO       | Numéro de la table                                 |
| submission_date      | DATETIME | NO       | Date de soumission de la réservation (automatique) |

### 5.2. Script de création

```sql
CREATE TABLE Consumables_orders(
   Id_Consumables_Order COUNTER,
   table_number INT NOT NULL,
   submission_date DATETIME NOT NULL,
   PRIMARY KEY(Id_Consumables_Order)
);
```

---

## 6. Consumables_ordered

### 6.1. Description

La table `Consumables_ordered` permet de faire le lien entre les informations de la commande et les produits commandés. Elle permet de stocker les produits comandés par les clients tout en permettant de pouvoir spécifier la quantité de chaque produit. (Cas où deux personnes commandent la même chose sur une seule commande)

| Colonnes             | Type | Nullable | Commentaire                                      |
| -------------------- | ---- | -------- | ------------------------------------------------ |
| Id_Consumable        | INT  | NO       | Clé étrangère vers la table `Consumables`        |
| Id_Consumables_Order | INT  | NO       | Clé étrangère vers la table `Consumables_orders` |
| quantity             | INT  | NO       | Quantité du produit commandé                     |

### 6.2. Script de création

```sql
CREATE TABLE Consumables_ordered(
   Id_Consumable INT,
   Id_Consumables_Order INT,
   quantity INT NOT NULL,
   PRIMARY KEY(Id_Consumable, Id_Consumables_Order),
   FOREIGN KEY(Id_Consumable) REFERENCES Consumables(Id_Consumable),
   FOREIGN KEY(Id_Consumables_Order) REFERENCES Consumables_orders(Id_Consumables_Order)
);
```

---

## 7. Brunch_items

### 7.1. Description

La table `Brunch_items` permet de stocker les _items_ composant les brunchs du café. Les _items_ sont des produits consommables pour les `Brunchs`. Les _items_ sont catégorisés par le champ `course` correspondant à l'entrée, le plat, la boisson ou le dessert.

| Colonnes       | Type          | Nullable | Commentaire                            |
| -------------- | ------------- | -------- | -------------------------------------- |
| Id_Brunch_item | COUNTER       | NO       | Clé primaire                           |
| name           | VARCHAR(255)  | NO       | Nom de l'_item_                        |
| course         | VARCHAR(50)   | NO       | Type de l'_item_                       |
| description    | TEXT          | YES      | Description de l'_item_                |
| availability   | LOGICAL       | NO       | Disponibilité de l'_item_              |
| is_vegetarian  | LOGICAL       | NO       | Produit végétarien                     |
| is_vegan       | LOGICAL       | NO       | Produit végan                          |
| allergens      | TEXT          | YES      | Description des allergènes de l'_item_ |
| hidden_price   | DECIMAL(10,2) | NO       | Prix caché de l'_item_                 |
| Id_Brunch      | INT           | NO       | Clé étrangère vers la table `Brunchs`  |

### 7.2. Script de création

```sql
CREATE TABLE Brunch_items(
   Id_Brunch_item COUNTER,
   name VARCHAR(255) NOT NULL,
   course VARCHAR(50) NOT NULL,
   description TEXT,
   availability LOGICAL NOT NULL,
   is_vegetarian LOGICAL NOT NULL,
   is_vegan LOGICAL NOT NULL,
   allergens TEXT,
   hidden_price DECIMAL(10,2) NOT NULL,
   Id_Brunch INT NOT NULL,
   PRIMARY KEY(Id_Brunch_item),
   FOREIGN KEY(Id_Brunch) REFERENCES Brunch(Id_Brunch)
);
```

---

## 8. Brunchs

### 8.1. Description

La table `Brunchs` permet de stocker les brunchs du café. Les brunchs sont des menus composés de plusieurs _items_ (boissons, plats, desserts) disponible au choix qui sont stockés dans la table `Brunch_items`.

| Colonnes    | Type         | Nullable | Commentaire           |
| ----------- | ------------ | -------- | --------------------- |
| Id_Brunch   | COUNTER      | NO       | Clé primaire          |
| name        | VARCHAR(255) | NO       | Nom du brunch         |
| description | TEXT         | NO       | Description du brunch |

### 8.2. Script de création

```sql
CREATE TABLE Brunchs(
   Id_Brunch COUNTER,
   name VARCHAR(255) NOT NULL,
   description TEXT NOT NULL,
   PRIMARY KEY(Id_Brunch)
);
```

---

## 9. Brunch_reservations

### 9.1. Description

La table `Brunch_reservations` permet de stocker les réservations de brunchs du café avec toutes les informations concernant le client.

| Colonnes              | Type        | Nullable | Commentaire                                      |
| --------------------- | ----------- | -------- | ------------------------------------------------ |
| Id_Brunch_reservation | COUNTER     | NO       | Clé primaire                                     |
| customer_name         | VARCHAR(50) | NO       | Nom du client                                    |
| customer_email        | VARCHAR(50) | NO       | Email du client                                  |
| customer_phone        | VARCHAR(10) | NO       | Téléphone du client                              |
| company_name          | VARCHAR(50) | YES      | Nom de l'entreprise du client                    |
| reservation_date      | DATETIME    | NO       | Date de la réservation                           |
| number_of_people      | BYTE        | NO       | Nombre de personnes                              |
| created_at            | DATETIME    | NO       | Date de création de la réservation (automatique) |
| table_number          | INT         | YES      | Numéro de la table                               |
| Id_Brunch             | INT         | NO       | Clé étrangère vers la table `Brunchs`            |

### 9.2. Script de création

```sql
CREATE TABLE Brunch_reservations(
   Id_Brunch_reservation COUNTER,
   customer_name VARCHAR(50) NOT NULL,
   customer_email VARCHAR(50) NOT NULL,
   customer_phone VARCHAR(10) NOT NULL,
   company_name VARCHAR(50),
   reservation_date DATETIME NOT NULL,
   number_of_people BYTE NOT NULL,
   created_at DATETIME NOT NULL,
   table_number INT,
   Id_Brunch INT NOT NULL,
   PRIMARY KEY(Id_Brunch_reservation),
   FOREIGN KEY(Id_Brunch) REFERENCES Brunchs(Id_Brunch)
);
```

---

## 10. Brunchs_Orders

### 10.1. Description

La table `Brunchs_Orders` permet de stocker les commandes de brunchs du café. Les commandes ne sont faisable que depuis le backoffice par le staff. Ces dernières ont besoin d'être associées à une réservation de brunchs pour une meilleure tracabilité de l'historique des commandes.

| Colonnes              | Type     | Nullable | Commentaire                                       |
| --------------------- | -------- | -------- | ------------------------------------------------- |
| Id_Brunch_Order       | COUNTER  | NO       | Clé primaire                                      |
| submission_date       | DATETIME | NO       | Date de soumission de la commande (automatique)   |
| Id_Brunch_reservation | INT      | NO       | Clé étrangère vers la table `Brunch_reservations` |

### 10.2. Script de création

```sql
CREATE TABLE Brunch_orders(
   Id_Brunch_Order COUNTER,
   submission_date DATETIME NOT NULL,
   Id_Brunch_reservations INT NOT NULL,
   PRIMARY KEY(Id_Brunch_Order),
   FOREIGN KEY(Id_Brunch_reservation) REFERENCES Brunch_reservations(Id_Brunch_reservation)
);
```

---

## 11. Brunchs_ordered

### 11.1. Description

La table `Brunchs_ordered` permet de faire le lien entre les informations de la commande et les _items_ commandés. Elle permet de stocker les _items_ commandés par les clients ainsi que la quantité de chaque _item_ commandé. Une commande doit contenir au minimum un `Brunch_item`. Dans l'idée, une commande de brunch peut alors en théorie contenir:

- Cas classique: 1 entrée, 1 plat, 1 boisson et 1 dessert
- n boissons (pour faire des compléments aux menus de base...)

La colonne quantity n'est alors utile que pour les compléments, ou bien si deux personnes commandent la même chose sur une seule commande si le serveur veut optimiser la prise de commande.

| Colonnes        | Type | Nullable | Commentaire                                 |
| --------------- | ---- | -------- | ------------------------------------------- |
| Id_Brunch_item  | INT  | NO       | Clé étrangère vers la table `Brunch_items`  |
| Id_Brunch_Order | INT  | NO       | Clé étrangère vers la table `Brunch_orders` |
| quantity        | INT  | NO       | Quantité de l'_item_ commandé               |

### 11.2. Script de création

```sql
CREATE TABLE Brunch_orders_items(
   Id_Brunch_items INT,
   Id_Brunch_Orders INT,
   quantity INT NOT NULL,
   PRIMARY KEY(Id_Brunch_item, Id_Brunch_Order),
   FOREIGN KEY(Id_Brunch_item) REFERENCES Brunch_items(Id_Brunch_item),
   FOREIGN KEY(Id_Brunch_Order) REFERENCES Brunch_orders(Id_Brunch_Order)
);
```

---

## 12. Brunch_orders_consumables

### 12.1. Description

La table `Brunch_orders_consumables` permet de faire le lien entre les informations de la commande et les produits consommables commandés. Elle permet de stocker les produits commandés en surplus par rapport aux _items_ commandés.

| Colonnes        | Type | Nullable | Commentaire                                 |
| --------------- | ---- | -------- | ------------------------------------------- |
| Id_Consumable   | INT  | NO       | Clé étrangère vers la table `Consumables`   |
| Id_Brunch_Order | INT  | NO       | Clé étrangère vers la table `Brunch_orders` |
| quantity        | INT  | NO       | Quantité du produit commandé                |

### 12.2. Script de création

```sql
CREATE TABLE Brunch_orders_consumables(
   Id_Consumable INT,
   Id_Brunch_Order INT,
   quantity INT NOT NULL,
   PRIMARY KEY(Id_Consumable, Id_Brunch_Order),
   FOREIGN KEY(Id_Consumable) REFERENCES Consumables(Id_Consumable),
   FOREIGN KEY(Id_Brunch_Order) REFERENCES Brunch_orders(Id_Brunch_Order)
);
```
