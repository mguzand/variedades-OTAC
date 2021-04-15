-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-04-2021 a las 08:04:27
-- Versión del servidor: 10.4.16-MariaDB
-- Versión de PHP: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_variedadesotaci`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `data` ()  BEGIN
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

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procesar_venta` (IN `cod_usuario` INT, IN `cod_cliente` INT, IN `token` VARCHAR(50))  BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `splogin` (IN `pusuario` VARCHAR(50), IN `ppass` VARCHAR(200))  begin
	
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
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTblBitacoraInsert` (IN `codu` INT, IN `codo` INT, IN `accion` VARCHAR(100), IN `descrip` VARCHAR(100))  begin

	insert into tbl_ms_bitacora (TBL_MS_USUARIO_id_usuario,TBL_MS_OBJETOS_id_objeto,accion,descripcion,fecha_creacion) values (codu,codo,accion,descrip,sysdate());

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTbl_ms_ClientesEliminar` (IN `Pid` INT)  begin
 delete from tbl_clientes where id_cliente = Pid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTbl_ms_Objetos_Actualizar` (IN `pcod` INT, IN `pobjeto` VARCHAR(100), IN `pdescripcion` VARCHAR(100), IN `ptipo` VARCHAR(15), IN `pidpadre` INT, IN `picono` VARCHAR(100), IN `purl` VARCHAR(100), IN `pestado` VARCHAR(100), IN `pcreado` VARCHAR(100))  begin

	start transaction;

	update tbl_ms_objetos set objeto = pobjeto, descripcion = pdescripcion, tipo_objeto = ptipo, idPadre = pidpadre, icono = picono,

			url = purl, estado = pestado, modificado_por = pcreado, fecha_modificacion = curdate() where id_objeto = pcod; 

	commit;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTbl_ms_Objetos_Insertar` (IN `pobjeto` VARCHAR(100), IN `pdescripcion` VARCHAR(100), IN `ptipo` VARCHAR(15), IN `pidpadre` INT, IN `picono` VARCHAR(100), IN `purl` VARCHAR(100), IN `pestado` VARCHAR(100), IN `pcreado` VARCHAR(100))  begin

	start transaction;

	insert into tbl_ms_objetos(objeto,descripcion,tipo_objeto,idPadre,icono,url,estado,creado_por,fecha_creacion)

	values(pobjeto,pdescripcion,ptipo,pidpadre,picono,purl,pestado,pcreado,curdate());

	commit;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTbl_ms_Objetos_Mostrar` ()  begin

	select * from tbl_ms_objetos;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTbl_ms_Permisos_Actualizar` (`pinsertar` INT(1), `peliminar` INT(1), `pactualizar` INT(1), `pconsultar` INT(1), `pcreadopor` VARCHAR(15), `pcod` INT(11))  begin

	start transaction;

	update tbl_ms_permisos SET  permiso_insercion = pinsertar, permiso_eliminacion = peliminar,

								 permiso_actualizacion = pactualizar, permiso_consultar = pconsultar, modificado_por = pcreadopor, fecha_modificacion = curdate() where id_permiso = pcod;

	commit;

  select 0 as codigo,'Se ha actualizado correctamente' as mensaje;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTbl_ms_Permisos_Eliminar` (`pcod` INT(11))  begin

	start transaction;

		delete from tbl_ms_permisos where id_permiso = pcod;

	commit;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTbl_ms_Permisos_Insertar` (`prol` INT(11), `pobjeto` INT(11), `pinsertar` INT(1), `peliminar` INT(1), `pactualizar` INT(1), `pconsultar` INT(1), `pcreadopor` VARCHAR(15))  begin

	

	if exists(select TBL_MS_ROLES_id_rol from tbl_ms_permisos where TBL_MS_ROLES_id_rol = prol and TBL_MS_OBJETOS_id_objeto = pobjeto) then 

	select 1 as codigo,'No pueden existir valores duplicados' as mensaje;



	ELSE

start transaction;

		insert into tbl_ms_permisos (TBL_MS_ROLES_id_rol,TBL_MS_OBJETOS_id_objeto,permiso_insercion,permiso_eliminacion,permiso_actualizacion,permiso_consultar,creado_por,fecha_creacion)

				values(prol,pobjeto,pinsertar,peliminar,pactualizar,pconsultar,pcreadopor,curdate());

			commit;

		

		  select 0 as codigo,'Se ha creado correctamente' as mensaje;

		 end if;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTbl_ms_Permisos_Mostrar` ()  begin

	SELECT p.id_permiso, p.TBL_MS_ROLES_id_rol AS roll, p.TBL_MS_OBJETOS_id_objeto AS obj ,r.rol,o.objeto,p.permiso_insercion,

	p.permiso_eliminacion,p.permiso_actualizacion,p.permiso_consultar,

	p.creado_por AS creado, p.modificado_por AS modificado, p.fecha_creacion AS fech_crea , 

	p.fecha_modificacion AS fech_mod

	

	from tbl_ms_permisos p join tbl_ms_roles r on p.TBL_MS_ROLES_id_rol = r.id_rol 

	join tbl_ms_objetos o on p.TBL_MS_OBJETOS_id_objeto = o.id_objeto;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTbl_ms_ProductosEliminar` (IN `Pid` INT)  begin
 delete from tbl_productos where id_producto = Pid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTbl_ms_Roles_Actualizar` (IN `pcod` INT(11), IN `prol` VARCHAR(30), IN `pdescripcion` VARCHAR(100), IN `pmodificado` VARCHAR(15))  begin

	start transaction;

	update tbl_ms_roles set rol = prol, descripcion = pdescripcion, modificado_por = pmodificado, fecha_modificacion = curdate() where id_rol = pcod; 

	commit;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTbl_ms_Roles_Insertar` (IN `prol` VARCHAR(30), IN `pdescripcion` VARCHAR(100), IN `pcreado` VARCHAR(15))  begin

	start transaction;

	insert into tbl_ms_roles(rol,descripcion,fecha_creacion,creado_por) Values(prol,pdescripcion,curdate(),pcreado);

	commit;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTbl_ms_Roles_Mostrar` ()  begin

	select * from tbl_ms_roles;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTbl_ms_UsuariosEliminar` (IN `Pid` INT)  begin
	delete from tbl_ms_usuario where id_usuario = Pid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTbl_ms_UsuariosInsertar` (IN `pusuario` VARCHAR(50), IN `pidestado` INT, IN `Ppasswordd` VARCHAR(100), IN `pNom_persona` VARCHAR(50), IN `pApellido` VARCHAR(50), IN `pSexo` ENUM('F','M'), IN `Pcorreo` VARCHAR(50), IN `PcodRol` BIGINT, IN `pcreadopor` VARCHAR(15), IN `pUsr_registro` VARCHAR(50))  BEGIN

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

 end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTbl_ms_UsuariosInsertaraA` (IN `pusuario` VARCHAR(50), IN `pidestado` INT, IN `Ppasswordd` VARCHAR(100), IN `pNom_persona` VARCHAR(50), IN `pApellido` VARCHAR(50), IN `pSexo` ENUM('F','M'), IN `Pcorreo` VARCHAR(50), IN `PcodRol` BIGINT, IN `pcreadopor` VARCHAR(15))  begin
	
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

 
 end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tt` ()  BEGIN
 select * from tbl_ms_preguntas;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_categoria`
--

CREATE TABLE `tbl_categoria` (
  `id_categoria` int(11) NOT NULL,
  `nombre_categoria` varchar(30) NOT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `creado_por` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_categoria`
--

INSERT INTO `tbl_categoria` (`id_categoria`, `nombre_categoria`, `fecha_creacion`, `creado_por`) VALUES
(1, 'AGROPECUARIA', '2021-04-06', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_clientes`
--

CREATE TABLE `tbl_clientes` (
  `id_cliente` int(11) NOT NULL,
  `DNI` varchar(20) NOT NULL,
  `nombre_cliente` varchar(100) NOT NULL,
  `telefono_cliente` int(15) NOT NULL,
  `direccion_cliente` varchar(100) NOT NULL,
  `fecha_creacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_clientes`
--

INSERT INTO `tbl_clientes` (`id_cliente`, `DNI`, `nombre_cliente`, `telefono_cliente`, `direccion_cliente`, `fecha_creacion`) VALUES
(3, '080120000641', 'Fernando C', 2147483647, 'direccion_cliente', NULL),
(4, '123456789', 'prueba ', 2147483647, 'ASDFGHJKLÑ', NULL),
(7, '787878787878', 'sdfrtgyuiop', 2147483647, '789sjfihsjd888', NULL),
(8, '784551224188', 'YHYHYHYH', 2147483647, 'GYUJHNJKJMKL', NULL),
(9, '789845652565', 'GWHJIDOCSILRUFN', 2147483647, 'JSDKNCKUSILDRN', NULL),
(10, '87945465123', 'HOLA', 2147483647, 'JUSUUJSDUNUNXSU', NULL),
(11, '789654156', 'KSUHDCN KSDL', 2147483647, 'SSDCOSMPCOWE', NULL),
(12, '273423452345', 'FFFFFFFF', 2147483647, '2938472093', NULL),
(13, 'LAJKERFNLKWDS', 'JUUUJUJUJUJ', 2147483647, 'ASDFGHJKLDFGH', NULL),
(14, '7412368963', 'SSSSSAAAAA', 2147483647, 'HJKLOIUYTFVB', NULL),
(15, '741258963', 'RFVBNMJUYTRFVBN', 1478523698, 'DFGHJUYTR7', NULL),
(16, '112226189645', 'ghyjuio', 2147483647, 'ghjukiopkjkk', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_compras`
--

CREATE TABLE `tbl_compras` (
  `id_compra` int(11) NOT NULL,
  `desc_compra` varchar(100) NOT NULL,
  `fecha_orden` date NOT NULL,
  `fecha_entrega` date NOT NULL,
  `cantidad_compra` int(11) NOT NULL,
  `cantidad_recibida` int(11) NOT NULL,
  `TBL_PROVEEDORES_id_proveedor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_devoluciones`
--

CREATE TABLE `tbl_devoluciones` (
  `id_devolucion` int(11) NOT NULL,
  `cantidad_dev` int(11) NOT NULL,
  `TBL_PRODUCTOS_id_producto` int(11) NOT NULL,
  `TBL_KARDEX_id_kardex` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_inventarios`
--

CREATE TABLE `tbl_inventarios` (
  `id_inventario` int(11) NOT NULL,
  `cantidad_disp` int(11) NOT NULL,
  `tipo` tinyint(1) NOT NULL COMMENT '1= stockin , 2 = stockout',
  `stock` varchar(100) NOT NULL COMMENT 'sales/receiving',
  `TBL_PRODUCTOS_id_producto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_kardex`
--

CREATE TABLE `tbl_kardex` (
  `id_kardex` int(11) NOT NULL,
  `cantidad_kardex` int(11) NOT NULL,
  `precio` decimal(9,2) NOT NULL,
  `fecha_kardex` date NOT NULL,
  `TBL_TIPO_KARDEX_id_tipo_kardex` int(11) NOT NULL,
  `TBL_PRODUCTOS_id_producto` int(11) NOT NULL,
  `TBL_MS_USUARIO_id_usuario` int(11) NOT NULL,
  `TBL_COMPRAS_id_compra` int(11) NOT NULL,
  `TBL_VENTAS_id_venta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_ms_bitacora`
--

CREATE TABLE `tbl_ms_bitacora` (
  `id_bitacora` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `TBL_MS_USUARIO_id_usuario` int(11) NOT NULL,
  `TBL_MS_OBJETOS_id_objeto` int(11) NOT NULL,
  `accion` varchar(20) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `creado_por` varchar(15) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `modificado_por` varchar(15) DEFAULT NULL,
  `fecha_modificacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_ms_bitacora`
--

INSERT INTO `tbl_ms_bitacora` (`id_bitacora`, `fecha`, `TBL_MS_USUARIO_id_usuario`, `TBL_MS_OBJETOS_id_objeto`, `accion`, `descripcion`, `creado_por`, `fecha_creacion`, `modificado_por`, `fecha_modificacion`) VALUES
(1143, '2021-03-25', 1, 23, 'Ingreso', 'Ingreso a consultar bitácora', NULL, '2021-03-25', NULL, NULL),
(1144, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL),
(1145, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL),
(1146, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL),
(1147, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL),
(1148, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL),
(1149, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL),
(1150, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL),
(1151, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL),
(1152, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL),
(1153, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL),
(1154, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL),
(1155, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL),
(1156, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-25', NULL, NULL),
(1157, '2021-03-25', 2, 7, 'creo', 'registro proveedor', NULL, '2021-03-25', NULL, NULL),
(1158, '2021-03-25', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-25', NULL, NULL),
(1159, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-25', NULL, NULL),
(1160, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL),
(1161, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-25', NULL, NULL),
(1162, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL),
(1163, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL),
(1164, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL),
(1165, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a edición de usuarios por administración', NULL, '2021-03-25', NULL, NULL),
(1166, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL),
(1167, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a edición de usuarios por administración', NULL, '2021-03-25', NULL, NULL),
(1168, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a edición de usuarios por administración', NULL, '2021-03-25', NULL, NULL),
(1169, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL),
(1170, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL),
(1171, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL),
(1172, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL),
(1173, '2021-03-25', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-25', NULL, NULL),
(1174, '2021-03-25', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-25', NULL, NULL),
(1175, '2021-03-25', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-25', NULL, NULL),
(1176, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL),
(1177, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL),
(1178, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL),
(1179, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-25', NULL, NULL),
(1180, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-25', NULL, NULL),
(1181, '2021-03-25', 2, 7, 'creo', 'registro proveedor', NULL, '2021-03-25', NULL, NULL),
(1182, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-25', NULL, NULL),
(1183, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-25', NULL, NULL),
(1184, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-25', NULL, NULL),
(1185, '2021-03-25', 2, 7, 'creo', 'registro proveedor', NULL, '2021-03-25', NULL, NULL),
(1186, '2021-03-25', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-25', NULL, NULL),
(1187, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL),
(1188, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL),
(1189, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL),
(1190, '2021-03-25', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-25', NULL, NULL),
(1191, '2021-03-25', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-25', NULL, NULL),
(1192, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL),
(1193, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL),
(1194, '2021-03-25', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-25', NULL, NULL),
(1195, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL),
(1196, '2021-03-25', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-25', NULL, NULL),
(1197, '2021-03-25', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-25', NULL, NULL),
(1198, '2021-03-25', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-25', NULL, NULL),
(1199, '2021-03-25', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-25', NULL, NULL),
(1202, '2021-03-25', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-25', NULL, NULL),
(1203, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL),
(1204, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL),
(1205, '2021-03-25', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-25', NULL, NULL),
(1208, '2021-03-25', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-25', NULL, NULL),
(1211, '2021-03-25', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-03-25', NULL, NULL),
(1214, '2021-03-25', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-25', NULL, NULL),
(1215, '2021-03-25', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-25', NULL, NULL),
(1216, '2021-03-25', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-25', NULL, NULL),
(1217, '2021-03-25', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-03-25', NULL, NULL),
(1220, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1221, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL),
(1222, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL),
(1223, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1224, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1225, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1226, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1227, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1228, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1229, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1230, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-26', NULL, NULL),
(1231, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-26', NULL, NULL),
(1232, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1233, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1234, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1235, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1236, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1237, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1256, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-26', NULL, NULL),
(1257, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1258, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1259, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1260, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1261, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1262, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1264, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1265, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL),
(1266, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL),
(1267, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1270, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1271, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1272, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1275, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1276, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1277, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1278, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1279, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1280, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1281, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1282, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1283, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1284, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1285, '2021-03-26', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-26', NULL, NULL),
(1286, '2021-03-26', 2, 7, 'creo', 'registro proveedor', NULL, '2021-03-26', NULL, NULL),
(1289, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1290, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1295, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL),
(1296, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1297, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-26', NULL, NULL),
(1298, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1299, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1300, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1301, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1302, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1305, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1306, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1312, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1315, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1316, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1317, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1320, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1323, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1326, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1329, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1332, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1335, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1338, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1341, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1344, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1348, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1351, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1354, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1357, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1360, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1363, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1366, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1367, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1368, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1369, '2021-03-26', 2, 7, 'Elimina', 'Elimino Usuario', NULL, '2021-03-26', NULL, NULL),
(1371, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1372, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1373, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1374, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1377, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL),
(1378, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1379, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1380, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1381, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1382, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1385, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL),
(1386, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1387, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL),
(1388, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL),
(1389, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a creación de usuario por administración', NULL, '2021-03-26', NULL, NULL),
(1390, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL),
(1391, '2021-03-26', 2, 9, 'Ingreso', 'Ingreso a edición de usuarios por administración', NULL, '2021-03-26', NULL, NULL),
(1392, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL),
(1393, '2021-03-26', 2, 9, 'Ingreso', 'Ingreso a edición de usuarios por administración', NULL, '2021-03-26', NULL, NULL),
(1394, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL),
(1395, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL),
(1396, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL),
(1397, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1398, '2021-03-26', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-26', NULL, NULL),
(1399, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1400, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1401, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1402, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1403, '2021-03-26', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-26', NULL, NULL),
(1406, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1407, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1408, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1409, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1410, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1411, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1412, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1413, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1414, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-26', NULL, NULL),
(1415, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-26', NULL, NULL),
(1417, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de productos por administración', NULL, '2021-03-26', NULL, NULL),
(1419, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-03-26', NULL, NULL),
(1421, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1422, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1423, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1424, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1425, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1426, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1427, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1428, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1429, '2021-03-26', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-03-26', NULL, NULL),
(1430, '2021-03-26', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-26', NULL, NULL),
(1431, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL),
(1432, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL),
(1433, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL),
(1434, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL),
(1435, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1436, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1439, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1440, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL),
(1441, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1442, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1443, '2021-03-26', 2, 9, 'Ingreso', 'Ingreso a creación de proveedor por administración', NULL, '2021-03-26', NULL, NULL),
(1444, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL),
(1445, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL),
(1446, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL),
(1447, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL),
(1448, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL),
(1449, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL),
(1450, '2021-03-26', 1, 3, 'Ingreso', 'Ingreso a recuperación por pregunta', NULL, '2021-03-26', NULL, NULL),
(1451, '2021-03-26', 1, 2, 'Ingreso', 'Ingreso a recuperación por correo', NULL, '2021-03-26', NULL, NULL),
(1452, '2021-03-26', 1, 2, 'Ingreso', 'Ingreso a recuperación por correo', NULL, '2021-03-26', NULL, NULL),
(1453, '2021-03-26', 1, 2, 'Ingreso', 'Ingreso a recuperación por correo', NULL, '2021-03-26', NULL, NULL),
(1454, '2021-03-26', 1, 2, 'Ingreso', 'Ingreso a recuperación por correo', NULL, '2021-03-26', NULL, NULL),
(1455, '2021-03-26', 1, 2, 'Ingreso', 'Ingreso a recuperación por correo', NULL, '2021-03-26', NULL, NULL),
(1456, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL),
(1457, '2021-03-26', 1, 5, 'Ingreso', 'Ingreso a restablecer contraseña por correo', NULL, '2021-03-26', NULL, NULL),
(1458, '2021-03-26', 1, 5, 'Ingreso', 'Ingreso a restablecer contraseña por correo', NULL, '2021-03-26', NULL, NULL),
(1459, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL),
(1460, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL),
(1461, '2021-03-26', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-03-26', NULL, NULL),
(1462, '2021-03-26', 1, 23, 'Ingreso', 'Ingreso a consultar bitácora', NULL, '2021-03-26', NULL, NULL),
(1463, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL),
(1464, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL),
(1465, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL),
(1466, '2021-03-26', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-03-26', NULL, NULL),
(1467, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL),
(1468, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1469, '2021-03-26', 31, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1470, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1471, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL),
(1472, '2021-03-26', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1473, '2021-03-26', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1476, '2021-03-26', 2, 36, 'Editar Producto', 'Ingreso a edición de clientes por administración', NULL, '2021-03-26', NULL, NULL),
(1483, '2021-03-26', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-03-26', NULL, NULL),
(1484, '2021-03-26', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-03-26', NULL, NULL),
(1485, '2021-04-02', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-02', NULL, NULL),
(1486, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1487, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-02', NULL, NULL),
(1492, '2021-04-02', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-02', NULL, NULL),
(1493, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1494, '2021-04-02', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-02', NULL, NULL),
(1495, '2021-04-02', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-02', NULL, NULL),
(1496, '2021-04-02', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1497, '2021-04-02', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1498, '2021-04-02', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1499, '2021-04-02', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1500, '2021-04-02', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1501, '2021-04-02', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1502, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1503, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1504, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1505, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1506, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1507, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1508, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1509, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1510, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1511, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1512, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1513, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1514, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1515, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1516, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1517, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1518, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1519, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1520, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1521, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1522, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1523, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1524, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-02', NULL, NULL),
(1527, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-02', NULL, NULL),
(1530, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-02', NULL, NULL),
(1533, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-02', NULL, NULL),
(1536, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-02', NULL, NULL),
(1539, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-02', NULL, NULL),
(1542, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-02', NULL, NULL),
(1545, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-02', NULL, NULL),
(1549, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1550, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1551, '2021-04-02', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-02', NULL, NULL),
(1552, '2021-04-02', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-02', NULL, NULL),
(1553, '2021-04-02', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-02', NULL, NULL),
(1554, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1555, '2021-04-02', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-02', NULL, NULL),
(1556, '2021-04-02', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1557, '2021-04-02', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1558, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1559, '2021-04-02', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1560, '2021-04-02', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-02', NULL, NULL),
(1561, '2021-04-02', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-02', NULL, NULL),
(1562, '2021-04-02', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-04-02', NULL, NULL),
(1563, '2021-04-02', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-04-02', NULL, NULL),
(1564, '2021-04-02', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-04-02', NULL, NULL),
(1565, '2021-04-02', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-02', NULL, NULL),
(1566, '2021-04-02', 1, 23, 'Ingreso', 'Ingreso a consultar bitácora', NULL, '2021-04-02', NULL, NULL),
(1567, '2021-04-02', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-02', NULL, NULL),
(1568, '2021-04-02', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-02', NULL, NULL),
(1574, '2021-04-02', 1, 23, 'Ingreso', 'Ingreso a consultar bitácora', NULL, '2021-04-02', NULL, NULL),
(1575, '2021-04-04', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-04', NULL, NULL),
(1576, '2021-04-04', 1, 7, 'Ingreso', 'Ingreso a módulo de usuarios', NULL, '2021-04-04', NULL, NULL),
(1577, '2021-04-04', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-04', NULL, NULL),
(1578, '2021-04-04', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-04', NULL, NULL),
(1579, '2021-04-04', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-04', NULL, NULL),
(1580, '2021-04-04', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-04', NULL, NULL),
(1581, '2021-04-04', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-04', NULL, NULL),
(1582, '2021-04-05', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-05', NULL, NULL),
(1583, '2021-04-05', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-05', NULL, NULL),
(1584, '2021-04-05', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-05', NULL, NULL),
(1585, '2021-04-05', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-05', NULL, NULL),
(1586, '2021-04-05', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-05', NULL, NULL),
(1587, '2021-04-05', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-05', NULL, NULL),
(1588, '2021-04-05', 1, 43, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-05', NULL, NULL),
(1589, '2021-04-05', 1, 43, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-05', NULL, NULL),
(1590, '2021-04-05', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-05', NULL, NULL),
(1591, '2021-04-05', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-05', NULL, NULL),
(1592, '2021-04-05', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-05', NULL, NULL),
(1593, '2021-04-05', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-05', NULL, NULL),
(1594, '2021-04-05', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-05', NULL, NULL),
(1595, '2021-04-06', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-06', NULL, NULL),
(1596, '2021-04-06', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1597, '2021-04-06', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-06', NULL, NULL),
(1601, '2021-04-06', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1602, '2021-04-06', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-06', NULL, NULL),
(1603, '2021-04-06', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-06', NULL, NULL),
(1604, '2021-04-06', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1605, '2021-04-06', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1606, '2021-04-06', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-06', NULL, NULL),
(1607, '2021-04-06', 2, 8, 'Ingreso', 'Ingreso a módulo de permisos por Admin', NULL, '2021-04-06', NULL, NULL),
(1608, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1609, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1610, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1611, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1612, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1613, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1614, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1615, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1616, '2021-04-06', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1617, '2021-04-06', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-06', NULL, NULL),
(1618, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1619, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1620, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1621, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1622, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1623, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1624, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1625, '2021-04-06', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-06', NULL, NULL),
(1626, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1627, '2021-04-06', 1, 44, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1628, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1629, '2021-04-06', 2, 38, 'Ingreso', 'Ingreso a creación de productos por administración', NULL, '2021-04-06', NULL, NULL),
(1635, '2021-04-06', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1636, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1637, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1638, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1639, '2021-04-06', 1, 1, 'Ingreso', 'Ingreso a iniciar sesión', NULL, '2021-04-06', NULL, NULL),
(1640, '2021-04-06', 1, 30, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL),
(1641, '2021-04-06', 2, 38, 'Ingreso', 'Ingreso a creación de clientes por administración', NULL, '2021-04-06', NULL, NULL),
(1642, '2021-04-06', 1, 33, 'Ingreso', 'Ingreso a módulo de proveedores', NULL, '2021-04-06', NULL, NULL),
(1643, '2021-04-06', 1, 39, 'Ingreso', 'Ingreso a módulo de Productos', NULL, '2021-04-06', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_ms_estado_usuario`
--

CREATE TABLE `tbl_ms_estado_usuario` (
  `id_estado_usuario` int(11) NOT NULL,
  `descripcion` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_ms_estado_usuario`
--

INSERT INTO `tbl_ms_estado_usuario` (`id_estado_usuario`, `descripcion`) VALUES
(1, 'Activo'),
(2, 'Inactivo'),
(3, 'Desactivado'),
(4, 'Nuevo'),
(5, 'Bloqueado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_ms_hist_contraseña`
--

CREATE TABLE `tbl_ms_hist_contraseña` (
  `id_hist` int(11) NOT NULL,
  `TBL_MS_USUARIO_id_usuario` int(11) NOT NULL,
  `contraseña` varchar(100) NOT NULL,
  `creado_por` varchar(15) DEFAULT NULL,
  `fecha_creacion` varchar(45) DEFAULT NULL,
  `modificado_por` varchar(15) DEFAULT NULL,
  `fecha_modificacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_ms_objetos`
--

CREATE TABLE `tbl_ms_objetos` (
  `id_objeto` int(11) NOT NULL,
  `objeto` varchar(100) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `tipo_objeto` varchar(15) NOT NULL,
  `idPadre` int(11) DEFAULT NULL,
  `icono` varchar(100) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `creado_por` varchar(15) DEFAULT NULL,
  `estado` varchar(100) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `modificado_por` varchar(15) DEFAULT NULL,
  `fecha_modificacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_ms_objetos`
--

INSERT INTO `tbl_ms_objetos` (`id_objeto`, `objeto`, `descripcion`, `tipo_objeto`, `idPadre`, `icono`, `url`, `creado_por`, `estado`, `fecha_creacion`, `modificado_por`, `fecha_modificacion`) VALUES
(1, 'Login', 'Inicio sesión', 'Módulo', 0, NULL, NULL, NULL, 'desactivado', NULL, NULL, NULL),
(2, 'Recuperación por Correo', 'Método de seguridad', 'Módulo', 0, NULL, NULL, NULL, 'desactivado', NULL, NULL, NULL),
(3, 'Recuperación por pregunta secreta', 'Método de seguridad', 'Módulo', 0, NULL, NULL, NULL, 'desactivado', NULL, NULL, NULL),
(4, 'Autoregistro', 'Creación propia de un perfil', 'Módulo', 0, NULL, NULL, NULL, 'desactivado', NULL, NULL, NULL),
(5, 'Restablecer contraseña por correo', 'Método de seguridad', 'Módulo', 0, NULL, NULL, NULL, 'desactivado', NULL, NULL, NULL),
(6, 'Restablecer contraseña por pregunta', 'Método de seguridad', 'Módulo', 0, NULL, NULL, NULL, 'desactivado', NULL, NULL, NULL),
(7, 'Usuarios', 'Vista usuarios', 'Modulo', 10, 'fa fa-users', 'Admin/usuarios', NULL, 'activo', NULL, NULL, NULL),
(8, 'Creacion de usuario', 'Crear usuario', 'Modulo', 0, NULL, NULL, NULL, 'desactivado', NULL, NULL, NULL),
(9, 'Actualizar usuario', 'Editar usuario', 'Modulo', 0, NULL, NULL, NULL, 'desactivado', NULL, NULL, NULL),
(10, 'Mantenimiento', 'mantenimiento del sistema', 'Modulo', 0, 'fa fa-archive', NULL, 'Admin', 'activo', NULL, NULL, NULL),
(11, 'Seguridad', 'Seguridad del sistema', 'Modulo', 0, 'fas fa-shield-alt', NULL, 'Admin', 'activo', NULL, NULL, NULL),
(12, 'Roles', 'Roles de los usuarios', 'Módulo', 11, 'fas fa-user-shield', 'Admin/roles', 'Admin', 'activo', NULL, NULL, NULL),
(13, 'Permisos', 'Permisos de los modulos para los usuarios', 'Módulo', 11, 'fas fa-door-closed', 'Admin/permisos', 'Admin', 'activo', NULL, NULL, NULL),
(14, 'Objetos', 'Menus ', 'Modulo', 11, 'fa fa-bookmark', 'Admin/objetos', NULL, 'activo', NULL, 'ROOT', '2021-03-25'),
(23, 'Bitacora', 'Modulo de bitacora', 'Modulo', 11, 'fa fa-users', 'Admin/BitacoraList', 'ROOT', 'activo', '2021-03-17', NULL, NULL),
(29, 'Clientes', 'Modulo de clientes', 'Modulo', 0, 'fa fa-users', '', 'ROOT', 'activo', '2021-03-22', NULL, NULL),
(30, 'Clientes', 'Modulo de clientes', 'Modulo', 29, 'fa fa-users', 'Admin/Clientes', 'ROOT', 'activo', '2021-03-22', 'ROOT', '2021-03-26'),
(32, 'Proveedores', 'Modulo de Proveedores', 'Modulo', 0, 'fa fa-university', '', 'ROOT', 'activo', '2021-03-25', NULL, NULL),
(33, 'Proveedores', 'Modulo de Proveedores', 'Modulo', 32, 'fa fa-users', 'Admin/proveedores', 'ROOT', 'activo', '2021-03-25', NULL, NULL),
(34, 'Ventas', 'Modulo de venta', 'Modulo', 0, 'fa fa-money', '', 'ROOT', 'activo', '2021-03-25', NULL, NULL),
(35, 'Ventas', 'Modulo de venta', 'Modulo', 34, 'fa fa-bars', 'Admin/Ventas', 'ROOT', 'activo', '2021-03-25', NULL, NULL),
(36, 'Nueva Venta', 'Modulo de Nueva venta', 'Modulo', 34, 'fa fa-plus', 'Admin/VentasNew', 'ROOT', 'activo', '2021-03-25', 'ROOT', '2021-03-25'),
(37, 'Nuevo Proveedor', 'Modulo de nuevo proveedor', 'Modulo', 32, 'fas fa-user-plus', 'Admin/proveedoresnew', 'ROOT', 'activo', '2021-03-25', NULL, NULL),
(38, 'Productos', 'Modulo de productos', 'Modulo', 0, 'fa fa-cube', '', 'ROOT', 'activo', '2021-03-25', NULL, NULL),
(39, 'Productos ', 'Lista de productos ', 'Modulo', 38, 'fa fa-bars', 'Admin/Productos', 'ROOT', 'activo', '2021-03-25', NULL, NULL),
(40, 'Nuevo producto', 'Nuevo producto', 'Modulo', 38, 'fa fa-plus', 'Admin/productosnew', 'ROOT', 'activo', '2021-03-25', NULL, NULL),
(41, 'Nuevo Cliente', 'Crear nuevo cliente', 'Modulo', 29, 'fas fa-user-plus', 'Admin/clientesnew', 'ROOT', 'activo', '2021-03-26', NULL, NULL),
(43, 'Actualizar Contraseña', 'Pantallapara actualizar contra', 'Modulo', 10, 'fas fa-ui', 'Admin/ActualizarContra', 'ROOT', 'activo', '2021-04-05', 'ROOT', '2021-04-05'),
(44, 'Categoría productos', 'Modulo de productos', 'Modulo', 38, 'fa fa-bars', 'Admin/Categoria', 'ROOT', 'activo', '2021-04-06', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_ms_parametros`
--

CREATE TABLE `tbl_ms_parametros` (
  `id_parametro` int(11) NOT NULL,
  `parametro` varchar(50) NOT NULL,
  `valor` varchar(100) NOT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `creado_por` varchar(15) DEFAULT NULL,
  `modificado_por` varchar(15) DEFAULT NULL,
  `fecha_modificacion` date DEFAULT NULL,
  `TBL_MS_USUARIO_id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_ms_parametros`
--

INSERT INTO `tbl_ms_parametros` (`id_parametro`, `parametro`, `valor`, `fecha_creacion`, `creado_por`, `modificado_por`, `fecha_modificacion`, `TBL_MS_USUARIO_id_usuario`) VALUES
(1, 'Correo_host', 'smtp.gmail.com', '2021-02-22', NULL, NULL, NULL, 1),
(2, 'Correo_usuario', 'variedadesotac@gmail.com', '2021-02-22', NULL, NULL, NULL, 1),
(3, 'Correo_contraseña', 'VOtac2021', '2021-02-22', NULL, NULL, NULL, 1),
(4, 'Correo_tipo_smtp', 'TLS', '2021-02-22', NULL, NULL, NULL, 1),
(5, 'Correo_puerto', '587', '2021-02-22', NULL, NULL, NULL, 1),
(6, 'Correo_nombre', 'Solutions Team', NULL, NULL, NULL, NULL, 1),
(7, 'Correo_horas_token', '24', NULL, NULL, NULL, NULL, 1),
(8, 'ADMIN_INTENTOS', '3', NULL, NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_ms_permisos`
--

CREATE TABLE `tbl_ms_permisos` (
  `id_permiso` int(11) NOT NULL,
  `TBL_MS_ROLES_id_rol` int(11) DEFAULT NULL,
  `TBL_MS_OBJETOS_id_objeto` int(11) DEFAULT NULL,
  `permiso_insercion` int(1) DEFAULT NULL,
  `permiso_eliminacion` int(1) DEFAULT NULL,
  `permiso_actualizacion` int(1) DEFAULT NULL,
  `permiso_consultar` int(1) DEFAULT NULL,
  `creado_por` varchar(15) DEFAULT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `modificado_por` varchar(15) DEFAULT NULL,
  `fecha_modificacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbl_ms_permisos`
--

INSERT INTO `tbl_ms_permisos` (`id_permiso`, `TBL_MS_ROLES_id_rol`, `TBL_MS_OBJETOS_id_objeto`, `permiso_insercion`, `permiso_eliminacion`, `permiso_actualizacion`, `permiso_consultar`, `creado_por`, `fecha_creacion`, `modificado_por`, `fecha_modificacion`) VALUES
(6, 2, 11, 1, 1, 1, 1, 'Admin', NULL, 'ROOT', '2021-03-15'),
(7, 2, 12, 1, 1, 1, 1, 'Admin', NULL, 'ROOT', '2021-03-15'),
(8, 2, 13, 1, 1, 1, 1, 'Admin', NULL, 'ROOT', '2021-03-15'),
(9, 1, 4, 1, 0, 1, 1, 'ROOT', '2021-03-12', 'ROOT', '2021-03-13'),
(10, 1, 2, 1, 1, 0, 1, 'ROOT', '2021-03-12', 'ROOT', '2021-03-14'),
(11, 3, 11, 0, 0, 1, 0, 'ROOT', '2021-03-13', 'ROOT', '2021-03-13'),
(18, 2, 7, 1, 1, 1, 1, 'ROOT', '2021-03-13', NULL, NULL),
(19, 2, 14, 1, 1, 1, 1, 'ROOT', '2021-03-13', 'ROOT', '2021-03-15'),
(23, 4, 9, 1, 1, 1, 1, 'ROOT', '2021-03-13', NULL, NULL),
(24, 1, 9, 1, 0, 1, 1, 'ROOT', '2021-03-13', 'ROOT', '2021-03-14'),
(25, 4, 10, 1, 1, 1, 0, 'ROOT', '2021-03-13', NULL, NULL),
(26, 4, 14, 0, 0, 0, 1, 'ROOT', '2021-03-13', NULL, NULL),
(27, 4, 13, 0, 0, 0, 0, 'ROOT', '2021-03-13', NULL, NULL),
(28, 4, 12, 0, 0, 0, 0, 'ROOT', '2021-03-13', NULL, NULL),
(29, 3, 2, 1, 1, 1, 0, 'ROOT', '2021-03-13', NULL, NULL),
(30, 3, 14, 1, 1, 0, 0, 'ROOT', '2021-03-13', NULL, NULL),
(31, 3, 13, 0, 0, 0, 0, 'ROOT', '2021-03-13', 'ROOT', '2021-03-17'),
(32, 3, 10, 1, 1, 0, 1, 'ROOT', '2021-03-13', NULL, NULL),
(34, 4, 10, 1, 1, 1, 1, 'ROOT', '2021-03-14', 'ROOT', '2021-03-14'),
(37, 2, 23, 1, 1, 1, 1, 'ROOT', '2021-03-17', NULL, NULL),
(38, 3, 23, 0, 0, 0, 1, 'ROOT', '2021-03-17', NULL, NULL),
(42, 2, 30, 1, 1, 1, 1, 'ROOT', '2021-03-22', NULL, NULL),
(46, 2, 33, 1, 1, 1, 1, 'ROOT', '2021-03-25', NULL, NULL),
(47, 2, 35, 1, 1, 1, 1, 'ROOT', '2021-03-25', NULL, NULL),
(48, 2, 36, 1, 1, 1, 1, 'ROOT', '2021-03-25', NULL, NULL),
(49, 2, 37, 1, 1, 1, 1, 'ROOT', '2021-03-25', NULL, NULL),
(50, 2, 39, 1, 1, 1, 1, 'ROOT', '2021-03-25', NULL, NULL),
(51, 2, 40, 1, 1, 1, 1, 'ROOT', '2021-03-25', NULL, NULL),
(52, 2, 41, 1, 1, 1, 1, 'ROOT', '2021-03-26', NULL, NULL),
(53, 3, 30, 1, 1, 1, 1, 'ROOT', '2021-03-26', NULL, NULL),
(54, 2, 43, 1, 1, 1, 1, 'ROOT', '2021-04-05', NULL, NULL),
(55, 2, 44, 1, 1, 1, 1, 'ROOT', '2021-04-06', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_ms_preguntas`
--

CREATE TABLE `tbl_ms_preguntas` (
  `id_pregunta` int(11) NOT NULL,
  `pregunta` varchar(100) NOT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `creado_por` varchar(15) DEFAULT NULL,
  `fecha_modificacion` date DEFAULT NULL,
  `modificado_por` varchar(15) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_ms_preguntas`
--

INSERT INTO `tbl_ms_preguntas` (`id_pregunta`, `pregunta`, `fecha_creacion`, `creado_por`, `fecha_modificacion`, `modificado_por`, `estado`) VALUES
(1, '¿Cuál es tu color favorito?', NULL, NULL, NULL, NULL, 1),
(2, '¿Cuál es tu país favorito?', NULL, NULL, NULL, NULL, 1),
(3, '¿Cuál es el nombre de tu mascota?', NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_ms_preguntas_usuario`
--

CREATE TABLE `tbl_ms_preguntas_usuario` (
  `id_preguntas_usuario` int(11) NOT NULL,
  `id_pregunta` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `respuesta` varchar(30) NOT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_creacion` date NOT NULL,
  `fecha_modificacion` date NOT NULL,
  `modificado_por` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_ms_preguntas_usuario`
--

INSERT INTO `tbl_ms_preguntas_usuario` (`id_preguntas_usuario`, `id_pregunta`, `id_usuario`, `respuesta`, `creado_por`, `fecha_creacion`, `fecha_modificacion`, `modificado_por`) VALUES
(16, 1, 27, 'AZUL', '27', '0000-00-00', '0000-00-00', '27'),
(17, 1, 29, 'ROJO', '29', '0000-00-00', '0000-00-00', '29'),
(18, 1, 30, 'ROJO', '30', '0000-00-00', '0000-00-00', '30'),
(19, 1, 31, 'ROJO', '31', '0000-00-00', '0000-00-00', '31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_ms_roles`
--

CREATE TABLE `tbl_ms_roles` (
  `id_rol` int(11) NOT NULL,
  `rol` varchar(30) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `creado_por` varchar(15) DEFAULT NULL,
  `fecha_modificacion` date DEFAULT NULL,
  `modificado_por` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_ms_roles`
--

INSERT INTO `tbl_ms_roles` (`id_rol`, `rol`, `descripcion`, `fecha_creacion`, `creado_por`, `fecha_modificacion`, `modificado_por`) VALUES
(1, 'Default', '.', '2021-02-22', NULL, '2021-03-25', 'ROOT'),
(2, 'Administrador', 'Usuario administrativo', '2021-02-22', NULL, '2021-03-13', 'ROOT'),
(3, 'Empleado', 'Usuario de ventas', NULL, NULL, NULL, NULL),
(4, 'Ejecutivo', 'Usuario gerente', '2021-03-13', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_ms_token_usuario`
--

CREATE TABLE `tbl_ms_token_usuario` (
  `id_token` int(11) NOT NULL,
  `token` varchar(60) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_inicial` varchar(30) NOT NULL,
  `fecha_final` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_ms_usuario`
--

CREATE TABLE `tbl_ms_usuario` (
  `id_usuario` int(11) NOT NULL,
  `usuario` varchar(15) NOT NULL,
  `id_estado_usuario` int(11) NOT NULL,
  `contrasena` varchar(100) NOT NULL,
  `nombre_usuario` varchar(100) NOT NULL,
  `apellido_usuario` varchar(100) NOT NULL,
  `genero_usuario` varchar(15) NOT NULL,
  `correo_usuario` varchar(45) NOT NULL,
  `TBL_MS_ROLES_id_rol` int(11) NOT NULL,
  `fecha_creacion` date DEFAULT NULL,
  `creado_por` varchar(15) DEFAULT NULL,
  `fecha_modificacion` date DEFAULT NULL,
  `modificado_por` varchar(15) DEFAULT NULL,
  `fecha_ultima_conexion` date DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `preguntas_contestadas` int(11) DEFAULT NULL,
  `primer_ingreso` int(11) DEFAULT NULL,
  `token` varchar(60) DEFAULT NULL,
  `fecha_inicial` varchar(30) DEFAULT NULL,
  `fecha_final` varchar(30) DEFAULT NULL,
  `intentos` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_ms_usuario`
--

INSERT INTO `tbl_ms_usuario` (`id_usuario`, `usuario`, `id_estado_usuario`, `contrasena`, `nombre_usuario`, `apellido_usuario`, `genero_usuario`, `correo_usuario`, `TBL_MS_ROLES_id_rol`, `fecha_creacion`, `creado_por`, `fecha_modificacion`, `modificado_por`, `fecha_ultima_conexion`, `fecha_vencimiento`, `preguntas_contestadas`, `primer_ingreso`, `token`, `fecha_inicial`, `fecha_final`, `intentos`) VALUES
(1, 'Sin Registrar', 1, '99875d29b6df38b2b484f1e8ec5979c7', '', '', '', '', 2, '2021-02-22', NULL, NULL, NULL, '2021-02-25', NULL, NULL, NULL, 'aEB2WDtQ6wJRYHb', '23-02-2021 13:57:08', '24-02-2021 13:57:08', NULL),
(2, 'ROOT', 1, '3d35b9cf36e4c5b56c13bdc336c39df4', 'Variedades', 'OTAC', 'M', 'VARIEDADESOTAC@GMAIL.COM', 2, '2021-02-23', 'SUPERADMIN', '2021-03-03', '19', '2021-04-06', '2021-02-23', NULL, 1, 'hpfx6ZPAHBnNRMe', '03-03-2021 01:27:10', '04-03-2021 01:27:10', 3),
(29, 'HOLAAA', 1, 'dc763dbe574ab3827c9cb1d1fddfa994', 'HOLAA', 'KJ NZX', 'M', 'FERNANDO.CABRERA@UNAH.HN', 3, '2021-03-17', 'ROOT', NULL, NULL, '2021-03-17', '2021-03-17', NULL, 1, NULL, NULL, NULL, 3),
(31, 'FERNANDO', 1, '7fab95a149fd54bc6afa33d0aa745195', 'FERNANDO', 'WDCWS', 'M', 'CABRERAF83@GMAIL.COM', 3, '2021-03-17', 'ROOT', NULL, NULL, '2021-03-26', '2021-03-17', NULL, 1, 'Token reclamado', '26-03-2021 21:20:48', '27-03-2021 21:20:48', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_perdidas`
--

CREATE TABLE `tbl_perdidas` (
  `id_perdida` int(11) NOT NULL,
  `cantidad_perdida` int(11) NOT NULL,
  `TBL_PRODUCTOS_id_producto` int(11) NOT NULL,
  `TBL_KARDEX_id_kardex` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_productos`
--

CREATE TABLE `tbl_productos` (
  `id_producto` int(11) NOT NULL,
  `nombre_producto` varchar(45) NOT NULL,
  `nombre_categoria` varchar(30) NOT NULL,
  `desc_producto` varchar(100) NOT NULL,
  `precio_venta` decimal(9,2) NOT NULL,
  `cantidad_max` int(11) NOT NULL,
  `cantidad_min` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_productos`
--

INSERT INTO `tbl_productos` (`id_producto`, `nombre_producto`, `nombre_categoria`, `desc_producto`, `precio_venta`, `cantidad_max`, `cantidad_min`, `stock`, `fecha_registro`) VALUES
(2, 'hjkloieur', '', 'njdkfsdjf', '1.00', 45, 2, 45, '0000-00-00 00:00:00'),
(6, 'tgyhuj', '', 'gbhnjmk,l', '888.00', 4, 1, 4, '0000-00-00 00:00:00'),
(7, 'dfgdfgdf', '', 'dfgdfgdf', '42.00', 12, 10, 11, '2021-04-06 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_proveedores`
--

CREATE TABLE `tbl_proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `proveedor` varchar(45) NOT NULL,
  `contacto` varchar(45) NOT NULL,
  `telefono` varchar(45) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  `fecha_creacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbl_proveedores`
--

INSERT INTO `tbl_proveedores` (`id_proveedor`, `proveedor`, `contacto`, `telefono`, `direccion`, `fecha_creacion`) VALUES
(1, 'DFGHJK', 'FGHJ', '785245696', 'DEFGHYUGFDSFRTYU', '0000-00-00'),
(2, 'JJKKJ', 'NMNM', '858585', 'IJMIKJ I', '0000-00-00'),
(3, 'IMMIIM', 'NNJJNNJJN', '456852', 'KMKIDFMODFKI', '0000-00-00'),
(4, 'YUJIKOKIJUY', 'YHUJIKJUHYGTFT', '47896352478', 'GYHUNJIUY', '0000-00-00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_tipo_kardex`
--

CREATE TABLE `tbl_tipo_kardex` (
  `id_tipo_kardex` int(11) NOT NULL,
  `nombre_tipo_kardex` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_ventas`
--

CREATE TABLE `tbl_ventas` (
  `id_venta` int(11) NOT NULL,
  `fecha_venta` datetime NOT NULL DEFAULT current_timestamp(),
  `cantidad_venta` int(11) NOT NULL,
  `isv` decimal(9,2) NOT NULL,
  `descuento` decimal(9,2) NOT NULL,
  `total_venta` decimal(10,2) NOT NULL,
  `usuario` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_categoria`
--
ALTER TABLE `tbl_categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `tbl_clientes`
--
ALTER TABLE `tbl_clientes`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `tbl_compras`
--
ALTER TABLE `tbl_compras`
  ADD PRIMARY KEY (`id_compra`),
  ADD KEY `fk_TBL_COMPRAS_TBL_PROVEEDORES1_idx` (`TBL_PROVEEDORES_id_proveedor`);

--
-- Indices de la tabla `tbl_devoluciones`
--
ALTER TABLE `tbl_devoluciones`
  ADD PRIMARY KEY (`id_devolucion`),
  ADD KEY `fk_TBL_DEVOLUCIONES_TBL_PRODUCTOS1_idx` (`TBL_PRODUCTOS_id_producto`),
  ADD KEY `fk_TBL_DEVOLUCIONES_TBL_KARDEX1_idx` (`TBL_KARDEX_id_kardex`);

--
-- Indices de la tabla `tbl_inventarios`
--
ALTER TABLE `tbl_inventarios`
  ADD PRIMARY KEY (`id_inventario`),
  ADD KEY `fk_TBL_INVENTARIOS_TBL_PRODUCTOS1_idx` (`TBL_PRODUCTOS_id_producto`);

--
-- Indices de la tabla `tbl_kardex`
--
ALTER TABLE `tbl_kardex`
  ADD PRIMARY KEY (`id_kardex`),
  ADD KEY `fk_TBL_KARDEX_TBL_TIPO_KARDEX1_idx` (`TBL_TIPO_KARDEX_id_tipo_kardex`),
  ADD KEY `fk_TBL_KARDEX_TBL_PRODUCTOS1_idx` (`TBL_PRODUCTOS_id_producto`),
  ADD KEY `fk_TBL_KARDEX_TBL_MS_USUARIO1_idx` (`TBL_MS_USUARIO_id_usuario`),
  ADD KEY `fk_TBL_KARDEX_TBL_COMPRAS1_idx` (`TBL_COMPRAS_id_compra`),
  ADD KEY `fk_TBL_KARDEX_TBL_VENTAS1_idx` (`TBL_VENTAS_id_venta`);

--
-- Indices de la tabla `tbl_ms_bitacora`
--
ALTER TABLE `tbl_ms_bitacora`
  ADD PRIMARY KEY (`id_bitacora`),
  ADD KEY `fk_TBL_MS_BITACORA_TBL_MS_USUARIO1_idx` (`TBL_MS_USUARIO_id_usuario`),
  ADD KEY `fk_TBL_MS_BITACORA_TBL_MS_OBJETOS1_idx` (`TBL_MS_OBJETOS_id_objeto`);

--
-- Indices de la tabla `tbl_ms_estado_usuario`
--
ALTER TABLE `tbl_ms_estado_usuario`
  ADD PRIMARY KEY (`id_estado_usuario`);

--
-- Indices de la tabla `tbl_ms_hist_contraseña`
--
ALTER TABLE `tbl_ms_hist_contraseña`
  ADD PRIMARY KEY (`id_hist`),
  ADD KEY `fk_TBL_MS_HIST_CONTRASEÑA_TBL_MS_USUARIO1_idx` (`TBL_MS_USUARIO_id_usuario`);

--
-- Indices de la tabla `tbl_ms_objetos`
--
ALTER TABLE `tbl_ms_objetos`
  ADD PRIMARY KEY (`id_objeto`);

--
-- Indices de la tabla `tbl_ms_parametros`
--
ALTER TABLE `tbl_ms_parametros`
  ADD PRIMARY KEY (`id_parametro`),
  ADD KEY `fk_TBL_MS_PARAMETROS_TBL_MS_USUARIO1_idx` (`TBL_MS_USUARIO_id_usuario`);

--
-- Indices de la tabla `tbl_ms_permisos`
--
ALTER TABLE `tbl_ms_permisos`
  ADD PRIMARY KEY (`id_permiso`),
  ADD KEY `tbl_ms_permisos_FK` (`TBL_MS_ROLES_id_rol`),
  ADD KEY `tbl_ms_permisos_FK_1` (`TBL_MS_OBJETOS_id_objeto`);

--
-- Indices de la tabla `tbl_ms_preguntas`
--
ALTER TABLE `tbl_ms_preguntas`
  ADD PRIMARY KEY (`id_pregunta`);

--
-- Indices de la tabla `tbl_ms_preguntas_usuario`
--
ALTER TABLE `tbl_ms_preguntas_usuario`
  ADD PRIMARY KEY (`id_preguntas_usuario`),
  ADD KEY `usuarios_preguntas_respuestas` (`id_pregunta`);

--
-- Indices de la tabla `tbl_ms_roles`
--
ALTER TABLE `tbl_ms_roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `tbl_ms_token_usuario`
--
ALTER TABLE `tbl_ms_token_usuario`
  ADD PRIMARY KEY (`id_token`),
  ADD KEY `token_usuario` (`id_usuario`);

--
-- Indices de la tabla `tbl_ms_usuario`
--
ALTER TABLE `tbl_ms_usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `fk_TBL_MS_USUARIO_TBL_MS_ROLES1_idx` (`TBL_MS_ROLES_id_rol`),
  ADD KEY `estados_usuarios` (`id_estado_usuario`);

--
-- Indices de la tabla `tbl_perdidas`
--
ALTER TABLE `tbl_perdidas`
  ADD PRIMARY KEY (`id_perdida`),
  ADD KEY `fk_TBL_PERDIDAS_TBL_PRODUCTOS1_idx` (`TBL_PRODUCTOS_id_producto`),
  ADD KEY `fk_TBL_PERDIDAS_TBL_KARDEX1_idx` (`TBL_KARDEX_id_kardex`);

--
-- Indices de la tabla `tbl_productos`
--
ALTER TABLE `tbl_productos`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `nombre_categoria` (`nombre_categoria`);

--
-- Indices de la tabla `tbl_proveedores`
--
ALTER TABLE `tbl_proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `tbl_tipo_kardex`
--
ALTER TABLE `tbl_tipo_kardex`
  ADD PRIMARY KEY (`id_tipo_kardex`);

--
-- Indices de la tabla `tbl_ventas`
--
ALTER TABLE `tbl_ventas`
  ADD PRIMARY KEY (`id_venta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_categoria`
--
ALTER TABLE `tbl_categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tbl_clientes`
--
ALTER TABLE `tbl_clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `tbl_compras`
--
ALTER TABLE `tbl_compras`
  MODIFY `id_compra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_inventarios`
--
ALTER TABLE `tbl_inventarios`
  MODIFY `id_inventario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_kardex`
--
ALTER TABLE `tbl_kardex`
  MODIFY `id_kardex` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_ms_bitacora`
--
ALTER TABLE `tbl_ms_bitacora`
  MODIFY `id_bitacora` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1644;

--
-- AUTO_INCREMENT de la tabla `tbl_ms_estado_usuario`
--
ALTER TABLE `tbl_ms_estado_usuario`
  MODIFY `id_estado_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tbl_ms_hist_contraseña`
--
ALTER TABLE `tbl_ms_hist_contraseña`
  MODIFY `id_hist` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_ms_objetos`
--
ALTER TABLE `tbl_ms_objetos`
  MODIFY `id_objeto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de la tabla `tbl_ms_parametros`
--
ALTER TABLE `tbl_ms_parametros`
  MODIFY `id_parametro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tbl_ms_permisos`
--
ALTER TABLE `tbl_ms_permisos`
  MODIFY `id_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT de la tabla `tbl_ms_preguntas`
--
ALTER TABLE `tbl_ms_preguntas`
  MODIFY `id_pregunta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tbl_ms_preguntas_usuario`
--
ALTER TABLE `tbl_ms_preguntas_usuario`
  MODIFY `id_preguntas_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `tbl_ms_roles`
--
ALTER TABLE `tbl_ms_roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `tbl_ms_token_usuario`
--
ALTER TABLE `tbl_ms_token_usuario`
  MODIFY `id_token` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_ms_usuario`
--
ALTER TABLE `tbl_ms_usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `tbl_perdidas`
--
ALTER TABLE `tbl_perdidas`
  MODIFY `id_perdida` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_productos`
--
ALTER TABLE `tbl_productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tbl_proveedores`
--
ALTER TABLE `tbl_proveedores`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tbl_tipo_kardex`
--
ALTER TABLE `tbl_tipo_kardex`
  MODIFY `id_tipo_kardex` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbl_ventas`
--
ALTER TABLE `tbl_ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbl_compras`
--
ALTER TABLE `tbl_compras`
  ADD CONSTRAINT `fk_TBL_COMPRAS_TBL_PROVEEDORES1` FOREIGN KEY (`TBL_PROVEEDORES_id_proveedor`) REFERENCES `tbl_proveedores` (`id_proveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_devoluciones`
--
ALTER TABLE `tbl_devoluciones`
  ADD CONSTRAINT `fk_TBL_DEVOLUCIONES_TBL_KARDEX1` FOREIGN KEY (`TBL_KARDEX_id_kardex`) REFERENCES `tbl_kardex` (`id_kardex`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_TBL_DEVOLUCIONES_TBL_PRODUCTOS1` FOREIGN KEY (`TBL_PRODUCTOS_id_producto`) REFERENCES `tbl_productos` (`id_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_inventarios`
--
ALTER TABLE `tbl_inventarios`
  ADD CONSTRAINT `fk_TBL_INVENTARIOS_TBL_PRODUCTOS1` FOREIGN KEY (`TBL_PRODUCTOS_id_producto`) REFERENCES `tbl_productos` (`id_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_kardex`
--
ALTER TABLE `tbl_kardex`
  ADD CONSTRAINT `fk_TBL_KARDEX_TBL_COMPRAS1` FOREIGN KEY (`TBL_COMPRAS_id_compra`) REFERENCES `tbl_compras` (`id_compra`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_TBL_KARDEX_TBL_MS_USUARIO1` FOREIGN KEY (`TBL_MS_USUARIO_id_usuario`) REFERENCES `tbl_ms_usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_TBL_KARDEX_TBL_PRODUCTOS1` FOREIGN KEY (`TBL_PRODUCTOS_id_producto`) REFERENCES `tbl_productos` (`id_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_TBL_KARDEX_TBL_TIPO_KARDEX1` FOREIGN KEY (`TBL_TIPO_KARDEX_id_tipo_kardex`) REFERENCES `tbl_tipo_kardex` (`id_tipo_kardex`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_TBL_KARDEX_TBL_VENTAS1` FOREIGN KEY (`TBL_VENTAS_id_venta`) REFERENCES `tbl_ventas` (`id_venta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_ms_bitacora`
--
ALTER TABLE `tbl_ms_bitacora`
  ADD CONSTRAINT `fk_TBL_MS_BITACORA_TBL_MS_OBJETOS1` FOREIGN KEY (`TBL_MS_OBJETOS_id_objeto`) REFERENCES `tbl_ms_objetos` (`id_objeto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_TBL_MS_BITACORA_TBL_MS_USUARIO1` FOREIGN KEY (`TBL_MS_USUARIO_id_usuario`) REFERENCES `tbl_ms_usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_ms_hist_contraseña`
--
ALTER TABLE `tbl_ms_hist_contraseña`
  ADD CONSTRAINT `fk_TBL_MS_HIST_CONTRASEÑA_TBL_MS_USUARIO1` FOREIGN KEY (`TBL_MS_USUARIO_id_usuario`) REFERENCES `tbl_ms_usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_ms_parametros`
--
ALTER TABLE `tbl_ms_parametros`
  ADD CONSTRAINT `fk_TBL_MS_PARAMETROS_TBL_MS_USUARIO1` FOREIGN KEY (`TBL_MS_USUARIO_id_usuario`) REFERENCES `tbl_ms_usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_ms_permisos`
--
ALTER TABLE `tbl_ms_permisos`
  ADD CONSTRAINT `tbl_ms_permisos_FK` FOREIGN KEY (`TBL_MS_ROLES_id_rol`) REFERENCES `tbl_ms_roles` (`id_rol`),
  ADD CONSTRAINT `tbl_ms_permisos_FK_1` FOREIGN KEY (`TBL_MS_OBJETOS_id_objeto`) REFERENCES `tbl_ms_objetos` (`id_objeto`);

--
-- Filtros para la tabla `tbl_ms_preguntas_usuario`
--
ALTER TABLE `tbl_ms_preguntas_usuario`
  ADD CONSTRAINT `usuarios_preguntas_respuestas` FOREIGN KEY (`id_pregunta`) REFERENCES `tbl_ms_preguntas` (`id_pregunta`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `tbl_ms_usuario`
--
ALTER TABLE `tbl_ms_usuario`
  ADD CONSTRAINT `estados_usuarios` FOREIGN KEY (`id_estado_usuario`) REFERENCES `tbl_ms_estado_usuario` (`id_estado_usuario`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_TBL_MS_USUARIO_TBL_MS_ROLES1` FOREIGN KEY (`TBL_MS_ROLES_id_rol`) REFERENCES `tbl_ms_roles` (`id_rol`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `tbl_perdidas`
--
ALTER TABLE `tbl_perdidas`
  ADD CONSTRAINT `fk_TBL_PERDIDAS_TBL_KARDEX1` FOREIGN KEY (`TBL_KARDEX_id_kardex`) REFERENCES `tbl_kardex` (`id_kardex`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_TBL_PERDIDAS_TBL_PRODUCTOS1` FOREIGN KEY (`TBL_PRODUCTOS_id_producto`) REFERENCES `tbl_productos` (`id_producto`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
