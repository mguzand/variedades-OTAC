/*
 Navicat Premium Data Transfer

 Source Server         : LOCAL_DB
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : db_variedadesotac

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 15/04/2021 01:30:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_categoria
-- ----------------------------
DROP TABLE IF EXISTS `tbl_categoria`;
CREATE TABLE `tbl_categoria`  (
  `id_categoria` int(0) NOT NULL AUTO_INCREMENT,
  `nombre_categoria` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fecha_creacion` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `creado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_categoria`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_categoria
-- ----------------------------
BEGIN;
INSERT INTO `tbl_categoria` VALUES (1, 'AGROPECUARIA', '2021-04-06 00:00:00', NULL), (2, 'qwwdsadasda', '2021-04-14 00:00:00', NULL), (3, 'Otra Categoria', '2021-04-14 23:29:56', NULL), (4, 'Categoría de Ariel', '2021-04-14 23:31:23', NULL), (5, 'Categoria de Roberto', '2021-04-14 23:31:46', NULL);
COMMIT;

-- ----------------------------
-- Table structure for tbl_clientes
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clientes`;
CREATE TABLE `tbl_clientes`  (
  `id_cliente` int(0) NOT NULL AUTO_INCREMENT,
  `DNI` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nombre_cliente` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `telefono_cliente` int(0) NOT NULL,
  `direccion_cliente` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fecha_creacion` date NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_clientes
-- ----------------------------
BEGIN;
INSERT INTO `tbl_clientes` VALUES (3, '080120000641', 'Fernando C', 2147483647, 'direccion_cliente', NULL), (4, '123456789', 'prueba ', 2147483647, 'ASDFGHJKLÑ', NULL), (7, '787878787878', 'sdfrtgyuiop', 2147483647, '789sjfihsjd888', NULL), (8, '784551224188', 'YHYHYHYH', 2147483647, 'GYUJHNJKJMKL', NULL), (9, '789845652565', 'GWHJIDOCSILRUFN', 2147483647, 'JSDKNCKUSILDRN', NULL), (10, '87945465123', 'HOLA', 2147483647, 'JUSUUJSDUNUNXSU', NULL), (11, '789654156', 'KSUHDCN KSDL', 2147483647, 'SSDCOSMPCOWE', NULL), (12, '273423452345', 'FFFFFFFF', 2147483647, '2938472093', NULL), (13, 'LAJKERFNLKWDS', 'JUUUJUJUJUJ', 2147483647, 'ASDFGHJKLDFGH', NULL), (14, '7412368963', 'SSSSSAAAAA', 2147483647, 'HJKLOIUYTFVB', NULL), (15, '741258963', 'RFVBNMJUYTRFVBN', 1478523698, 'DFGHJUYTR7', NULL), (16, '112226189645', 'ghyjuio', 2147483647, 'ghjukiopkjkk', NULL);
COMMIT;

-- ----------------------------
-- Table structure for tbl_compras
-- ----------------------------
DROP TABLE IF EXISTS `tbl_compras`;
CREATE TABLE `tbl_compras`  (
  `id_compra` int(0) NOT NULL AUTO_INCREMENT,
  `desc_compra` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fecha_orden` date NOT NULL,
  `fecha_entrega` date NOT NULL,
  `cantidad_compra` int(0) NOT NULL,
  `cantidad_recibida` int(0) NOT NULL,
  `TBL_PROVEEDORES_id_proveedor` int(0) NOT NULL,
  PRIMARY KEY (`id_compra`) USING BTREE,
  INDEX `fk_TBL_COMPRAS_TBL_PROVEEDORES1_idx`(`TBL_PROVEEDORES_id_proveedor`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_compras
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tbl_devoluciones
-- ----------------------------
DROP TABLE IF EXISTS `tbl_devoluciones`;
CREATE TABLE `tbl_devoluciones`  (
  `id_devolucion` int(0) NOT NULL,
  `cantidad_dev` int(0) NOT NULL,
  `TBL_PRODUCTOS_id_producto` int(0) NOT NULL,
  `TBL_KARDEX_id_kardex` int(0) NOT NULL,
  PRIMARY KEY (`id_devolucion`) USING BTREE,
  INDEX `fk_TBL_DEVOLUCIONES_TBL_PRODUCTOS1_idx`(`TBL_PRODUCTOS_id_producto`) USING BTREE,
  INDEX `fk_TBL_DEVOLUCIONES_TBL_KARDEX1_idx`(`TBL_KARDEX_id_kardex`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_devoluciones
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tbl_kardex
-- ----------------------------
DROP TABLE IF EXISTS `tbl_kardex`;
CREATE TABLE `tbl_kardex`  (
  `id_kardex` int(0) NOT NULL AUTO_INCREMENT,
  `cantidad_kardex` int(0) NOT NULL,
  `precio` decimal(9, 2) NOT NULL,
  `fecha_kardex` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `id_producto` int(0) NOT NULL,
  `id_tipo_kardex` int(0) NOT NULL,
  `id_usuario` int(0) NOT NULL,
  PRIMARY KEY (`id_kardex`) USING BTREE,
  INDEX `id_producto`(`id_producto`) USING BTREE,
  INDEX `id_tipo_kardex`(`id_tipo_kardex`) USING BTREE,
  INDEX `id_usuario`(`id_usuario`) USING BTREE,
  CONSTRAINT `tbl_kardex_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `tbl_productos` (`id_producto`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tbl_kardex_ibfk_2` FOREIGN KEY (`id_tipo_kardex`) REFERENCES `tbl_tipo_kardex` (`id_tipo_kardex`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tbl_kardex_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `tbl_ms_usuario` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_kardex
-- ----------------------------
BEGIN;
INSERT INTO `tbl_kardex` VALUES (2, 60, 300.00, '2021-04-15 00:50:35', 21, 1, 2), (3, 10, 0.00, '2021-04-15 01:09:04', 21, 1, 2), (4, 20, 0.00, '2021-04-15 01:09:55', 21, 1, 2), (5, 10, 0.00, '2021-04-15 01:10:47', 21, 1, 2), (6, 2, 0.00, '2021-04-15 01:11:47', 21, 1, 2), (7, 4, 0.00, '2021-04-15 01:12:31', 21, 1, 2), (8, 4, 0.00, '2021-04-15 01:13:44', 21, 1, 2), (9, 5, 0.00, '2021-04-15 01:14:37', 21, 1, 2), (10, 10, 0.00, '2021-04-15 01:15:31', 21, 1, 2), (11, 2, 0.00, '2021-04-15 01:15:58', 21, 1, 2), (12, 8, 0.00, '2021-04-15 01:16:53', 21, 1, 2), (13, 10, 0.00, '2021-04-15 01:17:06', 21, 2, 2), (14, 30, 0.00, '2021-04-15 01:18:02', 21, 1, 2);
COMMIT;

-- ----------------------------
-- Table structure for tbl_ms_bitacora
-- ----------------------------
DROP TABLE IF EXISTS `tbl_ms_bitacora`;
CREATE TABLE `tbl_ms_bitacora`  (
  `id_bitacora` int(0) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `TBL_MS_USUARIO_id_usuario` int(0) NOT NULL,
  `TBL_MS_OBJETOS_id_objeto` int(0) NOT NULL,
  `accion` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `descripcion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `creado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `fecha_creacion` date NULL DEFAULT NULL,
  `modificado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `fecha_modificacion` date NULL DEFAULT NULL,
  PRIMARY KEY (`id_bitacora`) USING BTREE,
  INDEX `fk_TBL_MS_BITACORA_TBL_MS_USUARIO1_idx`(`TBL_MS_USUARIO_id_usuario`) USING BTREE,
  INDEX `fk_TBL_MS_BITACORA_TBL_MS_OBJETOS1_idx`(`TBL_MS_OBJETOS_id_objeto`) USING BTREE,
  CONSTRAINT `fk_TBL_MS_BITACORA_TBL_MS_OBJETOS1` FOREIGN KEY (`TBL_MS_OBJETOS_id_objeto`) REFERENCES `tbl_ms_objetos` (`id_objeto`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_TBL_MS_BITACORA_TBL_MS_USUARIO1` FOREIGN KEY (`TBL_MS_USUARIO_id_usuario`) REFERENCES `tbl_ms_usuario` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1660 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_ms_bitacora
-- ----------------------------
BEGIN;
INSERT INTO `tbl_ms_bitacora` VALUES (1143, '2021-03-25', 1, 23, 'Ingreso', 'Ingreso a consultar bitácora', NULL, '2021-03-25', NULL, NULL), (1144, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL), (1145, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL), (1146, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL), (1147, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL), (1148, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL), (1149, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL), (1150, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL), (1151, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL), (1152, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL), (1153, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL), (1154, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL), (1155, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL), (1156, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-25', NULL, NULL), (1157, '2021-03-25', 2, 7, 'creo', 'registro proveedor', NULL, '2021-03-25', NULL, NULL), (1158, '2021-03-25', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-25', NULL, NULL), (1159, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-25', NULL, NULL), (1160, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL), (1161, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-25', NULL, NULL), (1162, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL), (1163, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL), (1164, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL), (1165, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a edición de usuarios por administración', NULL, '2021-03-25', NULL, NULL), (1166, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL), (1167, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a edición de usuarios por administración', NULL, '2021-03-25', NULL, NULL), (1168, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a edición de usuarios por administración', NULL, '2021-03-25', NULL, NULL), (1169, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL), (1170, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL), (1171, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL), (1172, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL), (1173, '2021-03-25', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-25', NULL, NULL), (1174, '2021-03-25', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-25', NULL, NULL), (1175, '2021-03-25', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-25', NULL, NULL), (1176, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL), (1177, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL), (1178, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL), (1179, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-25', NULL, NULL), (1180, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-25', NULL, NULL), (1181, '2021-03-25', 2, 7, 'creo', 'registro proveedor', NULL, '2021-03-25', NULL, NULL), (1182, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-25', NULL, NULL), (1183, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-25', NULL, NULL), (1184, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-25', NULL, NULL), (1185, '2021-03-25', 2, 7, 'creo', 'registro proveedor', NULL, '2021-03-25', NULL, NULL), (1186, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-25', NULL, NULL), (1187, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL), (1188, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL), (1189, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL), (1190, '2021-03-25', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-25', NULL, NULL), (1191, '2021-03-25', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-25', NULL, NULL), (1192, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL), (1193, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL), (1194, '2021-03-25', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-25', NULL, NULL), (1195, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL), (1196, '2021-03-25', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-25', NULL, NULL), (1197, '2021-03-25', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-25', NULL, NULL), (1198, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL), (1199, '2021-03-25', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-25', NULL, NULL), (1202, '2021-03-25', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-25', NULL, NULL), (1203, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL), (1204, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL), (1205, '2021-03-25', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-25', NULL, NULL), (1208, '2021-03-25', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-25', NULL, NULL), (1211, '2021-03-25', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-03-25', NULL, NULL), (1214, '2021-03-25', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-25', NULL, NULL), (1215, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL), (1216, '2021-03-25', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-25', NULL, NULL), (1217, '2021-03-25', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-03-25', NULL, NULL), (1220, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1221, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL), (1222, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL), (1223, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1224, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1225, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1226, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1227, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1228, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1229, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1230, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-26', NULL, NULL), (1231, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-26', NULL, NULL), (1232, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1233, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1234, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1235, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1236, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1237, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1256, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-26', NULL, NULL), (1257, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1258, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1259, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1260, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1261, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1262, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1264, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1265, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL), (1266, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL), (1267, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1270, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1271, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1272, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1275, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1276, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1277, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1278, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1279, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1280, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1281, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1282, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1283, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1284, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1285, '2021-03-26', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-26', NULL, NULL), (1286, '2021-03-26', 2, 7, 'creo', 'registro proveedor', NULL, '2021-03-26', NULL, NULL), (1289, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1290, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1295, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL), (1296, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1297, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-26', NULL, NULL), (1298, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1299, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1300, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1301, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1302, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1305, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1306, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1312, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1315, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1316, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1317, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1320, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1323, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1326, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1329, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1332, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1335, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1338, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1341, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1344, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1348, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1351, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1354, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1357, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1360, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1363, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1366, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1367, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1368, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1369, '2021-03-26', 2, 7, 'Elimina', 'Elimino Usuario', NULL, '2021-03-26', NULL, NULL), (1371, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1372, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1373, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1374, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1377, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL), (1378, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1379, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1380, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1381, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1382, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1385, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL), (1386, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1387, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL), (1388, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL), (1389, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a creación de usuario por administración', NULL, '2021-03-26', NULL, NULL), (1390, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL), (1391, '2021-03-26', 2, 9, 'Ingreso', 'Ingreso a edición de usuarios por administración', NULL, '2021-03-26', NULL, NULL), (1392, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL), (1393, '2021-03-26', 2, 9, 'Ingreso', 'Ingreso a edición de usuarios por administración', NULL, '2021-03-26', NULL, NULL), (1394, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL), (1395, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL), (1396, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL), (1397, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1398, '2021-03-26', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-26', NULL, NULL), (1399, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1400, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1401, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1402, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1403, '2021-03-26', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-26', NULL, NULL), (1406, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1407, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1408, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1409, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1410, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1411, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1412, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1413, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1414, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-26', NULL, NULL), (1415, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-26', NULL, NULL), (1417, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-03-26', NULL, NULL), (1419, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-26', NULL, NULL), (1421, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1422, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1423, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1424, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1425, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1426, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1427, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1428, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1429, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL), (1430, '2021-03-26', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-26', NULL, NULL), (1431, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL), (1432, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL), (1433, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL), (1434, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL), (1435, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1436, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1439, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1440, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL), (1441, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1442, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1443, '2021-03-26', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-26', NULL, NULL), (1444, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL), (1445, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL), (1446, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL), (1447, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL), (1448, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL), (1449, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL), (1450, '2021-03-26', 1, 3, 'Ingreso', 'Ingreso a recuperación por pregunta', NULL, '2021-03-26', NULL, NULL), (1451, '2021-03-26', 1, 2, 'Ingreso', 'Ingreso a recuperación por correo', NULL, '2021-03-26', NULL, NULL), (1452, '2021-03-26', 1, 2, 'Ingreso', 'Ingreso a recuperación por correo', NULL, '2021-03-26', NULL, NULL), (1453, '2021-03-26', 1, 2, 'Ingreso', 'Ingreso a recuperación por correo', NULL, '2021-03-26', NULL, NULL), (1454, '2021-03-26', 1, 2, 'Ingreso', 'Ingreso a recuperación por correo', NULL, '2021-03-26', NULL, NULL), (1455, '2021-03-26', 1, 2, 'Ingreso', 'Ingreso a recuperación por correo', NULL, '2021-03-26', NULL, NULL), (1456, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL), (1457, '2021-03-26', 1, 5, 'Ingreso', 'Ingreso a restablecer contraseña por correo', NULL, '2021-03-26', NULL, NULL), (1458, '2021-03-26', 1, 5, 'Ingreso', 'Ingreso a restablecer contraseña por correo', NULL, '2021-03-26', NULL, NULL), (1459, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL), (1460, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL), (1461, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL), (1462, '2021-03-26', 1, 23, 'Ingreso', 'Ingreso a consultar bitácora', NULL, '2021-03-26', NULL, NULL), (1463, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL), (1464, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL), (1465, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL), (1466, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL), (1467, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL), (1468, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1469, '2021-03-26', 31, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1470, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1471, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL), (1472, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1473, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1476, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL), (1483, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL), (1484, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL), (1485, '2021-04-02', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-02', NULL, NULL), (1486, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1487, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-02', NULL, NULL), (1492, '2021-04-02', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-02', NULL, NULL), (1493, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1494, '2021-04-02', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-02', NULL, NULL), (1495, '2021-04-02', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-02', NULL, NULL), (1496, '2021-04-02', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1497, '2021-04-02', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1498, '2021-04-02', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1499, '2021-04-02', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1500, '2021-04-02', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1501, '2021-04-02', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1502, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1503, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1504, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1505, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1506, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1507, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1508, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1509, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1510, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1511, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1512, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1513, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1514, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1515, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1516, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1517, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1518, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1519, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1520, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1521, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1522, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1523, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1524, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-02', NULL, NULL), (1527, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-02', NULL, NULL), (1530, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-02', NULL, NULL), (1533, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-02', NULL, NULL), (1536, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-02', NULL, NULL), (1539, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-02', NULL, NULL), (1542, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-02', NULL, NULL), (1545, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-02', NULL, NULL), (1549, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1550, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1551, '2021-04-02', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-02', NULL, NULL), (1552, '2021-04-02', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-02', NULL, NULL), (1553, '2021-04-02', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-02', NULL, NULL), (1554, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1555, '2021-04-02', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-02', NULL, NULL), (1556, '2021-04-02', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1557, '2021-04-02', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1558, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1559, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1560, '2021-04-02', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-02', NULL, NULL), (1561, '2021-04-02', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-02', NULL, NULL), (1562, '2021-04-02', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-04-02', NULL, NULL), (1563, '2021-04-02', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-04-02', NULL, NULL), (1564, '2021-04-02', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-04-02', NULL, NULL), (1565, '2021-04-02', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-02', NULL, NULL), (1566, '2021-04-02', 1, 23, 'Ingreso', 'Ingreso a consultar bitácora', NULL, '2021-04-02', NULL, NULL), (1567, '2021-04-02', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL), (1568, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-02', NULL, NULL), (1574, '2021-04-02', 1, 23, 'Ingreso', 'Ingreso a consultar bitácora', NULL, '2021-04-02', NULL, NULL), (1575, '2021-04-04', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-04', NULL, NULL), (1576, '2021-04-04', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-04-04', NULL, NULL), (1577, '2021-04-04', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-04', NULL, NULL), (1578, '2021-04-04', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-04', NULL, NULL), (1579, '2021-04-04', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-04', NULL, NULL), (1580, '2021-04-04', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-04', NULL, NULL), (1581, '2021-04-04', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-04', NULL, NULL), (1582, '2021-04-05', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-05', NULL, NULL), (1583, '2021-04-05', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-05', NULL, NULL), (1584, '2021-04-05', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-05', NULL, NULL), (1585, '2021-04-05', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-05', NULL, NULL), (1586, '2021-04-05', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-05', NULL, NULL), (1587, '2021-04-05', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-05', NULL, NULL), (1588, '2021-04-05', 1, 43, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-05', NULL, NULL), (1589, '2021-04-05', 1, 43, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-05', NULL, NULL), (1590, '2021-04-05', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-05', NULL, NULL), (1591, '2021-04-05', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-05', NULL, NULL), (1592, '2021-04-05', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-05', NULL, NULL), (1593, '2021-04-05', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-05', NULL, NULL), (1594, '2021-04-05', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-05', NULL, NULL), (1595, '2021-04-06', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-06', NULL, NULL), (1596, '2021-04-06', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1597, '2021-04-06', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-06', NULL, NULL), (1601, '2021-04-06', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1602, '2021-04-06', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-06', NULL, NULL), (1603, '2021-04-06', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-06', NULL, NULL), (1604, '2021-04-06', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1605, '2021-04-06', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1606, '2021-04-06', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-06', NULL, NULL), (1607, '2021-04-06', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-06', NULL, NULL), (1608, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1609, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1610, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1611, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1612, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1613, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1614, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1615, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1616, '2021-04-06', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1617, '2021-04-06', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-06', NULL, NULL), (1618, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1619, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1620, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1621, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1622, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1623, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1624, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1625, '2021-04-06', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-06', NULL, NULL), (1626, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1627, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1628, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1629, '2021-04-06', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-06', NULL, NULL), (1635, '2021-04-06', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1636, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1637, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1638, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1639, '2021-04-06', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-06', NULL, NULL), (1640, '2021-04-06', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1641, '2021-04-06', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-06', NULL, NULL), (1642, '2021-04-06', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-06', NULL, NULL), (1643, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL), (1644, '2021-04-14', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-14', NULL, NULL), (1645, '2021-04-14', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-14', NULL, NULL), (1646, '2021-04-14', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1647, '2021-04-14', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1648, '2021-04-14', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-14', NULL, NULL), (1649, '2021-04-14', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-14', NULL, NULL), (1650, '0000-00-00', 2, 12, 'Ingreso', 'Ingreso a módulo de roles', NULL, '2021-04-14', NULL, NULL), (1651, '0000-00-00', 2, 13, 'Ingreso', 'Ingreso a módulo de permisos', NULL, '2021-04-14', NULL, NULL), (1652, '2021-04-14', 1, 23, 'Ingreso', 'Ingreso a consultar bitácora', NULL, '2021-04-14', NULL, NULL), (1653, '2021-04-14', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-14', NULL, NULL), (1654, '2021-04-14', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-14', NULL, NULL), (1655, '2021-04-14', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-14', NULL, NULL), (1656, '2021-04-14', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1657, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1658, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1659, '2021-04-14', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1660, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1661, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1662, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1663, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1664, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1665, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1666, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1667, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1668, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1669, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1670, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1671, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1672, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1673, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1674, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1675, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1676, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1677, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1678, '2021-04-14', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-14', NULL, NULL), (1679, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1680, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1681, '2021-04-14', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-14', NULL, NULL), (1682, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1683, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1684, '2021-04-14', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-14', NULL, NULL), (1685, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1686, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1687, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1688, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1689, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1690, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1691, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1692, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1693, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1694, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1695, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1696, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1697, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1698, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1699, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1700, '2021-04-14', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1701, '2021-04-14', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-14', NULL, NULL), (1702, '2021-04-14', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-04-14', NULL, NULL), (1703, '2021-04-14', 2, 7, 'creo', 'registro proveedor', NULL, '2021-04-14', NULL, NULL), (1704, '2021-04-14', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1705, '2021-04-14', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-14', NULL, NULL), (1706, '2021-04-14', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1707, '0000-00-00', 2, 12, 'Ingreso', 'Ingreso a módulo de roles', NULL, '2021-04-14', NULL, NULL), (1708, '2021-04-14', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-14', NULL, NULL), (1709, '2021-04-14', 1, 23, 'Ingreso', 'Ingreso a consultar bitácora', NULL, '2021-04-14', NULL, NULL), (1710, '2021-04-14', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-04-14', NULL, NULL), (1711, '2021-04-14', 1, 43, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1712, '2021-04-14', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1713, '2021-04-14', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-14', NULL, NULL), (1714, '0000-00-00', 2, 12, 'Ingreso', 'Ingreso a módulo de roles', NULL, '2021-04-14', NULL, NULL), (1715, '2021-04-14', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-14', NULL, NULL), (1716, '2021-04-14', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-14', NULL, NULL), (1717, '2021-04-14', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-14', NULL, NULL), (1718, '2021-04-14', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-14', NULL, NULL), (1719, '2021-04-14', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-14', NULL, NULL), (1720, '2021-04-14', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-14', NULL, NULL), (1721, '2021-04-14', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-14', NULL, NULL), (1722, '2021-04-14', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-14', NULL, NULL), (1723, '2021-04-14', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-14', NULL, NULL), (1724, '2021-04-14', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-14', NULL, NULL), (1725, '2021-04-15', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-15', NULL, NULL), (1726, '2021-04-15', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-15', NULL, NULL), (1727, '2021-04-15', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-15', NULL, NULL), (1728, '2021-04-15', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-15', NULL, NULL), (1729, '2021-04-15', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-15', NULL, NULL), (1730, '2021-04-15', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-15', NULL, NULL), (1731, '2021-04-15', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-15', NULL, NULL), (1732, '2021-04-15', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-15', NULL, NULL), (1734, '2021-04-15', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-15', NULL, NULL), (1736, '2021-04-15', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-15', NULL, NULL), (1738, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1739, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1740, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1741, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1742, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1743, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1745, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1747, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1749, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1751, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1753, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1755, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1757, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1758, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1760, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1762, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1763, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1765, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1767, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL), (1769, '2021-04-15', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-04-15', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for tbl_ms_estado_usuario
-- ----------------------------
DROP TABLE IF EXISTS `tbl_ms_estado_usuario`;
CREATE TABLE `tbl_ms_estado_usuario`  (
  `id_estado_usuario` int(0) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_estado_usuario`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_ms_estado_usuario
-- ----------------------------
BEGIN;
INSERT INTO `tbl_ms_estado_usuario` VALUES (1, 'Activo'), (2, 'Inactivo'), (3, 'Desactivado'), (4, 'Nuevo'), (5, 'Bloqueado');
COMMIT;

-- ----------------------------
-- Table structure for tbl_ms_hist_contraseña
-- ----------------------------
DROP TABLE IF EXISTS `tbl_ms_hist_contraseña`;
CREATE TABLE `tbl_ms_hist_contraseña`  (
  `id_hist` int(0) NOT NULL AUTO_INCREMENT,
  `TBL_MS_USUARIO_id_usuario` int(0) NOT NULL,
  `contraseña` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `creado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `fecha_creacion` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `modificado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `fecha_modificacion` date NULL DEFAULT NULL,
  PRIMARY KEY (`id_hist`) USING BTREE,
  INDEX `fk_TBL_MS_HIST_CONTRASEÑA_TBL_MS_USUARIO1_idx`(`TBL_MS_USUARIO_id_usuario`) USING BTREE,
  CONSTRAINT `fk_TBL_MS_HIST_CONTRASEÑA_TBL_MS_USUARIO1` FOREIGN KEY (`TBL_MS_USUARIO_id_usuario`) REFERENCES `tbl_ms_usuario` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_ms_hist_contraseña
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tbl_ms_objetos
-- ----------------------------
DROP TABLE IF EXISTS `tbl_ms_objetos`;
CREATE TABLE `tbl_ms_objetos`  (
  `id_objeto` int(0) NOT NULL AUTO_INCREMENT,
  `objeto` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `descripcion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tipo_objeto` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `idPadre` int(0) NULL DEFAULT NULL,
  `icono` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `creado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `estado` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `fecha_creacion` date NULL DEFAULT NULL,
  `modificado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `fecha_modificacion` date NULL DEFAULT NULL,
  PRIMARY KEY (`id_objeto`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_ms_objetos
-- ----------------------------
BEGIN;
INSERT INTO `tbl_ms_objetos` VALUES (1, 'Login', 'Inicio sesión', 'Módulo', 0, NULL, NULL, NULL, 'desactivado', NULL, NULL, NULL), (2, 'Recuperación por Correo', 'Método de seguridad', 'Módulo', 0, NULL, NULL, NULL, 'desactivado', NULL, NULL, NULL), (3, 'Recuperación por pregunta secreta', 'Método de seguridad', 'Módulo', 0, NULL, NULL, NULL, 'desactivado', NULL, NULL, NULL), (4, 'Autoregistro', 'Creación propia de un perfil', 'Módulo', 0, NULL, NULL, NULL, 'desactivado', NULL, NULL, NULL), (5, 'Restablecer contraseña por correo', 'Método de seguridad', 'Módulo', 0, NULL, NULL, NULL, 'desactivado', NULL, NULL, NULL), (6, 'Restablecer contraseña por pregunta', 'Método de seguridad', 'Módulo', 0, NULL, NULL, NULL, 'desactivado', NULL, NULL, NULL), (7, 'Usuarios', 'Vista usuarios', 'Modulo', 10, 'fa fa-users', 'Admin/usuarios', NULL, 'activo', NULL, NULL, NULL), (8, 'Creacion de usuario', 'Crear usuario', 'Modulo', 0, NULL, NULL, NULL, 'desactivado', NULL, NULL, NULL), (9, 'Actualizar usuario', 'Editar usuario', 'Modulo', 0, NULL, NULL, NULL, 'desactivado', NULL, NULL, NULL), (10, 'Mantenimiento', 'mantenimiento del sistema', 'Modulo', 0, 'fa fa-archive', NULL, 'Admin', 'activo', NULL, NULL, NULL), (11, 'Seguridad', 'Seguridad del sistema', 'Modulo', 0, 'fas fa-shield-alt', NULL, 'Admin', 'activo', NULL, NULL, NULL), (12, 'Roles', 'Roles de los usuarios', 'Módulo', 11, 'fas fa-user-shield', 'Admin/roles', 'Admin', 'activo', NULL, NULL, NULL), (13, 'Permisos', 'Permisos de los modulos para los usuarios', 'Módulo', 11, 'fas fa-door-closed', 'Admin/permisos', 'Admin', 'activo', NULL, NULL, NULL), (14, 'Objetos', 'Menus ', 'Modulo', 11, 'fa fa-bookmark', 'Admin/objetos', NULL, 'activo', NULL, 'ROOT', '2021-03-25'), (23, 'Bitacora', 'Modulo de bitacora', 'Modulo', 11, 'fa fa-users', 'Admin/BitacoraList', 'ROOT', 'activo', '2021-03-17', NULL, NULL), (29, 'Clientes', 'Modulo de clientes', 'Modulo', 0, 'fa fa-users', '', 'ROOT', 'activo', '2021-03-22', NULL, NULL), (30, 'Clientes', 'Modulo de clientes', 'Modulo', 29, 'fa fa-users', 'Admin/Clientes', 'ROOT', 'activo', '2021-03-22', 'ROOT', '2021-03-26'), (32, 'Proveedores', 'Modulo de Proveedores', 'Modulo', 0, 'fa fa-university', '', 'ROOT', 'activo', '2021-03-25', NULL, NULL), (33, 'Proveedores', 'Modulo de Proveedores', 'Modulo', 32, 'fa fa-users', 'Admin/proveedores', 'ROOT', 'activo', '2021-03-25', NULL, NULL), (34, 'Ventas', 'Modulo de venta', 'Modulo', 0, 'fa fa-money', '', 'ROOT', 'activo', '2021-03-25', NULL, NULL), (35, 'Ventas', 'Modulo de venta', 'Modulo', 34, 'fa fa-bars', 'Admin/Ventas', 'ROOT', 'activo', '2021-03-25', NULL, NULL), (36, 'Nueva Venta', 'Modulo de Nueva venta', 'Modulo', 34, 'fa fa-plus', 'Admin/VentasNew', 'ROOT', 'activo', '2021-03-25', 'ROOT', '2021-03-25'), (37, 'Nuevo Proveedor', 'Modulo de nuevo proveedor', 'Modulo', 32, 'fas fa-user-plus', 'Admin/proveedoresnew', 'ROOT', 'activo', '2021-03-25', NULL, NULL), (38, 'Productos', 'Modulo de productos', 'Modulo', 0, 'fa fa-cube', '', 'ROOT', 'activo', '2021-03-25', NULL, NULL), (39, 'Productos ', 'Lista de productos ', 'Modulo', 38, 'fa fa-bars', 'Admin/Productos', 'ROOT', 'activo', '2021-03-25', NULL, NULL), (40, 'Nuevo producto', 'Nuevo producto', 'Modulo', 38, 'fa fa-plus', 'Admin/productosnew', 'ROOT', 'activo', '2021-03-25', NULL, NULL), (41, 'Nuevo Cliente', 'Crear nuevo cliente', 'Modulo', 29, 'fas fa-user-plus', 'Admin/clientesnew', 'ROOT', 'activo', '2021-03-26', NULL, NULL), (43, 'Actualizar Contraseña', 'Pantallapara actualizar contra', 'Modulo', 10, 'fas fa-ui', 'Admin/ActualizarContra', 'ROOT', 'activo', '2021-04-05', 'ROOT', '2021-04-05'), (44, 'Categoría productos', 'Modulo de productos', 'Modulo', 38, 'fa fa-bars', 'Admin/Categoria', 'ROOT', 'activo', '2021-04-06', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for tbl_ms_parametros
-- ----------------------------
DROP TABLE IF EXISTS `tbl_ms_parametros`;
CREATE TABLE `tbl_ms_parametros`  (
  `id_parametro` int(0) NOT NULL AUTO_INCREMENT,
  `parametro` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `valor` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fecha_creacion` date NULL DEFAULT NULL,
  `creado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `modificado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `fecha_modificacion` date NULL DEFAULT NULL,
  `TBL_MS_USUARIO_id_usuario` int(0) NOT NULL,
  PRIMARY KEY (`id_parametro`) USING BTREE,
  INDEX `fk_TBL_MS_PARAMETROS_TBL_MS_USUARIO1_idx`(`TBL_MS_USUARIO_id_usuario`) USING BTREE,
  CONSTRAINT `fk_TBL_MS_PARAMETROS_TBL_MS_USUARIO1` FOREIGN KEY (`TBL_MS_USUARIO_id_usuario`) REFERENCES `tbl_ms_usuario` (`id_usuario`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_ms_parametros
-- ----------------------------
BEGIN;
INSERT INTO `tbl_ms_parametros` VALUES (1, 'Correo_host', 'smtp.gmail.com', '2021-02-22', NULL, NULL, NULL, 1), (2, 'Correo_usuario', 'variedadesotac@gmail.com', '2021-02-22', NULL, NULL, NULL, 1), (3, 'Correo_contraseña', 'VOtac2021', '2021-02-22', NULL, NULL, NULL, 1), (4, 'Correo_tipo_smtp', 'TLS', '2021-02-22', NULL, NULL, NULL, 1), (5, 'Correo_puerto', '587', '2021-02-22', NULL, NULL, NULL, 1), (6, 'Correo_nombre', 'Solutions Team', NULL, NULL, NULL, NULL, 1), (7, 'Correo_horas_token', '24', NULL, NULL, NULL, NULL, 1), (8, 'ADMIN_INTENTOS', '3', NULL, NULL, NULL, NULL, 1);
COMMIT;

-- ----------------------------
-- Table structure for tbl_ms_permisos
-- ----------------------------
DROP TABLE IF EXISTS `tbl_ms_permisos`;
CREATE TABLE `tbl_ms_permisos`  (
  `id_permiso` int(0) NOT NULL AUTO_INCREMENT,
  `TBL_MS_ROLES_id_rol` int(0) NULL DEFAULT NULL,
  `TBL_MS_OBJETOS_id_objeto` int(0) NULL DEFAULT NULL,
  `permiso_insercion` int(0) NULL DEFAULT NULL,
  `permiso_eliminacion` int(0) NULL DEFAULT NULL,
  `permiso_actualizacion` int(0) NULL DEFAULT NULL,
  `permiso_consultar` int(0) NULL DEFAULT NULL,
  `creado_por` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fecha_creacion` date NULL DEFAULT NULL,
  `modificado_por` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fecha_modificacion` date NULL DEFAULT NULL,
  PRIMARY KEY (`id_permiso`) USING BTREE,
  INDEX `tbl_ms_permisos_FK`(`TBL_MS_ROLES_id_rol`) USING BTREE,
  INDEX `tbl_ms_permisos_FK_1`(`TBL_MS_OBJETOS_id_objeto`) USING BTREE,
  CONSTRAINT `tbl_ms_permisos_FK` FOREIGN KEY (`TBL_MS_ROLES_id_rol`) REFERENCES `tbl_ms_roles` (`id_rol`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tbl_ms_permisos_FK_1` FOREIGN KEY (`TBL_MS_OBJETOS_id_objeto`) REFERENCES `tbl_ms_objetos` (`id_objeto`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8 COLLATE = utf8_general_ci;

-- ----------------------------
-- Records of tbl_ms_permisos
-- ----------------------------
BEGIN;
INSERT INTO `tbl_ms_permisos` VALUES (6, 2, 11, 1, 1, 1, 1, 'Admin', NULL, 'ROOT', '2021-03-15'), (7, 2, 12, 1, 1, 1, 1, 'Admin', NULL, 'ROOT', '2021-03-15'), (8, 2, 13, 1, 1, 1, 1, 'Admin', NULL, 'ROOT', '2021-03-15'), (9, 1, 4, 1, 0, 1, 1, 'ROOT', '2021-03-12', 'ROOT', '2021-03-13'), (10, 1, 2, 1, 1, 0, 1, 'ROOT', '2021-03-12', 'ROOT', '2021-03-14'), (11, 3, 11, 0, 0, 1, 0, 'ROOT', '2021-03-13', 'ROOT', '2021-03-13'), (18, 2, 7, 1, 1, 1, 1, 'ROOT', '2021-03-13', NULL, NULL), (19, 2, 14, 1, 1, 1, 1, 'ROOT', '2021-03-13', 'ROOT', '2021-03-15'), (23, 4, 9, 1, 1, 1, 1, 'ROOT', '2021-03-13', NULL, NULL), (24, 1, 9, 1, 0, 1, 1, 'ROOT', '2021-03-13', 'ROOT', '2021-03-14'), (25, 4, 10, 1, 1, 1, 0, 'ROOT', '2021-03-13', NULL, NULL), (26, 4, 14, 0, 0, 0, 1, 'ROOT', '2021-03-13', NULL, NULL), (27, 4, 13, 0, 0, 0, 0, 'ROOT', '2021-03-13', NULL, NULL), (28, 4, 12, 0, 0, 0, 0, 'ROOT', '2021-03-13', NULL, NULL), (29, 3, 2, 1, 1, 1, 0, 'ROOT', '2021-03-13', NULL, NULL), (30, 3, 14, 1, 1, 0, 0, 'ROOT', '2021-03-13', NULL, NULL), (31, 3, 13, 0, 0, 0, 0, 'ROOT', '2021-03-13', 'ROOT', '2021-03-17'), (32, 3, 10, 1, 1, 0, 1, 'ROOT', '2021-03-13', NULL, NULL), (34, 4, 10, 1, 1, 1, 1, 'ROOT', '2021-03-14', 'ROOT', '2021-03-14'), (37, 2, 23, 1, 1, 1, 1, 'ROOT', '2021-03-17', NULL, NULL), (38, 3, 23, 0, 0, 0, 1, 'ROOT', '2021-03-17', NULL, NULL), (42, 2, 30, 1, 1, 1, 1, 'ROOT', '2021-03-22', NULL, NULL), (46, 2, 33, 1, 1, 1, 1, 'ROOT', '2021-03-25', NULL, NULL), (47, 2, 35, 1, 1, 1, 1, 'ROOT', '2021-03-25', NULL, NULL), (48, 2, 36, 1, 1, 1, 1, 'ROOT', '2021-03-25', NULL, NULL), (49, 2, 37, 1, 1, 1, 1, 'ROOT', '2021-03-25', NULL, NULL), (50, 2, 39, 1, 1, 1, 1, 'ROOT', '2021-03-25', NULL, NULL), (51, 2, 40, 1, 1, 1, 1, 'ROOT', '2021-03-25', NULL, NULL), (52, 2, 41, 1, 1, 1, 1, 'ROOT', '2021-03-26', NULL, NULL), (53, 3, 30, 1, 1, 1, 1, 'ROOT', '2021-03-26', NULL, NULL), (54, 2, 43, 1, 1, 1, 1, 'ROOT', '2021-04-05', NULL, NULL), (55, 2, 44, 1, 1, 1, 1, 'ROOT', '2021-04-06', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for tbl_ms_preguntas
-- ----------------------------
DROP TABLE IF EXISTS `tbl_ms_preguntas`;
CREATE TABLE `tbl_ms_preguntas`  (
  `id_pregunta` int(0) NOT NULL AUTO_INCREMENT,
  `pregunta` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fecha_creacion` date NULL DEFAULT NULL,
  `creado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `fecha_modificacion` date NULL DEFAULT NULL,
  `modificado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_pregunta`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_ms_preguntas
-- ----------------------------
BEGIN;
INSERT INTO `tbl_ms_preguntas` VALUES (1, '¿Cuál es tu color favorito?', NULL, NULL, NULL, NULL, 1), (2, '¿Cuál es tu país favorito?', NULL, NULL, NULL, NULL, 1), (3, '¿Cuál es el nombre de tu mascota?', NULL, NULL, NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for tbl_ms_preguntas_usuario
-- ----------------------------
DROP TABLE IF EXISTS `tbl_ms_preguntas_usuario`;
CREATE TABLE `tbl_ms_preguntas_usuario`  (
  `id_preguntas_usuario` int(0) NOT NULL AUTO_INCREMENT,
  `id_pregunta` int(0) NOT NULL,
  `id_usuario` int(0) NOT NULL,
  `respuesta` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `creado_por` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fecha_creacion` date NOT NULL,
  `fecha_modificacion` date NOT NULL,
  `modificado_por` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_preguntas_usuario`) USING BTREE,
  INDEX `usuarios_preguntas_respuestas`(`id_pregunta`) USING BTREE,
  CONSTRAINT `usuarios_preguntas_respuestas` FOREIGN KEY (`id_pregunta`) REFERENCES `tbl_ms_preguntas` (`id_pregunta`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_ms_preguntas_usuario
-- ----------------------------
BEGIN;
INSERT INTO `tbl_ms_preguntas_usuario` VALUES (16, 1, 27, 'AZUL', '27', '0000-00-00', '0000-00-00', '27'), (17, 1, 29, 'ROJO', '29', '0000-00-00', '0000-00-00', '29'), (18, 1, 30, 'ROJO', '30', '0000-00-00', '0000-00-00', '30'), (19, 1, 31, 'ROJO', '31', '0000-00-00', '0000-00-00', '31');
COMMIT;

-- ----------------------------
-- Table structure for tbl_ms_roles
-- ----------------------------
DROP TABLE IF EXISTS `tbl_ms_roles`;
CREATE TABLE `tbl_ms_roles`  (
  `id_rol` int(0) NOT NULL AUTO_INCREMENT,
  `rol` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `descripcion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fecha_creacion` date NULL DEFAULT NULL,
  `creado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `fecha_modificacion` date NULL DEFAULT NULL,
  `modificado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_rol`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_ms_roles
-- ----------------------------
BEGIN;
INSERT INTO `tbl_ms_roles` VALUES (1, 'Default', '.', '2021-02-22', NULL, '2021-03-25', 'ROOT'), (2, 'Administrador', 'Usuario administrativo', '2021-02-22', NULL, '2021-03-13', 'ROOT'), (3, 'Empleado', 'Usuario de ventas', NULL, NULL, NULL, NULL), (4, 'Ejecutivo', 'Usuario gerente', '2021-03-13', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for tbl_ms_token_usuario
-- ----------------------------
DROP TABLE IF EXISTS `tbl_ms_token_usuario`;
CREATE TABLE `tbl_ms_token_usuario`  (
  `id_token` int(0) NOT NULL AUTO_INCREMENT,
  `token` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_usuario` int(0) NOT NULL,
  `fecha_inicial` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fecha_final` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_token`) USING BTREE,
  INDEX `token_usuario`(`id_usuario`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_ms_token_usuario
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tbl_ms_usuario
-- ----------------------------
DROP TABLE IF EXISTS `tbl_ms_usuario`;
CREATE TABLE `tbl_ms_usuario`  (
  `id_usuario` int(0) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_estado_usuario` int(0) NOT NULL,
  `contrasena` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nombre_usuario` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `apellido_usuario` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `genero_usuario` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `correo_usuario` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `TBL_MS_ROLES_id_rol` int(0) NOT NULL,
  `fecha_creacion` date NULL DEFAULT NULL,
  `creado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `fecha_modificacion` date NULL DEFAULT NULL,
  `modificado_por` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `fecha_ultima_conexion` date NULL DEFAULT NULL,
  `fecha_vencimiento` date NULL DEFAULT NULL,
  `preguntas_contestadas` int(0) NULL DEFAULT NULL,
  `primer_ingreso` int(0) NULL DEFAULT NULL,
  `token` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `fecha_inicial` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `fecha_final` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `intentos` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`) USING BTREE,
  INDEX `fk_TBL_MS_USUARIO_TBL_MS_ROLES1_idx`(`TBL_MS_ROLES_id_rol`) USING BTREE,
  INDEX `estados_usuarios`(`id_estado_usuario`) USING BTREE,
  CONSTRAINT `estados_usuarios` FOREIGN KEY (`id_estado_usuario`) REFERENCES `tbl_ms_estado_usuario` (`id_estado_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_TBL_MS_USUARIO_TBL_MS_ROLES1` FOREIGN KEY (`TBL_MS_ROLES_id_rol`) REFERENCES `tbl_ms_roles` (`id_rol`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_ms_usuario
-- ----------------------------
BEGIN;
INSERT INTO `tbl_ms_usuario` VALUES (1, 'Sin Registrar', 1, '99875d29b6df38b2b484f1e8ec5979c7', '', '', '', '', 2, '2021-02-22', NULL, NULL, NULL, '2021-02-25', NULL, NULL, NULL, 'aEB2WDtQ6wJRYHb', '23-02-2021 13:57:08', '24-02-2021 13:57:08', NULL), (2, 'ROOT', 1, 'e10adc3949ba59abbe56e057f20f883e', 'Variedades', 'OTAC', 'M', 'VARIEDADESOTAC@GMAIL.COM', 2, '2021-02-23', 'SUPERADMIN', '2021-03-03', '19', '2021-04-14', '2021-02-23', NULL, 1, 'hpfx6ZPAHBnNRMe', '03-03-2021 01:27:10', '04-03-2021 01:27:10', 3), (29, 'HOLAAA', 1, 'dc763dbe574ab3827c9cb1d1fddfa994', 'HOLAA', 'KJ NZX', 'M', 'FERNANDO.CABRERA@UNAH.HN', 3, '2021-03-17', 'ROOT', NULL, NULL, '2021-03-17', '2021-03-17', NULL, 1, NULL, NULL, NULL, 3), (31, 'mguzman', 1, 'e10adc3949ba59abbe56e057f20f883e', 'FERNANDO', 'WDCWS', 'M', 'CABRERAF83@GMAIL.COM', 3, '2021-03-17', 'ROOT', NULL, NULL, '2021-04-14', '2021-03-17', NULL, 1, 'Token reclamado', '26-03-2021 21:20:48', '27-03-2021 21:20:48', 3);
COMMIT;

-- ----------------------------
-- Table structure for tbl_perdidas
-- ----------------------------
DROP TABLE IF EXISTS `tbl_perdidas`;
CREATE TABLE `tbl_perdidas`  (
  `id_perdida` int(0) NOT NULL AUTO_INCREMENT,
  `cantidad_perdida` int(0) NOT NULL,
  `TBL_PRODUCTOS_id_producto` int(0) NOT NULL,
  `TBL_KARDEX_id_kardex` int(0) NOT NULL,
  PRIMARY KEY (`id_perdida`) USING BTREE,
  INDEX `fk_TBL_PERDIDAS_TBL_PRODUCTOS1_idx`(`TBL_PRODUCTOS_id_producto`) USING BTREE,
  INDEX `fk_TBL_PERDIDAS_TBL_KARDEX1_idx`(`TBL_KARDEX_id_kardex`) USING BTREE,
  CONSTRAINT `fk_TBL_PERDIDAS_TBL_PRODUCTOS1` FOREIGN KEY (`TBL_PRODUCTOS_id_producto`) REFERENCES `tbl_productos` (`id_producto`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_perdidas
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tbl_productos
-- ----------------------------
DROP TABLE IF EXISTS `tbl_productos`;
CREATE TABLE `tbl_productos`  (
  `id_producto` int(0) NOT NULL AUTO_INCREMENT,
  `id_proveedor` int(0) NOT NULL,
  `nombre_producto` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_categoria` int(0) NOT NULL,
  `desc_producto` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `precio_venta` decimal(9, 2) NOT NULL,
  `cantidad_max` int(0) NOT NULL,
  `cantidad_min` int(0) NOT NULL,
  `stock` int(0) NOT NULL,
  `fecha_registro` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_producto`) USING BTREE,
  INDEX `nombre_categoria`(`id_categoria`) USING BTREE,
  INDEX `id_proveedor`(`id_proveedor`) USING BTREE,
  CONSTRAINT `tbl_productos_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `tbl_proveedores` (`id_proveedor`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tbl_productos_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `tbl_categoria` (`id_categoria`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_productos
-- ----------------------------
BEGIN;
INSERT INTO `tbl_productos` VALUES (21, 1, 'Banano', 1, 'Cajas de bananos', 300.00, 60, 0, 40, '2021-04-15 00:00:00');
COMMIT;

-- ----------------------------
-- Table structure for tbl_proveedores
-- ----------------------------
DROP TABLE IF EXISTS `tbl_proveedores`;
CREATE TABLE `tbl_proveedores`  (
  `id_proveedor` int(0) NOT NULL AUTO_INCREMENT,
  `proveedor` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `contacto` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `telefono` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `direccion` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fecha_creacion` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id_proveedor`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_proveedores
-- ----------------------------
BEGIN;
INSERT INTO `tbl_proveedores` VALUES (1, 'ARIEL ', 'FGHJ', '785245696', 'DEFGHYUGFDSFRTYU', '2021-04-14 00:00:00'), (2, 'JJKKJ', 'NMNM', '858585', 'IJMIKJ I', '2021-04-14 00:00:00'), (3, 'IMMIIM', 'NNJJNNJJN', '456852', 'KMKIDFMODFKI', '2021-04-14 00:00:00'), (4, 'YUJIKOKIJUY', 'YHUJIKJUHYGTFT', '47896352478', 'GYHUNJIUY', '2021-04-14 00:00:00'), (5, 'ALIN RODRIGUEZ', 'TELEFONO', '99999999', 'SU CASA', '2021-04-14 23:36:31');
COMMIT;

-- ----------------------------
-- Table structure for tbl_tipo_kardex
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tipo_kardex`;
CREATE TABLE `tbl_tipo_kardex`  (
  `id_tipo_kardex` int(0) NOT NULL AUTO_INCREMENT,
  `nombre_tipo_kardex` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id_tipo_kardex`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_tipo_kardex
-- ----------------------------
BEGIN;
INSERT INTO `tbl_tipo_kardex` VALUES (1, 'ENTRADA'), (2, 'SALIDA');
COMMIT;

-- ----------------------------
-- Table structure for tbl_ventas
-- ----------------------------
DROP TABLE IF EXISTS `tbl_ventas`;
CREATE TABLE `tbl_ventas`  (
  `id_venta` int(0) NOT NULL AUTO_INCREMENT,
  `fecha_venta` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `cantidad_venta` int(0) NOT NULL,
  `isv` decimal(9, 2) NOT NULL,
  `descuento` decimal(9, 2) NOT NULL,
  `total_venta` decimal(10, 2) NOT NULL,
  `usuario` int(0) NOT NULL,
  `id_cliente` int(0) NOT NULL,
  PRIMARY KEY (`id_venta`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of tbl_ventas
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Procedure structure for data
-- ----------------------------
DROP PROCEDURE IF EXISTS `data`;
delimiter ;;
CREATE PROCEDURE `data`()
BEGIN
DECLARE usuarios int;
DECLARE clientes int;
DECLARE proveedores int;
DECLARE productos int;
DECLARE ventas int;
SELECT COUNT(*) INTO usuarios FROM tbl_ms_usuario;

SELECT COUNT(*) INTO proveedores FROM tbl_proveedores;
SELECT COUNT(*) INTO productos FROM tbl_productos;
SELECT COUNT(*) INTO ventas FROM tbl_ventas WHERE fecha > CURDATE();

SELECT usuarios, clientes, proveedores, productos, ventas;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for procesar_venta
-- ----------------------------
DROP PROCEDURE IF EXISTS `procesar_venta`;
delimiter ;;
CREATE PROCEDURE `procesar_venta`(IN `cod_usuario` INT, IN `cod_cliente` INT, IN `token` VARCHAR(50))
BEGIN
DECLARE factura INT;
DECLARE registros INT;
DECLARE total DECIMAL(10,2);
DECLARE nueva_existencia int;
DECLARE existencia_actual int;

DECLARE tmp_cod_producto int;
DECLARE tmp_cant_producto int;
DECLARE a int;
SET a = 1;

CREATE TEMPORARY TABLE tbl_tmp_tokenuser(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cod_prod BIGINT,
    cant_prod int);
SET registros = (SELECT COUNT(*) FROM detalle_temp WHERE token_user = token);
IF registros > 0 THEN
INSERT INTO tbl_tmp_tokenuser(cod_prod, cant_prod) SELECT codproducto, cantidad FROM detalle_temp WHERE token_user = token;
INSERT INTO factura (usuario,codcliente) VALUES (cod_usuario, cod_cliente);
SET factura = LAST_INSERT_ID();

INSERT INTO detallefactura(nofactura,codproducto,cantidad,precio_venta) SELECT (factura) AS nofactura, codproducto, cantidad,precio_venta FROM detalle_temp WHERE token_user = token;
WHILE a <= registros DO
	SELECT cod_prod, cant_prod INTO tmp_cod_producto,tmp_cant_producto FROM tbl_tmp_tokenuser WHERE id = a;
    SELECT existencia INTO existencia_actual FROM producto WHERE codproducto = tmp_cod_producto;
    SET nueva_existencia = existencia_actual - tmp_cant_producto;
    UPDATE producto SET existencia = nueva_existencia WHERE codproducto = tmp_cod_producto;
    SET a=a+1;
END WHILE;
SET total = (SELECT SUM(cantidad * precio_venta) FROM detalle_temp WHERE token_user = token);
UPDATE factura SET totalfactura = total WHERE nofactura = factura;
DELETE FROM detalle_temp WHERE token_user = token;
TRUNCATE TABLE tbl_tmp_tokenuser;
SELECT * FROM factura WHERE nofactura = factura;
ELSE
SELECT 0;
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for splogin
-- ----------------------------
DROP PROCEDURE IF EXISTS `splogin`;
delimiter ;;
CREATE PROCEDURE `splogin`(IN `pusuario` VARCHAR(50), IN `ppass` VARCHAR(200))
begin
	
	declare num int;
    declare numerorestar int;
    declare numm int;
	declare codUsuario int;





 start transaction;


if exists(select * from tbl_ms_usuario where usuario = upper(pusuario) and contrasena = ppass and id_estado_usuario =1 and creado_por = 'Autoregistro' and primer_ingreso=0)THEN 

 	SELECT 2 as codigo;
   

end if;


if exists(select * from tbl_ms_usuario where usuario = upper(pusuario) and contrasena = ppass and id_estado_usuario = 1 and creado_por <> 'Autoregistro' and primer_ingreso=0)THEN 

 	SELECT 3 as codigo;
   

end if;

if exists(select * from tbl_ms_usuario  where usuario = upper(pusuario) and id_estado_usuario =5)THEN 

 	SELECT 1 as codigo, 'El usuario está bloqueadoo, comuniquese con el administrador' as mensaje;

end if;

if exists(select * from tbl_ms_usuario where usuario = upper(pusuario) and id_estado_usuario =2)THEN 

 	SELECT 1 as codigo, 'El usuario está desactivado, comuniquese con el administrador' as mensaje;

end if;

if not exists(select * from tbl_ms_usuario where usuario =upper(pusuario)) then 

   select 1 as codigo,'El usuario no existe' as mensaje;

end if;





if exists(select * from tbl_ms_usuario where usuario = upper(pusuario) and  contrasena = ppass and id_estado_usuario = 1) THEN 

	
	      update tbl_ms_usuario set fecha_ultima_conexion = curdate() where usuario = upper(pusuario);
	      set num = (select valor from tbl_ms_parametros where parametro = 'ADMIN_INTENTOS');
          update tbl_ms_usuario set intentos = num where usuario = upper(pusuario);
          commit;

	       SELECT * from tbl_ms_usuario where usuario =upper(pusuario);
	      
		else

		 set num = (select intentos from tbl_ms_usuario where usuario = upper(pusuario));
         set numerorestar=(num-1);
         update tbl_ms_usuario set intentos = numerorestar where usuario = upper(pusuario) and usuario <> 'ROOT';
         set numm = (select intentos from tbl_ms_usuario where usuario = upper(pusuario));
         commit;

        if(numm = -1) then
          update tbl_ms_usuario set id_estado_usuario = 5 where usuario =upper(pusuario);
          select 1 as codigo,'se ha bloqueado el usuario, comuniquese con el administrador' as mensaje;
        end if;
         select 1 as codigo, 'El correo o la contraseña son incorrectos' as mensaje;
  end if;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spTblBitacoraInsert
-- ----------------------------
DROP PROCEDURE IF EXISTS `spTblBitacoraInsert`;
delimiter ;;
CREATE PROCEDURE `spTblBitacoraInsert`(IN `codu` INT, IN `codo` INT, IN `accion` VARCHAR(100), IN `descrip` VARCHAR(100))
begin

	insert into tbl_ms_bitacora (TBL_MS_USUARIO_id_usuario,TBL_MS_OBJETOS_id_objeto,accion,descripcion,fecha_creacion) values (codu,codo,accion,descrip,sysdate());

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spTbl_ms_ClientesEliminar
-- ----------------------------
DROP PROCEDURE IF EXISTS `spTbl_ms_ClientesEliminar`;
delimiter ;;
CREATE PROCEDURE `spTbl_ms_ClientesEliminar`(IN `Pid` INT)
begin
 delete from tbl_clientes where id_cliente = Pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spTbl_ms_Objetos_Actualizar
-- ----------------------------
DROP PROCEDURE IF EXISTS `spTbl_ms_Objetos_Actualizar`;
delimiter ;;
CREATE PROCEDURE `spTbl_ms_Objetos_Actualizar`(IN `pcod` INT, IN `pobjeto` VARCHAR(100), IN `pdescripcion` VARCHAR(100), IN `ptipo` VARCHAR(15), IN `pidpadre` INT, IN `picono` VARCHAR(100), IN `purl` VARCHAR(100), IN `pestado` VARCHAR(100), IN `pcreado` VARCHAR(100))
begin

	start transaction;

	update tbl_ms_objetos set objeto = pobjeto, descripcion = pdescripcion, tipo_objeto = ptipo, idPadre = pidpadre, icono = picono,

			url = purl, estado = pestado, modificado_por = pcreado, fecha_modificacion = curdate() where id_objeto = pcod; 

	commit;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spTbl_ms_Objetos_Insertar
-- ----------------------------
DROP PROCEDURE IF EXISTS `spTbl_ms_Objetos_Insertar`;
delimiter ;;
CREATE PROCEDURE `spTbl_ms_Objetos_Insertar`(IN `pobjeto` VARCHAR(100), IN `pdescripcion` VARCHAR(100), IN `ptipo` VARCHAR(15), IN `pidpadre` INT, IN `picono` VARCHAR(100), IN `purl` VARCHAR(100), IN `pestado` VARCHAR(100), IN `pcreado` VARCHAR(100))
begin

	start transaction;

	insert into tbl_ms_objetos(objeto,descripcion,tipo_objeto,idPadre,icono,url,estado,creado_por,fecha_creacion)

	values(pobjeto,pdescripcion,ptipo,pidpadre,picono,purl,pestado,pcreado,curdate());

	commit;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spTbl_ms_Objetos_Mostrar
-- ----------------------------
DROP PROCEDURE IF EXISTS `spTbl_ms_Objetos_Mostrar`;
delimiter ;;
CREATE PROCEDURE `spTbl_ms_Objetos_Mostrar`()
begin

	select * from tbl_ms_objetos;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spTbl_ms_Permisos_Actualizar
-- ----------------------------
DROP PROCEDURE IF EXISTS `spTbl_ms_Permisos_Actualizar`;
delimiter ;;
CREATE PROCEDURE `spTbl_ms_Permisos_Actualizar`(`pinsertar` INT(1), `peliminar` INT(1), `pactualizar` INT(1), `pconsultar` INT(1), `pcreadopor` VARCHAR(15), `pcod` INT(11))
begin

	start transaction;

	update tbl_ms_permisos SET  permiso_insercion = pinsertar, permiso_eliminacion = peliminar,

								 permiso_actualizacion = pactualizar, permiso_consultar = pconsultar, modificado_por = pcreadopor, fecha_modificacion = curdate() where id_permiso = pcod;

	commit;

  select 0 as codigo,'Se ha actualizado correctamente' as mensaje;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spTbl_ms_Permisos_Eliminar
-- ----------------------------
DROP PROCEDURE IF EXISTS `spTbl_ms_Permisos_Eliminar`;
delimiter ;;
CREATE PROCEDURE `spTbl_ms_Permisos_Eliminar`(`pcod` INT(11))
begin

	start transaction;

		delete from tbl_ms_permisos where id_permiso = pcod;

	commit;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spTbl_ms_Permisos_Insertar
-- ----------------------------
DROP PROCEDURE IF EXISTS `spTbl_ms_Permisos_Insertar`;
delimiter ;;
CREATE PROCEDURE `spTbl_ms_Permisos_Insertar`(`prol` INT(11), `pobjeto` INT(11), `pinsertar` INT(1), `peliminar` INT(1), `pactualizar` INT(1), `pconsultar` INT(1), `pcreadopor` VARCHAR(15))
begin

	

	if exists(select TBL_MS_ROLES_id_rol from tbl_ms_permisos where TBL_MS_ROLES_id_rol = prol and TBL_MS_OBJETOS_id_objeto = pobjeto) then 

	select 1 as codigo,'No pueden existir valores duplicados' as mensaje;



	ELSE

start transaction;

		insert into tbl_ms_permisos (TBL_MS_ROLES_id_rol,TBL_MS_OBJETOS_id_objeto,permiso_insercion,permiso_eliminacion,permiso_actualizacion,permiso_consultar,creado_por,fecha_creacion)

				values(prol,pobjeto,pinsertar,peliminar,pactualizar,pconsultar,pcreadopor,curdate());

			commit;

		

		  select 0 as codigo,'Se ha creado correctamente' as mensaje;

		 end if;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spTbl_ms_Permisos_Mostrar
-- ----------------------------
DROP PROCEDURE IF EXISTS `spTbl_ms_Permisos_Mostrar`;
delimiter ;;
CREATE PROCEDURE `spTbl_ms_Permisos_Mostrar`()
begin

	SELECT p.id_permiso, p.TBL_MS_ROLES_id_rol AS roll, p.TBL_MS_OBJETOS_id_objeto AS obj ,r.rol,o.objeto,p.permiso_insercion,

	p.permiso_eliminacion,p.permiso_actualizacion,p.permiso_consultar,

	p.creado_por AS creado, p.modificado_por AS modificado, p.fecha_creacion AS fech_crea , 

	p.fecha_modificacion AS fech_mod

	

	from tbl_ms_permisos p join tbl_ms_roles r on p.TBL_MS_ROLES_id_rol = r.id_rol 

	join tbl_ms_objetos o on p.TBL_MS_OBJETOS_id_objeto = o.id_objeto;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spTbl_ms_ProductosEliminar
-- ----------------------------
DROP PROCEDURE IF EXISTS `spTbl_ms_ProductosEliminar`;
delimiter ;;
CREATE PROCEDURE `spTbl_ms_ProductosEliminar`(IN `Pid` INT)
begin
 delete from tbl_productos where id_producto = Pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spTbl_ms_Roles_Actualizar
-- ----------------------------
DROP PROCEDURE IF EXISTS `spTbl_ms_Roles_Actualizar`;
delimiter ;;
CREATE PROCEDURE `spTbl_ms_Roles_Actualizar`(IN `pcod` INT(11), IN `prol` VARCHAR(30), IN `pdescripcion` VARCHAR(100), IN `pmodificado` VARCHAR(15))
begin

	start transaction;

	update tbl_ms_roles set rol = prol, descripcion = pdescripcion, modificado_por = pmodificado, fecha_modificacion = curdate() where id_rol = pcod; 

	commit;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spTbl_ms_Roles_Insertar
-- ----------------------------
DROP PROCEDURE IF EXISTS `spTbl_ms_Roles_Insertar`;
delimiter ;;
CREATE PROCEDURE `spTbl_ms_Roles_Insertar`(IN `prol` VARCHAR(30), IN `pdescripcion` VARCHAR(100), IN `pcreado` VARCHAR(15))
begin

	start transaction;

	insert into tbl_ms_roles(rol,descripcion,fecha_creacion,creado_por) Values(prol,pdescripcion,curdate(),pcreado);

	commit;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spTbl_ms_Roles_Mostrar
-- ----------------------------
DROP PROCEDURE IF EXISTS `spTbl_ms_Roles_Mostrar`;
delimiter ;;
CREATE PROCEDURE `spTbl_ms_Roles_Mostrar`()
begin

	select * from tbl_ms_roles;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spTbl_ms_UsuariosEliminar
-- ----------------------------
DROP PROCEDURE IF EXISTS `spTbl_ms_UsuariosEliminar`;
delimiter ;;
CREATE PROCEDURE `spTbl_ms_UsuariosEliminar`(IN `Pid` INT)
begin
	delete from tbl_ms_usuario where id_usuario = Pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spTbl_ms_UsuariosInsertar
-- ----------------------------
DROP PROCEDURE IF EXISTS `spTbl_ms_UsuariosInsertar`;
delimiter ;;
CREATE PROCEDURE `spTbl_ms_UsuariosInsertar`(IN `pusuario` VARCHAR(50), IN `pidestado` INT, IN `Ppasswordd` VARCHAR(100), IN `pNom_persona` VARCHAR(50), IN `pApellido` VARCHAR(50), IN `pSexo` ENUM('F','M'), IN `Pcorreo` VARCHAR(50), IN `PcodRol` BIGINT, IN `pcreadopor` VARCHAR(15), IN `pUsr_registro` VARCHAR(50))
BEGIN

  declare num int;
  declare limite int;
  declare vigencia_dias int;
  declare vigencia int;

    if exists(SELECT * from tbl_ms_usuario where correo_usuario = pCorreo)then
    select 1 as codigo, 'Ya existe un usuario con este correo' as mensaje;
    ELSE 
    start transaction;

    set num = (select valor from tbl_ms_parametros where parametro = 'ADMIN_INTENTOS');
    set limite = (select valor from tbl_ms_parametros where parametro = 'ADMIN_VIGENCIA_USUARIO_DIAS');
	set vigencia_dias = (select curdate() + INTERVAL limite day); 
    set vigencia = (SELECT DATEDIFF(vigencia_dias, curdate()));

   
  insert into tbl_ms_usuario (usuario,id_estado_usuario ,contrasena ,nombre_usuario ,apellido_usuario 
  ,genero_usuario ,correo_usuario ,TBL_MS_ROLES_id_rol ,fecha_creacion ,creado_por,fecha_vencimiento,primer_ingreso)
 values (pusuario,pidestado,Ppasswordd,pNom_persona ,pApellido,pSexo,UPPER(Pcorreo),PcodRol,curdate(),pcreadopor,curdate(),0);

 

  COMMIT;

  select 0 as codigo, 'Se ha registrado correctamente' as mensaje;

 end if;

 end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for spTbl_ms_UsuariosInsertaraA
-- ----------------------------
DROP PROCEDURE IF EXISTS `spTbl_ms_UsuariosInsertaraA`;
delimiter ;;
CREATE PROCEDURE `spTbl_ms_UsuariosInsertaraA`(IN `pusuario` VARCHAR(50), IN `pidestado` INT, IN `Ppasswordd` VARCHAR(100), IN `pNom_persona` VARCHAR(50), IN `pApellido` VARCHAR(50), IN `pSexo` ENUM('F','M'), IN `Pcorreo` VARCHAR(50), IN `PcodRol` BIGINT, IN `pcreadopor` VARCHAR(15))
begin
	
  declare num int;
  declare limite int;
  declare vigencia_dias int;
  declare vigencia int;

    if exists(SELECT * from tbl_ms_usuario where correo_usuario = pCorreo)then
    select 1 as codigo, 'Ya existe un usuario con este correo' as mensaje;
    end if;
   
    if exists(SELECT * from tbl_ms_usuario where usuario = pusuario)then
    select 1 as codigo, 'Ya existe un usuario con este nombre' as mensaje;
    end if;
   
    start transaction;

    set num = (select valor from tbl_ms_parametros where parametro = 'ADMIN_INTENTOS');
    set limite = (select valor from tbl_ms_parametros where parametro = 'ADMIN_VIGENCIA_USUARIO_DIAS');
	set vigencia_dias = (select curdate() + INTERVAL limite day); 
    set vigencia = (SELECT DATEDIFF(vigencia_dias, curdate()));

   
  insert into tbl_ms_usuario (usuario,id_estado_usuario ,contrasena ,nombre_usuario ,apellido_usuario 
  ,genero_usuario ,correo_usuario ,TBL_MS_ROLES_id_rol ,fecha_creacion ,creado_por,fecha_vencimiento,primer_ingreso)
 values (pusuario,pidestado,Ppasswordd,pNom_persona ,pApellido,pSexo,UPPER(Pcorreo),PcodRol,curdate(),pcreadopor,curdate(),0);

 

  COMMIT;

  select 0 as codigo, 'Se ha registrado correctamente' as mensaje;

 
 end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for tt
-- ----------------------------
DROP PROCEDURE IF EXISTS `tt`;
delimiter ;;
CREATE PROCEDURE `tt`()
BEGIN
 select * from tbl_ms_preguntas;

END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
