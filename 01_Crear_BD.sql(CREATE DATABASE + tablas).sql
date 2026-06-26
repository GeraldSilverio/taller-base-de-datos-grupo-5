CREATE DATABASE TiendaOnlineDb;
GO

USE TiendaOnlineDb;
GO

-- =========================================================
-- TABLA: Clientes
-- =========================================================
CREATE TABLE dbo.Clientes
(
    ClienteId BIGINT IDENTITY(1,1) NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    Apellido NVARCHAR(100) NOT NULL,
    Correo NVARCHAR(255) NOT NULL,
    Telefono NVARCHAR(25) NULL,
    FechaNacimiento DATE NULL,
    EstadoCliente NVARCHAR(20) NOT NULL DEFAULT 'Activo',
    FechaCreacion DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
    FechaActualizacion DATETIME2(0) NULL,
    EstaEliminado BIT NOT NULL DEFAULT 0,

    CONSTRAINT PK_Clientes PRIMARY KEY (ClienteId),
    CONSTRAINT UQ_Clientes_Correo UNIQUE (Correo),
    CONSTRAINT CK_Clientes_Estado 
        CHECK (EstadoCliente IN ('Activo', 'Inactivo', 'Bloqueado'))
);
GO

-- =========================================================
-- TABLA: DireccionesCliente
-- =========================================================
CREATE TABLE dbo.DireccionesCliente
(
    DireccionId BIGINT IDENTITY(1,1) NOT NULL,
    ClienteId BIGINT NOT NULL,
    TipoDireccion NVARCHAR(20) NOT NULL,
    Direccion NVARCHAR(255) NOT NULL,
    Ciudad NVARCHAR(100) NOT NULL,
    Provincia NVARCHAR(100) NULL,
    CodigoPostal NVARCHAR(20) NULL,
    Pais NVARCHAR(100) NOT NULL DEFAULT 'Republica Dominicana',
    EsPrincipal BIT NOT NULL DEFAULT 0,
    FechaCreacion DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_DireccionesCliente PRIMARY KEY (DireccionId),
    CONSTRAINT FK_DireccionesCliente_Clientes 
        FOREIGN KEY (ClienteId) REFERENCES dbo.Clientes(ClienteId),
    CONSTRAINT CK_DireccionesCliente_Tipo 
        CHECK (TipoDireccion IN ('Facturacion', 'Envio'))
);
GO

-- =========================================================
-- TABLA: Categorias
-- =========================================================
CREATE TABLE dbo.Categorias
(
    CategoriaId INT IDENTITY(1,1) NOT NULL,
    CategoriaPadreId INT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    Slug NVARCHAR(120) NOT NULL,
    Descripcion NVARCHAR(500) NULL,
    OrdenVisualizacion INT NOT NULL DEFAULT 0,
    EstaActiva BIT NOT NULL DEFAULT 1,
    FechaCreacion DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
    FechaActualizacion DATETIME2(0) NULL,

    CONSTRAINT PK_Categorias PRIMARY KEY (CategoriaId),
    CONSTRAINT UQ_Categorias_Slug UNIQUE (Slug),
    CONSTRAINT FK_Categorias_CategoriaPadre 
        FOREIGN KEY (CategoriaPadreId) REFERENCES dbo.Categorias(CategoriaId)
);
GO

-- =========================================================
-- TABLA: Productos
-- =========================================================
CREATE TABLE dbo.Productos
(
    ProductoId BIGINT IDENTITY(1,1) NOT NULL,
    CodigoProducto NVARCHAR(50) NOT NULL,
    Nombre NVARCHAR(150) NOT NULL,
    Slug NVARCHAR(180) NOT NULL,
    Descripcion NVARCHAR(MAX) NULL,
    PrecioVenta DECIMAL(18,2) NOT NULL,
    PrecioCosto DECIMAL(18,2) NULL,
    PorcentajeImpuesto DECIMAL(5,2) NOT NULL DEFAULT 0,
    EstadoProducto NVARCHAR(20) NOT NULL DEFAULT 'Activo',
    FechaCreacion DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
    FechaActualizacion DATETIME2(0) NULL,
    EstaEliminado BIT NOT NULL DEFAULT 0,

    CONSTRAINT PK_Productos PRIMARY KEY (ProductoId),
    CONSTRAINT UQ_Productos_CodigoProducto UNIQUE (CodigoProducto),
    CONSTRAINT UQ_Productos_Slug UNIQUE (Slug),
    CONSTRAINT CK_Productos_PrecioVenta CHECK (PrecioVenta >= 0),
    CONSTRAINT CK_Productos_PrecioCosto CHECK (PrecioCosto IS NULL OR PrecioCosto >= 0),
    CONSTRAINT CK_Productos_Impuesto CHECK (PorcentajeImpuesto >= 0),
    CONSTRAINT CK_Productos_Estado 
        CHECK (EstadoProducto IN ('Borrador', 'Activo', 'Inactivo', 'Descontinuado'))
);
GO

-- =========================================================
-- TABLA: ProductosCategorias
-- Relación muchos a muchos entre Productos y Categorias
-- =========================================================
CREATE TABLE dbo.ProductosCategorias
(
    ProductoId BIGINT NOT NULL,
    CategoriaId INT NOT NULL,
    FechaCreacion DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_ProductosCategorias PRIMARY KEY (ProductoId, CategoriaId),
    CONSTRAINT FK_ProductosCategorias_Productos 
        FOREIGN KEY (ProductoId) REFERENCES dbo.Productos(ProductoId),
    CONSTRAINT FK_ProductosCategorias_Categorias 
        FOREIGN KEY (CategoriaId) REFERENCES dbo.Categorias(CategoriaId)
);
GO

-- =========================================================
-- TABLA: Almacenes
-- =========================================================
CREATE TABLE dbo.Almacenes
(
    AlmacenId INT IDENTITY(1,1) NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    Ubicacion NVARCHAR(255) NULL,
    EstaActivo BIT NOT NULL DEFAULT 1,
    FechaCreacion DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_Almacenes PRIMARY KEY (AlmacenId),
    CONSTRAINT UQ_Almacenes_Nombre UNIQUE (Nombre)
);
GO

-- =========================================================
-- TABLA: Inventario
-- =========================================================
CREATE TABLE dbo.Inventario
(
    InventarioId BIGINT IDENTITY(1,1) NOT NULL,
    ProductoId BIGINT NOT NULL,
    AlmacenId INT NOT NULL,
    CantidadDisponible INT NOT NULL DEFAULT 0,
    CantidadReservada INT NOT NULL DEFAULT 0,
    CantidadReal AS (CantidadDisponible - CantidadReservada) PERSISTED,
    NivelReorden INT NOT NULL DEFAULT 5,
    FechaUltimaActualizacion DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_Inventario PRIMARY KEY (InventarioId),
    CONSTRAINT UQ_Inventario_Producto_Almacen UNIQUE (ProductoId, AlmacenId),
    CONSTRAINT FK_Inventario_Productos 
        FOREIGN KEY (ProductoId) REFERENCES dbo.Productos(ProductoId),
    CONSTRAINT FK_Inventario_Almacenes 
        FOREIGN KEY (AlmacenId) REFERENCES dbo.Almacenes(AlmacenId),
    CONSTRAINT CK_Inventario_Cantidades 
        CHECK (
            CantidadDisponible >= 0 
            AND CantidadReservada >= 0 
            AND CantidadReservada <= CantidadDisponible
            AND NivelReorden >= 0
        )
);
GO

-- =========================================================
-- TABLA: Pedidos
-- =========================================================
CREATE TABLE dbo.Pedidos
(
    PedidoId BIGINT IDENTITY(1,1) NOT NULL,
    NumeroPedido NVARCHAR(30) NOT NULL,
    ClienteId BIGINT NOT NULL,
    DireccionFacturacionId BIGINT NULL,
    DireccionEnvioId BIGINT NULL,
    EstadoPedido NVARCHAR(20) NOT NULL DEFAULT 'Pendiente',
    Subtotal DECIMAL(18,2) NOT NULL DEFAULT 0,
    Descuento DECIMAL(18,2) NOT NULL DEFAULT 0,
    CostoEnvio DECIMAL(18,2) NOT NULL DEFAULT 0,
    Impuesto DECIMAL(18,2) NOT NULL DEFAULT 0,
    Total DECIMAL(18,2) NOT NULL DEFAULT 0,
    CodigoMoneda CHAR(3) NOT NULL DEFAULT 'DOP',
    Notas NVARCHAR(500) NULL,
    FechaCreacion DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
    FechaActualizacion DATETIME2(0) NULL,

    CONSTRAINT PK_Pedidos PRIMARY KEY (PedidoId),
    CONSTRAINT UQ_Pedidos_NumeroPedido UNIQUE (NumeroPedido),
    CONSTRAINT FK_Pedidos_Clientes 
        FOREIGN KEY (ClienteId) REFERENCES dbo.Clientes(ClienteId),
    CONSTRAINT FK_Pedidos_DireccionFacturacion 
        FOREIGN KEY (DireccionFacturacionId) REFERENCES dbo.DireccionesCliente(DireccionId),
    CONSTRAINT FK_Pedidos_DireccionEnvio 
        FOREIGN KEY (DireccionEnvioId) REFERENCES dbo.DireccionesCliente(DireccionId),
    CONSTRAINT CK_Pedidos_Estado 
        CHECK (EstadoPedido IN ('Pendiente', 'Pagado', 'Procesando', 'Enviado', 'Completado', 'Cancelado', 'Reembolsado')),
    CONSTRAINT CK_Pedidos_Montos 
        CHECK (
            Subtotal >= 0 
            AND Descuento >= 0 
            AND CostoEnvio >= 0 
            AND Impuesto >= 0 
            AND Total >= 0
        )
);
GO

-- =========================================================
-- TABLA: DetallesPedido
-- =========================================================
CREATE TABLE dbo.DetallesPedido
(
    DetallePedidoId BIGINT IDENTITY(1,1) NOT NULL,
    PedidoId BIGINT NOT NULL,
    ProductoId BIGINT NOT NULL,
    CodigoProductoSnapshot NVARCHAR(50) NOT NULL,
    NombreProductoSnapshot NVARCHAR(150) NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(18,2) NOT NULL,
    Descuento DECIMAL(18,2) NOT NULL DEFAULT 0,
    Impuesto DECIMAL(18,2) NOT NULL DEFAULT 0,
    TotalLinea AS ((Cantidad * PrecioUnitario) - Descuento + Impuesto) PERSISTED,

    CONSTRAINT PK_DetallesPedido PRIMARY KEY (DetallePedidoId),
    CONSTRAINT FK_DetallesPedido_Pedidos 
        FOREIGN KEY (PedidoId) REFERENCES dbo.Pedidos(PedidoId),
    CONSTRAINT FK_DetallesPedido_Productos 
        FOREIGN KEY (ProductoId) REFERENCES dbo.Productos(ProductoId),
    CONSTRAINT UQ_DetallesPedido_Pedido_Producto UNIQUE (PedidoId, ProductoId),
    CONSTRAINT CK_DetallesPedido_Cantidad CHECK (Cantidad > 0),
    CONSTRAINT CK_DetallesPedido_Montos 
        CHECK (
            PrecioUnitario >= 0 
            AND Descuento >= 0 
            AND Impuesto >= 0
        )
);
GO

-- =========================================================
-- TABLA: Pagos
-- =========================================================
CREATE TABLE dbo.Pagos
(
    PagoId BIGINT IDENTITY(1,1) NOT NULL,
    PedidoId BIGINT NOT NULL,
    MetodoPago NVARCHAR(30) NOT NULL,
    EstadoPago NVARCHAR(20) NOT NULL DEFAULT 'Pendiente',
    Monto DECIMAL(18,2) NOT NULL,
    ReferenciaTransaccion NVARCHAR(100) NULL,
    FechaPago DATETIME2(0) NULL,
    FechaCreacion DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_Pagos PRIMARY KEY (PagoId),
    CONSTRAINT FK_Pagos_Pedidos 
        FOREIGN KEY (PedidoId) REFERENCES dbo.Pedidos(PedidoId),
    CONSTRAINT UQ_Pagos_ReferenciaTransaccion UNIQUE (ReferenciaTransaccion),
    CONSTRAINT CK_Pagos_Metodo 
        CHECK (MetodoPago IN ('Efectivo', 'Tarjeta', 'Transferencia', 'PayPal', 'Otro')),
    CONSTRAINT CK_Pagos_Estado 
        CHECK (EstadoPago IN ('Pendiente', 'Aprobado', 'Rechazado', 'Reembolsado')),
    CONSTRAINT CK_Pagos_Monto CHECK (Monto > 0)
);
GO

-- =========================================================
-- TABLA: Envios
-- =========================================================
CREATE TABLE dbo.Envios
(
    EnvioId BIGINT IDENTITY(1,1) NOT NULL,
    PedidoId BIGINT NOT NULL,
    EmpresaEnvio NVARCHAR(100) NULL,
    NumeroSeguimiento NVARCHAR(100) NULL,
    EstadoEnvio NVARCHAR(20) NOT NULL DEFAULT 'Pendiente',
    FechaEnvio DATETIME2(0) NULL,
    FechaEntrega DATETIME2(0) NULL,
    FechaCreacion DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),

    CONSTRAINT PK_Envios PRIMARY KEY (EnvioId),
    CONSTRAINT FK_Envios_Pedidos 
        FOREIGN KEY (PedidoId) REFERENCES dbo.Pedidos(PedidoId),
    CONSTRAINT CK_Envios_Estado 
        CHECK (EstadoEnvio IN ('Pendiente', 'EnTransito', 'Entregado', 'Cancelado'))
);
GO