/*
SQLyog Community v13.2.1 (64 bit)
MySQL - 10.4.32-MariaDB : Database - inventory_management
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`inventory_management` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `inventory_management`;

/*Table structure for table `account_emailaddress` */

DROP TABLE IF EXISTS `account_emailaddress`;

CREATE TABLE `account_emailaddress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_emailaddress_user_id_email_987c8728_uniq` (`user_id`,`email`),
  KEY `account_emailaddress_email_03be32b2` (`email`),
  CONSTRAINT `account_emailaddress_user_id_2c513194_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `account_emailaddress` */

/*Table structure for table `account_emailconfirmation` */

DROP TABLE IF EXISTS `account_emailconfirmation`;

CREATE TABLE `account_emailconfirmation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `sent` datetime(6) DEFAULT NULL,
  `key` varchar(64) NOT NULL,
  `email_address_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` (`email_address_id`),
  CONSTRAINT `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `account_emailconfirmation` */

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add category',7,'add_category'),
(26,'Can change category',7,'change_category'),
(27,'Can delete category',7,'delete_category'),
(28,'Can view category',7,'view_category'),
(29,'Can add item',8,'add_item'),
(30,'Can change item',8,'change_item'),
(31,'Can delete item',8,'delete_item'),
(32,'Can view item',8,'view_item'),
(33,'Can add supplier',9,'add_supplier'),
(34,'Can change supplier',9,'change_supplier'),
(35,'Can delete supplier',9,'delete_supplier'),
(36,'Can view supplier',9,'view_supplier'),
(37,'Can add customer',10,'add_customer'),
(38,'Can change customer',10,'change_customer'),
(39,'Can delete customer',10,'delete_customer'),
(40,'Can view customer',10,'view_customer'),
(41,'Can add order',11,'add_order'),
(42,'Can change order',11,'change_order'),
(43,'Can delete order',11,'delete_order'),
(44,'Can view order',11,'view_order'),
(45,'Can add order item',12,'add_orderitem'),
(46,'Can change order item',12,'change_orderitem'),
(47,'Can delete order item',12,'delete_orderitem'),
(48,'Can view order item',12,'view_orderitem'),
(49,'Can add warehouse',13,'add_warehouse'),
(50,'Can change warehouse',13,'change_warehouse'),
(51,'Can delete warehouse',13,'delete_warehouse'),
(52,'Can view warehouse',13,'view_warehouse'),
(53,'Can add inventory',14,'add_inventory'),
(54,'Can change inventory',14,'change_inventory'),
(55,'Can delete inventory',14,'delete_inventory'),
(56,'Can view inventory',14,'view_inventory'),
(57,'Can add user',15,'add_user'),
(58,'Can change user',15,'change_user'),
(59,'Can delete user',15,'delete_user'),
(60,'Can view user',15,'view_user'),
(61,'Can add sale item',16,'add_saleitem'),
(62,'Can change sale item',16,'change_saleitem'),
(63,'Can delete sale item',16,'delete_saleitem'),
(64,'Can view sale item',16,'view_saleitem'),
(65,'Can add customer',17,'add_customer'),
(66,'Can change customer',17,'change_customer'),
(67,'Can delete customer',17,'delete_customer'),
(68,'Can view customer',17,'view_customer'),
(69,'Can add sale',18,'add_sale'),
(70,'Can change sale',18,'change_sale'),
(71,'Can delete sale',18,'delete_sale'),
(72,'Can view sale',18,'view_sale'),
(73,'Can add site',19,'add_site'),
(74,'Can change site',19,'change_site'),
(75,'Can delete site',19,'delete_site'),
(76,'Can view site',19,'view_site'),
(77,'Can add email address',20,'add_emailaddress'),
(78,'Can change email address',20,'change_emailaddress'),
(79,'Can delete email address',20,'delete_emailaddress'),
(80,'Can view email address',20,'view_emailaddress'),
(81,'Can add email confirmation',21,'add_emailconfirmation'),
(82,'Can change email confirmation',21,'change_emailconfirmation'),
(83,'Can delete email confirmation',21,'delete_emailconfirmation'),
(84,'Can view email confirmation',21,'view_emailconfirmation'),
(85,'Can add social account',22,'add_socialaccount'),
(86,'Can change social account',22,'change_socialaccount'),
(87,'Can delete social account',22,'delete_socialaccount'),
(88,'Can view social account',22,'view_socialaccount'),
(89,'Can add social application',23,'add_socialapp'),
(90,'Can change social application',23,'change_socialapp'),
(91,'Can delete social application',23,'delete_socialapp'),
(92,'Can view social application',23,'view_socialapp'),
(93,'Can add social application token',24,'add_socialtoken'),
(94,'Can change social application token',24,'change_socialtoken'),
(95,'Can delete social application token',24,'delete_socialtoken'),
(96,'Can view social application token',24,'view_socialtoken');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values 
(1,'pbkdf2_sha256$720000$KXngRwVILh71f9aJ1PrehH$LRG1KGqalN3RaU34bdF2SUPBsU0Bj0lqyRKvQE2C/Ls=','2024-08-17 21:36:53.372892',1,'emmanuel','','','emmanuelokoth2002@gmail.com',1,1,'2024-06-11 12:52:04.118215'),
(2,'pbkdf2_sha256$720000$WM7NJVpsGxnBbZVHyFcTqo$oEYbf5NycZ6wqhq0GF04ilitmfSfEkRcCZQLLRzIxXQ=','2024-08-13 20:24:32.300578',0,'okoth','','','emmanuelokoth2002@gmail.com',0,1,'2024-07-14 19:28:09.166922'),
(3,'pbkdf2_sha256$720000$77LapvpHVRzGibiKaZVPe1$d/IXY/JY6+ScEskkK4kaA7wUU7YONaV0+gny5r9As4g=','2024-07-21 19:46:49.086667',0,'peter','','','peter@gmail.com',0,1,'2024-07-14 21:00:28.363355'),
(4,'pbkdf2_sha256$720000$W8rXWCvl05dLrIk84pRySZ$XRztJfYtFvEd0PaDInND5dQ1fYZCd+Op+yJ0ZaKPZA4=','2024-08-13 20:07:09.482713',1,'admin','','','',1,1,'2024-08-09 11:59:55.238648'),
(5,'pbkdf2_sha256$720000$PuUedLQUzfZmoeXj4l1tAQ$WuFSFE4ur571TqfbVl/gDzf0uN/+E8dHZ3OpYF2YTgA=','2024-08-13 20:15:44.312986',0,'edward','','','edwardakelo4@gmail.com',0,1,'2024-08-13 20:12:33.134385'),
(6,'pbkdf2_sha256$720000$HZpXIESyUOhQVVcsrm2tiE$ZYxP0HqBKho/gERgUBgtAASzKYLTFcIOlLaHyRnsdhs=','2024-08-13 20:17:26.676252',0,'otieno','','','emmanuelotieno2002@gmail.com',0,1,'2024-08-13 20:17:12.769770');

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `customers_customer` */

DROP TABLE IF EXISTS `customers_customer`;

CREATE TABLE `customers_customer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `address` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `customers_customer` */

insert  into `customers_customer`(`id`,`created_at`,`updated_at`,`name`,`email`,`phone`,`address`) values 
(1,'2024-06-11 13:04:27.918569','2024-06-11 13:04:27.918569','Grace','grace@gmail.com','072345678','Kiambu'),
(2,'2024-06-11 17:04:25.374613','2024-06-11 17:04:25.374613','Alice Smith','alice.smith@example.com','5551234567','789 Customer Road'),
(3,'2024-06-11 17:04:25.726196','2024-06-11 17:04:25.726196','Bob Johnson','bob.johnson@example.com','5559876543','321 Customer Lane');

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `django_admin_log` */

insert  into `django_admin_log`(`id`,`action_time`,`object_id`,`object_repr`,`action_flag`,`change_message`,`content_type_id`,`user_id`) values 
(1,'2024-06-11 12:59:24.287941','1','otieno',1,'[{\"added\": {}}]',15,1),
(2,'2024-06-11 13:02:30.038233','1','techsupplier',1,'[{\"added\": {}}]',9,1),
(3,'2024-06-11 13:03:52.778897','1','Main Warehouse',1,'[{\"added\": {}}]',13,1),
(4,'2024-06-11 13:04:27.995806','1','Grace',1,'[{\"added\": {}}]',10,1),
(5,'2024-06-11 13:11:01.669202','2','sacco',1,'[{\"added\": {}}]',15,1),
(6,'2024-06-11 17:17:55.095730','1','Laptop',1,'[{\"added\": {}}]',8,1),
(7,'2024-06-11 17:19:58.583317','2','Office Chair',1,'[{\"added\": {}}]',8,1),
(8,'2024-06-11 17:20:46.157213','1','Laptop in Main Warehouse',1,'[{\"added\": {}}]',14,1),
(9,'2024-06-11 17:21:04.383194','2','Office Chair in Main Warehouse',1,'[{\"added\": {}}]',14,1),
(10,'2024-06-11 17:22:02.558749','3','Order #3 - Grace',1,'[{\"added\": {}}]',11,1),
(11,'2024-06-11 17:22:26.037961','4','Order #4 - Alice Smith',1,'[{\"added\": {}}]',11,1),
(12,'2024-06-11 17:23:41.708005','1','10 of Laptop for Order #1',1,'[{\"added\": {}}]',12,1),
(13,'2024-06-11 17:24:21.078912','2','10 of Office Chair for Order #2',1,'[{\"added\": {}}]',12,1),
(14,'2024-06-26 10:42:27.319645','3','mouse',1,'[{\"added\": {}}]',8,1),
(15,'2024-06-26 10:48:45.317608','3','mouse',2,'[]',8,1),
(16,'2024-06-26 10:50:23.394935','1','Laptop',2,'[{\"changed\": {\"fields\": [\"Stock\", \"Image\"]}}]',8,1),
(17,'2024-06-26 10:51:58.636366','2','Office Chair',2,'[{\"changed\": {\"fields\": [\"Stock\", \"Image\"]}}]',8,1);

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(20,'account','emailaddress'),
(21,'account','emailconfirmation'),
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(10,'customers','customer'),
(14,'inventory','inventory'),
(13,'inventory','warehouse'),
(11,'orders','order'),
(12,'orders','orderitem'),
(17,'pos','customer'),
(18,'pos','sale'),
(16,'pos','saleitem'),
(7,'products','category'),
(8,'products','item'),
(6,'sessions','session'),
(19,'sites','site'),
(22,'socialaccount','socialaccount'),
(23,'socialaccount','socialapp'),
(24,'socialaccount','socialtoken'),
(9,'suppliers','supplier'),
(15,'users','user');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2024-06-11 07:39:14.629639'),
(2,'auth','0001_initial','2024-06-11 07:39:29.148821'),
(3,'admin','0001_initial','2024-06-11 07:39:34.653017'),
(4,'admin','0002_logentry_remove_auto_add','2024-06-11 07:39:34.961340'),
(5,'admin','0003_logentry_add_action_flag_choices','2024-06-11 07:39:35.190348'),
(6,'contenttypes','0002_remove_content_type_name','2024-06-11 07:39:37.367535'),
(7,'auth','0002_alter_permission_name_max_length','2024-06-11 07:39:41.715918'),
(8,'auth','0003_alter_user_email_max_length','2024-06-11 07:39:42.545498'),
(9,'auth','0004_alter_user_username_opts','2024-06-11 07:39:42.747333'),
(10,'auth','0005_alter_user_last_login_null','2024-06-11 07:39:44.928407'),
(11,'auth','0006_require_contenttypes_0002','2024-06-11 07:39:45.185405'),
(12,'auth','0007_alter_validators_add_error_messages','2024-06-11 07:39:45.388407'),
(13,'auth','0008_alter_user_username_max_length','2024-06-11 07:39:45.844844'),
(14,'auth','0009_alter_user_last_name_max_length','2024-06-11 07:39:46.097403'),
(15,'auth','0010_alter_group_name_max_length','2024-06-11 07:39:46.622228'),
(16,'auth','0011_update_proxy_permissions','2024-06-11 07:39:46.772600'),
(17,'auth','0012_alter_user_first_name_max_length','2024-06-11 07:39:47.371676'),
(18,'sessions','0001_initial','2024-06-11 07:39:49.236555'),
(19,'products','0001_initial','2024-06-11 07:56:44.224838'),
(20,'suppliers','0001_initial','2024-06-11 11:54:08.955019'),
(21,'customers','0001_initial','2024-06-11 12:13:55.466032'),
(22,'inventory','0001_initial','2024-06-11 12:13:58.344038'),
(23,'orders','0001_initial','2024-06-11 12:14:01.899102'),
(24,'users','0001_initial','2024-06-11 12:50:19.805674'),
(25,'products','0002_item_image_item_stock','2024-06-26 09:39:21.373243'),
(26,'inventory','0002_alter_inventory_item_alter_inventory_warehouse','2024-06-29 11:55:26.762940'),
(27,'pos','0001_initial','2024-06-29 13:58:08.020816'),
(28,'pos','0002_remove_sale_customer_remove_sale_date_and_more','2024-06-30 02:28:32.430173'),
(29,'products','0003_remove_item_stock','2024-07-04 19:47:25.477329'),
(30,'users','0002_alter_user_email','2024-07-13 20:32:21.917743'),
(31,'account','0001_initial','2024-07-14 11:19:16.541354'),
(32,'account','0002_email_max_length','2024-07-14 11:19:16.682362'),
(33,'account','0003_alter_emailaddress_create_unique_verified_email','2024-07-14 11:19:17.112770'),
(34,'account','0004_alter_emailaddress_drop_unique_email','2024-07-14 11:19:19.214528'),
(35,'account','0005_emailaddress_idx_upper_email','2024-07-14 11:19:19.315750'),
(36,'account','0006_emailaddress_lower','2024-07-14 11:19:19.486735'),
(37,'account','0007_emailaddress_idx_email','2024-07-14 11:19:19.782540'),
(38,'account','0008_emailaddress_unique_primary_email_fixup','2024-07-14 11:19:19.929587'),
(39,'account','0009_emailaddress_unique_primary_email','2024-07-14 11:19:20.027805'),
(40,'sites','0001_initial','2024-07-14 11:19:20.540092'),
(41,'sites','0002_alter_domain_unique','2024-07-14 11:19:20.766905'),
(42,'socialaccount','0001_initial','2024-07-14 11:19:29.074561'),
(43,'socialaccount','0002_token_max_lengths','2024-07-14 11:19:29.514540'),
(44,'socialaccount','0003_extra_data_default_dict','2024-07-14 11:19:29.591022'),
(45,'socialaccount','0004_app_provider_id_settings','2024-07-14 11:19:30.235035'),
(46,'socialaccount','0005_socialtoken_nullable_app','2024-07-14 11:19:33.953631'),
(47,'socialaccount','0006_alter_socialaccount_extra_data','2024-07-14 11:19:34.919532');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('0u0mq5ygy2gwu88vzxw3f9w9y7ga7htl','.eJxVjDsOwjAQBe_iGllx_Kekzxks27uLA8iR4qRC3J1YSgHtzLz3ZiHuWwl7wzXMwK5MsMsvSzE_sXYBj1jvC89L3dY58Z7w0zY-LYCv29n-HZTYyrHGqJEyAWGUzpLTflRe6UQIPsnBJxjJSOMGDU7ajsWh0QpyyqBO7PMFGF84vw:1sH1fo:Jd1vfRADIhO1QVCj0DU5zzyJb-EOhepSWlk9f89M80Q','2024-06-25 13:36:28.449229'),
('1zzx5qyf8imv1q5lu7oezoauo5k6j1wq','.eJxVjDsOwjAQBe_iGllx_Kekzxks27uLA8iR4qRC3J1YSgHtzLz3ZiHuWwl7wzXMwK5MsMsvSzE_sXYBj1jvC89L3dY58Z7w0zY-LYCv29n-HZTYyrHGqJEyAWGUzpLTflRe6UQIPsnBJxjJSOMGDU7ajsWh0QpyyqBO7PMFGF84vw:1sfR6T:UK7cOBp__GdCD4K7y-kXlVxbq99HZ4xL5xgORR4DVmA','2024-08-31 21:36:53.845912'),
('9krt3bu2xelu8ze6392rj33l1ob6cy8q','e30:1sT4tQ:Ewj-BLZcrykLEACtt0ygVDlGAellbGuvIyS5W1TWHxE','2024-07-28 19:28:20.675887'),
('e9eklfk338ryw9sga32odsmu3mylofuq','.eJxVjDsOwjAQBe_iGllx_Kekzxks27uLA8iR4qRC3J1YSgHtzLz3ZiHuWwl7wzXMwK5MsMsvSzE_sXYBj1jvC89L3dY58Z7w0zY-LYCv29n-HZTYyrHGqJEyAWGUzpLTflRe6UQIPsnBJxjJSOMGDU7ajsWh0QpyyqBO7PMFGF84vw:1sXenl:_SFC1tasX7LimstKuy5PJ8CoaIbCl386JMHqprRwUe0','2024-08-10 10:37:25.544783'),
('i0vwu2d6nf316pqnkqqbnw3ihsgbzvdh','.eJxVjLsOwjAMAP8lM4pcNy8Y2fmGyqkdUkCJ1LQT4t9RpA6w3p3urSbatzztTdZpYXVRRp1-WaT5KaULflC5Vz3Xsq1L1D3Rh236Vlle16P9G2RquW8JMI2WDDPPYBHBC1o3sMGRBn8GQYMxivMmQEiQAoDlNAi45LxL6vMFy_c3MA:1scjI2:KdMbBeRpePgiwg4IfAhAQKOGuplg9VG4S1WNrYPlzL4','2024-08-24 10:25:38.248221'),
('i7xe5jwdzwd36d7v96ltlw7wxvu5k6ov','.eJxVjMEOwiAQRP-FsyFAuwt49O43kIWlUjU0Ke3J-O9K0oPeJvPezEsE2rcS9pbXMLM4CxSn3y5SeuTaAd-p3haZlrqtc5RdkQdt8rpwfl4O9--gUCt9PTJMzkcGz8YyqgiTYc8KBkgpof4m8kPWCjCCBrSjcxrYkjaoHIv3B-n1N04:1sSy6t:5-ugghZpumB2rmsTPt9qUN48A6SfCFgNaBOafEDaLac','2024-07-28 12:13:47.200270'),
('oriwfactcfsfpp6amzuwd55tmnu98bwf','.eJxVjDsOwjAQBe_iGllx_Kekzxks27uLA8iR4qRC3J1YSgHtzLz3ZiHuWwl7wzXMwK5MsMsvSzE_sXYBj1jvC89L3dY58Z7w0zY-LYCv29n-HZTYyrHGqJEyAWGUzpLTflRe6UQIPsnBJxjJSOMGDU7ajsWh0QpyyqBO7PMFGF84vw:1sWb22:AZdLihbGqzcIln9qBjKyOiOJu9Oc1CaOJWUQYZiZdsM','2024-08-07 12:23:46.766460'),
('rgzc0gqndujfi2evupfp24xgyrc0346t','.eJxVjDsOwjAQBe_iGllx_Kekzxks27uLA8iR4qRC3J1YSgHtzLz3ZiHuWwl7wzXMwK5MsMsvSzE_sXYBj1jvC89L3dY58Z7w0zY-LYCv29n-HZTYyrHGqJEyAWGUzpLTflRe6UQIPsnBJxjJSOMGDU7ajsWh0QpyyqBO7PMFGF84vw:1sMQ3w:MPfoY2k4A4XcKWLELuhZ2xH8CQJdNh9Q2JXxccOk7A0','2024-07-10 10:39:40.776452'),
('s9wlv10acwsvk5w26pqyl95i165yce28','.eJxVjLsOwjAMAP8lM4pcNy8Y2fmGyqkdUkCJ1LQT4t9RpA6w3p3urSbatzztTdZpYXVRRp1-WaT5KaULflC5Vz3Xsq1L1D3Rh236Vlle16P9G2RquW8JMI2WDDPPYBHBC1o3sMGRBn8GQYMxivMmQEiQAoDlNAi45LxL6vMFy_c3MA:1scOeh:5BGcU0NQggtzXcgh6P-hxyX9LkMLX9qWD_GsbPLm4iM','2024-08-23 12:23:39.439363'),
('sdn3lsaqkdbl4oddc948nwjhdfhyymq6','.eJxVjLsOwjAMAP8lM4pcNy8Y2fmGyqkdUkCJ1LQT4t9RpA6w3p3urSbatzztTdZpYXVRRp1-WaT5KaULflC5Vz3Xsq1L1D3Rh236Vlle16P9G2RquW8JMI2WDDPPYBHBC1o3sMGRBn8GQYMxivMmQEiQAoDlNAi45LxL6vMFy_c3MA:1scOef:Oz0rL79gCEvjglfJAiRLDzMGvExYC8hvPdMiT2bUEWI','2024-08-23 12:23:37.509365'),
('vprf4cxysrm0yjbyppt0enm7vq7xi00f','e30:1sT4vY:yQeJ_7LYHtBs2LdMofx-qSr2yhL6cjGob4Qr9cLUxGU','2024-07-28 19:30:32.466709'),
('wzpgceuvd77xto54wucdvx0rrscnmcwz','.eJxVjDsOwjAQBe_iGllx_Kekzxks27uLA8iR4qRC3J1YSgHtzLz3ZiHuWwl7wzXMwK5MsMsvSzE_sXYBj1jvC89L3dY58Z7w0zY-LYCv29n-HZTYyrHGqJEyAWGUzpLTflRe6UQIPsnBJxjJSOMGDU7ajsWh0QpyyqBO7PMFGF84vw:1sH107:aS385F-pElZRAwuXE0UmdTD-NBCbuvmCvmkIwqOJsTc','2024-06-25 12:53:23.093476');

/*Table structure for table `django_site` */

DROP TABLE IF EXISTS `django_site`;

CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `django_site` */

insert  into `django_site`(`id`,`domain`,`name`) values 
(1,'example.com','example.com');

/*Table structure for table `inventory_inventory` */

DROP TABLE IF EXISTS `inventory_inventory`;

CREATE TABLE `inventory_inventory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `quantity` int(10) unsigned NOT NULL CHECK (`quantity` >= 0),
  `reorder_level` int(10) unsigned NOT NULL CHECK (`reorder_level` >= 0),
  `item_id` bigint(20) NOT NULL,
  `warehouse_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `inventory_inventory_item_id_c77b66a4_fk_products_item_id` (`item_id`),
  KEY `inventory_inventory_warehouse_id_fadd9d8c_fk_inventory` (`warehouse_id`),
  CONSTRAINT `inventory_inventory_item_id_c77b66a4_fk_products_item_id` FOREIGN KEY (`item_id`) REFERENCES `products_item` (`id`),
  CONSTRAINT `inventory_inventory_warehouse_id_fadd9d8c_fk_inventory` FOREIGN KEY (`warehouse_id`) REFERENCES `inventory_warehouse` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `inventory_inventory` */

insert  into `inventory_inventory`(`id`,`created_at`,`updated_at`,`quantity`,`reorder_level`,`item_id`,`warehouse_id`) values 
(2,'2024-06-11 17:21:04.335203','2024-08-17 21:44:31.531630',45,20,2,2),
(5,'2024-07-05 06:54:32.017031','2024-08-14 08:25:04.546547',0,10,10,4),
(6,'2024-07-17 21:06:27.175951','2024-08-17 21:44:31.546635',80,10,11,4),
(7,'2024-07-17 21:09:37.457268','2024-08-14 09:08:29.961057',30,5,12,4),
(8,'2024-07-22 11:14:26.038020','2024-08-14 08:25:04.650553',0,5,13,4);

/*Table structure for table `inventory_warehouse` */

DROP TABLE IF EXISTS `inventory_warehouse`;

CREATE TABLE `inventory_warehouse` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `inventory_warehouse` */

insert  into `inventory_warehouse`(`id`,`created_at`,`updated_at`,`name`,`location`) values 
(1,'2024-06-11 13:03:52.678890','2024-06-11 13:03:52.678890','Main Warehouse','Nairobi'),
(2,'2024-06-11 17:06:25.559734','2024-06-11 17:06:25.559734','Mains Warehouse','123 Warehouse Ave'),
(3,'2024-06-11 17:06:25.731737','2024-06-11 17:06:25.731737','Secondary Warehouse','456 Warehouse Blvd'),
(4,'2024-07-04 19:36:56.655085','2024-07-04 19:36:56.655085','Default Warehouse','Default Location');

/*Table structure for table `orders_order` */

DROP TABLE IF EXISTS `orders_order`;

CREATE TABLE `orders_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `order_date` datetime(6) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `status` varchar(50) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_order_customer_id_0b76f6a4_fk_customers_customer_id` (`customer_id`),
  CONSTRAINT `orders_order_customer_id_0b76f6a4_fk_customers_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers_customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `orders_order` */

insert  into `orders_order`(`id`,`created_at`,`updated_at`,`order_date`,`total_amount`,`status`,`customer_id`) values 
(1,'2024-06-11 17:05:32.832917','2024-06-11 17:05:32.832917','2024-06-11 17:05:32.832917',1150.00,'Pending',2),
(2,'2024-06-11 17:05:33.093882','2024-06-11 17:05:33.094885','2024-06-11 17:05:33.094885',150.00,'Completed',3),
(3,'2024-06-11 17:22:02.537744','2024-06-11 17:22:02.537744','2024-06-11 17:22:02.537744',2000.00,'Completed',1),
(4,'2024-06-11 17:22:26.004964','2024-06-11 17:22:26.004964','2024-06-11 17:22:26.004964',1050.00,'Pending',2);

/*Table structure for table `orders_orderitem` */

DROP TABLE IF EXISTS `orders_orderitem`;

CREATE TABLE `orders_orderitem` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `quantity` int(10) unsigned NOT NULL CHECK (`quantity` >= 0),
  `price` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_orderitem_item_id_0f65da43_fk_products_item_id` (`item_id`),
  KEY `orders_orderitem_order_id_fe61a34d_fk_orders_order_id` (`order_id`),
  CONSTRAINT `orders_orderitem_item_id_0f65da43_fk_products_item_id` FOREIGN KEY (`item_id`) REFERENCES `products_item` (`id`),
  CONSTRAINT `orders_orderitem_order_id_fe61a34d_fk_orders_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `orders_orderitem` */

insert  into `orders_orderitem`(`id`,`created_at`,`updated_at`,`quantity`,`price`,`total`,`item_id`,`order_id`) values 
(2,'2024-06-11 17:24:21.025941','2024-06-11 17:24:21.025941',10,10000.00,100000.00,2,2);

/*Table structure for table `pos_sale` */

DROP TABLE IF EXISTS `pos_sale`;

CREATE TABLE `pos_sale` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `customer_contact` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `payment_method` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pos_sale` */

insert  into `pos_sale`(`id`,`created_at`,`updated_at`,`total_amount`,`customer_contact`,`customer_name`,`payment_method`) values 
(1,'2024-06-29 14:06:22.368761','2024-06-29 14:06:22.368761',0.00,NULL,NULL,'cash'),
(2,'2024-06-29 14:10:45.495493','2024-06-29 14:10:45.495493',0.00,NULL,NULL,'cash'),
(3,'2024-06-29 14:12:26.210675','2024-06-29 14:12:26.211672',0.00,NULL,NULL,'cash'),
(4,'2024-06-29 14:14:36.299387','2024-06-29 14:14:36.299387',0.00,NULL,NULL,'cash'),
(5,'2024-06-29 14:15:46.464319','2024-06-29 14:15:46.464319',0.00,NULL,NULL,'cash'),
(6,'2024-06-29 14:16:18.380245','2024-06-29 14:18:08.187771',6000.00,NULL,NULL,'cash'),
(7,'2024-06-29 14:26:20.318956','2024-06-29 14:26:33.300808',600.00,NULL,NULL,'cash'),
(8,'2024-06-30 02:32:22.291723','2024-06-30 02:32:22.291723',120000.00,'','','cash'),
(9,'2024-07-06 10:10:20.304102','2024-07-06 10:10:20.304982',12000.00,'','','cash'),
(10,'2024-07-06 10:10:24.152816','2024-07-06 10:10:24.152816',12000.00,'','','cash'),
(11,'2024-07-06 10:10:24.338806','2024-07-06 10:10:24.338806',12000.00,'','','cash'),
(12,'2024-07-06 10:10:32.558689','2024-07-06 10:10:32.558689',12000.00,'','','cash'),
(13,'2024-07-06 10:11:19.512245','2024-07-06 10:11:19.512245',22000.00,'','','cash'),
(14,'2024-07-09 02:11:44.530593','2024-07-09 02:11:44.530593',14000.00,'','','cash'),
(15,'2024-07-09 02:11:47.446196','2024-07-09 02:11:47.446196',14000.00,'','','cash'),
(16,'2024-07-13 19:38:27.945564','2024-07-13 19:38:27.945564',10000.00,'','','cash'),
(17,'2024-07-13 19:50:13.597814','2024-07-13 19:50:13.597814',10000.00,'','','card'),
(18,'2024-07-13 19:50:57.984669','2024-07-13 19:50:57.984669',2000.00,'','','cash'),
(19,'2024-07-13 19:51:19.826914','2024-07-13 19:51:19.826914',12000.00,'','','cash'),
(20,'2024-07-13 19:51:33.739459','2024-07-13 19:51:33.739459',10000.00,'','','cash'),
(21,'2024-07-13 19:56:13.446942','2024-07-13 19:56:13.446942',2000.00,'','','cash'),
(22,'2024-07-13 19:59:36.711900','2024-07-13 19:59:36.711900',10000.00,'','','cash'),
(23,'2024-07-13 20:00:18.983586','2024-07-13 20:00:18.983586',2000.00,'','','cash'),
(24,'2024-07-13 20:10:15.796456','2024-07-13 20:10:15.797455',2000.00,'','','cash'),
(25,'2024-07-13 20:16:28.180373','2024-07-13 20:16:28.181373',10000.00,'','','cash'),
(26,'2024-07-13 20:16:33.649928','2024-07-13 20:16:33.649928',2000.00,'','','cash'),
(27,'2024-07-14 21:29:26.994385','2024-07-14 21:29:26.994385',10000.00,'','','cash'),
(28,'2024-07-17 20:53:54.538139','2024-07-17 20:53:54.538139',2000.00,'','','cash'),
(29,'2024-07-17 20:59:58.121433','2024-07-17 20:59:58.121433',2000.00,'','','cash'),
(30,'2024-07-17 21:00:23.918185','2024-07-17 21:00:23.918185',2000.00,'','','cash'),
(31,'2024-07-17 21:02:48.287120','2024-07-17 21:02:48.287120',10000.00,'','','cash'),
(32,'2024-07-17 21:03:35.994219','2024-07-17 21:03:35.994219',1500.00,'','','cash'),
(33,'2024-07-17 21:04:04.316706','2024-07-17 21:04:04.316706',10000.00,'','','cash'),
(34,'2024-07-17 21:08:04.391723','2024-07-17 21:08:04.391723',500.00,'','','cash'),
(35,'2024-07-17 21:10:08.799216','2024-07-17 21:10:08.799216',2000.00,'','','cash'),
(36,'2024-07-17 21:16:03.221508','2024-07-17 21:16:03.221508',2000.00,'','','cash'),
(37,'2024-07-17 21:17:09.975793','2024-07-17 21:17:09.975793',3500.00,'','','cash'),
(38,'2024-07-17 21:17:26.417438','2024-07-17 21:17:26.417438',1500.00,'','','cash'),
(39,'2024-07-17 21:17:38.579263','2024-07-17 21:17:38.579263',1500.00,'','','cash'),
(40,'2024-07-17 21:17:45.325029','2024-07-17 21:17:45.326037',11500.00,'','','cash'),
(41,'2024-07-17 21:17:49.533071','2024-07-17 21:17:49.533071',10000.00,'','','cash'),
(42,'2024-07-17 21:17:55.524682','2024-07-17 21:17:55.524682',1500.00,'','','cash'),
(43,'2024-07-17 21:18:08.153362','2024-07-17 21:18:08.153362',500.00,'','','cash'),
(44,'2024-07-17 21:22:02.634756','2024-07-17 21:22:02.634756',500.00,'0114567533','emmanuel','card'),
(45,'2024-07-18 09:50:56.414081','2024-07-18 09:50:56.414081',1500.00,'','','cash'),
(46,'2024-07-18 09:54:58.555321','2024-07-18 09:54:58.556329',1500.00,'','','cash'),
(47,'2024-07-18 09:55:22.702509','2024-07-18 09:55:22.702509',2000.00,'','','cash'),
(48,'2024-07-18 10:03:47.089968','2024-07-18 10:03:47.089968',1500.00,'','','cash'),
(49,'2024-07-18 11:58:55.969534','2024-07-18 11:58:55.969534',2000.00,'','','cash'),
(50,'2024-07-18 12:00:12.679532','2024-07-18 12:00:12.679532',2000.00,'','','cash'),
(51,'2024-07-18 12:09:58.295037','2024-07-18 12:09:58.295037',1500.00,'','','cash'),
(52,'2024-07-18 12:20:50.377844','2024-07-18 12:20:50.378839',500.00,'','','cash'),
(53,'2024-07-18 12:29:04.779532','2024-07-18 12:29:04.779532',1500.00,'','','cash'),
(54,'2024-07-18 12:34:52.026308','2024-07-18 12:34:52.026308',1500.00,'','','cash'),
(55,'2024-07-18 12:34:58.749299','2024-07-18 12:34:58.749299',2000.00,'','','cash'),
(56,'2024-07-18 12:36:46.301385','2024-07-18 12:36:46.301385',1500.00,'','','cash'),
(57,'2024-07-18 12:37:02.422382','2024-07-18 12:37:02.422382',2000.00,'','','cash'),
(58,'2024-07-18 12:40:44.630479','2024-07-18 12:40:44.630479',2000.00,'','','cash'),
(59,'2024-07-18 12:43:26.581791','2024-07-18 12:43:26.582790',2000.00,'','','cash'),
(60,'2024-07-18 12:54:06.687097','2024-07-18 12:54:06.687097',1500.00,'','','card'),
(61,'2024-07-18 13:05:33.398119','2024-07-18 13:05:33.398119',500.00,'','','cash'),
(62,'2024-07-18 13:56:43.662464','2024-07-18 13:56:43.662464',2000.00,'','','cash'),
(63,'2024-07-18 14:00:09.958173','2024-07-18 14:00:09.958173',500.00,'','','cash'),
(64,'2024-07-18 14:00:36.395345','2024-07-18 14:00:36.396332',500.00,'','','cash'),
(65,'2024-07-18 14:02:55.134217','2024-07-18 14:02:55.134217',500.00,'','','cash'),
(66,'2024-07-18 14:04:09.806980','2024-07-18 14:04:09.807987',500.00,'','','cash'),
(67,'2024-07-18 14:07:05.445286','2024-07-18 14:07:05.445286',500.00,'','','cash'),
(68,'2024-07-18 14:08:03.257325','2024-07-18 14:08:03.257325',10000.00,'','','cash'),
(69,'2024-07-18 18:37:37.724625','2024-07-18 18:37:37.724625',2000.00,'','','cash'),
(70,'2024-07-18 18:42:19.932693','2024-07-18 18:42:19.932693',2000.00,'','','cash'),
(71,'2024-07-18 18:47:28.631789','2024-07-18 18:47:28.631789',500.00,'','','cash'),
(72,'2024-07-18 18:47:36.854779','2024-07-18 18:47:36.854779',500.00,'','','cash'),
(73,'2024-07-18 18:50:52.052109','2024-07-18 18:50:52.052109',500.00,'','','cash'),
(74,'2024-07-18 18:50:56.775027','2024-07-18 18:50:56.775027',500.00,'','','cash'),
(75,'2024-07-18 18:53:14.454856','2024-07-18 18:53:14.454856',500.00,'','','cash'),
(76,'2024-07-18 18:53:19.862495','2024-07-18 18:53:19.862495',500.00,'','','cash'),
(77,'2024-07-18 19:01:48.232480','2024-07-18 19:01:48.232480',500.00,'','','cash'),
(78,'2024-07-18 19:07:47.020889','2024-07-18 19:07:47.020889',2000.00,'','','cash'),
(79,'2024-07-18 19:20:55.712016','2024-07-18 19:20:55.713031',2000.00,'','','cash'),
(80,'2024-07-18 19:46:16.039053','2024-07-18 19:46:16.039053',2000.00,'','','cash'),
(81,'2024-07-18 19:58:17.719549','2024-07-18 19:58:17.719549',2500.00,'','','cash'),
(82,'2024-07-18 20:10:34.825534','2024-07-18 20:10:34.825534',500.00,'','','cash'),
(83,'2024-07-18 20:10:41.907858','2024-07-18 20:10:41.907858',2000.00,'','','cash'),
(84,'2024-07-18 20:10:52.337000','2024-07-18 20:10:52.337000',2000.00,'','','cash'),
(85,'2024-07-18 20:22:39.603974','2024-07-18 20:22:39.603974',4000.00,'','','cash'),
(86,'2024-07-18 20:22:50.830935','2024-07-18 20:22:50.830935',10000.00,'','','cash'),
(87,'2024-07-18 20:31:19.225894','2024-07-18 20:31:19.225894',500.00,'','','cash'),
(88,'2024-07-18 20:31:27.759712','2024-07-18 20:31:27.759712',13000.00,'','','cash'),
(89,'2024-08-14 07:07:52.012050','2024-08-14 07:07:52.012050',21500.00,'','','cash'),
(90,'2024-08-14 07:09:14.921891','2024-08-14 07:09:14.921891',21500.00,'','','cash'),
(91,'2024-08-14 07:11:56.539744','2024-08-14 07:11:56.539744',11500.00,'','','cash'),
(92,'2024-08-14 07:17:11.887713','2024-08-14 07:17:11.888707',2000.00,'','','cash'),
(93,'2024-08-14 08:22:14.634549','2024-08-14 08:22:14.634549',20000.00,'','','cash'),
(94,'2024-08-14 08:23:46.343658','2024-08-14 08:23:46.344666',20000.00,'','','cash'),
(95,'2024-08-14 08:25:03.275559','2024-08-14 08:25:03.275559',103000.00,'','','cash'),
(96,'2024-08-14 08:39:01.739090','2024-08-14 08:39:01.739090',12000.00,'','','cash'),
(97,'2024-08-14 08:41:32.386952','2024-08-14 08:41:32.386952',12000.00,'','','cash'),
(98,'2024-08-14 08:42:55.126948','2024-08-14 08:42:55.126948',10000.00,'','','cash'),
(99,'2024-08-14 08:44:25.867067','2024-08-14 08:44:25.867067',10000.00,'','','cash'),
(100,'2024-08-14 08:45:49.340071','2024-08-14 08:45:49.340071',10000.00,'','','cash'),
(101,'2024-08-14 08:52:06.526358','2024-08-14 08:52:06.526358',10000.00,'','','cash'),
(102,'2024-08-14 08:53:59.843768','2024-08-14 08:53:59.843768',500.00,'','','card'),
(103,'2024-08-14 09:04:31.365680','2024-08-14 09:04:31.366687',10000.00,'','','cash'),
(104,'2024-08-14 09:06:16.942500','2024-08-14 09:06:16.942500',10000.00,'','','cash'),
(105,'2024-08-14 09:07:02.537517','2024-08-14 09:07:02.537517',0.00,'','','cash'),
(106,'2024-08-14 09:08:29.898058','2024-08-14 09:08:29.898058',30500.00,'','','cash'),
(107,'2024-08-17 21:44:31.446628','2024-08-17 21:44:31.446628',20500.00,'','','card');

/*Table structure for table `pos_saleitem` */

DROP TABLE IF EXISTS `pos_saleitem`;

CREATE TABLE `pos_saleitem` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `quantity` int(10) unsigned NOT NULL CHECK (`quantity` >= 0),
  `price` decimal(10,2) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `sale_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pos_saleitem_item_id_f2cd0ef8_fk_products_item_id` (`item_id`),
  KEY `pos_saleitem_sale_id_9e4cc3b5_fk_pos_sale_id` (`sale_id`),
  CONSTRAINT `pos_saleitem_item_id_f2cd0ef8_fk_products_item_id` FOREIGN KEY (`item_id`) REFERENCES `products_item` (`id`),
  CONSTRAINT `pos_saleitem_sale_id_9e4cc3b5_fk_pos_sale_id` FOREIGN KEY (`sale_id`) REFERENCES `pos_sale` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pos_saleitem` */

insert  into `pos_saleitem`(`id`,`created_at`,`updated_at`,`quantity`,`price`,`item_id`,`sale_id`) values 
(1,'2024-06-29 14:17:48.778147','2024-06-29 14:17:48.778147',2,2000.00,2,6),
(4,'2024-06-30 02:32:22.389729','2024-06-30 02:32:22.389729',12,10000.00,2,8),
(5,'2024-07-06 10:10:20.373627','2024-07-06 10:10:20.374620',1,10000.00,2,9),
(6,'2024-07-06 10:10:24.359821','2024-07-06 10:10:24.359821',1,10000.00,2,10),
(7,'2024-07-06 10:10:24.451251','2024-07-06 10:10:24.451251',1,10000.00,2,11),
(8,'2024-07-06 10:10:32.629695','2024-07-06 10:10:32.629695',1,10000.00,2,12),
(9,'2024-07-06 10:11:19.685714','2024-07-06 10:11:19.685714',1,10000.00,2,13),
(10,'2024-07-09 02:11:44.691374','2024-07-09 02:11:44.691374',1,10000.00,2,14),
(11,'2024-07-09 02:11:47.638211','2024-07-09 02:11:47.638211',1,10000.00,2,15),
(12,'2024-07-13 19:38:28.032573','2024-07-13 19:38:28.032573',1,10000.00,2,16),
(13,'2024-07-13 19:51:33.819467','2024-07-13 19:51:33.819467',1,10000.00,2,20),
(14,'2024-07-13 19:59:36.884907','2024-07-13 19:59:36.885902',1,10000.00,2,22),
(15,'2024-07-13 20:16:28.326845','2024-07-13 20:16:28.326845',1,10000.00,2,25),
(16,'2024-07-14 21:29:27.150370','2024-07-14 21:29:27.151379',1,10000.00,2,27),
(17,'2024-07-17 21:02:48.378109','2024-07-17 21:02:48.378109',1,10000.00,2,31),
(19,'2024-07-17 21:17:49.603623','2024-07-17 21:17:49.603623',1,10000.00,2,41),
(20,'2024-07-18 14:08:03.439323','2024-07-18 14:08:03.439323',1,10000.00,2,68),
(21,'2024-07-18 20:10:34.884524','2024-07-18 20:10:34.884524',1,500.00,11,82),
(22,'2024-07-18 20:10:42.070869','2024-07-18 20:10:42.070869',1,2000.00,12,83),
(23,'2024-07-18 20:10:52.406532','2024-07-18 20:10:52.406532',1,1500.00,10,84),
(24,'2024-07-18 20:10:52.518895','2024-07-18 20:10:52.518895',1,500.00,11,84),
(25,'2024-07-18 20:22:39.645333','2024-07-18 20:22:39.645333',1,1500.00,10,85),
(26,'2024-07-18 20:22:39.658323','2024-07-18 20:22:39.658323',1,500.00,11,85),
(27,'2024-07-18 20:22:39.776667','2024-07-18 20:22:39.776667',1,2000.00,12,85),
(28,'2024-07-18 20:22:50.850982','2024-07-18 20:22:50.850982',1,10000.00,2,86),
(29,'2024-07-18 20:31:19.265894','2024-07-18 20:31:19.265894',1,500.00,11,87),
(30,'2024-07-18 20:31:27.783704','2024-07-18 20:31:27.783704',6,2000.00,12,88),
(31,'2024-07-18 20:31:27.880710','2024-07-18 20:31:27.880710',2,500.00,11,88),
(32,'2024-08-14 07:07:52.192029','2024-08-14 07:07:52.192029',2,10000.00,2,89),
(33,'2024-08-14 07:07:52.578046','2024-08-14 07:07:52.578046',1,1500.00,10,89),
(34,'2024-08-14 07:09:14.948902','2024-08-14 07:09:14.948902',2,10000.00,2,90),
(35,'2024-08-14 07:09:14.964898','2024-08-14 07:09:14.964898',1,1500.00,10,90),
(36,'2024-08-14 07:11:56.581739','2024-08-14 07:11:56.581739',1,10000.00,2,91),
(37,'2024-08-14 07:11:56.633748','2024-08-14 07:11:56.633748',1,1500.00,10,91),
(38,'2024-08-14 07:17:11.977711','2024-08-14 07:17:11.977711',1,500.00,11,92),
(39,'2024-08-14 07:17:11.993723','2024-08-14 07:17:11.994705',1,1500.00,10,92),
(40,'2024-08-14 08:22:14.929552','2024-08-14 08:22:14.929552',2,10000.00,2,93),
(41,'2024-08-14 08:23:46.462649','2024-08-14 08:23:46.462649',2,10000.00,2,94),
(42,'2024-08-14 08:25:03.398549','2024-08-14 08:25:03.398549',7,10000.00,2,95),
(43,'2024-08-14 08:25:04.540557','2024-08-14 08:25:04.540557',2,1500.00,10,95),
(44,'2024-08-14 08:25:04.553548','2024-08-14 08:25:04.553548',6,500.00,11,95),
(45,'2024-08-14 08:25:04.566555','2024-08-14 08:25:04.566555',6,2000.00,12,95),
(46,'2024-08-14 08:25:04.644546','2024-08-14 08:25:04.645554',10,1500.00,13,95),
(47,'2024-08-14 08:39:01.857082','2024-08-14 08:39:01.858085',1,2000.00,12,96),
(48,'2024-08-14 08:39:02.364079','2024-08-14 08:39:02.365083',1,10000.00,2,96),
(49,'2024-08-14 08:41:32.451947','2024-08-14 08:41:32.451947',1,2000.00,12,97),
(50,'2024-08-14 08:41:32.469950','2024-08-14 08:41:32.469950',1,10000.00,2,97),
(51,'2024-08-14 08:42:55.170952','2024-08-14 08:42:55.170952',1,10000.00,2,98),
(52,'2024-08-14 08:44:25.893073','2024-08-14 08:44:25.893073',1,10000.00,2,99),
(53,'2024-08-14 08:45:49.474061','2024-08-14 08:45:49.474061',1,10000.00,2,100),
(54,'2024-08-14 08:52:06.640355','2024-08-14 08:52:06.640355',1,10000.00,2,101),
(55,'2024-08-14 08:53:59.916760','2024-08-14 08:53:59.917762',1,500.00,11,102),
(56,'2024-08-14 09:04:31.461687','2024-08-14 09:04:31.461687',1,10000.00,2,103),
(57,'2024-08-14 09:06:16.999500','2024-08-14 09:06:16.999500',1,10000.00,2,104),
(58,'2024-08-14 09:08:29.938054','2024-08-14 09:08:29.938054',5,500.00,11,106),
(59,'2024-08-14 09:08:29.955055','2024-08-14 09:08:29.955055',4,2000.00,12,106),
(60,'2024-08-14 09:08:29.971056','2024-08-14 09:08:29.971056',2,10000.00,2,106),
(61,'2024-08-17 21:44:31.508634','2024-08-17 21:44:31.508634',2,10000.00,2,107),
(62,'2024-08-17 21:44:31.540640','2024-08-17 21:44:31.540640',1,500.00,11,107);

/*Table structure for table `products_category` */

DROP TABLE IF EXISTS `products_category`;

CREATE TABLE `products_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `products_category` */

insert  into `products_category`(`id`,`created_at`,`updated_at`,`name`,`description`) values 
(1,'2024-06-11 17:02:06.800940','2024-06-11 17:02:06.800940','Electronics','Electronic gadgets and devices'),
(2,'2024-06-11 17:02:07.069914','2024-06-11 17:02:07.069914','Furniture','Home and office furniture'),
(3,'2024-07-27 10:05:03.576856','2024-07-27 10:05:03.576856','Clothes','Ethopian clothes');

/*Table structure for table `products_item` */

DROP TABLE IF EXISTS `products_item`;

CREATE TABLE `products_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `SKU` varchar(100) NOT NULL,
  `barcode` varchar(100) DEFAULT NULL,
  `category_id` bigint(20) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `SKU` (`SKU`),
  UNIQUE KEY `barcode` (`barcode`),
  KEY `products_item_category_id_4c94af84_fk_products_category_id` (`category_id`),
  CONSTRAINT `products_item_category_id_4c94af84_fk_products_category_id` FOREIGN KEY (`category_id`) REFERENCES `products_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `products_item` */

insert  into `products_item`(`id`,`created_at`,`updated_at`,`name`,`description`,`price`,`cost`,`SKU`,`barcode`,`category_id`,`image`) values 
(2,'2024-06-11 17:19:58.562322','2024-07-04 19:38:26.564579','Office Chair','Ergonomic office chair',10000.00,100.00,'chair123','12345678901258',2,'product_images/chair.jpeg'),
(10,'2024-07-05 06:54:31.894028','2024-07-05 09:26:03.296034','laptop charger','Lenovo laptop charger',1500.00,1000.00,'charger012','68390209494',1,'product_images/laptop_charger_L08Ln85.jpg'),
(11,'2024-07-17 21:06:26.962936','2024-07-17 21:06:26.962936','mouse','wireless mouse',500.00,300.00,'mouse123','785894973533',1,'product_images/mouse_WDxw3ol.png'),
(12,'2024-07-17 21:09:37.410263','2024-07-17 21:09:37.410263','Keyboard','wireless LED keyboard',2000.00,1000.00,'keyboard123','98776654443',1,'product_images/keyboard_TGN3Sdg.jpeg'),
(13,'2024-07-22 11:14:25.957797','2024-07-22 11:14:25.957797','chiwfne','',1500.00,1000.00,'47467383939','383993948',1,'');

/*Table structure for table `socialaccount_socialaccount` */

DROP TABLE IF EXISTS `socialaccount_socialaccount`;

CREATE TABLE `socialaccount_socialaccount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(200) NOT NULL,
  `uid` varchar(191) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `extra_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`extra_data`)),
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialaccount_provider_uid_fc810c6e_uniq` (`provider`,`uid`),
  KEY `socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id` (`user_id`),
  CONSTRAINT `socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `socialaccount_socialaccount` */

/*Table structure for table `socialaccount_socialapp` */

DROP TABLE IF EXISTS `socialaccount_socialapp`;

CREATE TABLE `socialaccount_socialapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `name` varchar(40) NOT NULL,
  `client_id` varchar(191) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL,
  `provider_id` varchar(200) NOT NULL,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`settings`)),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `socialaccount_socialapp` */

/*Table structure for table `socialaccount_socialapp_sites` */

DROP TABLE IF EXISTS `socialaccount_socialapp_sites`;

CREATE TABLE `socialaccount_socialapp_sites` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `socialapp_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialapp_sites_socialapp_id_site_id_71a9a768_uniq` (`socialapp_id`,`site_id`),
  KEY `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` (`site_id`),
  CONSTRAINT `socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc` FOREIGN KEY (`socialapp_id`) REFERENCES `socialaccount_socialapp` (`id`),
  CONSTRAINT `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `socialaccount_socialapp_sites` */

/*Table structure for table `socialaccount_socialtoken` */

DROP TABLE IF EXISTS `socialaccount_socialtoken`;

CREATE TABLE `socialaccount_socialtoken` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` longtext NOT NULL,
  `token_secret` longtext NOT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `app_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq` (`app_id`,`account_id`),
  KEY `socialaccount_social_account_id_951f210e_fk_socialacc` (`account_id`),
  CONSTRAINT `socialaccount_social_account_id_951f210e_fk_socialacc` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  CONSTRAINT `socialaccount_social_app_id_636a42d7_fk_socialacc` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `socialaccount_socialtoken` */

/*Table structure for table `suppliers_supplier` */

DROP TABLE IF EXISTS `suppliers_supplier`;

CREATE TABLE `suppliers_supplier` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `contact_name` varchar(255) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(254) NOT NULL,
  `address` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `suppliers_supplier` */

insert  into `suppliers_supplier`(`id`,`created_at`,`updated_at`,`name`,`contact_name`,`phone`,`email`,`address`) values 
(1,'2024-06-11 13:02:29.946224','2024-06-11 13:02:29.946224','techsupplier','john','0114567533','john@gmail.coom','PO BOX 23'),
(2,'2024-06-11 17:02:55.807665','2024-06-11 17:02:55.807665','TechSupplier','John Doe','1234567890','techsupplier@example.com','123 Tech Street'),
(3,'2024-06-11 17:02:56.053280','2024-06-11 17:02:56.053280','FurniSupplier','Jane Doe','0987654321','furnisupplier@example.com','456 Furni Avenue'),
(4,'2024-06-11 17:03:29.171103','2024-06-11 17:03:29.171103','TechSupplier','John Doe','1234567890','techsupplier@example.com','123 Tech Street'),
(5,'2024-06-11 17:03:29.344061','2024-06-11 17:03:29.344061','FurniSupplier','Jane Doe','0987654321','furnisupplier@example.com','456 Furni Avenue'),
(6,'2024-06-11 17:14:07.381138','2024-06-11 17:14:07.382142','TechSupplier','John Doe','1234567890','techsupplier@example.com','123 Tech Street'),
(7,'2024-06-11 17:14:07.486140','2024-06-11 17:14:07.486140','FurniSupplier','Jane Doe','0987654321','furnisupplier@example.com','456 Furni Avenue');

/*Table structure for table `users_user` */

DROP TABLE IF EXISTS `users_user`;

CREATE TABLE `users_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `role` varchar(50) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `bio` longtext DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `users_user` */

insert  into `users_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`is_staff`,`is_active`,`date_joined`,`email`,`role`,`avatar`,`bio`,`name`) values 
(1,'admin123',NULL,0,'otieno','emmanuel','otieno',0,1,'2024-06-11 12:57:08.000000','emmanuelotieno2002@gmail.com','Admin','',NULL,NULL),
(2,'PA$$',NULL,0,'sacco','Vitalis','Sidi',0,1,'2024-06-11 13:08:44.000000','vitalis@gmail.com','Staff','',NULL,NULL),
(3,'pbkdf2_sha256$720000$RnPNHWysqUEJYq6JDPVhNh$Jo4ix0H6OmPoR4yCMnn9DMC0hxkXGi946fzyol+JC+I=',NULL,1,'admin','','',1,1,'2024-06-11 17:07:07.803832','admin@example.com','Admin','',NULL,NULL),
(4,'pbkdf2_sha256$720000$iedOcvyBPOMkjo9rhIl3cb$1EjkYAbnYtoEB4bqt338chMxhPFEbSVfgmXkL71oukQ=',NULL,0,'staff1','','',0,1,'2024-06-11 17:07:10.287594','staff1@example.com','Staff','',NULL,NULL),
(5,'pbkdf2_sha256$720000$t6OM3dugjC4OCLf0IXw0Ep$lkiq0/503gJ5OERpl2cSIM8Fkq3DCxTuWue73Qrl9sI=',NULL,0,'staff2','','',0,1,'2024-06-11 17:07:12.709588','staff2@example.com','Staff','',NULL,NULL);

/*Table structure for table `users_user_groups` */

DROP TABLE IF EXISTS `users_user_groups`;

CREATE TABLE `users_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_groups_user_id_group_id_b88eab82_uniq` (`user_id`,`group_id`),
  KEY `users_user_groups_group_id_9afc8d0e_fk_auth_group_id` (`group_id`),
  CONSTRAINT `users_user_groups_group_id_9afc8d0e_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `users_user_groups_user_id_5f6f5a90_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `users_user_groups` */

/*Table structure for table `users_user_user_permissions` */

DROP TABLE IF EXISTS `users_user_user_permissions`;

CREATE TABLE `users_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_user_permissions_user_id_permission_id_43338c45_uniq` (`user_id`,`permission_id`),
  KEY `users_user_user_perm_permission_id_0b93982e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `users_user_user_perm_permission_id_0b93982e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `users_user_user_permissions_user_id_20aca447_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `users_user_user_permissions` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
