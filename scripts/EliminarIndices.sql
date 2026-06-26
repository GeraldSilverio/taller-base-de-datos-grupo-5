USE TiendaOnlineDb;
GO

DROP INDEX IF EXISTS IX_Pedidos_Estado_Fecha_Cliente 
ON dbo.Pedidos;
GO

DROP INDEX IF EXISTS IX_Pedidos_Cliente_Estado_Total 
ON dbo.Pedidos;
GO

DROP INDEX IF EXISTS IX_DetallesPedido_Producto_Pedido 
ON dbo.DetallesPedido;
GO

DROP INDEX IF EXISTS IX_DetallesPedido_Pedido_Producto 
ON dbo.DetallesPedido;
GO

DROP INDEX IF EXISTS IX_Inventario_Producto_CantidadReal 
ON dbo.Inventario;
GO

DROP INDEX IF EXISTS IX_Productos_Estado_Eliminado_Nombre 
ON dbo.Productos;
GO

DROP INDEX IF EXISTS IX_ProductosCategorias_Categoria_Producto 
ON dbo.ProductosCategorias;
GO

DROP INDEX IF EXISTS IX_Categorias_Slug_Nombre 
ON dbo.Categorias;
GO

DROP INDEX IF EXISTS IX_Pagos_Estado_Fecha 
ON dbo.Pagos;

GO