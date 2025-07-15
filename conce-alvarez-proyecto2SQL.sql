USE controlpago;

-- Vista para seleccionar los pendientes 

CREATE VIEW ver_pendientes AS (
    SELECT 
        c.id_cliente,
        c.nombre,
        c.apellido,
        p.estado,
        p.fecha_actualizacion
    FROM cliente c  
    JOIN plan p ON c.id_cliente = p.id_cliente
    WHERE p.estado = 'pendiente'
);

-- Procedure para actualizar tabla

DELIMITER //

CREATE PROCEDURE actualizar_estado (
    IN p_estado VARCHAR(50),
    IN p_id_plan INT
)
BEGIN 
    UPDATE plan
    SET estado = p_estado,
        fecha_actualizacion = NOW()
    WHERE id_plan = p_id_plan;
END //

DELIMITER ;

CALL actualizar_estado('pendiente', 5);

SELECT * FROM ver_pendientes;

-- Funcion para dejar mensaje

DELIMITER //
CREATE FUNCTION pendientes(nombre VARCHAR(50), apellido VARCHAR(50), tipo_estado VARCHAR(50))
RETURNS VARCHAR (150)
DETERMINISTIC
NO SQL
BEGIN
DECLARE nombre_completo varchar (150);
SET nombre_completo = CONCAT(nombre, ' ', apellido);
 IF tipo_estado = 'pendiente' THEN
    RETURN CONCAT('Tu pago está pendiente ', nombre_completo);
  ELSEIF tipo_estado = 'pagado' THEN
    RETURN 'Estás al día :)';
  END IF;
END//
    
DELIMITER ;


 SELECT pendientes(
  c.nombre,
  c.apellido,
  (SELECT p.estado FROM plan p WHERE p.id_cliente = c.id_cliente LIMIT 1)
  ) AS mensaje
FROM cliente c
WHERE c.nombre = 'juan' AND c.apellido = 'perez';


-- Funcion para calcular descuento en efectivo 
DELIMITER $$


CREATE FUNCTION calcular_descuento(
    idPlan INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE costo_original INT;
    DECLARE tipo_pago VARCHAR(50);
    DECLARE costo_final INT;

    SELECT a.costo, m.tipo
    INTO costo_original, tipo_pago
    FROM plan p
    JOIN actividad a ON p.id_actividad = a.id_actividad
    JOIN mediodepago m ON p.id_pago = m.id_pago
    WHERE p.id_plan = idPlan;

    IF tipo_pago = 'Efectivo' THEN
        SET costo_final = costo_original * 0.90; 
    ELSE
        SET costo_final = costo_original;
    END IF;

    RETURN costo_final;
END$$

DELIMITER ;

-- Vista para visualizar tabla de precios con descuento
CREATE VIEW vista_planes_con_descuento AS
SELECT 
    c.nombre,
    c.apellido,
    a.actividad,
    a.costo AS costo_original,
    m.tipo AS medio_pago,
    calcular_descuento(p.id_plan) AS costo_final
FROM plan p
JOIN cliente c ON p.id_cliente = c.id_cliente
JOIN actividad a ON p.id_actividad = a.id_actividad
JOIN mediodepago m ON p.id_pago = m.id_pago;

DELIMITER $$

-- Agregar un nuevo cliente
CREATE PROCEDURE agregar_cliente(
    IN pnombre VARCHAR(100),
    IN papellido VARCHAR(100),
    IN pfecha_nacimiento DATE,
    IN pdireccion TEXT,
    IN ptelefono CHAR(10),
    IN pid_actividad INT
)
BEGIN
    INSERT INTO cliente (nombre, apellido, fecha_nacimiento, direccion, telefono, id_actividad)
    VALUES (pnombre, papellido, pfecha_nacimiento, pdireccion, ptelefono, pid_actividad);
END$$

DELIMITER ;

CALL agregar_cliente ('tomas', 'acevedo', '2000-09-03', 'jose longueira 23', 22323, 4);

-- filtrae por menores de edad
CREATE VIEW vista_menores_edad AS
SELECT 
    id_cliente,
    nombre,
    apellido,
    fecha_nacimiento,
    TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) AS edad
FROM cliente
WHERE TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) < 18;








