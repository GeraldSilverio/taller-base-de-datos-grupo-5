USE TiendaOnlineDb;
GO

-- =========================================================
-- CREACION DE ROLES
-- =========================================================

IF NOT EXISTS (
    SELECT 1 
    FROM sys.database_principals 
    WHERE name = 'RolGerente' AND type = 'R'
)
BEGIN
    CREATE ROLE RolGerente;
END;
GO

IF NOT EXISTS (
    SELECT 1 
    FROM sys.database_principals 
    WHERE name = 'RolVendedor' AND type = 'R'
)
BEGIN
    CREATE ROLE RolVendedor;
END;
GO

IF NOT EXISTS (
    SELECT 1 
    FROM sys.database_principals 
    WHERE name = 'RolCliente' AND type = 'R'
)
BEGIN
    CREATE ROLE RolCliente;
END;
GO

-- =========================================================
-- PERMISOS PARA ROL GERENTE
-- El gerente puede consultar, insertar, actualizar y eliminar
-- informacion en todas las tablas del sistema.
-- =========================================================

GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Clientes TO RolGerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.DireccionesCliente TO RolGerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Categorias TO RolGerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Productos TO RolGerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.ProductosCategorias TO RolGerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Almacenes TO RolGerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Inventario TO RolGerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Pedidos TO RolGerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.DetallesPedido TO RolGerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Pagos TO RolGerente;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Envios TO RolGerente;
GO

-- =========================================================
-- PERMISOS PARA ROL VENDEDOR
-- El vendedor puede consultar informacion general,
-- registrar clientes, crear pedidos, registrar pagos,
-- actualizar estados y reservar inventario.
-- No puede eliminar informacion.
-- =========================================================

GRANT SELECT ON dbo.Clientes TO RolVendedor;
GRANT INSERT, UPDATE ON dbo.Clientes TO RolVendedor;

GRANT SELECT ON dbo.DireccionesCliente TO RolVendedor;
GRANT INSERT, UPDATE ON dbo.DireccionesCliente TO RolVendedor;

GRANT SELECT ON dbo.Categorias TO RolVendedor;
GRANT SELECT ON dbo.Productos TO RolVendedor;
GRANT SELECT ON dbo.ProductosCategorias TO RolVendedor;
GRANT SELECT ON dbo.Almacenes TO RolVendedor;

GRANT SELECT ON dbo.Inventario TO RolVendedor;
GRANT UPDATE ON dbo.Inventario TO RolVendedor;

GRANT SELECT, INSERT, UPDATE ON dbo.Pedidos TO RolVendedor;
GRANT SELECT, INSERT, UPDATE ON dbo.DetallesPedido TO RolVendedor;
GRANT SELECT, INSERT, UPDATE ON dbo.Pagos TO RolVendedor;
GRANT SELECT, INSERT, UPDATE ON dbo.Envios TO RolVendedor;

DENY DELETE ON dbo.Clientes TO RolVendedor;
DENY DELETE ON dbo.DireccionesCliente TO RolVendedor;
DENY DELETE ON dbo.Categorias TO RolVendedor;
DENY DELETE ON dbo.Productos TO RolVendedor;
DENY DELETE ON dbo.ProductosCategorias TO RolVendedor;
DENY DELETE ON dbo.Almacenes TO RolVendedor;
DENY DELETE ON dbo.Inventario TO RolVendedor;
DENY DELETE ON dbo.Pedidos TO RolVendedor;
DENY DELETE ON dbo.DetallesPedido TO RolVendedor;
DENY DELETE ON dbo.Pagos TO RolVendedor;
DENY DELETE ON dbo.Envios TO RolVendedor;
GO

-- =========================================================
-- PERMISOS PARA ROL CLIENTE
-- El cliente puede consultar productos, categorias,
-- crear pedidos, registrar sus datos y consultar sus pagos/envios.
-- No puede eliminar informacion ni modificar productos/inventario.
-- =========================================================

GRANT SELECT ON dbo.Categorias TO RolCliente;
GRANT SELECT ON dbo.Productos TO RolCliente;
GRANT SELECT ON dbo.ProductosCategorias TO RolCliente;

GRANT SELECT, INSERT, UPDATE ON dbo.Clientes TO RolCliente;
GRANT SELECT, INSERT, UPDATE ON dbo.DireccionesCliente TO RolCliente;

GRANT SELECT, INSERT ON dbo.Pedidos TO RolCliente;
GRANT SELECT, INSERT ON dbo.DetallesPedido TO RolCliente;

GRANT SELECT ON dbo.Pagos TO RolCliente;
GRANT SELECT ON dbo.Envios TO RolCliente;

DENY INSERT, UPDATE, DELETE ON dbo.Categorias TO RolCliente;
DENY INSERT, UPDATE, DELETE ON dbo.Productos TO RolCliente;
DENY INSERT, UPDATE, DELETE ON dbo.ProductosCategorias TO RolCliente;
DENY INSERT, UPDATE, DELETE ON dbo.Almacenes TO RolCliente;
DENY INSERT, UPDATE, DELETE ON dbo.Inventario TO RolCliente;
DENY DELETE ON dbo.Clientes TO RolCliente;
DENY DELETE ON dbo.DireccionesCliente TO RolCliente;
DENY UPDATE, DELETE ON dbo.Pedidos TO RolCliente;
DENY UPDATE, DELETE ON dbo.DetallesPedido TO RolCliente;
DENY INSERT, UPDATE, DELETE ON dbo.Pagos TO RolCliente;
DENY INSERT, UPDATE, DELETE ON dbo.Envios TO RolCliente;
GO