/*---------------------------- 1) SCRIPT CREACIÓN DE BBDD Y TABLAS------------------------- */

CREATE DATABASE IF NOT EXISTS libreria;

USE libreria;

/*creo tablas que solo tienen PK para luego crear tablas con FK asociadas, el nro de tabla referencia las tablas de este script con el listado de tablas guia*/

/*tabla 1*/
CREATE TABLE IF NOT EXISTS documento_tipo (
	documento_tipo_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    documento_tipo_nombre VARCHAR (50)  NOT NULL
);

/*tabla 2*/
CREATE TABLE IF NOT EXISTS canal_venta (
	canal_venta_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    canal_venta_nombre VARCHAR (50) NOT NULL
);

/*tabla 4*/
CREATE TABLE IF NOT EXISTS ciudad (
	ciudad_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    ciudad_nombre VARCHAR (80) NOT NULL
);

/*tabla 5*/
CREATE TABLE IF NOT EXISTS condicion_fiscal (
	condicion_fiscal_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    condicion_fiscal_nombre VARCHAR (50) NOT NULL
);


/*tabla 7*/
CREATE TABLE IF NOT EXISTS sucursal (
	sucursal_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    sucursal_nombre VARCHAR (50) NOT NULL
);

/*tabla 8*/
CREATE TABLE IF NOT EXISTS tipo_persona (
	tipo_persona_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    tipo_persona_detalle VARCHAR (50) NOT NULL
);

/*tabla 11*/
CREATE TABLE IF NOT EXISTS medio_pago (
	medio_pago_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    medio_pago_nombre VARCHAR (50) NOT NULL
);

/*tabla 12*/
CREATE TABLE IF NOT EXISTS genero (
	genero_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    genero_nombre VARCHAR (50) NOT NULL
);

/*tabla 13*/
CREATE TABLE IF NOT EXISTS editorial (
	editorial_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    editorial_nombre VARCHAR (50) NOT NULL
);

/*tabla 15*/
CREATE TABLE IF NOT EXISTS comprobante_tipo (
	comprobante_tipo_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    comprobante_tipo_nombre VARCHAR (30) NOT NULL
);

/*tabla 16*/
CREATE TABLE IF NOT EXISTS nacionalidad (
	nacionalidad_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
    nacionalidad_nombre VARCHAR (30) NOT NULL
);

/* Creo las Tablas  con PK y FK*/

/*tabla 3*/
CREATE TABLE IF NOT EXISTS persona (
persona_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
documento_tipo_id  INT NOT NULL,
documento_numero INT (11) NOT NULL,
persona_nombre VARCHAR (20) NOT NULL,
persona_apellido VARCHAR (20) NOT NULL,
persona_mail VARCHAR (50) NOT NULL,
persona_telefono INT (20) NOT NULL,
domicilio_calle VARCHAR (80) NOT NULL,
domicilio_numero INT (10) NOT NULL,
ciudad_id INT NOT NULL,
condicion_fiscal_id INT NOT NULL,
tipo_persona_id INT NOT NULL,

FOREIGN KEY (documento_tipo_id)
		REFERENCES documento_tipo(documento_tipo_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,

FOREIGN KEY (ciudad_id)
		REFERENCES ciudad(ciudad_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,
        
FOREIGN KEY (condicion_fiscal_id)
		REFERENCES condicion_fiscal(condicion_fiscal_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,

FOREIGN KEY (tipo_persona_id)
		REFERENCES tipo_persona(tipo_persona_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE
); 

/*tabla 14*/
CREATE TABLE IF NOT EXISTS autor(
autor_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
autor_nombre VARCHAR (100) NOT NULL,
nacionalidad_id INT NOT NULL,

FOREIGN KEY (nacionalidad_id)
		REFERENCES nacionalidad(nacionalidad_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE

);

/*tabla 9*/
CREATE TABLE IF NOT EXISTS libro(
libro_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
genero_id INT NOT NULL,
editorial_id INT NOT NULL,
autor_id INT NOT NULL,
anio_edicion INT (4),
titulo VARCHAR (200) NOT NULL,
precio_libro DECIMAL (11,2) NOT NULL,

FOREIGN KEY (genero_id)
		REFERENCES genero(genero_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,
        
FOREIGN KEY (editorial_id)
		REFERENCES editorial(editorial_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,

FOREIGN KEY (autor_id)
		REFERENCES autor(autor_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE
);

/*tabla 6*/
CREATE TABLE IF NOT EXISTS venta (
venta_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
canal_venta_id INT (30) NOT NULL,
libro_id INT NOT NULL,
medio_pago_id INT NOT NULL,
sucursal_id INT NOT NULL,
cantidad_libro INT (4) NOT NULL,
cantidad_libro_total INT (10) NOT NULL,
precio_libro DECIMAL (11,2) NOT NULL,
venta_monto_total DECIMAL (11,2) NOT NULL,
compra_fecha TIMESTAMP NOT NULL,

FOREIGN KEY (canal_venta_id)
		REFERENCES canal_venta(canal_venta_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,

FOREIGN KEY (libro_id)
		REFERENCES libro(libro_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,

FOREIGN KEY (medio_pago_id)
		REFERENCES medio_pago(medio_pago_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,

FOREIGN KEY (sucursal_id)
		REFERENCES sucursal(sucursal_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE
);

/*TABLA 10*/
CREATE TABLE IF NOT EXISTS comprobante(
comprobante_id INT NOT NULL UNIQUE AUTO_INCREMENT PRIMARY KEY,
comprobante_tipo_id INT NOT NULL,
venta_id INT NOT NULL,
persona_id INT NOT NULL,
comprobante_numero_fiscal INT (20) NOT NULL,
comprobante_fecha TIMESTAMP NOT NULL,
items_cantidad_total INT (5) NOT NULL,
items_cantidad INT (4) NOT NULL,
items_precio DECIMAL (11,2) NOT NULL,
comprobante_monto_total DECIMAL (11,2) NOT NULL,

FOREIGN KEY (comprobante_tipo_id)
		REFERENCES comprobante_tipo(comprobante_tipo_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,

FOREIGN KEY (venta_id)
		REFERENCES venta(venta_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE,

FOREIGN KEY (persona_id)
		REFERENCES persona(persona_id)
        ON DELETE CASCADE
		ON UPDATE CASCADE
);

/*----------------------------- 2 ) INSERCIÓN DE DATOS EN LAS TABLAS CREADAS --------------------------*/
/*Inserto valores en las tablas que tienen datos que luego se utlitilzan como FK*/
INSERT INTO documento_tipo
VALUES
(null, 'dni'),
(null, 'cuil'),
(null, 'cuit'),
(null, 'pasaporte');

INSERT INTO canal_venta
VALUES
(null, 'teléfono'),
(null, 'app'),
(null, 'web'),
(null, 'presencial');

INSERT INTO ciudad
VALUES 
(null, 'Rosario'),
(null, 'Córdoba'),
(null, 'CABA'),
(null, 'Mendoza'),
(null, 'Mar del Plata'),
(null, 'Bariloche'),
(null, 'San Nicolás'),
(null, 'San Pedro'),
(null, 'Junin'),
(null, 'Rafaela'),
(null, 'Perez'),
(null, 'Funes'),
(null, 'Roldán');

INSERT INTO condicion_fiscal
VALUES
(null, 'Consumidor Final'),
(null, 'Responsables Inscripto'),
(null, 'Monotributista'),
(null, 'Excento');

INSERT INTO sucursal
VALUES
(null, 'Centro'),
(null, 'Zona Sur'),
(null, 'Shoping'),
(null, 'Aeropuerto');

INSERT INTO tipo_persona
VALUES 
(null, 'cliente'),
(null, 'empleado'),
(null, 'proveedor');

INSERT INTO medio_pago
VALUES
(null, 'tarjeta'),
(null, 'efectivo'),
(null, 'cheque'),
(null, 'medios electrónicos');

INSERT INTO genero
VALUES
(null, 'narrativo'),
(null, 'épico'),
(null, 'lírico'),
(null, 'dramático'),
(null, 'didáctico');


INSERT INTO editorial
VALUES
(null, 'editorial_1'),
(null, 'editorial_2'),
(null, 'editorial_3'),
(null, 'editorial_4');

INSERT INTO  comprobante_tipo
VALUES
(null, 'factura a'),
(null, 'factura b'),
(null, 'nota crédito'),
(null, 'nota débito'),
(null, 'recibo');

INSERT INTO nacionalidad
VALUES
(null, 'Argentina'),
(null, 'Chilena'),
(null, 'Británica');

/* Inserto valores en las tablas que continen datos de clientes, productoa, compras, etc*/

INSERT INTO persona
VALUES
(null, 1, 11222333, 'Juan', 'Perez', 'juanperez@gmail.com', 34111111, 'Calle Falsa', 123, 1, 1, 1),
(null, 1, 22555888, 'Mario', 'Bross', 'supermario@hotmail.com', 1159888, 'Calle Inexistente', 678, 2,1,1),
(null, 1, 88444555, 'Lara', 'Croft', 'tombraider@gmail.com', 351998745, 'Sin nombre', 4567, 3, 1, 2),
(null, 2, 30-55555555-7, 'Donkey', 'Kong', 'mono@gmail.com', 34182745, 'Calle Falsa', 8899, 4, 2, 3);

INSERT INTO autor
VALUES
(null,'Viviana Rivero', 1),
(null, 'Isabel Allende', 2),
(null, 'J. K. Rowlling', 3);

INSERT INTO libro
VALUES
(null, 1, 1, 1, '2019', 'Secreto bien guardado', 1300.00),
(null, 1, 1, 1, '2017', 'La magia de la vida', 1800.00),
(null, 1, 1, 1, '2019', 'Los colores de la felicidad', 1560.00),
(null, 1, 2, 2, '1990', 'La casa de los espiritus', 2400.00),
(null, 1, 2, 2, '2015', 'Eva Luna', 2600.00),
(null, 1, 2, 2, '2013', 'Violeta', 1900.00),
(null, 4, 3, 3, '1997', 'Harry Potter y la piedra filosofal', 3100.00),
(null, 4, 3, 3, '1998', 'Harry Potter y la cámara secreta', 3500.00),
(null, 4, 3, 3, '1999', 'Harry Potter y el prisionero de Azcaban', 3800.00),
(null, 4, 3, 3, '2000', 'Harry Potter y el caliz de fuego', 3200.00);

INSERT INTO venta
VALUES
(null, 1, 1, 1, 1, 1, 1, 1300.00, 1300.00, '2022/08/01 10:00:00'),
(null, 4, 2, 3, 1, 1, 1, 1800.00, 1800.00, '2022/08/02 10:00:00'),
(null, 3, 4, 1, 1, 1, 1, 2400.00, 2400.00, '2022/08/03 10:00:00'),
(null, 1, 5, 1, 1, 1, 1, 2600.00, 2600.00, '2022/08/03 10:00:00'),
(null, 1, 6, 1, 1, 1, 1, 1900.00, 1900.00, '2022/08/04 10:00:00');


INSERT INTO comprobante
VALUES
(null, 1, 2, 1, 124, '2022/08/02 10:00:00', 1, 1, 1800.00, 1800.00),
(null, 1, 3, 1, 125, '2022/08/03 10:00:00', 1, 1, 2400.00, 2400.00),
(null, 1, 3, 1, 126, '2022/08/03 10:00:00', 1, 1, 2600.00, 2600.00),
(null, 1, 2, 1, 127, '2022/08/04 10:00:00', 1, 1, 1900.00, 1900.00);


/*-------------------------------- 3) CREACIÓN DE VISTAS------------------------------------*/ 
-- VISTA DATOS LIBROS: esta vista mustra una lista con: titulo, autor, genero--

CREATE OR REPLACE VIEW vTituloLibro_Autor_Genero
AS 
	SELECT
		l.libro_id,
        l.titulo,
        a.autor_nombre,
        g.genero_nombre
FROM libro l
JOIN autor a  ON l.autor_id = a.autor_id
JOIN genero g ON l.genero_id = g.genero_id;

-- VISTA DATOS VENTAS: esta vista muestra una lista con: titulo, canal de ventas--

CREATE OR REPLACE VIEW vVentas_titulo_canalVenta
AS 
	SELECT    
		v.venta_id,
		c.canal_venta_nombre,
        l.titulo
	FROM venta v
    JOIN canal_venta c ON v.canal_venta_id = c.canal_venta_id
    JOIN libro l ON v.libro_id = l.libro_id;

-- VISTA DATOS VENTAS: titulo,comprobante, monto, cliente--   
CREATE OR REPLACE VIEW vVentas_comprobantes
AS 
	SELECT
		v.venta_id,
        l.titulo,
        c.comprobante_numero_fiscal,
        c.comprobante_monto_total,
        p.persona_nombre,
        p.persona_apellido
	FROM venta v
    JOIN libro l ON v.libro_id = l.libro_id
    JOIN comprobante c 	ON  v.venta_id = c.venta_id
    JOIN persona p ON p.persona_id = c.persona_id;
    
    /*----------------------------- 4)  CREACION DE STORE PROCEDURES ------------------------------------------*/
    -- a) Indica en un parámetro el campo de la tabla "venta" por el cual que quiero ordenar agrego un segundo parametro para indicar como será el orden (DESC o ASC)
    
DELIMITER //

CREATE PROCEDURE `sp_ordenamiento_tabla ventas` (IN campo_tabla_ventas CHAR(50), IN orden CHAR(10))
BEGIN
	IF  campo_tabla_ventas <> '' THEN
		SET @orden_tabla_ventas = CONCAT('ORDER BY ',  campo_tabla_ventas, ' ', orden);
    ELSE
		SET @orden_tabla_ventas = '';
	END IF;
    
    SET @clausula_a_ejecutar = CONCAT('SELECT * FROM `libreria`.`venta`', @orden_tabla_ventas);
    /*en esta variable guardo la clausula que quiero ejecutar con el valor que paso en el parametro (campo por el cual se ordenara)*/
    
    PREPARE querySQL from @clausula_a_ejecutar;
    EXECUTE querySQL;
    DEALLOCATE PREPARE querySQL;
    /*en este bloque llamo desde querySQL a la clausla que guarde como string en @clausula_a_ejecutar, la ejecuto y luego la borro de memoria*/
    
END//

DELIMITER ;

    -- B) Inserta un dato en la tabla ciudad
    
DELIMITER //

CREATE PROCEDURE `sp_insert_ciudad` (IN nueva_ciudad CHAR(80))
BEGIN
	IF  nueva_ciudad = '' THEN
		SET @respuesta = 'SELECT "Error: no se pudo crear la nueva ciudad"';
    ELSE
		SET @respuesta = CONCAT('INSERT INTO `libreria`.`ciudad` (`ciudad_nombre`) VALUES ("', nueva_ciudad,'")');
	END IF;
    
	PREPARE querySQL from @respuesta;
    EXECUTE querySQL;
    DEALLOCATE PREPARE querySQL;
       
END//

DELIMITER ;

/*--------------------------------------- 5) TRIGGERS:---------------------------*/

CREATE TABLE IF NOT EXISTS `auditoria_nuevo_libro`(
libro_id INT PRIMARY KEY,
titulo VARCHAR (100),
usuario VARCHAR (100),
fecha DATE,
hora TIME);

/*Cuando se crea un nuevo registro de un nuevo libro, en la tabla "libro" se graba en la tabla "auditoria_nuevo_libro" 
id del libro, titulo del libro, el usuario que inserto el registro  y la fecha en la que se inserto ese dato*/
CREATE TRIGGER `tr_nuevo_libro`
AFTER INSERT ON `libro`
FOR EACH ROW
INSERT INTO `auditoria_nuevo_libro`(libro_id, titulo, usuario, fecha, hora)
VALUES (NEW.libro_id, NEW.titulo, SESSION_USER(), CURDATE(), CURTIME());

CREATE TABLE IF NOT EXISTS `auditoria_nuevo_precio_libro` (
cambio_id INT AUTO_INCREMENT PRIMARY KEY,
libro_id INT,
titulo VARCHAR (100),
nuevo_precio_libro INT,
antiguo_precio_libro INT,
usuario VARCHAR (100),
fecha DATE,
hora TIME);

/*Cuando se modifica un precio de un libro se inserta en la tabla auditoria_nuevo_precio_libro 
un registro con el id del libro, titulo, nuevo precio, precio anterior, ususario que ejecuto la transacción, fecha y hora*/
CREATE TRIGGER `tr_nuevo_precio_libro`
AFTER UPDATE ON `libro`
FOR EACH ROW
INSERT INTO `auditoria_nuevo_precio_libro`(libro_id, titulo, nuevo_precio_libro, antiguo_precio_libro, usuario, fecha, hora)
VALUES (NEW.libro_id, NEW.titulo, NEW.precio_libro, OLD.precio_libro, SESSION_USER(), CURDATE(), CURTIME());

/* ----------------------------------6) CRACIÓN DE FUNCIONES------------------------------------------------------*/

-- 1)  Función que concatena nombre, apellido y un texto que se utilizará como bienvenida (puede ser cuando un usuario se registra 
-- en la web de la librea)

DELIMITER $$

CREATE FUNCTION fn_texto_bienvenida (param_nombre VARCHAR(50), param_apellido VARCHAR (50))
RETURNS VARCHAR(400)
DETERMINISTIC
BEGIN
DECLARE texto_completo VARCHAR(400);
SET texto_completo = 
	(SELECT CONCAT('Hola ', param_nombre, ' ' , param_apellido,'! ', 'Bienvenido a Librerías XXXX, es un placer tenerte entre nosotros!'));
RETURN UPPER(texto_completo);

END $$

-- SELECT fn_texto_bienvenida ('juan', 'perez');

 -- 2) Función que recibe el id de una persona y arma un string con el nombre y el apellido

DELIMITER $$
CREATE FUNCTION fn_datos_persona(param_persona_id INT)
RETURNS VARCHAR(500)
READS SQL DATA
BEGIN
DECLARE nombre VARCHAR(100);
DECLARE apellido VARCHAR(100);
DECLARE datos_persona VARCHAR(500);
SELECT persona_nombre INTO nombre FROM persona WHERE persona_id = param_persona_id;
SELECT persona_apellido INTO apellido FROM persona WHERE persona_id = param_persona_id;

SET datos_persona = (CONCAT('Nombre Completo: ', nombre,' ', apellido));

RETURN datos_persona;

END$$

-- SELECT fn_datos_persona(2)


/*-----------------------------------7) SENTENCIAS DCL - CRERACIÓN DE USUARIOS Y PERMISOS-------------------------*/
-- VERIFICO LOS USUARIOS EXISTENTES
USE Mysql;
SELECT * FROM USER;

-- creo usuario 2 usuarios locales y les asigno claves de acceso
CREATE USER 'usuario1'@'localhost' IDENTIFIED BY 'usuario1';
CREATE USER 'usuario2'@'localhost' IDENTIFIED BY 'usuario2';

-- con esta sentencia verifico los permisos que tienen los usuarios creados, en este caso estoy consultando ambos 
SELECT * FROM mysql.user WHERE USER IN ('usuario1','usuario2');

-- ASIGNO PERMISOS A USUARIO1:
-- Al usuario1 se le asigna permiso solo de LECTURA, este permiso se asigna tabla por tabla de la Base a la que se dio acceso:
GRANT SELECT ON libreria.auditoria_nuevo_libro TO usuario1@localhost;
GRANT SELECT ON libreria.auditoria_nuevo_precio_libro TO usuario1@localhost;
GRANT SELECT ON libreria.autor TO usuario1@localhost;
GRANT SELECT ON libreria.canal_venta TO usuario1@localhost;
GRANT SELECT ON libreria.ciudad TO usuario1@localhost;
GRANT SELECT ON libreria.comprobante TO usuario1@localhost;
GRANT SELECT ON libreria.comprobante_tipo TO usuario1@localhost;
GRANT SELECT ON libreria.condicion_fiscal TO usuario1@localhost;
GRANT SELECT ON libreria.documento_tipo TO usuario1@localhost;
GRANT SELECT ON libreria.editorial TO usuario1@localhost;
GRANT SELECT ON libreria.genero TO usuario1@localhost;
GRANT SELECT ON libreria.libro TO usuario1@localhost;
GRANT SELECT ON libreria.medio_pago TO usuario1@localhost;
GRANT SELECT ON libreria.nacionalidad TO usuario1@localhost;
GRANT SELECT ON libreria.persona TO usuario1@localhost;
GRANT SELECT ON libreria.sucursal TO usuario1@localhost;
GRANT SELECT ON libreria.tipo_persona TO usuario1@localhost;
GRANT SELECT ON libreria.venta TO usuario1@localhost;

-- verificación de  permisos otorgados a usuario1:
SHOW GRANTS FOR usuario1@localhost;

-- ASIGNO PERMISOS A USUARIO2:
-- Al usuario2 se le asigna permiso solo de LECTURA, INSERCIÓN Y MODIFICACIÓN 
-- estos permisos se asignan tabla por tabla de la Base a la que se dio acceso:
GRANT SELECT, UPDATE, INSERT ON libreria.auditoria_nuevo_libro TO usuario2@localhost;
GRANT SELECT, UPDATE, INSERT ON libreria.auditoria_nuevo_precio_libro TO usuario2@localhost;
GRANT SELECT, UPDATE, INSERT ON libreria.autor TO usuario2@localhost;
GRANT SELECT, UPDATE, INSERT ON libreria.canal_venta TO usuario2@localhost;
GRANT SELECT, UPDATE, INSERT ON libreria.ciudad TO usuario2@localhost;
GRANT SELECT, UPDATE, INSERT ON libreria.comprobante TO usuario2@localhost;
GRANT SELECT, UPDATE, INSERT ON libreria.comprobante_tipo TO usuario2@localhost;
GRANT SELECT, UPDATE, INSERT ON libreria.condicion_fiscal TO usuario2@localhost;
GRANT SELECT, UPDATE, INSERT ON libreria.documento_tipo TO usuario2@localhost;
GRANT SELECT, UPDATE, INSERT ON libreria.editorial TO usuario2@localhost;
GRANT SELECT, UPDATE, INSERT ON libreria.genero TO usuario2@localhost;
GRANT SELECT, UPDATE, INSERT ON libreria.libro TO usuario2@localhost;
GRANT SELECT, UPDATE, INSERT ON libreria.medio_pago TO usuario2@localhost;
GRANT SELECT, UPDATE, INSERT ON libreria.nacionalidad TO usuario2@localhost;
GRANT SELECT, UPDATE, INSERT ON libreria.persona TO usuario2@localhost;
GRANT SELECT, UPDATE, INSERT ON libreria.sucursal TO usuario2@localhost;
GRANT SELECT, UPDATE, INSERT ON libreria.tipo_persona TO usuario2@localhost;
GRANT SELECT, UPDATE, INSERT ON libreria.venta TO usuario2@localhost;

-- verificación de  permisos otorgados a usuario2:
SHOW GRANTS FOR usuario2@localhost;

-- con esta sentencia puedo borrar los usuarios creados, ejecutando una a la vez
/*DROP USER 'usuario1'@'localhost';
DROP USER 'usuario2'@'localhost';*/


/*--------------------------------- 8) SENTENCIAS SUBLENGUAJE TCL-------------------------------------*/

SELECT @@autocommit; -- con esta variable puedo saber si el autocommit está activado o no

-- transacción en la tabla ciudad, para eliminar 3 registros existentes

START TRANSACTION;

DELETE FROM `libreria`.`ciudad` WHERE (`ciudad_id` = '8');
DELETE FROM `libreria`.`ciudad` WHERE (`ciudad_id` = '9');
DELETE FROM `libreria`.`ciudad` WHERE (`ciudad_id` = '10');

-- 	ROLLBACK
COMMIT;

-- en esta sentrencia dejo preparado el insert para volver a agregar los registros que borré en la transacción anterior
/*START TRANSACTION;

INSERT INTO `libreria`.`ciudad` (`ciudad_id`, `ciudad_nombre`) VALUES ('8', 'San Pedro');
INSERT INTO `libreria`.`ciudad` (`ciudad_id`, `ciudad_nombre`) VALUES ('9', 'Junin');
INSERT INTO `libreria`.`ciudad` (`ciudad_id`, `ciudad_nombre`) VALUES ('10', 'Rafaela');

COMMIT;*/


-- transacción en la tabla nacionalidad
START TRANSACTION;

INSERT INTO `libreria`.`nacionalidad` (`nacionalidad_id`, `nacionalidad_nombre`) VALUES (null, 'Colombiana');
INSERT INTO `libreria`.`nacionalidad` (`nacionalidad_id`, `nacionalidad_nombre`) VALUES (null, 'Chilena');
INSERT INTO `libreria`.`nacionalidad` (`nacionalidad_id`, `nacionalidad_nombre`) VALUES (null, 'Peruana');
INSERT INTO `libreria`.`nacionalidad` (`nacionalidad_id`, `nacionalidad_nombre`) VALUES (null, 'Venezolana');

SAVEPOINT primer_savepoint;

INSERT INTO `libreria`.`nacionalidad` (`nacionalidad_id`, `nacionalidad_nombre`) VALUES (null, 'Mexicana');
INSERT INTO `libreria`.`nacionalidad` (`nacionalidad_id`, `nacionalidad_nombre`) VALUES (null, 'Cubana');
INSERT INTO `libreria`.`nacionalidad` (`nacionalidad_id`, `nacionalidad_nombre`) VALUES (null, 'Boliviana');
INSERT INTO `libreria`.`nacionalidad` (`nacionalidad_id`, `nacionalidad_nombre`) VALUES (null, 'Uruguaya');


-- SAVEPOINT segundo_savepoint;

ROLLBACK TO primer_savepoint;

COMMIT;