-- 1. Listar información básica de las oficinas
SELECT codigo_oficina, ciudad, pais, telefono
FROM oficina;

-- 2. Obtener los empleados por oficina
SELECT o.codigo_oficina, e.nombre, e.apellido1, e.apellido2, e.puesto
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
ORDER BY o.codigo_oficina;

-- 3. Promedio de límite de crédito por región
SELECT region, AVG(limite_credito) AS promedio_credito
FROM cliente
GROUP BY region;

-- 4. Listar clientes con sus representantes de ventas
SELECT c.nombre_cliente,
       CONCAT(e.nombre, ' ', e.apellido1, ' ', IFNULL(e.apellido2,'')) AS representante
FROM cliente c
LEFT JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;

-- 5. Productos disponibles en stock
SELECT codigo_producto, nombre, cantidad_en_stock
FROM producto
WHERE cantidad_en_stock > 0;

-- 6. Productos con precio menor al promedio
SELECT *
FROM producto
WHERE precio_venta < (SELECT AVG(precio_venta) FROM producto);

-- 7. Pedidos pendientes por cliente
SELECT p.codigo_pedido, p.estado, c.nombre_cliente
FROM pedido p
JOIN cliente c ON p.codigo_cliente = c.codigo_cliente
WHERE p.estado <> 'Entregado';

-- 8. Total de productos por gama
SELECT gama, COUNT(*) AS total
FROM producto
GROUP BY gama;

-- 9. Ingresos totales por cliente
SELECT c.nombre_cliente, SUM(p.total) AS ingresos
FROM pago p
JOIN cliente c ON p.codigo_cliente = c.codigo_cliente
GROUP BY c.codigo_cliente;

-- 10. Pedidos realizados entre fechas
SELECT codigo_pedido, fecha_pedido
FROM pedido
WHERE fecha_pedido BETWEEN '2008-01-01' AND '2008-12-31';

-- 11. Detalles de un pedido específico (ejemplo: pedido 1)
SELECT d.codigo_pedido, d.codigo_producto, d.cantidad,
       (d.cantidad * d.precio_unidad) AS total_linea
FROM detalle_pedido d
WHERE d.codigo_pedido = 1;

-- 12. Productos más vendidos
SELECT p.nombre, SUM(d.cantidad) AS total_vendido
FROM detalle_pedido d
JOIN producto p ON d.codigo_producto = p.codigo_producto
GROUP BY p.codigo_producto
ORDER BY total_vendido DESC;

-- 13. Pedidos con valor superior al promedio
SELECT d.codigo_pedido, SUM(d.cantidad * d.precio_unidad) AS total_pedido
FROM detalle_pedido d
GROUP BY d.codigo_pedido
HAVING total_pedido > (
    SELECT AVG(cantidad * precio_unidad)
    FROM detalle_pedido
);

-- 14. Clientes sin representante de ventas
SELECT *
FROM cliente
WHERE codigo_empleado_rep_ventas IS NULL;

-- 15. Total de empleados por oficina
SELECT codigo_oficina, COUNT(*) AS total_empleados
FROM empleado
GROUP BY codigo_oficina;

-- 16. Pagos realizados con forma específica
SELECT *
FROM pago
WHERE forma_pago = 'Tarjeta de Crédito';

-- 17. Ingresos mensuales
SELECT DATE_FORMAT(fecha_pago, '%Y-%m') AS mes, SUM(total) AS ingresos
FROM pago
GROUP BY mes;

-- 18. Clientes con múltiples pedidos
SELECT c.nombre_cliente, COUNT(p.codigo_pedido) AS num_pedidos
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
GROUP BY c.codigo_cliente
HAVING num_pedidos > 1;

-- 19.
