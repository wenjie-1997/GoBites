INSERT INTO `go-bites_db`.`people`
(`id`, `firstName`, `lastName`, `birthDate`, `gender`, `age`, `title`)
VALUES
(1, "Admin", "Guy", "1999-12-31", "Male", 20, "Sir"),
(2, "Azman", "Hashim", "1997-11-21", "Male", 23, "Sir"),
(3, "Siti Aisyah", "Azree", "1987-12-21", "Female", 33, "Madam"),
(4, "Alvin", "Ivan", "1999-06-21", "Male", 21, "Mr"),
(5, "Ali", "Hussin", "1999-03-11", "Male", 21, "Mr"),
(6, "Siti Salehah", "Abdullah", "1997-06-21", "Female", 23, "Miss"),
(7, "Jonathan", "Shuuar", "1989-08-31", "Male", 31, "Mr"),
(8, "Farid", "Zainal", "1999-02-21", "Male", 21, "Mr"),
(9, "Kamarulzaman", "Zainal Abidin", "1986-02-01", "Male", 34, "Dato"),
(10, "Ridzwan", "Syah", "1980-01-01", "Male", 40, "Tan Sri"),
(11, "Siti Nur Amalina", "Azman", "1990-05-23", "Female", 30, "Madam");

INSERT INTO `go-bites_db`.`restaurants`
(`id`, `restaurantName`, `restaurantStyle`, `restaurantRating`, `restaurantTotalCustomer`)
VALUES
(1, "Kentucky Fried Chicken (KFC) Taman Sarjana", "Fast Food", 4.3, 100),
(2, "McDonald Gemilang", "Fast Food", 3.9, 160),
(3, "Nasi Ayam Kak Mala", "Contemporary Casual", 5, 50);

INSERT INTO `go-bites_db`.`addresses`
(`id`, `detailedAddress`, `city`, `state`, `zipCode`, `country`, `personId`, `restaurantId`)
VALUES
(1, "Rumah Petugas Ladang Felda Krau 02", "Lurah Bilut", "Pahang", "28800", "Malaysia", (SELECT `id` FROM people WHERE `id` = 1), null),
(2, "Taman Sarjana", "Skudai", "Johor", "28391", "Malaysia", (SELECT `id` FROM people WHERE `id` = 2), null),
(3, "Kg Bendahara", "Selayang", "Selangor", "57800", "Malaysia", (SELECT `id` FROM people WHERE `id` = 3), null),
(4, "Felda Umas 6", "Tawau", "Sabah", "32800", "Malaysia", (SELECT `id` FROM people WHERE `id` = 4), null),
(5, "Rumah Petugas Ladang Felda", "Lurah Bilut", "Pahang", "28800", "Malaysia", (SELECT `id` FROM people WHERE `id` = 5), null),
(6, "Taman Rajawali", "Dengkil", "Selangor", "57830", "Malaysia", (SELECT `id` FROM people WHERE `id` = 6), null),
(7, "Rumah Petugas Ladang Felda Umas 8", "Tawau", "Sabah", "32800", "Malaysia", (SELECT `id` FROM people WHERE `id` = 7), null),
(8, "Taman Skudai 3", "Skudai", "Johor", "28800", "Malaysia", (SELECT `id` FROM people WHERE `id` = 8), null),
(9, "Taman Sarjana 9", "Sarjana", "Perlis", "43800", "Malaysia", (SELECT `id` FROM people WHERE `id` = 9), null),
(10, "Kg Celuk", "Pasir Mas", "Kelantan", "23200", "Malaysia", (SELECT `id` FROM people WHERE `id` = 10), null),
(11, "Taman Helang 12", "Labuan", "Wilayah Persekutuan Labuan", "53200", "Malaysia", (SELECT `id` FROM people WHERE `id` = 11), null),
(12, "Taman Sarjana", "Skudai", "Johor", "28800", "Malaysia", null, (SELECT `id` FROM restaurants WHERE `id` = 1)),
(13, "No 3, Lot 4 Jalan Gemilang", "Temerloh", "Pahang", "28000", "Malaysia", null, (SELECT `id` FROM restaurants WHERE `id` = 2)),
(14, "Taman Temerloh Jaya", "Temerloh", "Pahang", "28000", "Malaysia", null, (SELECT `id` FROM restaurants WHERE `id` = 3));

INSERT INTO `go-bites_db`.`contacts`
(`id`, `email`, `telephoneNumber`, `personId`, `restaurantId`)
VALUES
( 1, "admin@gmail.com", "01122643732", (SELECT `id` FROM people WHERE `id` =  1), null),
( 2, "azman@gmail.com", "01123873622", (SELECT `id` FROM people WHERE `id` =  2), null),
( 3, "siti.aisyah@gmail.com", "0182039222", (SELECT `id` FROM people WHERE `id` =  3), null),
( 4, "alvin123.enjoy@gmail.com", "0145048362", (SELECT `id` FROM people WHERE `id` =  4), null),
( 5, "ali123.yay@yahoo.com", "0132938643", (SELECT `id` FROM people WHERE `id` =  5), null),
( 6, "salehah.siti12@gmail.com", "01174673958", (SELECT `id` FROM people WHERE `id` =  6), null),
( 7, "jonathan89@gmail.com", "01198643732", (SELECT `id` FROM people WHERE `id` =  7), null),
( 8, "farid.zainal@gmail.com", "0143746321", (SELECT `id` FROM people WHERE `id` =  8), null),
( 9, "kamarul12@gmail.com", "0127384732", (SELECT `id` FROM people WHERE `id` =  9), null),
(10, "ridzz123@gmail.com", "0153749321", (SELECT `id` FROM people WHERE `id` = 10), null),
(11, "amalina.official@gmail.com", "0182648399", (SELECT `id` FROM people WHERE `id` = 11), null),
(12, "sarjana.skudai.kfc@gmail.com", "0127438234", null, (SELECT `id` FROM restaurants WHERE `id` = 1)),
(13, "gemilang.mcd@gmail.com", "01184374743", null, (SELECT `id` FROM restaurants WHERE `id` = 2)),
(14, "nasi.ayam.kakmala@gmail.com", "0136574833", null, (SELECT `id` FROM restaurants WHERE `id` = 3));

INSERT INTO `go-bites_db`.`admin`
(`id`, `adminPrivilege`)
VALUES
(1, "View, Delete, Edit Information");

INSERT INTO `go-bites_db`.`customers`
(`id`,
`customerTotalOrderMade`)
VALUES
(1, 20),
(2, 12),
(3, 3);

INSERT INTO `go-bites_db`.`deliverydrivers`
(`id`,
`deliveryDriverDeliveryMethod`,
`deliveryDriverWorkArea`)
VALUES
(1, "Motorcycle", "Bentong, Pahang"),
(2, "Car", "Kuala Lumpur"),
(3, "Motorcycle", "Tawau, Sabah"),
(4, "Motorcycle", "Skudai, Johor");

/* dummy data for menuLists has not initialized yet */
INSERT INTO `go-bites_db`.`menulists`
(`id`,
`restaurantId`)
VALUES
(1, 1);

/* dummy data for menuItems has not initialized yet */
INSERT INTO `go-bites_db`.`menuitems`
(`id`,
`itemName`,
`itemPrice`,
`itemPhoto`,
`itemDescription`,
`menuListId`)
VALUES
(1, "itemName", "itemPrice", "itemPhoto", "itemDescription", (SELECT `id` FROM menuLists WHERE `id` =  1));

INSERT INTO `go-bites_db`.`users`
(`id`, `userName`, `userPassword`, `userType`, `personId`, `restaurantOwnerId`, `customerId`, `adminId`, `deliveryDriverId`)
VALUES
(1, "admin", "1234", "admin", (SELECT `id` FROM people WHERE `id` =  1), null, null, (SELECT `id` FROM admin WHERE `id` =  1), null),
(2, "azmanHashim", "1234", "customer", (SELECT `id` FROM people WHERE `id` =  2), null, (SELECT `id` FROM customers WHERE `id` =  1), null, null),
(3, "sitiaisyah", "1234", "customer", (SELECT `id` FROM people WHERE `id` =  3), null, (SELECT `id` FROM customers WHERE `id` =  2), null, null),
(4, "alvin", "1234", "customer", (SELECT `id` FROM people WHERE `id` =  4), null, (SELECT `id` FROM customers WHERE `id` =  3), null, null),
(5, "ali", "1234", "delivery driver", (SELECT `id` FROM people WHERE `id` =  5), null, null, null, (SELECT `id` FROM deliveryDrivers WHERE `id` =  1)),
(6, "sitisalehah", "1234", "delivery driver", (SELECT `id` FROM people WHERE `id` =  6), null, null, null, (SELECT `id` FROM deliveryDrivers WHERE `id` =  2)),
(7, "jonathan", "1234", "delivery driver", (SELECT `id` FROM people WHERE `id` =  7), null, null, null, (SELECT `id` FROM deliveryDrivers WHERE `id` =  3)),
(8, "farid", "1234", "delivery driver", (SELECT `id` FROM people WHERE `id` =  8), null, null, null, (SELECT `id` FROM deliveryDrivers WHERE `id` =  4)),
(9, "kfcsarjana", "1234", "restaurant", (SELECT `id` FROM people WHERE `id` =  9), (SELECT `id` FROM restaurants WHERE `id` =  1), null, null, null),
(10, "mcdgemilang", "1234", "restaurant", (SELECT `id` FROM people WHERE `id` =  10), (SELECT `id` FROM restaurants WHERE `id` =  2), null, null, null),
(11, "nasiayamkakmala", "1234", "restaurant", (SELECT `id` FROM people WHERE `id` =  11), (SELECT `id` FROM restaurants WHERE `id` =  3), null, null, null);
