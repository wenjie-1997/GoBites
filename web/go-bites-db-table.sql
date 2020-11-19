CREATE TABLE `people` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastName` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birthDate` date NOT NULL,
  `gender` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` int NOT NULL,
  `title` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `adminPrivilege` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customerTotalOrderMade` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `deliverydrivers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `deliveryDriverDeliveryMethod` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deliveryDriverWorkArea` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `restaurants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `restaurantName` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `restaurantStyle` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `restaurantRating` float NOT NULL,
  `restaurantTotalCustomer` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `detailedAddress` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zipCode` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `personId` int DEFAULT NULL,
  `restaurantId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `personId` (`personId`),
  KEY `restaurantId` (`restaurantId`),
  CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`personId`) REFERENCES `people` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `addresses_ibfk_2` FOREIGN KEY (`restaurantId`) REFERENCES `restaurants` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `contacts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telephoneNumber` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `personId` int DEFAULT NULL,
  `restaurantId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `personId` (`personId`),
  KEY `restaurantId` (`restaurantId`),
  CONSTRAINT `contacts_ibfk_1` FOREIGN KEY (`personId`) REFERENCES `people` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `contacts_ibfk_2` FOREIGN KEY (`restaurantId`) REFERENCES `restaurants` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `menulists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `restaurantId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `restaurantId` (`restaurantId`),
  CONSTRAINT `menulists_ibfk_1` FOREIGN KEY (`restaurantId`) REFERENCES `restaurants` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `menuitems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `itemName` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `itemPrice` decimal(5,2) NOT NULL,
  `itemPhoto` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `itemDescription` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `menuListId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menuListId` (`menuListId`),
  CONSTRAINT `menuitems_ibfk_1` FOREIGN KEY (`menuListId`) REFERENCES `menulists` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userPassword` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `userType` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `personId` int DEFAULT NULL,
  `restaurantOwnerId` int DEFAULT NULL,
  `customerId` int DEFAULT NULL,
  `adminId` int DEFAULT NULL,
  `deliveryDriverId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `personId` (`personId`),
  KEY `restaurantOwnerId` (`restaurantOwnerId`),
  KEY `customerId` (`customerId`),
  KEY `adminId` (`adminId`),
  KEY `deliveryDriverId` (`deliveryDriverId`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`personId`) REFERENCES `people` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`restaurantOwnerId`) REFERENCES `restaurants` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_3` FOREIGN KEY (`customerId`) REFERENCES `customers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_4` FOREIGN KEY (`adminId`) REFERENCES `admin` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `users_ibfk_5` FOREIGN KEY (`deliveryDriverId`) REFERENCES `deliverydrivers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;