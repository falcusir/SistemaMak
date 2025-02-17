/* PROYECTO DE AULA - KANBAN */
create database proyecto_kanban;
-- drop database proyecto_kanban;
use proyecto_kanban;
-- ---------------------------------------------------TABLA PERSONAS------------------------------
CREATE TABLE personas (
    idPersona INT PRIMARY KEY AUTO_INCREMENT,
    per_nombre VARCHAR(100) NOT NULL,
    per_apellido VARCHAR(100) NOT NULL,
    per_cedula VARCHAR(20) UNIQUE NOT NULL,
    per_fecha_nac DATE NOT NULL,
    per_direccion VARCHAR(255),
    per_telefono VARCHAR(100) NOT NULL,
    per_correo VARCHAR(100) UNIQUE NOT NULL
);

INSERT INTO personas (per_nombre, per_apellido, per_cedula, per_fecha_nac, per_direccion, per_telefono, per_correo) VALUES
('Fer', 'Alcusir', '1003188198', '1989-05-15', 'Ibarra', '0986309417', 'fer_al@example.com'),
('María', 'Gómez', '1001058153', '1985-10-20', 'San Antonio', '062601133', 'maria.gomez@example.com'),
('José', 'Suárez', '1002003001', '2005-03-01', 'Otavalo', '0984561247', 'jose.suarez@example.com');


select * from personas;
-- -----------------------------------------------------TABLA USUARIOS--------------------------------------
CREATE TABLE usuarios (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    idPersona INT UNIQUE NOT NULL,
    us_usuario VARCHAR(50) UNIQUE NOT NULL,
    us_contraseña VARCHAR(255) NOT NULL,
    us_rol ENUM('Administrador', 'Gestor', 'Miembro') NULL,
    FOREIGN KEY (idPersona) REFERENCES personas(idPersona) ON DELETE CASCADE
);

INSERT INTO usuarios (idPersona, us_usuario, us_contraseña, us_rol) VALUES
(1, 'fer.alcusir', 'fer123', null),
(2, 'maria.gomez', 'mar123',null),
(3, 'jose.suarez', 'jos123',null);

select * from usuarios;
select * from personas;
-- -----------------------------------------------------TABLA GESTORES--------------------------------
CREATE TABLE gestores_p (
    idGestor INT PRIMARY KEY AUTO_INCREMENT,
    idPersona INT UNIQUE NOT NULL,
    gp_fecha_asignacion DATE NOT NULL,
    FOREIGN KEY (idPersona) REFERENCES personas(idPersona) ON DELETE CASCADE
);

select * from gestores_p;

-- Insert data into gestores_p table
INSERT INTO gestores_p (idPersona, gp_fecha_asignacion) VALUES
(1, curdate()),
(8, curdate());

select * from gestores_p;
-- -------------------------------------------------------TABLA PROYECTOS-----------------------------------

CREATE TABLE proyectos (
    idProyecto INT PRIMARY KEY AUTO_INCREMENT,
    idGestor INT NOT NULL,
    pro_nombre VARCHAR(100) NOT NULL,
    pro_descripcion TEXT,
	pro_fecha_inicio DATE NOT NULL,
    pro_fecha_fin DATE NOT NULL,
    FOREIGN KEY (idGestor) REFERENCES gestores_p(idGestor) ON DELETE CASCADE
);

-- Insert data into proyectos table
INSERT INTO proyectos (idGestor, pro_nombre, pro_descripcion, pro_fecha_inicio, pro_fecha_fin) VALUES
(1, 'Proyecto A', 'Descripción del proyecto A', '2025-01-01', '2025-06-30');
INSERT INTO proyectos (idGestor, pro_nombre, pro_descripcion, pro_fecha_inicio, pro_fecha_fin) VALUES
(2, 'Proyecto B', 'Descripción del proyecto B', '2025-02-10', '2024-03-29');

-- (4, 'Proyecto D', 'Descripción del proyecto D', '2024-04-10', '2024-11-30'),
-- (5, 'Proyecto E', 'Descripción del proyecto E', '2024-05-01', '2024-12-31');

select * from proyectos;
select * from usuarios;
select * from gestores_p;

-- --------------------------------------------------TABLA MIEMBROS DEL EQUIPO-----------------------------

CREATE TABLE miembros_e (
    idMiembro INT PRIMARY KEY AUTO_INCREMENT,
    idPersona INT UNIQUE NOT NULL,
    me_estado ENUM('Activo', 'Inactivo') NOT NULL DEFAULT 'Inactivo',
    FOREIGN KEY (idPersona) REFERENCES personas(idPersona) ON DELETE CASCADE
);

-- Insert data into miembros_e table
INSERT INTO miembros_e (idPersona, me_estado) VALUES
(2, 'Activo'),
(3, 'Activo'),
(8, 'Activo');


select * from miembros_e;

-- -----------------------------------------------TABLA MIEMBROS-PROYECTO--------------------------------

CREATE TABLE miembro_proyecto (
    idMiembroProy INT PRIMARY KEY AUTO_INCREMENT,
    idMiembro INT NOT NULL,
    idProyecto INT NOT NULL,
    mipro_fecha_asig DATE NOT NULL,
    mipro_nombreEquipo VARCHAR(100),
    FOREIGN KEY (idMiembro) REFERENCES miembros_e(idMiembro) ON DELETE CASCADE,
    FOREIGN KEY (idProyecto) REFERENCES proyectos(idProyecto) ON DELETE CASCADE
);

-- Insert data into miembro_proyecto table
INSERT INTO miembro_proyecto (idMiembro, idProyecto, mipro_fecha_asig, mipro_nombreEquipo) VALUES
(1, 1, '2025-01-05', 'Equipo Alfa'),
(2, 1, '2024-01-02', 'Equipo Alfa');

select * from miembro_proyecto;
-- --------------------------------------------------TABLA TAREAS------------------------------------
drop table tareas;
CREATE TABLE Tareas (
    idTarea INT PRIMARY KEY AUTO_INCREMENT,
    idProyecto INT NOT NULL,
    idMiembro INT DEFAULT NULL,
    tar_nombre VARCHAR(100) NOT NULL,
    tar_descripcion TEXT,
    tar_prioridad ENUM('Alta', 'Media', 'Baja') NOT NULL,
    tar_fecha_inicio DATE NOT NULL,
    tar_fecha_fin DATE NOT NULL,
    tar_estado ENUM('Por hacer', 'En Proceso', 'Terminada') NOT NULL DEFAULT 'Por hacer',
    FOREIGN KEY (idProyecto) REFERENCES proyectos(idProyecto) ON DELETE CASCADE,
    FOREIGN KEY (idMiembro) REFERENCES miembros_e(idMiembro) ON DELETE CASCADE
);

INSERT INTO Tareas (idProyecto,idMiembro, tar_nombre, tar_descripcion, tar_prioridad, tar_fecha_inicio, tar_fecha_fin, tar_estado) VALUES
(1, 1,'Tarea 1', 'Descripción de la tarea 1', 'Alta', '2025-01-05', '2025-01-15', 'Terminada'),
(1, 1,'Tarea 2', 'Descripción de la tarea 2', 'Media', '2025-01-16', '2025-01-25', 'En Proceso'),
(1, 2,'Tarea 3', 'Descripción de la tarea 3', 'Baja', '2025-01-20', '2025-01-28', 'En Proceso'),
(1, 2,'Tarea 4', 'Descripción de la tarea 4', 'Media', '2025-02-05', '2025-03-01', 'Por hacer'),
(1, 1,'Tarea 5', 'Descripción de la tarea 5', 'Alta', '2025-02-05', '2025-03-20', 'Por hacer');

select * from tareas;

-- -------------------------------------SP PARA INSERTAR PERSONA--------------------------------------

use proyecto_kanban;

DROP PROCEDURE IF EXISTS sp_insertarPersona;
DELIMITER //
CREATE PROCEDURE sp_insertarPersona(
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_cedula VARCHAR(20),
    IN p_fecha_nac DATE,
    IN p_direccion VARCHAR(255),
    IN p_telefono VARCHAR(100),
    IN p_correo VARCHAR(100)
)
BEGIN
    INSERT INTO personas (per_nombre, per_apellido, per_cedula, per_fecha_nac, per_direccion, per_telefono, per_correo)
    VALUES (p_nombre, p_apellido, p_cedula, p_fecha_nac, p_direccion, p_telefono, p_correo);
END //
DELIMITER ;

CALL sp_insertarPersona('Francisco','Acostar','1003188190','1989-12-12','Ibarra','0986309417','fra_acosta@example.com');
select * from personas;
-- -------------------------------------------------SP insertar persona y usuario ROL

DROP PROCEDURE IF EXISTS sp_insertarPersonaUsuarioRol;
DELIMITER //
CREATE PROCEDURE sp_insertarPersonaUsuarioRol(
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_cedula VARCHAR(20),
    IN p_fecha_nac DATE,
    IN p_direccion VARCHAR(255),
    IN p_telefono VARCHAR(100),
    IN p_correo VARCHAR(100),
    IN p_usuario VARCHAR(50),
    IN p_contrasena VARCHAR(255),  
    IN p_rol VARCHAR(50)
)
BEGIN
    -- Declarar variable para almacenar el idPersona
    DECLARE v_idPersona INT;

    -- Insertar datos en la tabla personas
    INSERT INTO personas (per_nombre, per_apellido, per_cedula, per_fecha_nac, per_direccion, per_telefono, per_correo)
    VALUES (p_nombre, p_apellido, p_cedula, p_fecha_nac, p_direccion, p_telefono, p_correo);

    -- Obtener el último idPersona insertado
    SET v_idPersona = LAST_INSERT_ID();

    -- Insertar datos en la tabla usuarios
    INSERT INTO usuarios (idPersona, us_usuario, us_contraseña, us_rol)
    VALUES (v_idPersona, p_usuario, p_contrasena, p_rol);

    -- Insertar en tabla miembro_e si el rol es 'miembro'
    IF p_rol = 'Miembro' THEN
        INSERT INTO miembros_e (idPersona, me_estado) VALUES (v_idPersona, 'Activo');
    -- Insertar en tabla gestores_p si el rol es 'gestor'
    ELSEIF p_rol = 'Gestor' THEN
        INSERT INTO gestores_p (idPersona, gp_fecha_asignacion) VALUES (v_idPersona, CURDATE());
    END IF;

END //
DELIMITER ;
CALL sp_insertarPersonaUsuarioRol('ANITA',
'Montenegro',
'1001801594',
'1990-01-12',
'Urcuqui',
'0986309400',
'anitas@example.com',
'anita123',
'anita',
null);

CALL sp_insertarPersonaUsuarioRol('Raul', 'López', '1050007046', '1988-12-10', 'Atuntaqui', '097452631', 'raul.lopez@example.com','rau123','rau123','Miembro');
CALL sp_insertarPersonaUsuarioRol('Gabriela', 'Lanchimba', '1001058150', '1990-07-25', 'San Antonio', '3017008989', 'gaby.lan@example.com','gab123','gab123',null);

CALL sp_insertarPersonaUsuarioRol('Anthony', 'Bedoya', '0240105815', '2000-07-25', 'Otavalo', 
'3017778981', 'ant.bed@example.com','ant123','ant123','Gestor');

select * from personas;
select * from usuarios;
select * from miembros_e;
select * from gestores_p;

-- ---------------------------------------------SP BUSCAR PERSONA----------------------------

DROP PROCEDURE IF EXISTS sp_buscarPersona;
DELIMITER //
CREATE PROCEDURE sp_buscarPersona(
    IN p_cedula_busqueda VARCHAR(20)
)
BEGIN
    SELECT 
        p.idPersona,
        p.per_nombre,
        p.per_apellido,
        p.per_cedula,
        p.per_fecha_nac,
        p.per_direccion,
        p.per_telefono,
        p.per_correo,
        u.us_usuario,
        u.us_contraseña, 
        u.us_rol
    FROM personas p
    JOIN usuarios u ON p.idPersona = u.idPersona
    WHERE p.per_cedula LIKE CONCAT('%',p_cedula_busqueda,'%');
END //
DELIMITER ;

call sp_buscarPersona('1003188198');

select * from personas;
select * from usuarios;

-- Para que no se muestre la contraseña
-- INSERT INTO usuarios (idPersona, us_usuario, us_contraseña, us_rol)
-- VALUES (5,'fra123', SHA2('fra123', 256), null);

-- --------------------------------------------SP ACTUALIZAR PERSONA---------------------------

DROP PROCEDURE IF EXISTS sp_actualizarPerosna;
DELIMITER //
CREATE PROCEDURE sp_actualizarPerosna(
    IN p_cedula_busqueda VARCHAR(20),
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_fecha_nac DATE,
    IN p_direccion VARCHAR(255),
    IN p_telefono VARCHAR(100),
    IN p_correo VARCHAR(100)
)
BEGIN
    UPDATE personas
    SET
        per_nombre = p_nombre,
        per_apellido = p_apellido,
        per_fecha_nac = p_fecha_nac,
        per_direccion = p_direccion,
        per_telefono = p_telefono,
        per_correo = p_correo
    WHERE per_cedula = p_cedula_busqueda;
END //
DELIMITER ;

Call sp_actualizarPerosna('1003188198','Fernanda','Alcusir','1989-12-12','Pimanpiro','0986309416','fer_al@example.com');
select * from personas;

-- *******************************************************ACTUALIZAR PERSONA Y USUARIO-- FALTA MODIFICAR
DROP PROCEDURE IF EXISTS sp_actualizarPersonaUsuario;
DELIMITER //
CREATE PROCEDURE sp_actualizarPersonaUsuario(
    IN p_cedula_busqueda VARCHAR(20),
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_fecha_nac DATE,
    IN p_direccion VARCHAR(255),
    IN p_telefono VARCHAR(100),
    IN p_correo VARCHAR(100),
    IN p_usuario VARCHAR(50),
    IN p_contrasena VARCHAR(255),  --  
    IN p_rol VARCHAR(50)
)
BEGIN
    -- Actualizar datos en la tabla personas
    UPDATE personas
    SET
        per_nombre = p_nombre,
        per_apellido = p_apellido,
        per_fecha_nac = p_fecha_nac,
        per_direccion = p_direccion,
        per_telefono = p_telefono,
        per_correo = p_correo
    WHERE per_cedula = p_cedula_busqueda;

    -- Actualizar datos en la tabla usuarios
    UPDATE usuarios
    SET
        us_usuario = p_usuario,
        us_contraseña = p_contrasena,  
        us_rol = p_rol
    WHERE idPersona = (SELECT idPersona FROM personas WHERE per_cedula = p_cedula_busqueda);

END //
DELIMITER ;

select * from personas;
CALL sp_actualizarPersonaUsuario(
    '1003188198',  
    'Fernanda',
    'Alcusir',
    '1989-12-12',
    'Ibarra',	-- Nueva dirección
    '0986309416', -- Nuevo teléfono
    'fer_al@example.com',
    'fer321',	-- Nuevo usuario
    'fer321',	-- Nueva contraseña
    null
);

-- ------------------------------------------------SP PARA LISTAR PERSONAL--------------------------

DROP PROCEDURE IF EXISTS sp_listarPersonal;
DELIMITER //
CREATE PROCEDURE sp_listarPersonal()
BEGIN
     SELECT
        p.idPersona, p.per_nombre, p.per_apellido, p.per_cedula, p.per_fecha_nac,
        p.per_direccion, p.per_telefono, p.per_correo,
		u.us_rol
    FROM personas p
    JOIN usuarios u ON p.idPersona = u.idPersona;
END //
DELIMITER ;

select *from usuarios;

CALL sp_listarPersonal();


-- --------------------------------------------- SP PARA LISTAR A LOS MIEMBROS DEL EQUIPO---------------------
DROP PROCEDURE IF EXISTS sp_listarMiembrosEquipo;
DELIMITER //
CREATE PROCEDURE sp_listarMiembrosEquipo()
BEGIN
   SELECT 
        me.idMiembro,
        per.per_nombre,
        per.per_apellido,
        per.per_cedula,
        per.per_fecha_nac,
        per.per_direccion,
        per.per_telefono,
        per.per_correo,
        me.me_estado
    FROM miembros_e me
	JOIN personas per ON me.idPersona = per.idPersona;
END //
DELIMITER ;

CALL sp_listarMiembrosEquipo();

-- --------------------------------------------- SP PARA LISTAR A LOS GESTORES-----------------------------

DROP PROCEDURE IF EXISTS sp_listarGestores;
DELIMITER //
CREATE PROCEDURE sp_listarGestores()
BEGIN
	SELECT 
			gp.idGestor,
			per.per_nombre,
			per.per_apellido,
			per.per_cedula,
			per.per_fecha_nac,
			per.per_direccion,
			per.per_telefono,
			per.per_correo,
			gp.gp_fecha_asignacion
		FROM gestores_p  gp
		JOIN personas per ON gp.idPersona = per.idPersona;
    END //
DELIMITER ;

CALL sp_listarGestores();

-- ----------------------------------------------------SP PARA LISTAR PROYECTOS--------------------------------

DROP PROCEDURE IF EXISTS sp_listarProyectos;
DELIMITER //
CREATE PROCEDURE sp_listarProyectos()
BEGIN
	SELECT * from Proyectos;
    END //
DELIMITER ;

CALL sp_listarProyectos();


-- -------------------------------------------------- sp listar proyectos CON GESTOR
DROP PROCEDURE IF EXISTS sp_listarProyectosConGestor;
DELIMITER //
CREATE PROCEDURE sp_listarProyectosConGestor()
BEGIN
    SELECT
        p.idProyecto,
        p.pro_nombre,
        p.pro_descripcion,
        p.pro_fecha_inicio,
        p.pro_fecha_fin,
        per.per_nombre AS nombre_gestor,
        per.per_apellido AS apellido_gestor
    FROM proyectos p
    JOIN gestores_p gp ON p.idGestor = gp.idGestor
    JOIN personas per ON gp.idPersona = per.idPersona;
END //
DELIMITER ;

CALL sp_listarProyectosConGestor();

-- --------------------------------------------SP listar tareas por proyecto y miembro

-- buscar las tareas que pertenecen a un determinado proyecto y a quien fueron asignadas

DROP PROCEDURE IF EXISTS sp_buscarTareasPorProyectoMiembro;
DELIMITER //
CREATE PROCEDURE sp_buscarTareasPorProyectoMiembro(
    IN p_nombre_proyecto VARCHAR(100)
)
BEGIN
    SELECT
        t.idTarea,
        t.tar_nombre AS nombre_tarea,
        t.tar_estado,
        p.pro_nombre AS nombre_proyecto,
        per.per_nombre AS nombre_miembro,
        per.per_apellido AS apellido_miembro
    FROM Tareas t
    JOIN proyectos p ON t.idProyecto = p.idProyecto
    JOIN miembros_e me ON t.idMiembro = me.idMiembro
    JOIN personas per ON me.idPersona = per.idPersona
    WHERE p.pro_nombre LIKE CONCAT('%',p_nombre_proyecto,'%');
END //
DELIMITER ;

CALL sp_buscarTareasPorProyectoMiembro('proYECTO A');

-- ------------------------------------------------listar miembros del proyecto
-- listar los miembros que pertenecen a un determinado proyecto

DROP PROCEDURE IF EXISTS sp_listarMiembrosDelProyecto;
DELIMITER //
CREATE PROCEDURE sp_listarMiembrosDelProyecto(
    IN p_nombre_proyecto VARCHAR(100)
)
BEGIN
    SELECT
        me.idMiembro,
        per.per_nombre AS nombre_miembro,
        per.per_apellido AS apellido_miembro,
        p.pro_nombre AS nombre_proyecto
    FROM miembros_e AS me
    JOIN miembro_proyecto AS mp ON me.idMiembro = mp.idMiembro
    JOIN proyectos AS p ON mp.idProyecto = p.idProyecto
    JOIN personas AS per ON me.idPersona = per.idPersona
    WHERE p.pro_nombre LIKE CONCAT('%',p_nombre_proyecto,'%');
END //
DELIMITER ;

call sp_listarMiembrosDelProyecto('proyecto a');

-- -----------------------------------------SP buscar el ID del gestor por nombre, apellido Y CEDULA
DROP PROCEDURE IF EXISTS sp_buscarIdGestor;
DELIMITER //
CREATE PROCEDURE sp_buscarIdGestor(
    IN p_nombre_gestor VARCHAR(100),
    IN p_apellido_gestor VARCHAR(100),
    IN p_cedula_busqueda VARCHAR(100),
    OUT p_id_gestor INT  -- Parámetro de salida para el ID del gestor
)
BEGIN
    SELECT gp.idGestor INTO p_id_gestor
    FROM gestores_p gp
    JOIN personas p ON gp.idPersona = p.idPersona
    WHERE p.per_nombre = p_nombre_gestor 
    AND p.per_apellido = p_apellido_gestor
    AND p.per_cedula = p_cedula_busqueda;

    -- Si no se encuentra el gestor, establecer el ID a NULL
    IF p_id_gestor IS NULL THEN
        SET p_id_gestor = NULL;
    END IF;
END //
DELIMITER ;

call sp_buscarIdGestor('Anthony','Bedoya','0240105815',@p_id_gestor);
select @p_id_gestor;

-- ---------------------------------------------------SP para insertar un nuevo proyecto
DROP PROCEDURE IF EXISTS sp_insertarProyecto;
DELIMITER //
CREATE PROCEDURE sp_insertarProyecto(
    IN p_pro_nombre VARCHAR(100),
    IN p_pro_descripcion TEXT,
    IN p_pro_fecha_inicio DATE,
    IN p_pro_fecha_fin DATE,
    IN p_nombre_gestor VARCHAR(100),
    IN p_apellido_gestor VARCHAR(100),
    IN p_cedula_busqueda VARCHAR(100)
)
BEGIN
    -- Declarar variable para almacenar el ID del gestor
    DECLARE v_idGestor INT;

    -- Llamar al SP para buscar el ID del gestor
    CALL sp_buscarIdGestor(p_nombre_gestor, p_apellido_gestor,p_cedula_busqueda, v_idGestor);

    -- Insertar el nuevo proyecto con el ID del gestor
    INSERT INTO proyectos (pro_nombre, pro_descripcion, pro_fecha_inicio, pro_fecha_fin, idGestor)
    VALUES (p_pro_nombre, p_pro_descripcion, p_pro_fecha_inicio, p_pro_fecha_fin, v_idGestor);

END //
DELIMITER ;

CALL sp_insertarProyecto(
    'Proyecto Beta ',
    'Descripción del Beta',
    '2025-01-01',       -- Fecha de inicio
    '2025-04-30',       -- Fecha de fin
    'Anthony',
    'Bedoya',
    '0240105815'
);

select * from Proyectos;

-- (3, 'Proyecto C', 'Descripción del proyecto C', '2024-03-01', '2024-10-31'),
-- ****************************************************
-- ----------------------------------------------SP BUSCAR EL ROL DEL USUARIO

DROP PROCEDURE IF EXISTS sp_obtenerRolUsuario;
DELIMITER //
CREATE PROCEDURE sp_obtenerRolUsuario(
    IN p_usuario VARCHAR(50),
    IN p_contrasena VARCHAR(255),  
    OUT p_rol VARCHAR(50)
)
BEGIN
    -- Buscar el rol del usuario
    SELECT us_rol INTO p_rol
    FROM usuarios
    WHERE us_usuario = p_usuario AND us_contraseña = p_contrasena;  

    -- Si no se encuentra el usuario, establecer el rol a NULL
    IF p_rol IS NULL THEN
        SET p_rol = NULL;
    END IF;
END //
DELIMITER ;

select * from usuarios;
CALL sp_obtenerRolUsuario(
    'fer321',   -- Reemplaza con el nombre de usuario
    'fer321', -- Reemplaza con la contraseña ENCRIPTADA
    @p_rol           -- Pasa la variable como parámetro de salida
);
-- Mostrar el valor del rol
SELECT @p_rol AS Rol_Usuario;


-- -------------------------------------------------- SP numero de tareas por ESTADO segun Proyecto
DROP PROCEDURE IF EXISTS sp_numeroTareasPorEstado;
DELIMITER //
CREATE PROCEDURE sp_numeroTareasPorEstado(
    IN p_pro_nombre VARCHAR(100)
)
BEGIN
SELECT
        p.pro_nombre AS NombreProyecto,
        COUNT(t.idTarea) AS total_tareas,
        SUM(CASE WHEN t.tar_estado = 'Por hacer' THEN 1 ELSE 0 END) AS PorHacer,
        SUM(CASE WHEN t.tar_estado = 'En Proceso' THEN 1 ELSE 0 END) AS EnProceso,
        SUM(CASE WHEN t.tar_estado = 'Terminada' THEN 1 ELSE 0 END) AS Terminada
    FROM proyectos p
    JOIN Tareas t ON p.idProyecto = t.idProyecto
    WHERE p.pro_nombre LIKE CONCAT('%',p_pro_nombre,'%')
    GROUP BY p.pro_nombre;
    END //
DELIMITER ;

call sp_numeroTareasPorEstado('proyecto a');

    -- ---------------------------------- OBTENER DATOS DEL USUARIO SEGUN SU ROL
DROP PROCEDURE IF EXISTS sp_obtenerDatosUsuario;
DELIMITER //
CREATE PROCEDURE sp_obtenerDatosUsuario(
    IN p_usuario VARCHAR(50),
    IN p_contrasena VARCHAR(255),  
    OUT p_rol VARCHAR(50),
    OUT p_nombre VARCHAR(100),
    OUT p_apellido VARCHAR(100),
    OUT p_cedula VARCHAR(20),
    OUT p_direccion VARCHAR(255),
    OUT p_telefono VARCHAR(100),
    OUT p_correo VARCHAR(100)
)
BEGIN
    -- Inicializar los parámetros de salida
    SET p_rol = NULL;
    SET p_nombre = NULL;
    SET p_apellido = NULL;
    SET p_cedula = NULL;
    SET p_direccion = NULL;
    SET p_telefono = NULL;
    SET p_correo = NULL;

    -- Buscar el rol y los datos del usuario
    SELECT 
        u.us_rol,p.per_nombre,p.per_apellido,p.per_cedula,p.per_direccion,p.per_telefono,p.per_correo
    INTO 
        p_rol, p_nombre, p_apellido, p_cedula, p_direccion, p_telefono, p_correo
    FROM usuarios u
    JOIN personas p ON u.idPersona = p.idPersona
    WHERE u.us_usuario = p_usuario AND u.us_contraseña = p_contrasena;  -- Compara con la contraseña 

END //
DELIMITER ;
select *from usuarios;
CALL sp_listarPersonal;

CALL sp_obtenerDatosUsuario(
    'lau123',       -- Reemplaza con el nombre de usuario
    'lau123',   -- Reemplaza con la contraseña ENCRIPTADA
    @rol_usuario,@nombre_usuario,@apellido_usuario,@cedula_usuario,@direccion_usuario,@telefono_usuario,@correo_usuario            
);

-- Mostrar los valores obtenidos
SELECT 
    @rol_usuario AS Rol_Usuario,
    @nombre_usuario AS Nombre,
    @apellido_usuario AS Apellido,
    @cedula_usuario AS Cedula,
    @direccion_usuario AS Direccion,
    @telefono_usuario AS Telefono,
    @correo_usuario AS Correo;

    -- ------------------------------------------ OBTENER EL ROL SEGUN SU USUARIO Y CONTRASEÑA
    -- Para el inicio de Sesión
    
DROP PROCEDURE IF EXISTS sp_obtenerRolUsuario;
DELIMITER //
CREATE PROCEDURE sp_obtenerRolUsuario(
    IN p_usuario VARCHAR(50),
    IN p_contrasena VARCHAR(255),  
    OUT p_rol VARCHAR(50)
)
BEGIN
    -- Buscar el rol del usuario
    SELECT us_rol INTO p_rol
    FROM usuarios
    WHERE us_usuario = p_usuario AND us_contraseña = p_contrasena;  

    -- Si no se encuentra el usuario, establecer el rol a NULL
    IF p_rol IS NULL THEN
        SET p_rol = NULL;
    END IF;
END //
DELIMITER ;
    
CALL sp_obtenerRolUsuario(
    'fer321',   -- Reemplaza con el nombre de usuario
    'fer321', -- Reemplaza con la contraseña 
    @rol_usuario           -- Pasa la variable como parámetro de salida
);
SELECT @rol_usuario AS Rol_Usuario;

-- ------------------------ -------------------- SP TABLERO KANBAN
 -- parecido al tablero kanban
DROP PROCEDURE IF EXISTS sp_ObtenerTareasPorEstadoProyecto;
DELIMITER //
CREATE PROCEDURE sp_ObtenerTareasPorEstadoProyecto(
    IN p_nombre_proyecto VARCHAR(100)
)
BEGIN
    SELECT
        p.pro_nombre AS NombreProyecto,
        GROUP_CONCAT(CASE WHEN t.tar_estado = 'Por hacer' THEN t.tar_nombre ELSE NULL END SEPARATOR ', ') AS PorHacer,
        GROUP_CONCAT(CASE WHEN t.tar_estado = 'En Proceso' THEN t.tar_nombre ELSE NULL END SEPARATOR ', ') AS EnProceso,
        GROUP_CONCAT(CASE WHEN t.tar_estado = 'Terminada' THEN t.tar_nombre ELSE NULL END SEPARATOR ', ') AS Terminada
    FROM proyectos p
    JOIN Tareas t ON p.idProyecto = t.idProyecto
    WHERE p.pro_nombre LIKE CONCAT('%', p_nombre_proyecto, '%')
    GROUP BY p.pro_nombre;
END //
DELIMITER ;

call sp_ObtenerTareasPorEstadoProyecto('proyecto b');


select * from gestores_p;
select * from miembros_e;
select * from proyectos;
select * from tareas;
select * from miembro_proyecto;

-- -------------------------------------------------------TAEAS POR ESTADO EN TABLAS SEPARADAS
DROP PROCEDURE IF EXISTS ObtenerTareasPorEstadoProyectoSeparado;
DELIMITER //

CREATE PROCEDURE ObtenerTareasPorEstadoProyectoSeparado(
    IN p_nombre_proyecto VARCHAR(100)
)
BEGIN
    -- Crear tabla temporal para almacenar las tareas del proyecto
    CREATE TEMPORARY TABLE IF NOT EXISTS TareasProyecto AS
    SELECT
        t.tar_nombre AS NombreTarea,
        t.tar_estado AS EstadoTarea,
        p.pro_nombre AS NombreProyecto
    FROM proyectos AS p
    JOIN Tareas AS t ON p.idProyecto = t.idProyecto
    WHERE p.pro_nombre LIKE CONCAT('%', p_nombre_proyecto, '%');

    -- Seleccionar tareas "Por hacer"
    SELECT NombreProyecto, NombreTarea, EstadoTarea FROM TareasProyecto WHERE EstadoTarea = 'Por hacer';

    -- Seleccionar tareas "En Proceso"
    SELECT NombreProyecto, NombreTarea, EstadoTarea FROM TareasProyecto WHERE EstadoTarea = 'En Proceso';

    -- Seleccionar tareas "Terminada"
    SELECT NombreProyecto, NombreTarea, EstadoTarea FROM TareasProyecto WHERE EstadoTarea = 'Terminada';

    -- Eliminar la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS TareasProyecto;

END //

DELIMITER ;

CALL ObtenerTareasPorEstadoProyectoSeparado('proyecto a');

-- ----------------------------------------SP MOSTRAR LOS PROYECTOS Y TAREAS POR MIEMBRO
DROP PROCEDURE IF EXISTS sp_visualizarProyectosYTareasPorMiembro;
DELIMITER //
CREATE PROCEDURE sp_visualizarProyectosYTareasPorMiembro(
    IN p_nombre_miembro VARCHAR(100),
    IN p_apellido_miembro VARCHAR(100),
    IN p_cedula_miembro VARCHAR(20)
)
BEGIN
    SELECT 
        p.pro_nombre AS nombre_proyecto,
        t.tar_nombre AS nombre_tarea,
        t.tar_descripcion AS nombre_tarea,
        t.tar_prioridad AS prioridad_tarea,
        t.tar_fecha_inicio as fecha_inicio,
        t.tar_fecha_fin as fecha_fin,
        t.tar_estado AS estado_tarea
    FROM personas per
    JOIN miembros_e me ON per.idPersona = me.idPersona
    JOIN Tareas t ON me.idMiembro = t.idMiembro
    JOIN proyectos p ON t.idProyecto = p.idProyecto
    WHERE per.per_nombre = p_nombre_miembro 
      AND per.per_apellido = p_apellido_miembro 
      AND per.per_cedula = p_cedula_miembro;
END //
DELIMITER ;
select * from tareas;
CALL sp_visualizarProyectosYTareasPorMiembro('María','Gómez','1001058153');

-- ---------------------------------------- SP PAR ACTUALIZAR UNA TAREA /ESTADO(miembro equipo)

-- Actualizar una tarea en base al miembro del equipo
DROP PROCEDURE IF EXISTS sp_modificarTareaPorMiembro;
DELIMITER //
CREATE PROCEDURE sp_modificarTareaPorMiembro(
    IN p_nombre_miembro VARCHAR(100),
    IN p_apellido_miembro VARCHAR(100),
    IN p_cedula_miembro VARCHAR(20),
    IN p_id_tarea INT,
    IN p_tar_nombre VARCHAR(100),
    IN p_tar_descripcion TEXT,
    IN p_tar_prioridad ENUM('Alta', 'Media', 'Baja'),
    IN p_tar_estado ENUM('Por hacer', 'En Proceso', 'Terminada'),
    IN p_tar_fecha_inicio DATE,
    IN p_tar_fecha_fin DATE
)
BEGIN
    DECLARE v_id_miembro INT;

    -- Obtener el ID del miembro basado en el nombre, apellido y cédula
    SELECT me.idMiembro INTO v_id_miembro
    FROM personas per
    JOIN miembros_e me ON per.idPersona = me.idPersona
    WHERE per.per_nombre = p_nombre_miembro 
      AND per.per_apellido = p_apellido_miembro 
      AND per.per_cedula = p_cedula_miembro;

    -- Verificar si se encontró el miembro
    IF v_id_miembro IS NOT NULL THEN
        -- Modificar la tarea si el miembro existe
        UPDATE Tareas
        SET 
            tar_nombre = p_tar_nombre,
            tar_descripcion = p_tar_descripcion,
            tar_prioridad = p_tar_prioridad,
            tar_estado = p_tar_estado,
            tar_fecha_inicio = p_tar_fecha_inicio,
            tar_fecha_fin = p_tar_fecha_fin
        WHERE idTarea = p_id_tarea AND idMiembro = v_id_miembro;
        
        -- Verificar si se actualizó la tarea
        IF ROW_COUNT() = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: No se encontró la tarea o no pertenece al miembro especificado.';
        END IF;
        
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Miembro no encontrado.';
    END IF;

END //
DELIMITER ;
call sp_listarProyectos;
call sp_buscarTareasPorProyectoMiembro('proyecto');

select * from tareas;
select * from personas;
select * from miembros_e;
CALL sp_modificarTareaPorMiembro(
    'María',         -- nombre del miembro
    'Gómez',       -- apellido del miembro
    '1001058153',         -- cédula del miembro
    2,                           -- ID de la tarea a modificar
    'Nuevo Nombre Tarea',       --  nombre para la tarea
    'Nueva Descripción',        --  descripción para la tarea
    'Alta',                     -- prioridad (puede ser Alta, Media o Baja)
    'Terminada',               --  estado (puede ser Por hacer, En Proceso o Terminada)
    '2025-01-16',               --  fecha de inicio 
    '2025-01-25'                --  fecha de fin 
);

select * from tareas;
-- -------------------------------------------------- SP BUSCAR TAREAS POR PROYECTO
DROP PROCEDURE IF EXISTS sp_buscarTareasProyecto;
DELIMITER //
CREATE PROCEDURE sp_buscarTareasProyecto(
    IN p_nombre_proyecto VARCHAR(100)
)
BEGIN
    SELECT
        t.idTarea,
        t.tar_nombre AS nombre_tarea,
        t.tar_estado,
        p.pro_nombre AS nombre_proyecto
    FROM Tareas t
    JOIN proyectos p ON t.idProyecto = p.idProyecto
    WHERE p.pro_nombre LIKE CONCAT('%',p_nombre_proyecto,'%');
END //
DELIMITER ;

call sp_buscarTareasProyecto('proyecto B');
call sp_ObtenerTareasPorEstadoProyecto('proye');

-- ------------------------------------------------------SP CREAR TAREAS(GESTOR)

DROP PROCEDURE IF EXISTS sp_CrearTarea;
DELIMITER //
CREATE PROCEDURE sp_CrearTarea(
    IN p_nombre_proyecto VARCHAR(100),
    IN p_tar_nombre VARCHAR(100),
    IN p_tar_descripcion TEXT,
    IN p_tar_prioridad ENUM('Alta', 'Media', 'Baja'),
    IN p_tar_fecha_inicio DATE,
    IN p_tar_fecha_fin DATE
)
BEGIN
    -- Declarar variables para almacenar los IDs
    DECLARE v_idProyecto INT;

    -- Obtener el ID del proyecto
    SELECT idProyecto INTO v_idProyecto
    FROM proyectos
    WHERE pro_nombre = p_nombre_proyecto;
    
    -- Insertar la tarea si existen el proyecto 
    IF v_idProyecto IS NOT NULL THEN
        INSERT INTO Tareas (idProyecto, tar_nombre, tar_descripcion, tar_prioridad, tar_fecha_inicio, tar_fecha_fin)
        VALUES (v_idProyecto, p_tar_nombre, p_tar_descripcion, p_tar_prioridad, p_tar_fecha_inicio, p_tar_fecha_fin);
    ELSE
        -- Lanzar un error si no se encuentra el proyecto
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: No se encontró el proyecto';
    END IF;
END //
DELIMITER ;

CALL sp_CrearTarea(
    'Proyecto B',        -- ver nombre del proyecto
    'Prueba Proyecto',          -- Nombre de la tarea nueva
    'Defensa mas o menos',  -- Descripción de la tarea nueva
    'Media',                       -- Prioridad de la tarea ('Alta', 'Media', 'Baja')
    curdate(),                -- Fecha de inicio de la tarea nueva
    '2025-02-22'                -- Fecha de fin de la tarea nueva
);

select * from tareas;
call sp_buscarTareasProyecto ('proyecto B');
call sp_ObtenerTareasPorEstadoProyecto ('proyecto b');

-- -------------------------------------------------------SP ASIGNAR MIEMBRO AL PROYECTO

call sp_listarProyectos;
call sp_listarMiembrosEquipo;

DROP PROCEDURE IF EXISTS sp_asignarMiembroAProyecto;
DELIMITER //
CREATE PROCEDURE sp_asignarMiembroAProyecto(
    IN p_nombre_miembro VARCHAR(100),
    IN p_apellido_miembro VARCHAR(100),
    IN p_cedula_miembro VARCHAR(20),
    IN p_nombre_proyecto VARCHAR(100),
    IN p_nombre_equipo VARCHAR(100)
)
BEGIN
    -- Declarar variables para almacenar los IDs
    DECLARE v_idMiembro INT;
    DECLARE v_idProyecto INT;

    -- Obtener el ID del miembro
    SELECT me.idMiembro INTO v_idMiembro
    FROM miembros_e me
    JOIN personas p ON me.idPersona = p.idPersona
    WHERE p.per_nombre = p_nombre_miembro
      AND p.per_apellido = p_apellido_miembro
      AND p.per_cedula = p_cedula_miembro;

    -- Obtener el ID del proyecto
    SELECT idProyecto INTO v_idProyecto
    FROM proyectos
    WHERE pro_nombre = p_nombre_proyecto;

    -- Asignar el miembro al proyecto si existen el miembro y el proyecto
    IF v_idMiembro IS NOT NULL AND v_idProyecto IS NOT NULL THEN
        INSERT INTO miembro_proyecto (idMiembro, idProyecto, mipro_fecha_asig, mipro_nombreEquipo)
        VALUES (v_idMiembro, v_idProyecto, CURDATE(), p_nombre_equipo);
    ELSE
        -- Lanzar un error si no se encuentra el miembro o el proyecto
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: No se encontró el miembro o el proyecto.';
    END IF;
END //
DELIMITER ;

CALL sp_asignarMiembroAProyecto(
    'laura',   -- Nombre del miembro
    'Martínez', -- Apellido del miembro
    '1050504751',   -- Cédula del miembro
    'Proyecto B',  -- Nombre del proyecto
    'Los Chéveres'     -- Nombre del equipo (puede ser NULL si no hay equipos)
);

CALL sp_listarMiembrosEquipo();
call sp_listarMiembrosDelProyecto('Proyecto b');
call sp_visualizarProyectosYTareasPorMiembro('Raúl','López','1050007046');
call sp_buscarTareasPorProyectoMiembro ('Proyecto');

-- **************************************************** SP ASIGNAR TAREAS (GESTOR)

call sp_buscarTareasProyecto('proyecto b');
call sp_listarMiembrosDelProyecto('proyecto b');
call sp_ObtenerTareasPorEstadoProyecto('proyecto');
call sp_buscarTareasPorProyectoMiembro ('Proyecto');
select * from miembro_proyecto;
select * from miembros_e;
select * from tareas;



DROP PROCEDURE IF EXISTS sp_asignarTarea;
DELIMITER //
CREATE PROCEDURE sp_asignarTarea(
    IN p_id_tarea INT,
    IN p_nombre_proyecto VARCHAR(100),
    IN p_nombre_miembro VARCHAR(100),
    IN p_apellido_miembro VARCHAR(100),
    IN p_cedula_miembro VARCHAR(20)
)
BEGIN
    -- Declarar variables para almacenar los IDs
    DECLARE v_idProyecto INT;
    DECLARE v_idMiembro INT;

    -- Obtener el ID del proyecto
    SELECT idProyecto INTO v_idProyecto
    FROM proyectos
    WHERE pro_nombre = p_nombre_proyecto;

    -- Obtener el ID del miembro del equipo
    SELECT me.idMiembro INTO v_idMiembro
    FROM miembros_e me
    JOIN personas p ON me.idPersona = p.idPersona
    JOIN miembro_proyecto mp ON me.idMiembro = mp.idMiembro
    WHERE p.per_nombre = p_nombre_miembro
      AND p.per_apellido = p_apellido_miembro
      AND p.per_cedula = p_cedula_miembro
      AND mp.idProyecto = v_idProyecto;

    -- Verificar si la tarea existe y pertenece al proyecto
    IF v_idProyecto IS NOT NULL THEN
        -- Actualizar la tarea si se encuentra el proyecto y el miembro
        UPDATE Tareas
        SET
            idMiembro = v_idMiembro,
            tar_estado = 'En Proceso'
        WHERE idTarea = p_id_tarea AND idProyecto = v_idProyecto;

        -- Verificar si se actualizó la tarea
        IF ROW_COUNT() = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: No se encontró la tarea en el proyecto o el miembro no está asignado al proyecto.';
        END IF;
    ELSE
        -- Lanzar un error si no se encuentra el proyecto
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: No se encontró el proyecto.';
    END IF;
END //
DELIMITER ;

call sp_buscarTareasPorProyectoMiembro('Proyecto B');
call sp_listarMiembrosDelProyecto('Proyecto B');
CALL sp_buscarTareasProyecto ('Proyecto B');
call sp_ObtenerTareasPorEstadoProyecto('Proyecto A');
call sp_ObtenerTareasPorEstadoProyecto('proyecto a');
CALL sp_asignarTarea(
    8,                          -- ID de la tarea
    'Proyecto B',        -- Nombre del proyecto
    'Laura',       -- Nombre del miembro
    'Martínez',     -- Apellido del miembro
    '1050504751'	-- Cédula del miembro
);

-- -------------------------------------- TRIGGER PARA ELIMINAR UN USUARIO EN BASE A LA CEDULA

CREATE TABLE aud_usuarios_password_historial (
    id INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT NOT NULL,
    old_contraseña VARCHAR(255) NOT NULL,
    new_contraseña VARCHAR(255) NOT NULL,
    change_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idUsuario) REFERENCES usuarios(idUsuario) ON DELETE CASCADE
);

-- Trigger to log password changes
DROP TRIGGER IF EXISTS before_update_usuarios;
DELIMITER //
CREATE TRIGGER before_update_usuarios
BEFORE UPDATE ON usuarios
FOR EACH ROW
BEGIN
    IF OLD.us_contraseña <> NEW.us_contraseña THEN
        INSERT INTO aud_usuarios_password_historial (idUsuario, old_contraseña, new_contraseña)
        VALUES (OLD.idUsuario, OLD.us_contraseña, NEW.us_contraseña);
    END IF;
END //
DELIMITER ;

select * from usuarios;
select * from aud_usuarios_password_historial;
