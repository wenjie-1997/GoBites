INSERT INTO `ainalfa_go-bites-db`.`admins`
(`id`,
`adminName`,
`adminTitle`)
VALUES
(1,
"Admin",
"Sir");

INSERT INTO `ainalfa_go-bites-db`.`customers`
(`id`,
`customerName`,
`customerBirthDate`,
`customerGender`,
`customerAddress`,
`customerCity`,
`customerState`,
`customerZipCode`,
`customerCountry`,
`customerEmail`,
`customerTelephoneNo`,
`customerTotalOrderMade`)
VALUES
(1,
"Azman Hashim",
1997-11-21,
"Male",
"Taman Sarjana",
"Skudai",
"Johor",
"28800",
"Malaysia",
"azman@gmail.com",
"01123873622",
5), 
(2,
"Siti Aisyah",
1987-12-21,
"Female",
"Kg Bendahara",
"Selayang",
"Selangor",
"57800",
"Malaysia",
"siti.aisyah@gmail.com",
"0182039222",
3), 
(3,
"Alvin",
1999-06-21,
"Male",
"Felda Umas 6",
"Tawau",
"Sabah",
"32800",
"Malaysia",
"alvin123.enjoy@gmail.com",
"0145048362",
1);

INSERT INTO `ainalfa_go-bites-db`.`deliveryDrivers`
(`id`,
`deliveryDriverName`,
`deliveryDriverAge`,
`deliveryDriverGender`,
`deliveryDriverDeliveryMethod`,
`deliveryDriverWorkArea`,
`deliveryDriverAddress`,
`deliveryDriverCity`,
`deliveryDriverState`,
`deliveryDriverZipCode`,
`deliveryDriverCountry`,
`deliveryDriverEmail`,
`deliveryDriverTelephoneNo`)
VALUES
(1,
"Ali bin Hussin",
23,
"Male",
"Motorcycle",
"Bentong, Pahang",
"Rumah Petugas Ladang Felda",
"Lurah Bilut",
"pahang",
"28800",
"Malaysia",
"ali123.yay@yahoo.com",
"0132938643"),
(2,
"Siti Salehah",
23,
"Female",
"Car",
"Kuala Lumpur",
"Taman Rajawali",
"Dengkil",
"Selangor",
"57830",
"Malaysia",
"salehah.siti12@yahoo.com",
"01174673958"),
(3,
"Jonathan",
33,
"Male",
"Motorcycle",
"Tawau, Sabah",
"Rumah Petugas Ladang Felda Umas 8",
"Tawau",
"Sabah",
"32800",
"Malaysia",
"jonathan89@gmail.com",
"01198643732"),
(4,
"Farid bin Zainal",
21,
"Male",
"Motorcycle",
"Skudai, Johor",
"Taman Skudai 3",
"Skudai",
"Johor",
"28800",
"Malaysia",
"farid.zainal@gmail.com",
"0143746321");

INSERT INTO `ainalfa_go-bites-db`.`restaurants`
(`id`,
`restaurantName`,
`restaurantOwner`,
`restaurantAddress`,
`restaurantCity`,
`restaurantState`,
`restaurantZipCode`,
`restaurantCountry`,
`restaurantStyle`,
`restaurantEmail`,
`restaurantTelephoneNo`,
`restaurantRating`,
`restaurantTotalCustomer`)
VALUES
(1,
"Kentucky Fried Chicken (KFC) Taman Sarjana",
"Kamarulzaman bin Zainal Abidin",
"Taman Sarjana",
"Skudai",
"Johor",
"28800",
"Malaysia",
"Fast Food",
"sarjana.skudai.kfc@gmail.com",
"0127438234",
4.3,
100),
(2,
"McDonald Gemilang",
"Ridzwan Syah",
"No 3, Lot 4 Jalan Gemilang",
"Temerloh",
"Pahang",
"28000",
"Malaysia",
"Fast Food",
"gemilang.mcd@gmail.com",
"01184374743",
3.9,
160),
(3,
"Nasi Ayam Kak Mala",
"Siti Nur Amalina",
"Taman Temerloh Jaya",
"Temerloh",
"Pahang",
"28000",
"Malaysia",
"Contemporary Casual",
"nasi.ayam.kakmala@gmail.com",
"0136574833",
5,
50);

INSERT INTO `ainalfa_go-bites-db`.`users`
(`id`,
`userName`,
`userPassword`,
`userType`,
`restaurantId`,
`customerId`,
`adminId`,
`deliveryDriverId`)
VALUES
(1,
"admin",
"1234",
"admin",
null,
null,
(
SELECT id
FROM admins
WHERE id = 1),
null),
(2,
"azmanHashim",
"1234",
"customer",
null,
(
SELECT id
FROM customers
WHERE id = 1),
null,
null),
(3,
"sitiaisyah",
"1234",
"customer",
null,
(
SELECT id
FROM customers
WHERE id = 2),
null,
null),
(4,
"alvin",
"1234",
"customer",
null,
(
SELECT id
FROM customers
WHERE id = 3),
null,
null),
(5,
"ali",
"1234",
"delivery driver",
null,
null,
null,
(
SELECT id
FROM deliveryDrivers
WHERE id = 1)),
(6,
"sitisalehah",
"1234",
"delivery driver",
null,
null,
null,
(
SELECT id
FROM deliveryDrivers
WHERE id = 2)),
(7,
"jonathan",
"1234",
"delivery driver",
null,
null,
null,
(
SELECT id
FROM deliveryDrivers
WHERE id = 3)),
(8,
"farid",
"1234",
"delivery driver",
null,
null,
null,
(
SELECT id
FROM deliveryDrivers
WHERE id = 4)),
(9,
"kfcsarjana",
"1234",
"restaurant",
(
SELECT id
FROM restaurants
WHERE id = 1),
null,
null,
null),
(10,
"mcdgemilang",
"1234",
"restaurant",
(
SELECT id
FROM restaurants
WHERE id = 2),
null,
null,
null),
(11,
"nasiayamkakmala",
"1234",
"restaurant",
(
SELECT id
FROM restaurants
WHERE id = 3),
null,
null,
null);
