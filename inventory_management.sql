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
(1,'pbkdf2_sha256$720000$KXngRwVILh71f9aJ1PrehH$LRG1KGqalN3RaU34bdF2SUPBsU0Bj0lqyRKvQE2C/Ls=','2024-08-20 20:23:49.248820',1,'emmanuel','','','emmanuelokoth2002@gmail.com',1,1,'2024-06-11 12:52:04.118215'),
(2,'pbkdf2_sha256$720000$WM7NJVpsGxnBbZVHyFcTqo$oEYbf5NycZ6wqhq0GF04ilitmfSfEkRcCZQLLRzIxXQ=','2024-08-13 20:24:32.300578',0,'okoth','','','emmanuelokoth2002@gmail.com',0,1,'2024-07-14 19:28:09.166922'),
(3,'pbkdf2_sha256$720000$77LapvpHVRzGibiKaZVPe1$d/IXY/JY6+ScEskkK4kaA7wUU7YONaV0+gny5r9As4g=','2024-07-21 19:46:49.086667',0,'peter','','','peter@gmail.com',0,1,'2024-07-14 21:00:28.363355'),
(4,'pbkdf2_sha256$720000$W8rXWCvl05dLrIk84pRySZ$XRztJfYtFvEd0PaDInND5dQ1fYZCd+Op+yJ0ZaKPZA4=','2024-08-22 14:48:13.966790',1,'admin','','','',1,1,'2024-08-09 11:59:55.238648'),
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
('1zzx5qyf8imv1q5lu7oezoauo5k6j1wq','.eJxVjDsOwjAQBe_iGllx_Kekzxks27uLA8iR4qRC3J1YSgHtzLz3ZiHuWwl7wzXMwK5MsMsvSzE_sXYBj1jvC89L3dY58Z7w0zY-LYCv29n-HZTYyrHGqJEyAWGUzpLTflRe6UQIPsnBJxjJSOMGDU7ajsWh0QpyyqBO7PMFGF84vw:1sgVOP:nq2Rv1ocQs6_XOjm_NEIWHY8p_KSA3keE_WJUD3_XwE','2024-09-03 20:23:49.583832'),
('9krt3bu2xelu8ze6392rj33l1ob6cy8q','e30:1sT4tQ:Ewj-BLZcrykLEACtt0ygVDlGAellbGuvIyS5W1TWHxE','2024-07-28 19:28:20.675887'),
('e9eklfk338ryw9sga32odsmu3mylofuq','.eJxVjDsOwjAQBe_iGllx_Kekzxks27uLA8iR4qRC3J1YSgHtzLz3ZiHuWwl7wzXMwK5MsMsvSzE_sXYBj1jvC89L3dY58Z7w0zY-LYCv29n-HZTYyrHGqJEyAWGUzpLTflRe6UQIPsnBJxjJSOMGDU7ajsWh0QpyyqBO7PMFGF84vw:1sXenl:_SFC1tasX7LimstKuy5PJ8CoaIbCl386JMHqprRwUe0','2024-08-10 10:37:25.544783'),
('i7xe5jwdzwd36d7v96ltlw7wxvu5k6ov','.eJxVjMEOwiAQRP-FsyFAuwt49O43kIWlUjU0Ke3J-O9K0oPeJvPezEsE2rcS9pbXMLM4CxSn3y5SeuTaAd-p3haZlrqtc5RdkQdt8rpwfl4O9--gUCt9PTJMzkcGz8YyqgiTYc8KBkgpof4m8kPWCjCCBrSjcxrYkjaoHIv3B-n1N04:1sSy6t:5-ugghZpumB2rmsTPt9qUN48A6SfCFgNaBOafEDaLac','2024-07-28 12:13:47.200270'),
('oriwfactcfsfpp6amzuwd55tmnu98bwf','.eJxVjDsOwjAQBe_iGllx_Kekzxks27uLA8iR4qRC3J1YSgHtzLz3ZiHuWwl7wzXMwK5MsMsvSzE_sXYBj1jvC89L3dY58Z7w0zY-LYCv29n-HZTYyrHGqJEyAWGUzpLTflRe6UQIPsnBJxjJSOMGDU7ajsWh0QpyyqBO7PMFGF84vw:1sWb22:AZdLihbGqzcIln9qBjKyOiOJu9Oc1CaOJWUQYZiZdsM','2024-08-07 12:23:46.766460'),
('rgzc0gqndujfi2evupfp24xgyrc0346t','.eJxVjDsOwjAQBe_iGllx_Kekzxks27uLA8iR4qRC3J1YSgHtzLz3ZiHuWwl7wzXMwK5MsMsvSzE_sXYBj1jvC89L3dY58Z7w0zY-LYCv29n-HZTYyrHGqJEyAWGUzpLTflRe6UQIPsnBJxjJSOMGDU7ajsWh0QpyyqBO7PMFGF84vw:1sMQ3w:MPfoY2k4A4XcKWLELuhZ2xH8CQJdNh9Q2JXxccOk7A0','2024-07-10 10:39:40.776452'),
('s9wlv10acwsvk5w26pqyl95i165yce28','.eJxVjLsOwjAMAP8lM4pcNy8Y2fmGyqkdUkCJ1LQT4t9RpA6w3p3urSbatzztTdZpYXVRRp1-WaT5KaULflC5Vz3Xsq1L1D3Rh236Vlle16P9G2RquW8JMI2WDDPPYBHBC1o3sMGRBn8GQYMxivMmQEiQAoDlNAi45LxL6vMFy_c3MA:1sh96k:UMRXaMCoKKleUvjjJK1RpXemg9XoMrN4rxBJBKBdvIA','2024-09-05 14:48:14.075807'),
('sdn3lsaqkdbl4oddc948nwjhdfhyymq6','.eJxVjLsOwjAMAP8lM4pcNy8Y2fmGyqkdUkCJ1LQT4t9RpA6w3p3urSbatzztTdZpYXVRRp1-WaT5KaULflC5Vz3Xsq1L1D3Rh236Vlle16P9G2RquW8JMI2WDDPPYBHBC1o3sMGRBn8GQYMxivMmQEiQAoDlNAi45LxL6vMFy_c3MA:1scOef:Oz0rL79gCEvjglfJAiRLDzMGvExYC8hvPdMiT2bUEWI','2024-08-23 12:23:37.509365'),
('vprf4cxysrm0yjbyppt0enm7vq7xi00f','e30:1sT4vY:yQeJ_7LYHtBs2LdMofx-qSr2yhL6cjGob4Qr9cLUxGU','2024-07-28 19:30:32.466709'),
('wsy4qhml9s90xnyjmpbfikqy2k40mwcl','.eJxVjLsOwjAMAP8lM4pcNy8Y2fmGyqkdUkCJ1LQT4t9RpA6w3p3urSbatzztTdZpYXVRRp1-WaT5KaULflC5Vz3Xsq1L1D3Rh236Vlle16P9G2RquW8JMI2WDDPPYBHBC1o3sMGRBn8GQYMxivMmQEiQAoDlNAi45LxL6vMFy_c3MA:1sgWTg:Kk1SLsqWAdCrdJ-XNAUi8pfyO0c5Gxu6qXGSIRPNLSA','2024-09-03 21:33:20.805727'),
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `inventory_inventory` */

insert  into `inventory_inventory`(`id`,`created_at`,`updated_at`,`quantity`,`reorder_level`,`item_id`,`warehouse_id`) values 
(9,'2024-08-22 15:11:13.060384','2024-08-22 15:39:33.801781',18,5,14,5),
(10,'2024-08-22 15:13:10.181382','2024-08-22 15:39:34.145773',18,5,15,5),
(11,'2024-08-22 15:15:10.972390','2024-08-22 15:39:34.157777',18,5,16,5),
(12,'2024-08-22 15:16:45.092388','2024-08-22 15:39:34.205789',18,5,17,5),
(13,'2024-08-22 15:18:29.754778','2024-08-22 15:39:34.192775',18,5,18,5),
(14,'2024-08-22 15:20:18.300788','2024-08-22 15:39:34.169771',18,5,19,5),
(15,'2024-08-22 15:21:47.322788','2024-08-22 15:39:34.180776',18,5,20,5);

/*Table structure for table `inventory_warehouse` */

DROP TABLE IF EXISTS `inventory_warehouse`;

CREATE TABLE `inventory_warehouse` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `inventory_warehouse` */

insert  into `inventory_warehouse`(`id`,`created_at`,`updated_at`,`name`,`location`) values 
(5,'2024-08-22 15:11:13.017391','2024-08-22 15:11:13.017391','Default Warehouse','Default Location');

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
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pos_sale` */

insert  into `pos_sale`(`id`,`created_at`,`updated_at`,`total_amount`,`customer_contact`,`customer_name`,`payment_method`) values 
(109,'2024-08-22 15:33:31.725784','2024-08-22 15:33:31.725784',27400.00,'','','card'),
(110,'2024-08-22 15:39:33.777787','2024-08-22 15:39:33.777787',27400.00,'','','card');

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
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pos_saleitem` */

insert  into `pos_saleitem`(`id`,`created_at`,`updated_at`,`quantity`,`price`,`item_id`,`sale_id`) values 
(64,'2024-08-22 15:33:31.779781','2024-08-22 15:33:31.779781',1,3000.00,14,109),
(65,'2024-08-22 15:33:31.810778','2024-08-22 15:33:31.810778',1,3000.00,15,109),
(66,'2024-08-22 15:33:31.912779','2024-08-22 15:33:31.912779',1,4000.00,16,109),
(67,'2024-08-22 15:33:31.926783','2024-08-22 15:33:31.926783',1,4500.00,19,109),
(68,'2024-08-22 15:33:31.939779','2024-08-22 15:33:31.939779',1,3400.00,20,109),
(69,'2024-08-22 15:33:31.951778','2024-08-22 15:33:31.951778',1,4500.00,18,109),
(70,'2024-08-22 15:33:31.963777','2024-08-22 15:33:31.963777',1,5000.00,17,109),
(71,'2024-08-22 15:39:33.794774','2024-08-22 15:39:33.794774',1,3000.00,14,110),
(72,'2024-08-22 15:39:33.974770','2024-08-22 15:39:33.974770',1,3000.00,15,110),
(73,'2024-08-22 15:39:34.151774','2024-08-22 15:39:34.151774',1,4000.00,16,110),
(74,'2024-08-22 15:39:34.163775','2024-08-22 15:39:34.163775',1,4500.00,19,110),
(75,'2024-08-22 15:39:34.175780','2024-08-22 15:39:34.175780',1,3400.00,20,110),
(76,'2024-08-22 15:39:34.187781','2024-08-22 15:39:34.187781',1,4500.00,18,110),
(77,'2024-08-22 15:39:34.199792','2024-08-22 15:39:34.199792',1,5000.00,17,110);

/*Table structure for table `products_category` */

DROP TABLE IF EXISTS `products_category`;

CREATE TABLE `products_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `products_category` */

insert  into `products_category`(`id`,`created_at`,`updated_at`,`name`,`description`) values 
(4,'2024-08-22 15:04:02.593383','2024-08-22 15:04:02.593383','Festive Wear','A simple, possibly traditional dress with decorative details, often worn for special occasions or festive events.'),
(5,'2024-08-22 15:05:11.176381','2024-08-22 15:05:11.176381','Family Matching Outfits','potentially designed for coordinated family outfits.'),
(6,'2024-08-22 15:06:17.603386','2024-08-22 15:06:17.603386','Cultural or Traditional Wear','This outfits may be a traditional Ethiopian dress, often worn during cultural or religious events. The red cross and trim suggest a connection to cultural heritage.');

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `products_item` */

insert  into `products_item`(`id`,`created_at`,`updated_at`,`name`,`description`,`price`,`cost`,`SKU`,`barcode`,`category_id`,`image`) values 
(14,'2024-08-22 15:11:12.812381','2024-08-22 15:11:12.813382','Habesha Kemis (ሐበሻ ቀሚስ)','This is a traditional Ethiopian and Eritrean dress worn by women. It is usually made from handwoven cotton and features intricate embroidery, often in bright colors like green, red, or gold. The dress is long and often features a shawl (netela) draped over the shoulders.',3000.00,2000.00,'clothe01',NULL,6,'product_images/image36.jpg'),
(15,'2024-08-22 15:13:09.980376','2024-08-22 15:13:09.980376','Habesha Libs (ሐበሻ ልብስ)','The men\'s version of the traditional attire typically includes a shirt and pants made from similar fabric as the women\'s dress. The shirt often features embroidered patterns along the collar and chest. A shawl (gabi) is also worn over the shoulders.',3000.00,2000.00,'clothe02',NULL,6,'product_images/image28.jpg'),
(16,'2024-08-22 15:15:10.880373','2024-08-22 15:15:10.880373','Tunic Dress','A simple, possibly traditional dress with decorative details, often worn for special occasions or festive events.',4000.00,3000.00,'clothe03',NULL,4,'product_images/image1.jpg'),
(17,'2024-08-22 15:16:44.928387','2024-08-22 15:16:44.928387','Maxi Dresses','The yellow dresses with floral embroidery could represent traditional or cultural attire, potentially designed for coordinated family outfits.',5000.00,3000.00,'clothe04',NULL,6,'product_images/image3.jpg'),
(18,'2024-08-22 15:18:29.674780','2024-08-22 15:18:29.674780','Habesha Kemis (ሐበሻ ቀሚስ)','This outfit may be a traditional Ethiopian dress, often worn during cultural or religious events. The red cross and trim suggest a connection to cultural heritage.',4500.00,3000.00,'clothe05',NULL,6,'product_images/image4.jpg'),
(19,'2024-08-22 15:20:18.044784','2024-08-22 15:20:18.044784','Habesha Kemis (ሐበሻ ቀሚስ)','This outfit may be a traditional Ethiopian dress, often worn during cultural or religious events. The red cross and trim suggest a connection to cultural heritage.',4500.00,3200.00,'clothe06',NULL,6,'product_images/image6.jpg'),
(20,'2024-08-22 15:21:47.239775','2024-08-22 15:21:47.239775','Habesha Libs (ሐበሻ ልብስ)','The men\'s version of the traditional attire typically includes a shirt and pants made from similar fabric as the women\'s dress. The shirt often features embroidered patterns along the collar and chest. A shawl (gabi) is also worn over the shoulders.',3400.00,2500.00,'clothe07',NULL,6,'product_images/image18.jpg');

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
(3,'pbkdf2_sha256$720000$RnPNHWysqUEJYq6JDPVhNh$Jo4ix0H6OmPoR4yCMnn9DMC0hxkXGi946fzyol+JC+I=',NULL,1,'admin','','',1,1,'2024-06-11 17:07:07.803832','admin@example.com','Admin','',NULL,NULL);

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
