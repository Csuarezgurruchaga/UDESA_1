-- -- /*******************************************************************************
-- --    Barberia Database - Version 1.0
-- --    Script: barberia.sql
-- --    Description: Creates and populates the Barberia database.
-- --    DB Server: PostgreSql
-- --    Author: Grupo BDC
-- -- ********************************************************************************/

-- ----------------------------
-- Sequence structure for turnos_id_seq
-- ----------------------------
CREATE SEQUENCE IF NOT EXISTS"turnos_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 2147483647
 START 1
 CACHE 1;
SELECT setval('"public"."turnos_id_seq"', 1, true);-- arranca en 20


-- ----------------------------
-- Sequence structure for servicio_id_seq
-- ----------------------------
CREATE SEQUENCE IF NOT EXISTS "servicio_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 2147483647
 START 1
 CACHE 1;
SELECT setval('"public"."servicio_id_seq"', 1, true);


-- ----------------------------
-- Sequence structure for clientes_id_seq
-- ----------------------------
CREATE SEQUENCE IF NOT EXISTS "clientes_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 2147483647
 START 1
 CACHE 1;
SELECT setval('"public"."clientes_id_seq"', 1, true);

-- ----------------------------
-- Sequence structure for gift_card_id_seq
-- ----------------------------
CREATE SEQUENCE "gift_card_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 2147483647
 START 1
 CACHE 1;
SELECT setval('"public"."gift_card_id_seq"', 1, true);


-- ----------------------------
-- Sequence structure for idsuc
-- ----------------------------
CREATE SEQUENCE IF NOT EXISTS "sucursal_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 2147483647
 START 1
 CACHE 1;
SELECT setval('"public"."sucursal_id_seq"', 1, true);


-- ----------------------------
-- Sequence structure for id_herramienta
-- ----------------------------
CREATE SEQUENCE IF NOT EXISTS "herramienta_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 2147483647
 START 1
 CACHE 1;
SELECT setval('"public"."herramienta_id_seq"', 1, true);

-- ----------------------------
-- Sequence structure for id_factura
-- ----------------------------
CREATE SEQUENCE IF NOT EXISTS "factura_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 2147483647
 START 1
 CACHE 1;
SELECT setval('"public"."factura_id_seq"', 1, true);

-- ----------------------------
-- Sequence structure for id_juego
-- ----------------------------
CREATE SEQUENCE IF NOT EXISTS "id_juego_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 2147483647
 START 1
 CACHE 1;
SELECT setval('"public"."id_juego_seq"', 1, true);

-- ----------------------------
-- Sequence structure for id_producto
-- ----------------------------
CREATE SEQUENCE IF NOT EXISTS "id_producto_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 2147483647
 START 1
 CACHE 1;
SELECT setval('"public"."id_producto_seq"', 1, true);

-- ----------------------------
-- Sequence structure for id_bebida
-- ----------------------------
CREATE SEQUENCE "bebida_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 2147483647
 START 1
 CACHE 1;
SELECT setval('"public"."bebida_id_seq"', 1, true);-- 

-- ----------------------------
-- Sequence structure for puesto_id_seq
-- ----------------------------
CREATE SEQUENCE "puesto_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 2147483647
 START 1
 CACHE 1;
SELECT setval('"public"."puesto_id_seq"', 1, true);

-- ----------------------------
-- Sequence structure for id_precio_seq
-- ----------------------------
CREATE SEQUENCE "id_precio_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 2147483647
 START 1
 CACHE 1;
SELECT setval('"public"."id_precio_seq"', 1, true);


-- /*******************************************************************************
--    Create Tables
-- ********************************************************************************/



CREATE TABLE IF NOT EXISTS turnos
(
    id_reserva int DEFAULT nextval('turnos_id_seq'::regclass) NOT NULL,
    id_servicio INT NOT NULL,
    id_cliente INT,
    legajo INT,
    id_factura INT,
    horafecha TIMESTAMP,
    CONSTRAINT pk_id_reserva PRIMARY KEY  (id_reserva)
);


CREATE TABLE IF NOT EXISTS servicio
(
    id_servicio int DEFAULT nextval('servicio_id_seq'::regclass) NOT NULL,
    id_factura INT,
	id_precio INT,
    CONSTRAINT pk_id_servicio PRIMARY KEY  (id_servicio)
);


CREATE TABLE IF NOT EXISTS clientes
(
    id_cliente int DEFAULT nextval('clientes_id_seq'::regclass) NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    apellido VARCHAR(40) NOT NULL,
    email VARCHAR(60) NOT NULL,
    contraseña VARCHAR(10) NOT NULL,
    id_gift INT,
    CONSTRAINT pk_id_cliente PRIMARY KEY  (id_cliente)
);


CREATE TABLE IF NOT EXISTS gift_card
(
    id_gift INT DEFAULT nextval('gift_card_id_seq'::regclass) NOT NULL,
    id_suc INT NOT NULL,
    monto_total INT NOT NULL,
    descripcion VARCHAR(20) NOT NULL,
    lote INT,
    saldo INT NOT NULL,
    empresa VARCHAR(20),
    id_factura INT NOT NULL,
    monto_del_descuento FLOAT,
    CONSTRAINT pk_id_gift_card PRIMARY KEY  (id_gift)
);


CREATE TABLE IF NOT EXISTS empleado
(
	legajo INT NOT NULL PRIMARY KEY,
	id_suc INT,
	id_puesto INT,
	nombre_empleado VARCHAR(50) NOT NULL,
	apellido_empleado VARCHAR(50) NOT NULL,
	CUIL BIGINT NOT NULL
);

CREATE TABLE IF NOT EXISTS sucursal
(
	id_suc INT DEFAULT nextval('sucursal_id_seq'::regclass) NOT NULL PRIMARY KEY,
	id_domicilio INT, 
	id_inmueble INT
);

CREATE TABLE IF NOT EXISTS herramienta
(
	id_herramienta INT DEFAULT nextval('herramienta_id_seq'::regclass) NOT NULL PRIMARY KEY,
	descripcion_herramienta VARCHAR(100) NOT NULL,
	tiempo_vigencia DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS stock_herramienta
(
	id_suc INT NOT NULL,
	id_herramienta INT NOT NULL,
	comienza_uso DATE,
	PRIMARY KEY (id_suc, id_herramienta)
);

CREATE TABLE IF NOT EXISTS domicilio
(
	id_domicilio INT NOT NULL PRIMARY KEY,
	ciudad VARCHAR (30) NOT NULL,
	barrio VARCHAR (30) NOT NULL,
	codigo_postal SMALLINT NOT NULL,
	calle_y_numero VARCHAR (100) NOT NULL,
	provincia VARCHAR(30) NOT NULL,
	pais VARCHAR (30) NOT NULL
);

CREATE TABLE IF NOT EXISTS inmueble
(
	id_inmueble INT NOT NULL PRIMARY KEY,
	metro_cuadrado SMALLINT NOT NULL,
	propietario VARCHAR (50) NOT NULL,
	inmobiliaria VARCHAR (50),
	tipo_de_pago VARCHAR(25) NOT NULL,
	precio_alquiler FLOAT NOT NULL, 
	dependencias_en_altura VARCHAR (50),
	emplazamiento VARCHAR(100) 
);

CREATE TABLE IF NOT EXISTS consume
(
	id_bebida INT NOT NULL, 
	id_servicio INT NOT NULL,
	cantidad INT NOT NULL,
	PRIMARY KEY (id_bebida, id_servicio)
);

CREATE TABLE IF NOT EXISTS factura
(
	id_factura INT DEFAULT nextval('factura_id_seq'::regclass) NOT NULL PRIMARY KEY,
	fecha DATE NOT NULL,
	metodo_de_pago VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS juego
(
	id_juego INT DEFAULT nextval('id_juego_seq'::regclass) NOT NULL PRIMARY KEY,
	descripcion VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS ofrece
(
	id_juego INT NOT NULL,
	id_suc INT NOT NULL,
	PRIMARY KEY(id_juego, id_suc)
);

CREATE TABLE IF NOT EXISTS usa_producto
(
	id_reserva INT NOT NULL,
	id_producto INT NOT NULL,
	PRIMARY KEY (id_reserva, id_producto)
);

CREATE TABLE IF NOT EXISTS producto
(
	id_producto INT DEFAULT nextval('id_producto_seq'::regclass) NOT NULL PRIMARY KEY,
	descripcion VARCHAR(100) NOT NULL,
	precio_venta FLOAT,
	costo_reposicion FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS tarjeta
(
	id_factura INT NOT NULL PRIMARY KEY,
	cantidad_cuotas INT NOT NULL
	
);

CREATE TABLE IF NOT EXISTS bebida
(
	id_bebida INT DEFAULT nextval('bebida_id_seq'::regclass) NOT NULL PRIMARY KEY,
	id_factura INT NOT NULL,
	nombre VARCHAR(20) NOT NULL,
	precio FLOAT NOT NULL

);

CREATE TABLE IF NOT EXISTS puesto
(
	id_puesto INT DEFAULT nextval('puesto_id_seq'::regclass) NOT NULL PRIMARY KEY,
	descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS peluqueria
(
	id_servicio INT NOT NULL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS combo
(
	id_servicio INT NOT NULL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS especial
(
	id_servicio INT NOT NULL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS stock_productos
(
	id_producto INT,
	id_suc INT,
	cantidad INT NOT NULL,
	PRIMARY KEY (id_producto, id_suc)
);

CREATE TABLE IF NOT EXISTS barberia
(
	id_servicio INT NOT NULL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS precio
(
	id_precio INT DEFAULT nextval('id_precio_seq'::regclass) NOT NULL PRIMARY KEY,
	precio FLOAT,
	nombre_servicio VARCHAR(20)
);

/*******************************************************************************
   Create Foreign Keys
********************************************************************************/

ALTER TABLE clientes ADD CONSTRAINT fk_clientes_id_gift_card
    FOREIGN KEY (id_gift) REFERENCES gift_card (id_gift) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE turnos ADD CONSTRAINT fk_turnos_id_servicio
    FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE turnos ADD CONSTRAINT fk_turnos_id_cliente
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE empleado ADD CONSTRAINT fk_idsuc
	FOREIGN KEY (id_suc) REFERENCES sucursal (id_suc) ON DELETE NO ACTION ON UPDATE NO ACTION;
	
ALTER TABLE stock_herramienta ADD CONSTRAINT fk_idsuc2
	FOREIGN KEY (id_suc) REFERENCES sucursal (id_suc) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE stock_herramienta ADD CONSTRAINT fk_idherramienta
	FOREIGN KEY (id_herramienta) REFERENCES herramienta (id_herramienta) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE consume ADD CONSTRAINT fk_id_bebida
	FOREIGN KEY (id_bebida) REFERENCES bebida (id_bebida) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE consume ADD CONSTRAINT fk_id_servicio
	FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio) ON DELETE NO ACTION ON UPDATE NO ACTION;
	
ALTER TABLE ofrece ADD CONSTRAINT fk_id_juego
	FOREIGN KEY (id_juego) REFERENCES juego (id_juego) ON DELETE NO ACTION ON UPDATE NO ACTION;
	
ALTER TABLE ofrece ADD CONSTRAINT fk_idsuc3
	FOREIGN KEY (id_suc) REFERENCES sucursal (id_suc) ON DELETE NO ACTION ON UPDATE NO ACTION;
	
ALTER TABLE usa_producto ADD CONSTRAINT fk_id_reserva
	FOREIGN KEY (id_reserva) REFERENCES turnos (id_reserva) ON DELETE NO ACTION ON UPDATE NO ACTION;
	
ALTER TABLE usa_producto ADD CONSTRAINT fk_id_producto
	FOREIGN KEY (id_producto) REFERENCES producto (id_producto) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE tarjeta ADD CONSTRAINT fk_tarjeta_id_factura
    FOREIGN KEY (id_factura) REFERENCES factura (id_factura) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE bebida ADD CONSTRAINT fk_bebida_id_factura
    FOREIGN KEY (id_factura) REFERENCES factura (id_factura) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE peluqueria ADD CONSTRAINT fk_peluqueria_id_factura
    FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE barberia ADD CONSTRAINT fk_barberia_id_factura
    FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio) ON DELETE NO ACTION ON UPDATE NO ACTION;
	
ALTER TABLE especial ADD CONSTRAINT fk_especial_id_factura
    FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio) ON DELETE NO ACTION ON UPDATE NO ACTION;
	
ALTER TABLE combo ADD CONSTRAINT fk_combo_id_factura
    FOREIGN KEY (id_servicio) REFERENCES servicio (id_servicio) ON DELETE NO ACTION ON UPDATE NO ACTION;
	
ALTER TABLE stock_productos ADD CONSTRAINT fk_id_producto_stock_productos
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto) ON DELETE NO ACTION ON UPDATE NO ACTION;
	
ALTER TABLE stock_productos ADD CONSTRAINT fk_id_suc4
    FOREIGN KEY (id_suc) REFERENCES sucursal (id_suc) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE servicio ADD CONSTRAINT fk_id_precio
    FOREIGN KEY (id_precio) REFERENCES precio (id_precio) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*******************************************************************************
   Populate Tables
********************************************************************************/

INSERT INTO factura (id_factura, fecha, metodo_de_pago) VALUES(1,'2022-05-05','efectivo');
INSERT INTO factura (id_factura, fecha, metodo_de_pago) VALUES(2,'2022-05-05','efectivo');
INSERT INTO factura (id_factura, fecha, metodo_de_pago) VALUES(3,'2022-05-06','tarjeta');
INSERT INTO factura (id_factura, fecha, metodo_de_pago) VALUES(4,'2022-05-06','tarjeta');
INSERT INTO factura (id_factura, fecha, metodo_de_pago) VALUES(5,'2022-05-06','tarjeta');
INSERT INTO factura (id_factura, fecha, metodo_de_pago) VALUES(6,'2022-05-07','tarjeta');
INSERT INTO factura (id_factura, fecha, metodo_de_pago) VALUES(7,'2022-05-08','tarjeta');
INSERT INTO factura (id_factura, fecha, metodo_de_pago) VALUES(8,'2022-05-09','tarjeta');
INSERT INTO factura (id_factura, fecha, metodo_de_pago) VALUES(9,'2022-05-05','efectivo');
INSERT INTO factura (id_factura, fecha, metodo_de_pago) VALUES(10,'2022-05-05','efectivo');
INSERT INTO factura (id_factura, fecha, metodo_de_pago) VALUES(11,'2022-05-06','tarjeta');
INSERT INTO factura (id_factura, fecha, metodo_de_pago) VALUES(12,'2022-05-06','efectivo');
INSERT INTO factura (id_factura, fecha, metodo_de_pago) VALUES(13,'2022-05-06','efectivo');
INSERT INTO factura (id_factura, fecha, metodo_de_pago) VALUES(14,'2022-05-07','tarjeta');
INSERT INTO factura (id_factura, fecha, metodo_de_pago) VALUES(15,'2022-05-08','tarjeta');
INSERT INTO factura (id_factura, fecha, metodo_de_pago) VALUES(16,'2022-05-09','tarjeta');



INSERT INTO gift_card (id_gift, descripcion, empresa, id_factura, id_suc, lote, monto_del_descuento, monto_total, saldo) 
			VALUES (1,'barbería', 'FIAT', 1, 1, 10, 10, 100, 100);
INSERT INTO gift_card (id_gift, descripcion, empresa, id_factura, id_suc, lote, monto_del_descuento, monto_total, saldo) 
			VALUES (2,'combo', 'Google', 5, 2, 10, 10, 100, 100);
INSERT INTO gift_card (id_gift, descripcion, empresa, id_factura, id_suc, lote, monto_del_descuento, monto_total, saldo) 
			VALUES (3,'especial', 'Mercado', 7, 3, 10, 10, 100, 0);
INSERT INTO gift_card (id_gift, descripcion, empresa, id_factura, id_suc, lote, monto_del_descuento, monto_total, saldo) 
			VALUES (4,'barbería', 'FIAT', 3, 1, 10, 10, 100, 90);
			



INSERT INTO clientes (id_cliente, nombre, apellido, email, "contraseña", id_gift) VALUES (1,'Jorge', 'Bueno', 'jbueno@gmail.com', 'jb12',NULL);
INSERT INTO clientes (id_cliente, nombre, apellido, email, "contraseña", id_gift) VALUES (2,'Claudio', 'Perez', 'cperez@gmail.com', 'cp12',NULL);
INSERT INTO clientes (id_cliente, nombre, apellido, email, "contraseña", id_gift) VALUES (3,'Esteban', 'Gonzalez', 'egonzalez@gmail.com', 'eg34',1);
INSERT INTO clientes (id_cliente, nombre, apellido, email, "contraseña", id_gift) VALUES (4,'Daniel', 'Grosky', 'dg@gmail.com', 'dg45',NULL);
INSERT INTO clientes (id_cliente, nombre, apellido, email, "contraseña", id_gift) VALUES (5,'Jorge', 'Perez', 'jperez@gmail.com', 'jp19',NULL);
INSERT INTO clientes (id_cliente, nombre, apellido, email, "contraseña", id_gift) VALUES (6,'Matías', 'Fernandez', 'mf@hotmail.com', 'mf99',2);
INSERT INTO clientes (id_cliente, nombre, apellido, email, "contraseña", id_gift) VALUES (7,'Carlos', 'Altamirano', 'caltamirano@gmail.com', 'cc11',NULL);
INSERT INTO clientes (id_cliente, nombre, apellido, email, "contraseña", id_gift) VALUES (8,'Carlos', 'Acha', 'cacha@gmail.com', 'ca01',NULL);
INSERT INTO clientes (id_cliente, nombre, apellido, email, "contraseña", id_gift) VALUES (9,'Miguel', 'Gonzalez', 'mgonzalez@gmail.com', 'mg88',3);
INSERT INTO clientes (id_cliente, nombre, apellido, email, "contraseña", id_gift) VALUES (10,'Manuel', 'Holmberg', 'mholmberg@gmail.com', 'mh87',NULL);
INSERT INTO clientes (id_cliente, nombre, apellido, email, "contraseña", id_gift) VALUES (11,'Eduardo', 'Donado', 'edonado@gmail.com', 'ed12',NULL);
INSERT INTO clientes (id_cliente, nombre, apellido, email, "contraseña", id_gift) VALUES (12,'Mateo', 'Donado', 'mdonado@gmail.com', 'md34',4);




INSERT INTO servicio (id_servicio, id_factura) VALUES (1,1);
INSERT INTO servicio (id_servicio, id_factura) VALUES (2,2);
INSERT INTO servicio (id_servicio, id_factura) VALUES (3,3);
INSERT INTO servicio (id_servicio, id_factura) VALUES (4,4);


INSERT INTO servicio (id_servicio, id_factura) VALUES (5,5);
INSERT INTO servicio (id_servicio, id_factura) VALUES (6,6);
INSERT INTO servicio (id_servicio, id_factura) VALUES (7,7);
INSERT INTO servicio (id_servicio, id_factura) VALUES (8,8);
INSERT INTO servicio (id_servicio, id_factura) VALUES (9,9);
INSERT INTO servicio (id_servicio, id_factura) VALUES (10,10);
INSERT INTO servicio (id_servicio, id_factura) VALUES (11,11);
INSERT INTO servicio (id_servicio, id_factura) VALUES (12,12);
INSERT INTO servicio (id_servicio, id_factura) VALUES (13,13);
INSERT INTO servicio (id_servicio, id_factura) VALUES (14,14);
INSERT INTO servicio (id_servicio, id_factura) VALUES (15,15);
INSERT INTO servicio (id_servicio, id_factura) VALUES (16,16);
INSERT INTO servicio (id_servicio, id_factura) VALUES (17,17);



INSERT INTO barberia (id_servicio) values (1);
INSERT INTO barberia (id_servicio) values (2);
INSERT INTO barberia (id_servicio) values (4);
INSERT INTO barberia (id_servicio) values (7);
INSERT INTO barberia (id_servicio) values (8);
INSERT INTO barberia (id_servicio) values (9);
INSERT INTO barberia (id_servicio) values (12);
INSERT INTO barberia (id_servicio) values (17);

INSERT INTO especial (id_servicio) values (15);

INSERT INTO combo (id_servicio) values (3);
INSERT INTO combo (id_servicio) values (11);
INSERT INTO combo (id_servicio) values (14);

INSERT INTO peluqueria (id_servicio) values (1);
INSERT INTO peluqueria (id_servicio) values (2);
INSERT INTO peluqueria (id_servicio) values (4);
INSERT INTO peluqueria (id_servicio) values (5);
INSERT INTO peluqueria (id_servicio) values (6);
INSERT INTO peluqueria (id_servicio) values (7);
INSERT INTO peluqueria (id_servicio) values (8);
INSERT INTO peluqueria (id_servicio) values (9);
INSERT INTO peluqueria (id_servicio) values (10);
INSERT INTO peluqueria (id_servicio) values (12);
INSERT INTO peluqueria (id_servicio) values (13);
INSERT INTO peluqueria (id_servicio) values (16);

------------AGREGO CHARLY R.----------

INSERT INTO puesto (id_puesto, descripcion) VALUES (1, 'barbero'); 
INSERT INTO puesto (id_puesto, descripcion) VALUES (2, 'peluquero');
INSERT INTO puesto (id_puesto, descripcion) VALUES (3, 'cajero');


INSERT INTO bebida (id_bebida, id_factura, nombre, precio) VALUES (1, 1, 'agua saborizada', 200);
INSERT INTO bebida (id_bebida, id_factura, nombre, precio) VALUES (2, 2, 'bebida no alcoholica', 200);
INSERT INTO bebida (id_bebida, id_factura, nombre, precio) VALUES (3, 5, 'cerveza quilmes', 230);
INSERT INTO bebida (id_bebida, id_factura, nombre, precio) VALUES (4, 16, 'cerveza corona', 300);
INSERT INTO bebida (id_bebida, id_factura, nombre, precio) VALUES (5, 4, 'cerveza brahma', 250);
INSERT INTO bebida (id_bebida, id_factura, nombre, precio) VALUES (6, 3, 'agua sin gas', 170);
INSERT INTO bebida (id_bebida, id_factura, nombre, precio) VALUES (7, 6, 'agua con gas', 170);
INSERT INTO bebida (id_bebida, id_factura, nombre, precio) VALUES (8, 7, 'sumo de naranja', 200);


INSERT INTO consume (id_bebida, id_servicio, cantidad) VALUES (1, 1, 1);
INSERT INTO consume (id_bebida, id_servicio, cantidad) VALUES (2, 2, 1);
INSERT INTO consume (id_bebida, id_servicio, cantidad) VALUES (3, 3, 2);
INSERT INTO consume (id_bebida, id_servicio, cantidad) VALUES (4, 16, 3);
INSERT INTO consume (id_bebida, id_servicio, cantidad) VALUES (5, 4, 2);
INSERT INTO consume (id_bebida, id_servicio, cantidad) VALUES (6, 3, 1);
INSERT INTO consume (id_bebida, id_servicio, cantidad) VALUES (7, 6, 1);
INSERT INTO consume (id_bebida, id_servicio, cantidad) VALUES (8, 7, 1);



INSERT INTO tarjeta (id_factura, cantidad_cuotas) VALUES (3, 1);
INSERT INTO tarjeta (id_factura, cantidad_cuotas) VALUES (4, 6);
INSERT INTO tarjeta (id_factura, cantidad_cuotas) VALUES (5, 6);
INSERT INTO tarjeta (id_factura, cantidad_cuotas) VALUES (6, 3);
INSERT INTO tarjeta (id_factura, cantidad_cuotas) VALUES (7, 3);
INSERT INTO tarjeta (id_factura, cantidad_cuotas) VALUES (8, 1);
INSERT INTO tarjeta (id_factura, cantidad_cuotas) VALUES (11, 1);
INSERT INTO tarjeta (id_factura, cantidad_cuotas) VALUES (14, 3);
INSERT INTO tarjeta (id_factura, cantidad_cuotas) VALUES (15, 3);
INSERT INTO tarjeta (id_factura, cantidad_cuotas) VALUES (16, 6);


INSERT INTO producto (id_producto, descripcion, precio_venta, costo_reposicion) VALUES (1, 'aceite de jerez', 1500, 800);
INSERT INTO producto (id_producto, descripcion, precio_venta, costo_reposicion) VALUES (2, 'aceite europeo', 3000, 1000);
INSERT INTO producto (id_producto, descripcion, precio_venta, costo_reposicion) VALUES (3, 'aceite estandard', 600, 250);
INSERT INTO producto (id_producto, descripcion, precio_venta, costo_reposicion) VALUES (4, 'balsamo de caña', 2000, 1200);
INSERT INTO producto (id_producto, descripcion, precio_venta, costo_reposicion) VALUES (5, 'balsamo de pistaccio', 2200, 1300);
INSERT INTO producto (id_producto, descripcion, precio_venta, costo_reposicion) VALUES (6, 'balsamo standard', 800, 400);
INSERT INTO producto (id_producto, descripcion, precio_venta, costo_reposicion) VALUES (7, 'jabon natura', 500, 300);
INSERT INTO producto (id_producto, descripcion, precio_venta, costo_reposicion) VALUES (8, 'jabon estandard', 300, 100);
INSERT INTO producto (id_producto, descripcion, precio_venta, costo_reposicion) VALUES (9, 'jabon con fragancia de la mesopotamia', 600, 200);
INSERT INTO producto (id_producto, descripcion, precio_venta, costo_reposicion) VALUES (10, 'cera premium', 1000, 500);
INSERT INTO producto (id_producto, descripcion, precio_venta, costo_reposicion) VALUES (11, 'cera estandard', 750, 400);
INSERT INTO producto (id_producto, descripcion, precio_venta, costo_reposicion) VALUES (12, 'cera nacional', 600, 250);


INSERT INTO precio (id_precio, precio, nombre_servicio) VALUES (1, 2500, 'combo'); -- combo
INSERT INTO precio (id_precio, precio, nombre_servicio) VALUES (2, 1000, 'corte de pelo'); -- pelo
INSERT INTO precio (id_precio, precio, nombre_servicio) VALUES (3, 800, 'corte de barba'); -- barba
INSERT INTO precio (id_precio, precio, nombre_servicio) VALUES (4, 3200, 'servicio especial'); -- especial


INSERT INTO turnos (id_reserva, id_servicio, id_cliente, id_factura, legajo, horafecha) 
			VALUES (01, 01, 01, 01, 03, '2022-05-05 10:00:00');
INSERT INTO turnos (id_reserva, id_servicio, id_cliente, id_factura, legajo, horafecha) 
			VALUES (02, 02, 02, 02, 03, '2022-05-05 10:30:00');
INSERT INTO turnos (id_reserva, id_servicio, id_cliente, id_factura, legajo, horafecha) 
			VALUES (03, 03, 03, 03, 03, '2022-05-06 11:00:00');
INSERT INTO turnos (id_reserva, id_servicio, id_cliente, id_factura, legajo, horafecha) 
			VALUES (04, 04, 04, 04, 02, '2022-05-06 10:00:00');
INSERT INTO turnos (id_reserva, id_servicio, id_cliente, id_factura, legajo, horafecha) 
			VALUES (05, 05, 05, 05, 02,  '2022-05-06 10:30:00');
INSERT INTO turnos (id_reserva, id_servicio, id_cliente, id_factura, legajo, horafecha) 
			VALUES (06, 06, 06, 06, 06, '2022-05-07 10:00:00');
INSERT INTO turnos (id_reserva, id_servicio, id_cliente, id_factura, legajo, horafecha) 
			VALUES (07, 07, 07, 07, 06,  '2022-05-08 10:30:00');
INSERT INTO turnos (id_reserva, id_servicio, id_cliente, id_factura, legajo, horafecha) 
			VALUES (08, 08, 08, 08, 02,  '2022-05-09 10:00:00');
INSERT INTO turnos (id_reserva, id_servicio, id_cliente, id_factura, legajo, horafecha) 
			VALUES (09, 09, 09, 09, 06,  '2022-05-05 15:30:00');
INSERT INTO turnos (id_reserva, id_servicio, id_cliente, id_factura, legajo, horafecha) 
			VALUES (10, 10, 10, 10, 06,'2022-05-05 16:00:00');









--- de aca para abajo CL ----

INSERT INTO sucursal (id_suc, id_domicilio, id_inmueble) VALUES (01,01,01);
INSERT INTO sucursal (id_suc, id_domicilio, id_inmueble) VALUES (02,02,02);
INSERT INTO sucursal (id_suc, id_domicilio, id_inmueble) VALUES (03,03,03);
INSERT INTO sucursal (id_suc, id_domicilio, id_inmueble) VALUES (04,04,04);
INSERT INTO sucursal (id_suc, id_domicilio, id_inmueble) VALUES (05,05,05);
INSERT INTO sucursal (id_suc, id_domicilio, id_inmueble) VALUES (06,06,06);
INSERT INTO sucursal (id_suc, id_domicilio, id_inmueble) VALUES (07,07,07);

INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (1,01,3);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (2,01,4);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (3,01,2);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (4,01,5);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (5,01,3);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (6,01,6);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (7,01,2);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (8,01,1);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (9,01,5);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (10,01,6);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (11,01,2);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (12,01,3);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (1,02,3);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (2,02,4);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (3,02,2);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (4,02,5);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (5,02,3);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (6,02,6);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (7,02,2);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (8,02,1);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (9,02,5);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (10,02,6);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (11,02,2);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (12,02,3);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (1,07,3);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (2,07,4);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (3,07,2);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (4,07,5);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (5,07,3);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (6,07,6);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (7,07,2);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (8,07,1);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (9,07,5);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (10,07,6);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (11,07,2);
INSERT INTO stock_productos (id_producto, id_suc, cantidad) VALUES (12,07,3);



INSERT INTO empleado (legajo, id_suc, id_puesto, nombre_empleado, apellido_empleado, CUIL) VALUES (01, 1, 01, 'Julian', 'Alvarez', 23309498309);
INSERT INTO empleado (legajo, id_suc, id_puesto, nombre_empleado, apellido_empleado, CUIL) VALUES (02, 1, 02, 'Miguel', 'Gomez', 23329558429);
INSERT INTO empleado (legajo, id_suc, id_puesto, nombre_empleado, apellido_empleado, CUIL) VALUES (03, 2, 01, 'Jose', 'Smith', 23313966309);
INSERT INTO empleado (legajo, id_suc, id_puesto, nombre_empleado, apellido_empleado, CUIL) VALUES (04, 2, 03, 'Carlos', 'Tapia', 23309438419);
INSERT INTO empleado (legajo, id_suc, id_puesto, nombre_empleado, apellido_empleado, CUIL) VALUES (05, 7, 01, 'Rafael', 'Fernandez', 23294466309);
INSERT INTO empleado (legajo, id_suc, id_puesto, nombre_empleado, apellido_empleado, CUIL) VALUES (06, 7, 02, 'Walter', 'Gonzalez', 23359123419);

INSERT INTO herramienta (id_herramienta, descripcion_herramienta, tiempo_vigencia) VALUES (01,'Tijera de acero inoxidable', '2023-05-05');
INSERT INTO herramienta (id_herramienta, descripcion_herramienta, tiempo_vigencia) VALUES (02,'Tijera de acero inoxidable', '2023-07-05');
INSERT INTO herramienta (id_herramienta, descripcion_herramienta, tiempo_vigencia) VALUES (03,'Tijera de acero inoxidable', '2024-01-05');
INSERT INTO herramienta (id_herramienta, descripcion_herramienta, tiempo_vigencia) VALUES (04,'Maquina de afeitar Whal', '2023-03-05');
INSERT INTO herramienta (id_herramienta, descripcion_herramienta, tiempo_vigencia) VALUES (05,'Maquina de afeitar Whal', '2024-03-05');
INSERT INTO herramienta (id_herramienta, descripcion_herramienta, tiempo_vigencia) VALUES (06,'Maquina de afeitar Brown', '2026-03-05');
INSERT INTO herramienta (id_herramienta, descripcion_herramienta, tiempo_vigencia) VALUES (07,'Peine importado', '2026-05-05');
INSERT INTO herramienta (id_herramienta, descripcion_herramienta, tiempo_vigencia) VALUES (08,'Navaja importado', '2026-05-05');
INSERT INTO herramienta (id_herramienta, descripcion_herramienta, tiempo_vigencia) VALUES (09,'Navaja importada', '2026-05-05');

INSERT INTO stock_herramienta (id_suc, id_herramienta, comienza_uso) VALUES (01,01, '2020-05-05');
INSERT INTO stock_herramienta (id_suc, id_herramienta, comienza_uso) VALUES (02,02, '2020-07-05');
INSERT INTO stock_herramienta (id_suc, id_herramienta, comienza_uso) VALUES (07,03, '2021-01-05');
INSERT INTO stock_herramienta (id_suc, id_herramienta, comienza_uso) VALUES (01,04, '2020-03-05');
INSERT INTO stock_herramienta (id_suc, id_herramienta, comienza_uso) VALUES (02,05, '2021-03-05');
INSERT INTO stock_herramienta (id_suc, id_herramienta, comienza_uso) VALUES (07,06, '2022-03-05');
INSERT INTO stock_herramienta (id_suc, id_herramienta, comienza_uso) VALUES (01,07, '2022-05-05');
INSERT INTO stock_herramienta (id_suc, id_herramienta, comienza_uso) VALUES (02,08, '2022-05-05');
INSERT INTO stock_herramienta (id_suc, id_herramienta, comienza_uso) VALUES (07,09, '2022-05-05');

INSERT INTO domicilio (id_domicilio, ciudad, barrio, codigo_postal, calle_y_numero, provincia, pais) VALUES (01, 'CABA', 'Belgrano', 1671, 'Libertador 1020', 'Buenos Aires', 'Argentina');
INSERT INTO domicilio (id_domicilio, ciudad, barrio, codigo_postal, calle_y_numero, provincia, pais) VALUES (02, 'CABA', 'Palermo', 1341, 'Santa Fe 135', 'Buenos Aires', 'Argentina');
INSERT INTO domicilio (id_domicilio, ciudad, barrio, codigo_postal, calle_y_numero, provincia, pais) VALUES (03, 'Rio de Janeiro', 'Botafogo', 2013, 'Pasteur 3334', 'Estado de Rio de janeiro', 'Brasil');
INSERT INTO domicilio (id_domicilio, ciudad, barrio, codigo_postal, calle_y_numero, provincia, pais) VALUES (04, 'Carilo', 'Norte', 1511, 'Divisadero 1020', 'Buenos Aires', 'Argentina');
INSERT INTO domicilio (id_domicilio, ciudad, barrio, codigo_postal, calle_y_numero, provincia, pais) VALUES (05, 'Los Angeles', 'Irvine', 1001, 'Edinger 111', 'California', 'EEUU');
INSERT INTO domicilio (id_domicilio, ciudad, barrio, codigo_postal, calle_y_numero, provincia, pais) VALUES (06, 'Londres', 'Islington', 1344, 'Smith Av. 1033', 'Londres', 'UK');
INSERT INTO domicilio (id_domicilio, ciudad, barrio, codigo_postal, calle_y_numero, provincia, pais) VALUES (07, 'CABA', 'Nuñez', 1441, 'Libertador 3030', 'Buenos Aires', 'Argentina');

INSERT INTO inmueble (id_inmueble, metro_cuadrado, propietario, inmobiliaria, tipo_de_pago, precio_alquiler, dependencias_en_altura, emplazamiento) VALUES (01, 30, 'Juan Perez', 'Gonzalez Hermanos', 'efectivo', 45000, 'Local sin dependencias en altura', 'el local está sobre una avenida');
INSERT INTO inmueble (id_inmueble, metro_cuadrado, propietario, inmobiliaria, tipo_de_pago, precio_alquiler, dependencias_en_altura, emplazamiento) VALUES (02, 60, 'Carlos Gonzalez', 'Castellanos and Flia.', 'efectivo', 85000, 'Local con dependencias en altura', 'el local está sobre una calle secundaria');
INSERT INTO inmueble (id_inmueble, metro_cuadrado, propietario, inmobiliaria, tipo_de_pago, precio_alquiler, dependencias_en_altura, emplazamiento) VALUES (03, 30, 'Carlos Gonzalez', 'Castellanos and Flia.', 'tarjeta', 30000, 'Local con dependencias en altura', 'el local está sobre una avenida');
INSERT INTO inmueble (id_inmueble, metro_cuadrado, propietario, inmobiliaria, tipo_de_pago, precio_alquiler, dependencias_en_altura, emplazamiento) VALUES (04, 25, 'Ruben Diaz', 'Castellanos and Flia.', 'efectivo', 20000, 'Local sin dependencias en altura', 'el local está sobre una calle secundaria');
INSERT INTO inmueble (id_inmueble, metro_cuadrado, propietario, inmobiliaria, tipo_de_pago, precio_alquiler, dependencias_en_altura, emplazamiento) VALUES (05, 35, 'Julian Riquelme', 'Inmobisolutions', 'tarjeta', 55000, 'Local con dependencias en altura', 'el local está sobre una avenida');
INSERT INTO inmueble (id_inmueble, metro_cuadrado, propietario, inmobiliaria, tipo_de_pago, precio_alquiler, dependencias_en_altura, emplazamiento) VALUES (06, 25, 'Maria Gross', 'Inmobisolutions', 'efectivo', 18000, 'Local sin dependencias en altura', 'el local está sobre una calle secundaria');
INSERT INTO inmueble (id_inmueble, metro_cuadrado, propietario, inmobiliaria, tipo_de_pago, precio_alquiler, dependencias_en_altura, emplazamiento) VALUES (07, 80, 'Federico Franco', 'Gonzalez Hermanos', 'tarjeta', 105000, 'Local con dependencias en altura', 'el local está sobre una avenida');

INSERT INTO juego (id_juego, descripcion) VALUES (01, 'Ajedrez');
INSERT INTO juego (id_juego, descripcion) VALUES (02, 'Domino');
INSERT INTO juego (id_juego, descripcion) VALUES (03, 'Monopoli');
INSERT INTO juego (id_juego, descripcion) VALUES (04, 'Risk');
INSERT INTO juego (id_juego, descripcion) VALUES (05, 'Pictionary');
INSERT INTO juego (id_juego, descripcion) VALUES (06, 'Damas');

INSERT INTO ofrece (id_juego, id_suc) VALUES (01,01);
INSERT INTO ofrece (id_juego, id_suc) VALUES (01,02);
INSERT INTO ofrece (id_juego, id_suc) VALUES (01,03);
INSERT INTO ofrece (id_juego, id_suc) VALUES (02,04);
INSERT INTO ofrece (id_juego, id_suc) VALUES (02,05);
INSERT INTO ofrece (id_juego, id_suc) VALUES (03,06);
INSERT INTO ofrece (id_juego, id_suc) VALUES (04,07);
INSERT INTO ofrece (id_juego, id_suc) VALUES (05,06);
INSERT INTO ofrece (id_juego, id_suc) VALUES (06,04);

INSERT INTO usa_producto (id_reserva, id_producto) VALUES (01,01);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (01,02);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (01,03);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (02,01);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (02,02);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (02,03);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (03,04);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (03,05);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (03,06);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (04,04);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (04,05);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (05,06);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (05,07);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (06,08);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (06,09);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (07,10);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (07,11);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (07,12);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (08,11);
INSERT INTO usa_producto (id_reserva, id_producto) VALUES (09,01);



-- Queremos saber qué clientes poseen giftcards, empresa que regala y su saldo
SELECT c.nombre, c.apellido, g.saldo, g.empresa FROM CLIENTES c
inner join gift_card g
	on c.id_gift = g.id_gift;


-- Donde quedan las sucursales de Argentina?
SELECT ciudad, barrio, calle_y_numero FROM domicilio
WHERE pais = 'Argentina';


-- Qué sucursales ofrecen el juego Domino?
SELECT s.id_suc, d.ciudad, d.barrio, d.calle_y_numero FROM domicilio d
inner join sucursal s 
	on s.id_domicilio = d.id_domicilio
inner join ofrece o
	on o.id_suc = s.id_suc
inner join juego j
	on j.id_juego = o.id_juego
WHERE j.descripcion = 'Domino';


-- Qué empleado es el más solicitado
SELECT  e.apellido_empleado, e.nombre_empleado, e.legajo as cantidad_turnos FROM empleado e
inner join turnos t 
	on t.legajo = e.legajo
GROUP BY e.legajo 
ORDER BY cantidad_turnos DESC
LIMIT 1;


-- Stock de productos de la sucursal 2
SELECT p.descripcion, p.id_producto, sp.cantidad FROM sucursal s  
inner join stock_productos sp 
	on s.id_suc = sp.id_suc
inner join producto p
	on p.id_producto = sp.id_producto
WHERE s.id_suc = 2;


-- Que cliente consume agua saborizada?
SELECT c.nombre, c.apellido, b.nombre FROM clientes c
inner join turnos t 
	on c.id_cliente = t.id_cliente
inner join servicio s
	on s.id_servicio = t.id_servicio
inner join consume co
	on co.id_servicio = s.id_servicio
inner join bebida b
	on b.id_bebida = co.id_bebida
WHERE b.nombre = 'agua saborizada';


-- Stock de herramientas de la sucursal 1 y 2
SELECT h.descripcion_herramienta, h.id_herramienta, s.id_suc FROM sucursal s
inner join stock_herramienta sh 
	on s.id_suc = sh.id_suc
inner join herramienta h
	on h.id_herramienta = sh.id_herramienta
WHERE s.id_suc IN (1,2);


---- Precio de un corte de pelo
SELECT pr.precio, pr.nombre_servicio FROM precio pr
WHERE pr.nombre_servicio = 'corte de pelo';




