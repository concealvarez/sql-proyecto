INSERT INTO cliente (nombre, apellido, fecha_nacimiento, direccion, telefono)
VALUE 
("Micaela", "Videla", "20-07-1990", "cerrito 120", 222333444),
("Sofia", "Acuña", "30-05-2002", "av.malvina 34", 333444555),
("Candela", "Perez", "09-03-1987", "esq. San Martin", 444333222),
("Mateo", "Juarez", "20-03-2000", "9 de Julio 89", 00222333),
("Juan", "Perez", "09-04-1994", "cangallo 321", 3339999),
("Claudia", "Sanchez", "30-02-2003", "av. belgrano 97", 3097322),
("Maximiliano", "Castro", "25-06-2004", "belgrano 455", 4628639);

INSERT INTO mediodepago (tipo)
VALUE 
("Débito"),
("Crédito"),
("Efectivo"),
("Qr");

INSERT INTO profesor (nombre, direccion, telefono)
VALUE 
("Ignacio Farias", "cerrito 20", 2333000),
("Veronica Balmaceda", "Concorida 56", 4445555),
("Rodrigo Campos", "neuquen 305", 44555322),
("Julia Romero", "villa los altos 90", 767687);

INSERT INTO actividad (actividad, dias, costo, id_profe)
VALUE
("Musculacion", 2, 20000, 1),
("Musculacion", 3, 25000, 1),
("Musculacion", 5, 30000, 1),
("Pilates", 2, 15000, 4),
("Pilates", 4, 25000, 4),
("Natacion", 3, 30000, 2),
("Natacion", 5, 40000, 2),
("Entrenamiento Deportivo", 5, 30000, 3);

INSERT INTO plan (id_actividad, id_cliente, id_pago, estado)
VALUE
(1, 1, 3, "pagado"),
(5, 2, 3, "pagado"),
(8, 3, 4, "pagado"),
(6, 4, 1, "pagado"),
(2, 5, 4, "pendiente"),
(3, 6, 2, "pagado"),
(7, 7, 1, "pendiente");

ALTER TABLE plan
ADD COLUMN fecha_actualizacion DATETIME;

UPDATE plan SET fecha_actualizacion = '2025-06-20' WHERE id_plan = 1;
UPDATE plan SET fecha_actualizacion = '2025-07-05' WHERE id_plan = 2;
UPDATE plan SET fecha_actualizacion = '2025-06-30' WHERE id_plan = 3;
UPDATE plan SET fecha_actualizacion = '2025-07-04' WHERE id_plan = 4;
UPDATE plan SET fecha_actualizacion = '2025-06-01' WHERE id_plan = 5;
UPDATE plan SET fecha_actualizacion = '2025-07-12' WHERE id_plan = 6;
UPDATE plan SET fecha_actualizacion = '2025-07-05' WHERE id_plan = 7;

UPDATE cliente SET id_actividad = 1 WHERE id_cliente = 1;
UPDATE cliente SET id_actividad = 5 WHERE id_cliente = 2 ;
UPDATE cliente SET id_actividad = 8 WHERE id_cliente = 3;
UPDATE cliente SET id_actividad = 6 WHERE id_cliente = 4;
UPDATE cliente SET id_actividad = 2 WHERE id_cliente = 5;
UPDATE cliente SET id_actividad = 3 WHERE id_cliente = 6;
UPDATE cliente SET id_actividad = 7 WHERE id_cliente = 7;