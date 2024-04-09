SELECT COUNT(producto.id_producto) AS bebidas_vendidas
FROM pedido 
JOIN producto  ON pedido.id_productos = producto.id_producto
JOIN categoria  ON producto.id_categoria = categoria.id_categoria
JOIN tienda  ON pedido.id_tienda = tienda.id_tienda
WHERE categoria.nombre = 'Bebidas'
AND tienda.localidad = 'Barcelona';


SELECT COUNT(id_pedido) AS total_pedidos
FROM pedido
WHERE id_empleado = 3;