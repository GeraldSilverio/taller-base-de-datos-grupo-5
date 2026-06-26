USE TiendaOnlineDb;
GO

-- =====================================================
-- INDICE PARA CONSULTAS DE PEDIDOS POR ESTADO Y FECHA
-- Optimiza: ingresos por mes y filtros por estado del pedido
-- =====================================================

CREATE INDEX IX_Pedidos_Estado_Fecha_Cliente
ON dbo.Pedidos
(
    EstadoPedido,
    FechaCreacion,
    ClienteId
)
INCLUDE
(
    PedidoId,
    Subtotal,
    Impuesto,
    CostoEnvio,
    Total
);
GO

-- =====================================================
-- INDICE PARA CLIENTES CON MAS COMPRAS
-- Optimiza: agrupaciones por cliente y suma de compras
-- =====================================================

CREATE INDEX IX_Pedidos_Cliente_Estado_Total
ON dbo.Pedidos
(
    ClienteId,
    EstadoPedido
)
INCLUDE
(
    PedidoId,
    Total,
    FechaCreacion
);
GO

-- =====================================================
-- INDICE PARA PRODUCTOS MAS VENDIDOS
-- Optimiza: busquedas y agrupaciones por producto
-- =====================================================

CREATE INDEX IX_DetallesPedido_Producto_Pedido
ON dbo.DetallesPedido
(
    ProductoId,
    PedidoId
)
INCLUDE
(
    Cantidad,
    PrecioUnitario,
    Impuesto,
    TotalLinea
);
GO

-- =====================================================
-- INDICE PARA DETALLES DE PEDIDO POR PEDIDO
-- Optimiza: joins desde Pedidos hacia DetallesPedido
-- =====================================================

CREATE INDEX IX_DetallesPedido_Pedido_Producto
ON dbo.DetallesPedido
(
    PedidoId,
    ProductoId
)
INCLUDE
(
    Cantidad,
    PrecioUnitario,
    Impuesto,
    TotalLinea
);
GO

-- =====================================================
-- INDICE PARA PRODUCTOS SIN INVENTARIO
-- Optimiza: joins contra Inventario y calculo de cantidad real
-- =====================================================

CREATE INDEX IX_Inventario_Producto_CantidadReal
ON dbo.Inventario
(
    ProductoId
)
INCLUDE
(
    AlmacenId,
    CantidadDisponible,
    CantidadReservada,
    CantidadReal,
    NivelReorden
);
GO

-- =====================================================
-- INDICE PARA BUSQUEDA DE PRODUCTOS ACTIVOS
-- Optimiza: filtros por EstadoProducto y EstaEliminado
-- =====================================================

CREATE INDEX IX_Productos_Estado_Eliminado_Nombre
ON dbo.Productos
(
    EstadoProducto,
    EstaEliminado,
    Nombre
)
INCLUDE
(
    CodigoProducto,
    PrecioVenta,
    Descripcion
);
GO

-- =====================================================
-- INDICE PARA BUSQUEDA POR CATEGORIA
-- Optimiza: joins desde Categorias hacia ProductosCategorias
-- =====================================================

CREATE INDEX IX_ProductosCategorias_Categoria_Producto
ON dbo.ProductosCategorias
(
    CategoriaId,
    ProductoId
);
GO

-- =====================================================
-- INDICE PARA BUSQUEDA DE CATEGORIA POR SLUG
-- Nota: ya existe UQ_Categorias_Slug, pero este incluye Nombre
-- para evitar lecturas adicionales en consultas de productos por categoria.
-- =====================================================

CREATE INDEX IX_Categorias_Slug_Nombre
ON dbo.Categorias
(
    Slug
)
INCLUDE
(
    Nombre
);
GO

-- =====================================================
-- INDICE PARA ANALISIS DE PAGOS
-- Util para futuras consultas de ingresos confirmados por pagos
-- =====================================================

CREATE INDEX IX_Pagos_Estado_Fecha
ON dbo.Pagos
(
    EstadoPago,
    FechaPago
)
INCLUDE
(
    PedidoId,
    Monto,
    MetodoPago
);
GO