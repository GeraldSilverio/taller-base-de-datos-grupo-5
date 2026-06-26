USE TiendaOnlineDb;
GO


-- 1. Clientes con más compras
SELECT 
    c.ClienteId,
    c.Nombre + ' ' + c.Apellido AS NombreCompleto,
    c.Correo,
    COUNT(p.PedidoId) AS TotalPedidos,
    SUM(p.Total) AS TotalComprado
FROM dbo.Clientes c
INNER JOIN dbo.Pedidos p 
    ON p.ClienteId = c.ClienteId
WHERE p.EstadoPedido IN ('Pagado', 'Procesando', 'Enviado', 'Completado')
GROUP BY 
    c.ClienteId,
    c.Nombre,
    c.Apellido,
    c.Correo
ORDER BY TotalComprado DESC;
GO

--2. Productos sin inventario
SELECT 
    p.ProductoId,
    p.CodigoProducto,
    p.Nombre AS Producto,
    p.PrecioVenta,
    p.EstadoProducto,
    ISNULL(SUM(i.CantidadDisponible), 0) AS CantidadDisponible,
    ISNULL(SUM(i.CantidadReservada), 0) AS CantidadReservada,
    ISNULL(SUM(i.CantidadReal), 0) AS CantidadReal
FROM dbo.Productos p
LEFT JOIN dbo.Inventario i 
    ON i.ProductoId = p.ProductoId
WHERE p.EstaEliminado = 0
GROUP BY 
    p.ProductoId,
    p.CodigoProducto,
    p.Nombre,
    p.PrecioVenta,
    p.EstadoProducto
HAVING ISNULL(SUM(i.CantidadReal), 0) <= 0
ORDER BY p.Nombre;
GO

--3. Ingresos por mes
SELECT 
    YEAR(p.FechaCreacion) AS Anio,
    MONTH(p.FechaCreacion) AS Mes,
    DATENAME(MONTH, p.FechaCreacion) AS NombreMes,
    COUNT(p.PedidoId) AS TotalPedidos,
    SUM(p.Subtotal) AS Subtotal,
    SUM(p.Impuesto) AS TotalImpuestos,
    SUM(p.CostoEnvio) AS TotalEnvios,
    SUM(p.Total) AS IngresosTotales
FROM dbo.Pedidos p
WHERE p.EstadoPedido IN ('Pagado', 'Procesando', 'Enviado', 'Completado')
GROUP BY 
    YEAR(p.FechaCreacion),
    MONTH(p.FechaCreacion),
    DATENAME(MONTH, p.FechaCreacion)
ORDER BY 
    Anio,
    Mes;

--4. Productos más vendidos.
SELECT 
    pr.ProductoId,
    pr.CodigoProducto,
    pr.Nombre AS Producto,
    SUM(dp.Cantidad) AS CantidadVendida,
    COUNT(DISTINCT p.PedidoId) AS PedidosRelacionados,
    SUM(dp.TotalLinea) AS TotalGenerado
FROM dbo.DetallesPedido dp
INNER JOIN dbo.Pedidos p 
    ON p.PedidoId = dp.PedidoId
INNER JOIN dbo.Productos pr 
    ON pr.ProductoId = dp.ProductoId
WHERE p.EstadoPedido IN ('Pagado', 'Procesando', 'Enviado', 'Completado')
GROUP BY 
    pr.ProductoId,
    pr.CodigoProducto,
    pr.Nombre
ORDER BY CantidadVendida DESC, TotalGenerado DESC;


--5 Búsqueda con JSON
DECLARE @ProductosJson NVARCHAR(MAX) = N'
{
    "codigosProductos": [
        "SKU-001",
        "SKU-006",
        "SKU-003"
    ]
}';

SELECT 
    p.ProductoId,
    p.CodigoProducto,
    p.Nombre,
    p.PrecioVenta,
    p.EstadoProducto
FROM dbo.Productos p
INNER JOIN OPENJSON(@ProductosJson, '$.codigosProductos')
WITH 
(
    CodigoProducto NVARCHAR(50) '$'
) j
    ON j.CodigoProducto = p.CodigoProducto
WHERE p.EstaEliminado = 0
ORDER BY p.Nombre;
GO