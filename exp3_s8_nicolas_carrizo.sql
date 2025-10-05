-- Eliminacion de tablas
DROP TABLE DETALLE_VENTA PURGE;
DROP TABLE VENTA PURGE;
DROP TABLE MEDIO_PAGO PURGE;
DROP TABLE VENDEDOR PURGE;
DROP TABLE ADMINISTRATIVO PURGE;
DROP TABLE EMPLEADO PURGE;
DROP TABLE SALUD PURGE;
DROP TABLE AFP PURGE;
DROP TABLE PRODUCTO PURGE;
DROP TABLE MARCA PURGE;
DROP TABLE CATEGORIA PURGE;
DROP TABLE PROVEEDOR PURGE;
DROP TABLE COMUNA PURGE;
DROP TABLE REGION PURGE;

-- Eliminacion de secuencias
DROP SEQUENCE SEQ_SALUD;
DROP SEQUENCE SEQ_EMPLEADO;

-- Creacion de tabla Region
CREATE TABLE REGION (
id_region NUMBER(4),
nom_region VARCHAR2(255)
CONSTRAINT NOM_REGION_NNULL NOT NULL,
-- Definicion de clave primaria
CONSTRAINT REGION_PK PRIMARY KEY (id_region)
);

-- Creacion de tabla comuna
CREATE TABLE COMUNA (
id_comuna NUMBER(4),
nom_comuna VARCHAR2(100)
CONSTRAINT NOM_COMUNA_NNULL NOT NULL,
cod_region NUMBER(4)
CONSTRAINT COMUNA_REGION_NNULL NOT NULL,
-- Definicion de claves primaria y foraneas
CONSTRAINT COMUNA_PK PRIMARY KEY (id_comuna),
CONSTRAINT COMUNA_REGION_FK FOREIGN KEY (cod_region)
REFERENCES REGION (id_region)
);

-- Definicion de tabla Proveedor
CREATE TABLE PROVEEDOR (
id_proveedor NUMBER(5),
nombre_proveedor VARCHAR2(150)
CONSTRAINT NOMBRE_PROVEEDOR_NNULL NOT NULL,
rut_proveedor VARCHAR2(10)
CONSTRAINT RUT_PROVEEDOR_NNULL NOT NULL,
telefono VARCHAR2(10)
CONSTRAINT TELEFONO_NNULL NOT NULL,
email VARCHAR2(200)
CONSTRAINT EMAIL_NNULL NOT NULL,
direccion VARCHAR2(200)
CONSTRAINT DIRECCION_NNULL NOT NULL,
cod_comuna NUMBER(4)
CONSTRAINT PROVEEDOR_COMUNA_NNULL NOT NULL,
-- Definicion de claves primaria y foraneas
CONSTRAINT PROVEEDOR_PK PRIMARY KEY (id_proveedor),
CONSTRAINT PROVEEDOR_COMUNA_FK FOREIGN KEY (cod_comuna) 
REFERENCES COMUNA(id_comuna)
);

-- Creacion de tabla Categoria
CREATE TABLE CATEGORIA (
id_categoria NUMBER(3),
nombre_categoria VARCHAR2(255)
CONSTRAINT NOMBRE_CATEGORIA_NNULL NOT NULL,
-- Definicion de clave primaria
CONSTRAINT CATEGORIA_PK PRIMARY KEY (id_categoria)
);

-- Creacion de tabla Marca
CREATE TABLE MARCA (
id_marca NUMBER(3),
nombre_marca VARCHAR2(25)
CONSTRAINT NOMBRE_MARCA_NNULL NOT NULL,
-- Definicion de clave primaria
CONSTRAINT MARCA_PK PRIMARY KEY (id_marca)
);

-- Creacion de tabla Producto
CREATE TABLE PRODUCTO (
id_producto NUMBER(4),
nombre_producto VARCHAR2(100)
CONSTRAINT NOMBRE_PRODUCTO_NNULL NOT NULL,
precio_unitario NUMBER
CONSTRAINT PRECIO_UNITARIO_NNULL NOT NULL,
origen_nacional CHAR(1)
CONSTRAINT ORIGEN_NACIONAL_NNULL NOT NULL,
stock_minimo NUMBER(3)
CONSTRAINT STOCK_MINIMO_NNULL NOT NULL,
activo CHAR(1)
CONSTRAINT ACTIVO_PRODUCTO_NNULL NOT NULL,
cod_marca NUMBER(3)
CONSTRAINT PRODUCTO_MARCA_NNULL NOT NULL,
cod_categoria NUMBER(3)
CONSTRAINT PRODUCTO_CATEGORIA_NNULL NOT NULL,
cod_proveedor NUMBER(5)
CONSTRAINT PRODUCTO_PROVEEDOR_NNULL NOT NULL,
-- Definicion de claves primaria y foraneas
CONSTRAINT PRODUCTO_PK PRIMARY KEY (id_producto),
CONSTRAINT PRODUCTO_MARCA_FK FOREIGN KEY (cod_marca) 
    REFERENCES MARCA(id_marca),
CONSTRAINT PRODUCTO_CATEGORIA_FK FOREIGN KEY (cod_categoria)
    REFERENCES CATEGORIA(id_categoria),
CONSTRAINT PRODUCTO_PROVEEDOR_FK FOREIGN KEY (cod_proveedor) 
    REFERENCES PROVEEDOR(id_proveedor)
);

-- Creacion de tabla Afp
CREATE TABLE AFP (
-- El ID de la Afp se genera como identity
id_afp NUMBER(5) GENERATED ALWAYS AS IDENTITY 
    START WITH 210
    INCREMENT BY 6,
nom_afp VARCHAR2(255)
CONSTRAINT NOM_AFP_NNULL NOT NULL,
-- Definicion de clave primaria
CONSTRAINT AFP_PK PRIMARY KEY (id_afp)
);

-- Creacion de tabla Salud
CREATE TABLE SALUD (
id_salud NUMBER(4),
nom_salud VARCHAR2(40)
CONSTRAINT NOM_SALUD_NNULL NOT NULL,
-- Definicion de clave primaria
CONSTRAINT SALUD_PK PRIMARY KEY (id_salud)
);

-- Creacion de tabla Empleado
CREATE TABLE EMPLEADO (
id_empleado NUMBER(4),
rut_empleado VARCHAR2(10)
CONSTRAINT RUT_EMPLEADO_NNULL NOT NULL,
nombre_empleado VARCHAR2(25)
CONSTRAINT NOMBRE_EMPLEADO_NNULL NOT NULL,
apellido_paterno VARCHAR2(25)
CONSTRAINT APELLIDO_PATERNO_NNULL NOT NULL,
apellido_materno VARCHAR2(25)
CONSTRAINT APELLIDO_MATERNO_NNULL NOT NULL,
fecha_contratacion DATE
CONSTRAINT FECHA_CONTRATACION_NNULL NOT NULL,
sueldo_base NUMBER(10)
CONSTRAINT SUELDO_BASE_NNULL NOT NULL,
bono_jefatura NUMBER(10),
activo CHAR(1)
CONSTRAINT ACTIVO_EMPLEADO_NNULL NOT NULL,
tipo_empleado VARCHAR2(25)
CONSTRAINT TIPO_EMPLEADO_NNULL NOT NULL,
cod_empleado NUMBER(4),
cod_salud NUMBER(4)
CONSTRAINT EMPLEADO_SALUD_NNULL NOT NULL,
cod_afp NUMBER(5)
CONSTRAINT EMPLEADO_AFP_NNULL NOT NULL,
-- Claves primaria y foraneas
CONSTRAINT EMPLEADO_PK PRIMARY KEY (id_empleado),
CONSTRAINT EMPLEADO_SALUD_FK FOREIGN KEY (cod_salud) 
    REFERENCES SALUD(id_salud),
CONSTRAINT EMPLEADO_AFP_FK FOREIGN KEY (cod_afp) 
    REFERENCES AFP(id_afp),
CONSTRAINT EMPLEADO_EMPLEADO_FK FOREIGN KEY (cod_empleado) 
    REFERENCES EMPLEADO(id_empleado)
);

-- Creacion de tabla Administrativo (hereda de Empleado)
CREATE TABLE ADMINISTRATIVO (
id_empleado NUMBER(4),
-- Definicion de claves primaria y foranea
CONSTRAINT ADMINISTRATIVO_PK PRIMARY KEY (id_empleado),
CONSTRAINT ADMINISTRATIVO_EMPLEADO_FK FOREIGN KEY (id_empleado) 
    REFERENCES EMPLEADO (id_empleado)
);

-- Creacion de tabla Vendedor (hereda de Empleado)
CREATE TABLE VENDEDOR (
id_empleado NUMBER(4),
comision_venta NUMBER(5,2)
CONSTRAINT COMISION_VENTA_NNULL NOT NULL,
-- Definicion de claves primaria y foranea
CONSTRAINT VENDEDOR_PK PRIMARY KEY (id_empleado),
CONSTRAINT VENDEDOR_EMPLEADO_FK FOREIGN KEY (id_empleado) 
    REFERENCES EMPLEADO(id_empleado)
);

-- Creacion de tabla Medio de pago
CREATE TABLE MEDIO_PAGO (
id_mpago NUMBER(3),
nombre_mpago VARCHAR2(50)
CONSTRAINT NOMBRE_MPAGO_NNULL NOT NULL,
-- Definicion de clave primaria
CONSTRAINT MEDIO_PAGO_PK PRIMARY KEY (id_mpago)
);

-- Creacion de tabla Venta
CREATE TABLE VENTA (
id_venta NUMBER(4) GENERATED ALWAYS AS IDENTITY 
    START WITH 5050
    INCREMENT BY 3,
fecha_venta DATE
CONSTRAINT FECHA_VENTA_NNULL NOT NULL,
total_venta NUMBER(10)
CONSTRAINT TOTAL_VENTA_NNULL NOT NULL,
cod_mpago NUMBER(3)
CONSTRAINT VENTA_MEDIO_PAGO_NNULL NOT NULL,
cod_empleado NUMBER(4)
CONSTRAINT VENTA_EMPLEADO_NNULL NOT NULL,
-- Definicion de claves primaria y foraneas
CONSTRAINT VENTA_PK PRIMARY KEY (id_venta),
CONSTRAINT VENTA_MEDIO_PAGO_FK FOREIGN KEY (cod_mpago) 
    REFERENCES MEDIO_PAGO(id_mpago),
CONSTRAINT VENTA_EMPLEADO_FK FOREIGN KEY (cod_empleado) 
    REFERENCES EMPLEADO(id_empleado)
);

-- Creacion de tabla Detalle de venta
CREATE TABLE DETALLE_VENTA (
cod_venta NUMBER(4),
cod_producto NUMBER(4),
cantidad NUMBER(6)
CONSTRAINT CANTIDAD_NNULL NOT NULL,
-- Definicion de claves primarias y foraneas
CONSTRAINT DETALLE_VENTA_PK PRIMARY KEY (cod_venta, cod_producto),
CONSTRAINT DETALLE_VENTA_VENTA_FK FOREIGN KEY (cod_venta) 
    REFERENCES VENTA(id_venta),
CONSTRAINT DETALLE_VENTA_PRODUCTO_FK FOREIGN KEY (cod_producto) 
    REFERENCES PRODUCTO(id_producto)
);

-- Modificacion de tablas (se anaden restricciones)

-- El sueldo base de un empleado no puede ser menor a 400.000
ALTER TABLE EMPLEADO ADD CONSTRAINT SUELDO_BASE_CK
    CHECK (sueldo_base >= 400000);
-- La comision de un vendedor debe estar entre 0 y 0.25
ALTER TABLE VENDEDOR ADD CONSTRAINT COMISION_VENTA_CK 
    CHECK (comision_venta >= 0 AND comision_venta <= 0.25);
-- Se debe validar que el stock minimo de un producto sea 3 o mayor
ALTER TABLE PRODUCTO ADD CONSTRAINT STOCK_MINIMO_CK 
    CHECK (stock_minimo >= 3);
-- Cada proveedor debe tener un correo unico
ALTER TABLE PROVEEDOR ADD CONSTRAINT EMAIL_UN UNIQUE (email);
-- Cada marca debe tener un nombre unico
ALTER TABLE MARCA ADD CONSTRAINT NOMBRE_MARCA_UN UNIQUE (nombre_marca);
-- La cantidad de productos vendidos en un detalle de venta debe ser minimo 1
ALTER TABLE DETALLE_VENTA ADD CONSTRAINT CANTIDAD_CK 
    CHECK (cantidad >= 1);

-- Creacion de secuencias

-- Secuencia para generar el ID de las empresas de salud
CREATE SEQUENCE SEQ_SALUD
    START WITH 2050
    INCREMENT BY 10
;

-- Secuencia para generar los ID de empleado
CREATE SEQUENCE SEQ_EMPLEADO
    START WITH 750
    INCREMENT BY 3
;

--Poblamiento de tablas

 --Poblamiento de tabla SALUD
INSERT INTO SALUD (id_salud, nom_salud) VALUES (SEQ_SALUD.NEXTVAL, 'Fonasa');
INSERT INTO SALUD (id_salud, nom_salud) VALUES 
    (SEQ_SALUD.NEXTVAL, 'Isapre Colmena');
INSERT INTO SALUD (id_salud, nom_salud) VALUES 
    (SEQ_SALUD.NEXTVAL, 'Isapre Banmédica');
INSERT INTO SALUD (id_salud, nom_salud) VALUES 
    (SEQ_SALUD.NEXTVAL, 'Isapre Cruz Blanca');
-- Commit para confirmar cambios
COMMIT;

-- Poblamiento de tabla AFP
INSERT INTO AFP (nom_afp) VALUES ('AFP Habitat');
INSERT INTO AFP (nom_afp) VALUES ('AFP Cuprum');
INSERT INTO AFP (nom_afp) VALUES ('AFP Provida');
INSERT INTO AFP (nom_afp) VALUES ('AFP PlanVital');
-- Commit para confirmar cambios
COMMIT;

-- Poblamiento de tabla MEDIO_PAGO
INSERT INTO MEDIO_PAGO (id_mpago, nombre_mpago) VALUES (11, 'Efectivo');
INSERT INTO MEDIO_PAGO (id_mpago, nombre_mpago) VALUES (12, 'Tarjeta Débito');
INSERT INTO MEDIO_PAGO (id_mpago, nombre_mpago) VALUES (13, 'Tarjeta Crédito');
INSERT INTO MEDIO_PAGO (id_mpago, nombre_mpago) VALUES (14, 'Cheque');
-- Commit para confirmar cambios
COMMIT;

-- Poblamiento de tabla REGION
INSERT INTO REGION (id_region, nom_region) VALUES (1, 'Región Metropolitana');
INSERT INTO REGION (id_region, nom_region) VALUES (2, 'Valparaíso');
INSERT INTO REGION (id_region, nom_region) VALUES (3, 'Biobío');
INSERT INTO REGION (id_region, nom_region) VALUES (4, 'Los Lagos');
-- Commit para confirmar cambios
COMMIT;

-- Poblamiento de tabla EMPLEADO
INSERT INTO empleado (
    id_empleado,
    rut_empleado,
    nombre_empleado,
    apellido_paterno,
    apellido_materno,
    fecha_contratacion,
    sueldo_base,
    bono_jefatura,
    activo,
    tipo_empleado,
    cod_empleado,
    cod_salud,
    cod_afp
) VALUES (
    SEQ_EMPLEADO.NEXTVAL,
    '11111111-1',
    'Marcela',
    'González',
    'Pérez',
    TO_DATE('15-03-2022', 'DD-MM-YYYY'),
    950000,
    80000,
    'S',
    'Administrativo',
    null,
    2050,
    210
);

INSERT INTO empleado (
    id_empleado,
    rut_empleado,
    nombre_empleado,
    apellido_paterno,
    apellido_materno,
    fecha_contratacion,
    sueldo_base,
    bono_jefatura,
    activo,
    tipo_empleado,
    cod_empleado,
    cod_salud,
    cod_afp
) VALUES (
    SEQ_EMPLEADO.NEXTVAL,
    '22222222-2',
    'José',
    'Muñoz',
    'Ramírez',
    TO_DATE('10-07-2021', 'DD-MM-YYYY'),
    900000,
    75000,
    'S',
    'Administrativo',
    null,
    2060,
    216
);

INSERT INTO empleado (
    id_empleado,
    rut_empleado,
    nombre_empleado,
    apellido_paterno,
    apellido_materno,
    fecha_contratacion,
    sueldo_base,
    bono_jefatura,
    activo,
    tipo_empleado,
    cod_empleado,
    cod_salud,
    cod_afp
) VALUES (
    SEQ_EMPLEADO.NEXTVAL,
    '33333333-3',
    'Verónica',
    'Soto',
    'Alarcón',
    TO_DATE('05-01-2020', 'DD-MM-YYYY'),
    880000,
    70000,
    'S',
    'Vendedor',
    750,
    2060,
    228
);

INSERT INTO empleado (
    id_empleado,
    rut_empleado,
    nombre_empleado,
    apellido_paterno,
    apellido_materno,
    fecha_contratacion,
    sueldo_base,
    bono_jefatura,
    activo,
    tipo_empleado,
    cod_empleado,
    cod_salud,
    cod_afp
) VALUES (
    SEQ_EMPLEADO.NEXTVAL,
    '44444444-4',
    'Luis',
    'Reyes',
    'Fuentes',
    TO_DATE('01-04-2023', 'DD-MM-YYYY'),
    560000,
    null,
    'S',
    'Vendedor',
    750,
    2070,
    228
);

INSERT INTO empleado (
    id_empleado,
    rut_empleado,
    nombre_empleado,
    apellido_paterno,
    apellido_materno,
    fecha_contratacion,
    sueldo_base,
    bono_jefatura,
    activo,
    tipo_empleado,
    cod_empleado,
    cod_salud,
    cod_afp
) VALUES (
    SEQ_EMPLEADO.NEXTVAL,
    '55555555-5',
    'Claudia',
    'Fernández',
    'Lagos',
    TO_DATE('15-04-2023', 'DD-MM-YYYY'),
    600000,
    null,
    'S',
    'Vendedor',
    753,
    2070,
    216
);

INSERT INTO empleado (
    id_empleado,
    rut_empleado,
    nombre_empleado,
    apellido_paterno,
    apellido_materno,
    fecha_contratacion,
    sueldo_base,
    bono_jefatura,
    activo,
    tipo_empleado,
    cod_empleado,
    cod_salud,
    cod_afp
) VALUES (
    SEQ_EMPLEADO.NEXTVAL,
    '66666666-6',
    'Carlos',
    'Navarro',
    'Vega',
    TO_DATE('01-05-2023', 'DD-MM-YYYY'),
    610000,
    null,
    'S',
    'Administrativo',
    753,
    2060,
    210
);

INSERT INTO empleado (
    id_empleado,
    rut_empleado,
    nombre_empleado,
    apellido_paterno,
    apellido_materno,
    fecha_contratacion,
    sueldo_base,
    bono_jefatura,
    activo,
    tipo_empleado,
    cod_empleado,
    cod_salud,
    cod_afp
) VALUES (
    SEQ_EMPLEADO.NEXTVAL,
    '77777777-7',
    'Javiera',
    'Pino',
    'Rojas',
    TO_DATE('10-05-2023', 'DD-MM-YYYY'),
    650000,
    null,
    'S',
    'Administrativo',
    750,
    2050,
    210
);

INSERT INTO empleado (
    id_empleado,
    rut_empleado,
    nombre_empleado,
    apellido_paterno,
    apellido_materno,
    fecha_contratacion,
    sueldo_base,
    bono_jefatura,
    activo,
    tipo_empleado,
    cod_empleado,
    cod_salud,
    cod_afp
) VALUES (
    SEQ_EMPLEADO.NEXTVAL,
    '88888888-8',
    'Diego',
    'Mella',
    'Contreras',
    TO_DATE('12-05-2023', 'DD-MM-YYYY'),
    620000,
    null,
    'S',
    'Vendedor',
    750,
    2060,
    216
);

INSERT INTO empleado (
    id_empleado,
    rut_empleado,
    nombre_empleado,
    apellido_paterno,
    apellido_materno,
    fecha_contratacion,
    sueldo_base,
    bono_jefatura,
    activo,
    tipo_empleado,
    cod_empleado,
    cod_salud,
    cod_afp
) VALUES (
    SEQ_EMPLEADO.NEXTVAL,
    '99999999-9',
    'Fernanda',
    'Salas',
    'Herrera',
    TO_DATE('18-05-2023', 'DD-MM-YYYY'),
    570000,
    null,
    'S',
    'Vendedor',
    753,
    2070,
    228
);

INSERT INTO empleado (
    id_empleado,
    rut_empleado,
    nombre_empleado,
    apellido_paterno,
    apellido_materno,
    fecha_contratacion,
    sueldo_base,
    bono_jefatura,
    activo,
    tipo_empleado,
    cod_empleado,
    cod_salud,
    cod_afp
) VALUES (
    SEQ_EMPLEADO.NEXTVAL,
    '10101010-0',
    'Tomás',
    'Vidal',
    'Espinoza',
    TO_DATE('01-06-2023', 'DD-MM-YYYY'),
    530000,
    null,
    'S',
    'Vendedor',
    null,
    2050,
    222
);

-- Commit para confirmar cambios
COMMIT;

-- Recuperacion de datos

-- Informe 1
SELECT
    id_empleado AS "IDENTIFICADOR",
    nombre_empleado || ' ' || apellido_paterno || ' ' || apellido_materno 
        AS "NOMBRE COMPLETO",
    sueldo_base AS "SALARIO",
    bono_jefatura AS "BONIFICACION",
    sueldo_base + bono_jefatura AS "SALARIO SIMULADO"
FROM EMPLEADO
WHERE activo = 'S' AND bono_jefatura IS NOT NULL
ORDER BY "SALARIO SIMULADO" DESC, apellido_paterno DESC;

-- Informe 2
SELECT 
    nombre_empleado || ' ' || apellido_paterno || ' ' || apellido_materno 
        AS "EMPLEADO",
    sueldo_base as "SUELDO",
    sueldo_base * 0.08 AS "POSIBLE AUMENTO",
    sueldo_base + (sueldo_base * 0.08) AS "SALARIO SIMULADO"
FROM EMPLEADO
WHERE sueldo_base BETWEEN 550000 AND 800000
ORDER BY sueldo_base ASC;