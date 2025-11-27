– 1. Información básica de oficinas SELECT codigo_oficina, ciudad, pais,
telefono FROM oficina;

– 2. Empleados por oficina SELECT codigo_oficina, nombre, apellido1,
apellido2, puesto FROM empleado ORDER BY codigo_oficina;

– 3. Promedio límite de crédito por región SELECT region,
AVG(limite_credito) AS promedio_limite FROM cliente GROUP BY region;

– 4. Clientes con sus representantes de ventas SELECT c.nombre_cliente,
CONCAT(e.nombre, ’ ‘, e.apellido1,’ ’, e.apellido2) AS representante
FROM cliente c LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas =
e.codigo_empleado;

– 5. Productos disponibles SELECT codigo_producto, nombre,
cantidad_en_stock FROM producto WHERE cantidad_en_stock > 0;

– 6. Productos por debajo del precio promedio SELECT * FROM producto
WHERE precio_venta < (SELECT AVG(precio_venta) FROM producto);

– 7. Pedidos pendientes por cliente SELECT p.codigo_pedido, p.estado,
c.nombre_cliente FROM pedido p JOIN cliente c ON p.codigo_cliente =
c.codigo_cliente WHERE p.estado <> ‘Entregado’;

– 8. Total de productos por gama SELECT gama, COUNT(*) AS
total_productos FROM producto GROUP BY gama;

– 9. Ingresos totales por cliente SELECT c.nombre_cliente, SUM(p.total)
AS ingresos FROM pago p JOIN cliente c ON p.codigo_cliente =
c.codigo_cliente GROUP BY c.codigo_cliente;

– 10. Pedidos en un rango de fechas SELECT codigo_pedido, fecha_pedido
FROM pedido WHERE fecha_pedido BETWEEN ‘2008-01-01’ AND ‘2008-12-31’;

– 11. Detalles de pedido SELECT d.codigo_pedido, d.codigo_producto,
d.cantidad, (d.cantidad * d.precio_unidad) AS total_linea FROM
detalle_pedido d;

– 12. Productos más vendidos SELECT p.nombre, SUM(d.cantidad) AS
total_vendido FROM detalle_pedido d JOIN producto p ON d.codigo_producto
= p.codigo_producto GROUP BY p.codigo_producto ORDER BY total_vendido
DESC;

– 13. Pedidos con valor total superior al promedio SELECT
d.codigo_pedido, SUM(d.cantidad * d.precio_unidad) AS total_pedido FROM
detalle_pedido d GROUP BY d.codigo_pedido HAVING total_pedido > ( SELECT
AVG(sub.total_pedido) FROM ( SELECT SUM(cantidad * precio_unidad) AS
total_pedido FROM detalle_pedido GROUP BY codigo_pedido ) sub );

– 14. Clientes sin representante SELECT nombre_cliente FROM cliente
WHERE codigo_empleado_rep_ventas IS NULL;

– 15. Número de empleados por oficina SELECT codigo_oficina, COUNT(*) AS
total_empleados FROM empleado GROUP BY codigo_oficina;

– 16. Pagos por forma específica SELECT * FROM pago WHERE forma_pago =
‘Tarjeta de Crédito’;

– 17. Ingresos mensuales SELECT MONTH(fecha_pago) AS mes, SUM(total) AS
ingresos FROM pago GROUP BY mes;

– 18. Clientes con múltiples pedidos SELECT c.nombre_cliente FROM
cliente c JOIN pedido p ON c.codigo_cliente = p.codigo_cliente GROUP BY
c.codigo_cliente HAVING COUNT(*) > 1;

– 19. Pedidos con productos agotados SELECT DISTINCT d.codigo_pedido
FROM detalle_pedido d JOIN producto p ON d.codigo_producto =
p.codigo_producto WHERE p.cantidad_en_stock = 0;

– 20. Crédito promedio, máximo y mínimo por país SELECT pais,
AVG(limite_credito), MAX(limite_credito), MIN(limite_credito) FROM
cliente GROUP BY pais;

– 21. Historial de pagos de un cliente específico (ejemplo: cliente 1)
SELECT fecha_pago, total, forma_pago FROM pago WHERE codigo_cliente = 1;

– 22. Empleados sin jefe SELECT nombre, apellido1, apellido2 FROM
empleado WHERE codigo_jefe IS NULL;

– 23. Productos con precio mayor al promedio de su gama SELECT p.* FROM
producto p JOIN ( SELECT gama, AVG(precio_venta) AS promedio FROM
producto GROUP BY gama ) g ON p.gama = g.gama WHERE p.precio_venta >
g.promedio;

– 24. Promedio de días de entrega por estado SELECT estado,
AVG(DATEDIFF(fecha_entrega, fecha_pedido)) AS dias_promedio FROM pedido
WHERE fecha_entrega IS NOT NULL GROUP BY estado;

– 25. Países con clientes que tienen más de un pedido SELECT pais,
COUNT(*) AS clientes_con_multiples_pedidos FROM cliente c JOIN pedido p
ON c.codigo_cliente = p.codigo_cliente GROUP BY pais, c.codigo_cliente
HAVING COUNT(p.codigo_pedido) > 1;
