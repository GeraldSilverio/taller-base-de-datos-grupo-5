# 🛒 TiendaOnlineDb

## Proyecto Final — Diseño, Implementación y Optimización de una Base de Datos para Tienda Online

![SQL Server](https://img.shields.io/badge/SQL%20Server-Database-red)
![T-SQL](https://img.shields.io/badge/T--SQL-Scripts-blue)
![Status](https://img.shields.io/badge/Estado-Completado-success)
![Backup](https://img.shields.io/badge/Backup-.bak-orange)

---

## 📌 Descripción

**TiendaOnlineDb** es una base de datos relacional diseñada para administrar las operaciones principales de una tienda online.

El proyecto contempla el diseño de tablas, relaciones, restricciones, seguridad por roles, carga de datos transaccionales, consultas complejas, optimización mediante índices y respaldo completo de la base de datos.

La solución fue desarrollada en **SQL Server** utilizando **T-SQL**, aplicando buenas prácticas de administración de bases de datos, integridad referencial y organización de scripts.

---

## 🎯 Objetivo del proyecto

Diseñar e implementar una base de datos completa para una tienda online que permita gestionar:

* Clientes
* Direcciones
* Productos
* Categorías
* Inventario
* Pedidos
* Detalles de pedidos
* Pagos
* Envíos
* Seguridad por roles
* Consultas analíticas
* Optimización de rendimiento
* Respaldo completo

---

## 🧰 Tecnologías utilizadas

| Tecnología                   | Uso                                            |
| ---------------------------- | ---------------------------------------------- |
| SQL Server                   | Motor de base de datos                         |
| SQL Server Management Studio | Administración y ejecución de scripts          |
| T-SQL                        | Creación de tablas, consultas, roles e índices |
| JSON en SQL Server           | Búsquedas dinámicas                            |
| Execution Plan               | Análisis de rendimiento                        |
| Backup `.bak`                | Respaldo completo de la base de datos          |

---

## 🗄️ Base de datos

```sql
TiendaOnlineDb
```

---

## 📁 Estructura del proyecto

```text
TiendaOnlineDb/
│
├── README.md
│
├── scripts/
│   ├── 01_creacion_base_datos_y_tablas.sql
│   ├── 02_seguridad_roles_permisos.sql
│   ├── 03_insertar_datos_prueba.sql
│   ├── 04_consultas_complejas.sql
│   ├── 05_optimizacion_indices.sql
│   ├── 06_respaldo_completo.sql
│
├── diagramas/
│   └── Diagrama_ER_TiendaOnlineDb.pdf
│
└── backup/
    └── TiendaOnlineDb_BackupCompleto.bak
```

---

# 🧩 Modelo de base de datos

## Entidades principales

| Tabla                 | Descripción                                       |
| --------------------- | ------------------------------------------------- |
| `Clientes`            | Registra la información principal de los clientes |
| `DireccionesCliente`  | Guarda direcciones de envío y facturación         |
| `Categorias`          | Clasifica los productos de la tienda              |
| `Productos`           | Contiene el catálogo de productos                 |
| `ProductosCategorias` | Relaciona productos con categorías                |
| `Almacenes`           | Representa ubicaciones físicas de almacenamiento  |
| `Inventario`          | Controla existencias por producto y almacén       |
| `Pedidos`             | Registra las órdenes realizadas por clientes      |
| `DetallesPedido`      | Contiene los productos incluidos en cada pedido   |
| `Pagos`               | Registra pagos asociados a pedidos                |
| `Envios`              | Administra información de envío y entrega         |

---

## 🔗 Relaciones principales

```text
Clientes 1 ---- N DireccionesCliente
Clientes 1 ---- N Pedidos

Categorias 1 ---- N Categorias
Productos N ---- N Categorias mediante ProductosCategorias

Productos 1 ---- N Inventario
Almacenes 1 ---- N Inventario

Pedidos 1 ---- N DetallesPedido
Productos 1 ---- N DetallesPedido

Pedidos 1 ---- N Pagos
Pedidos 1 ---- N Envios
```

---

# 📖 Diccionario de datos

## Tabla: `Clientes`

| Campo                | Tipo              | Descripción                     |
| -------------------- | ----------------- | ------------------------------- |
| `ClienteId`          | `BIGINT IDENTITY` | Identificador único del cliente |
| `Nombre`             | `NVARCHAR(100)`   | Nombre del cliente              |
| `Apellido`           | `NVARCHAR(100)`   | Apellido del cliente            |
| `Correo`             | `NVARCHAR(255)`   | Correo electrónico único        |
| `Telefono`           | `NVARCHAR(25)`    | Teléfono de contacto            |
| `FechaNacimiento`    | `DATE`            | Fecha de nacimiento             |
| `EstadoCliente`      | `NVARCHAR(20)`    | Estado del cliente              |
| `FechaCreacion`      | `DATETIME2(0)`    | Fecha de creación               |
| `FechaActualizacion` | `DATETIME2(0)`    | Última actualización            |
| `EstaEliminado`      | `BIT`             | Eliminación lógica              |

Estados permitidos:

```text
Activo, Inactivo, Bloqueado
```

---

## Tabla: `DireccionesCliente`

| Campo           | Tipo              | Descripción                         |
| --------------- | ----------------- | ----------------------------------- |
| `DireccionId`   | `BIGINT IDENTITY` | Identificador de la dirección       |
| `ClienteId`     | `BIGINT`          | Cliente relacionado                 |
| `TipoDireccion` | `NVARCHAR(20)`    | Tipo de dirección                   |
| `Direccion`     | `NVARCHAR(255)`   | Dirección física                    |
| `Ciudad`        | `NVARCHAR(100)`   | Ciudad                              |
| `Provincia`     | `NVARCHAR(100)`   | Provincia                           |
| `CodigoPostal`  | `NVARCHAR(20)`    | Código postal                       |
| `Pais`          | `NVARCHAR(100)`   | País                                |
| `EsPrincipal`   | `BIT`             | Indica si es la dirección principal |
| `FechaCreacion` | `DATETIME2(0)`    | Fecha de creación                   |

Tipos permitidos:

```text
Facturacion, Envio
```

---

## Tabla: `Categorias`

| Campo                | Tipo            | Descripción            |
| -------------------- | --------------- | ---------------------- |
| `CategoriaId`        | `INT IDENTITY`  | Identificador único    |
| `CategoriaPadreId`   | `INT`           | Categoría padre        |
| `Nombre`             | `NVARCHAR(100)` | Nombre de categoría    |
| `Slug`               | `NVARCHAR(120)` | Identificador amigable |
| `Descripcion`        | `NVARCHAR(500)` | Descripción            |
| `OrdenVisualizacion` | `INT`           | Orden visual           |
| `EstaActiva`         | `BIT`           | Estado de la categoría |
| `FechaCreacion`      | `DATETIME2(0)`  | Fecha de creación      |
| `FechaActualizacion` | `DATETIME2(0)`  | Última actualización   |

---

## Tabla: `Productos`

| Campo                | Tipo              | Descripción               |
| -------------------- | ----------------- | ------------------------- |
| `ProductoId`         | `BIGINT IDENTITY` | Identificador único       |
| `CodigoProducto`     | `NVARCHAR(50)`    | Código único del producto |
| `Nombre`             | `NVARCHAR(150)`   | Nombre del producto       |
| `Slug`               | `NVARCHAR(180)`   | Identificador amigable    |
| `Descripcion`        | `NVARCHAR(MAX)`   | Descripción completa      |
| `PrecioVenta`        | `DECIMAL(18,2)`   | Precio de venta           |
| `PrecioCosto`        | `DECIMAL(18,2)`   | Costo del producto        |
| `PorcentajeImpuesto` | `DECIMAL(5,2)`    | Impuesto aplicado         |
| `EstadoProducto`     | `NVARCHAR(20)`    | Estado del producto       |
| `FechaCreacion`      | `DATETIME2(0)`    | Fecha de creación         |
| `FechaActualizacion` | `DATETIME2(0)`    | Última actualización      |
| `EstaEliminado`      | `BIT`             | Eliminación lógica        |

Estados permitidos:

```text
Borrador, Activo, Inactivo, Descontinuado
```

---

## Tabla: `ProductosCategorias`

| Campo           | Tipo           | Descripción           |
| --------------- | -------------- | --------------------- |
| `ProductoId`    | `BIGINT`       | Producto relacionado  |
| `CategoriaId`   | `INT`          | Categoría relacionada |
| `FechaCreacion` | `DATETIME2(0)` | Fecha de creación     |

Esta tabla permite una relación **muchos a muchos** entre productos y categorías.

---

## Tabla: `Almacenes`

| Campo           | Tipo            | Descripción               |
| --------------- | --------------- | ------------------------- |
| `AlmacenId`     | `INT IDENTITY`  | Identificador del almacén |
| `Nombre`        | `NVARCHAR(100)` | Nombre del almacén        |
| `Ubicacion`     | `NVARCHAR(255)` | Ubicación física          |
| `EstaActivo`    | `BIT`           | Estado del almacén        |
| `FechaCreacion` | `DATETIME2(0)`  | Fecha de creación         |

---

## Tabla: `Inventario`

| Campo                      | Tipo              | Descripción                  |
| -------------------------- | ----------------- | ---------------------------- |
| `InventarioId`             | `BIGINT IDENTITY` | Identificador único          |
| `ProductoId`               | `BIGINT`          | Producto relacionado         |
| `AlmacenId`                | `INT`             | Almacén relacionado          |
| `CantidadDisponible`       | `INT`             | Cantidad registrada          |
| `CantidadReservada`        | `INT`             | Cantidad reservada           |
| `CantidadReal`             | Campo calculado   | Disponible menos reservado   |
| `NivelReorden`             | `INT`             | Nivel mínimo para reposición |
| `FechaUltimaActualizacion` | `DATETIME2(0)`    | Última actualización         |

---

## Tabla: `Pedidos`

| Campo                    | Tipo              | Descripción                     |
| ------------------------ | ----------------- | ------------------------------- |
| `PedidoId`               | `BIGINT IDENTITY` | Identificador del pedido        |
| `NumeroPedido`           | `NVARCHAR(30)`    | Número único del pedido         |
| `ClienteId`              | `BIGINT`          | Cliente que realizó el pedido   |
| `DireccionFacturacionId` | `BIGINT`          | Dirección de facturación        |
| `DireccionEnvioId`       | `BIGINT`          | Dirección de envío              |
| `EstadoPedido`           | `NVARCHAR(20)`    | Estado del pedido               |
| `Subtotal`               | `DECIMAL(18,2)`   | Monto antes de impuesto y envío |
| `Descuento`              | `DECIMAL(18,2)`   | Descuento aplicado              |
| `CostoEnvio`             | `DECIMAL(18,2)`   | Costo de envío                  |
| `Impuesto`               | `DECIMAL(18,2)`   | Impuesto aplicado               |
| `Total`                  | `DECIMAL(18,2)`   | Total final                     |
| `CodigoMoneda`           | `CHAR(3)`         | Moneda                          |
| `Notas`                  | `NVARCHAR(500)`   | Observaciones                   |
| `FechaCreacion`          | `DATETIME2(0)`    | Fecha de creación               |
| `FechaActualizacion`     | `DATETIME2(0)`    | Última actualización            |

Estados permitidos:

```text
Pendiente, Pagado, Procesando, Enviado, Completado, Cancelado, Reembolsado
```

---

## Tabla: `DetallesPedido`

| Campo                    | Tipo              | Descripción                                |
| ------------------------ | ----------------- | ------------------------------------------ |
| `DetallePedidoId`        | `BIGINT IDENTITY` | Identificador del detalle                  |
| `PedidoId`               | `BIGINT`          | Pedido relacionado                         |
| `ProductoId`             | `BIGINT`          | Producto comprado                          |
| `CodigoProductoSnapshot` | `NVARCHAR(50)`    | Código del producto al momento de la venta |
| `NombreProductoSnapshot` | `NVARCHAR(150)`   | Nombre del producto al momento de la venta |
| `Cantidad`               | `INT`             | Cantidad comprada                          |
| `PrecioUnitario`         | `DECIMAL(18,2)`   | Precio unitario                            |
| `Descuento`              | `DECIMAL(18,2)`   | Descuento aplicado                         |
| `Impuesto`               | `DECIMAL(18,2)`   | Impuesto aplicado                          |
| `TotalLinea`             | Campo calculado   | Total de la línea                          |

---

## Tabla: `Pagos`

| Campo                   | Tipo              | Descripción               |
| ----------------------- | ----------------- | ------------------------- |
| `PagoId`                | `BIGINT IDENTITY` | Identificador del pago    |
| `PedidoId`              | `BIGINT`          | Pedido relacionado        |
| `MetodoPago`            | `NVARCHAR(30)`    | Método de pago            |
| `EstadoPago`            | `NVARCHAR(20)`    | Estado del pago           |
| `Monto`                 | `DECIMAL(18,2)`   | Monto pagado              |
| `ReferenciaTransaccion` | `NVARCHAR(100)`   | Referencia de transacción |
| `FechaPago`             | `DATETIME2(0)`    | Fecha del pago            |
| `FechaCreacion`         | `DATETIME2(0)`    | Fecha de creación         |

Métodos permitidos:

```text
Efectivo, Tarjeta, Transferencia, PayPal, Otro
```

Estados permitidos:

```text
Pendiente, Aprobado, Rechazado, Reembolsado
```

---

## Tabla: `Envios`

| Campo               | Tipo              | Descripción             |
| ------------------- | ----------------- | ----------------------- |
| `EnvioId`           | `BIGINT IDENTITY` | Identificador del envío |
| `PedidoId`          | `BIGINT`          | Pedido relacionado      |
| `EmpresaEnvio`      | `NVARCHAR(100)`   | Empresa de envío        |
| `NumeroSeguimiento` | `NVARCHAR(100)`   | Número de seguimiento   |
| `EstadoEnvio`       | `NVARCHAR(20)`    | Estado del envío        |
| `FechaEnvio`        | `DATETIME2(0)`    | Fecha de envío          |
| `FechaEntrega`      | `DATETIME2(0)`    | Fecha de entrega        |
| `FechaCreacion`     | `DATETIME2(0)`    | Fecha de creación       |

Estados permitidos:

```text
Pendiente, EnTransito, Entregado, Cancelado
```

---

# 🔐 Seguridad: roles y permisos

La base de datos implementa seguridad mediante roles para limitar el acceso según el tipo de usuario.

## Roles creados

| Rol           | Descripción                                                     |
| ------------- | --------------------------------------------------------------- |
| `RolGerente`  | Usuario administrativo con control completo                     |
| `RolVendedor` | Usuario operativo para registrar ventas y consultar información |
| `RolCliente`  | Usuario final con acceso limitado a compras y consultas         |

---

## Matriz de permisos

| Recurso             |                     RolGerente |            RolVendedor |             RolCliente |
| ------------------- | -----------------------------: | ---------------------: | ---------------------: |
| Clientes            | SELECT, INSERT, UPDATE, DELETE | SELECT, INSERT, UPDATE | SELECT, INSERT, UPDATE |
| DireccionesCliente  | SELECT, INSERT, UPDATE, DELETE | SELECT, INSERT, UPDATE | SELECT, INSERT, UPDATE |
| Categorias          | SELECT, INSERT, UPDATE, DELETE |                 SELECT |                 SELECT |
| Productos           | SELECT, INSERT, UPDATE, DELETE |                 SELECT |                 SELECT |
| ProductosCategorias | SELECT, INSERT, UPDATE, DELETE |                 SELECT |                 SELECT |
| Almacenes           | SELECT, INSERT, UPDATE, DELETE |                 SELECT |                     No |
| Inventario          | SELECT, INSERT, UPDATE, DELETE |         SELECT, UPDATE |                     No |
| Pedidos             | SELECT, INSERT, UPDATE, DELETE | SELECT, INSERT, UPDATE |         SELECT, INSERT |
| DetallesPedido      | SELECT, INSERT, UPDATE, DELETE | SELECT, INSERT, UPDATE |         SELECT, INSERT |
| Pagos               | SELECT, INSERT, UPDATE, DELETE | SELECT, INSERT, UPDATE |                 SELECT |
| Envios              | SELECT, INSERT, UPDATE, DELETE | SELECT, INSERT, UPDATE |                 SELECT |

---

# 🧪 Datos de prueba

El proyecto incluye scripts para cargar datos de prueba transaccionales.

## Datos insertados

| Elemento                 | Cantidad |
| ------------------------ | -------: |
| Clientes                 |        5 |
| Productos con inventario |       10 |
| Productos sin inventario |        5 |
| Pedidos                  |        8 |
| Categorías               |        5 |
| Almacenes                |        2 |
| Pagos                    |        8 |
| Envíos                   |        8 |

Los productos `SKU-011` hasta `SKU-015` fueron creados sin registros en la tabla `Inventario`, con el objetivo de probar la consulta de productos sin inventario.

---

# 🔎 Consultas complejas

El proyecto incluye consultas SQL para análisis de información:

| Consulta                 | Objetivo                                            |
| ------------------------ | --------------------------------------------------- |
| Clientes con más compras | Identificar clientes con mayor volumen de compra    |
| Productos sin inventario | Detectar productos sin existencias registradas      |
| Ingresos por mes         | Calcular ingresos agrupados por período             |
| Productos más vendidos   | Obtener ranking de productos por cantidad vendida   |
| Búsqueda con JSON        | Filtrar productos usando parámetros en formato JSON |

---

# ⚡ Optimización

Se crearon índices para mejorar el rendimiento de las consultas principales.

## Índices recomendados

```text
IX_Pedidos_Estado_Fecha_Cliente
IX_Pedidos_Cliente_Estado_Total
IX_DetallesPedido_Producto_Pedido
IX_DetallesPedido_Pedido_Producto
IX_Inventario_Producto_CantidadReal
IX_Productos_Estado_Eliminado_Nombre
IX_ProductosCategorias_Categoria_Producto
IX_Categorias_Slug_Nombre
IX_Pagos_Estado_Fecha
```

## Evidencia de optimización

Para demostrar la mejora de rendimiento se deben capturar:

* Plan de ejecución antes de crear índices
* Plan de ejecución después de crear índices
* Estadísticas de lectura con `SET STATISTICS IO ON`
* Estadísticas de tiempo con `SET STATISTICS TIME ON`

---

# 💾 Respaldo

El proyecto incluye un script para generar respaldo completo de la base de datos en formato `.bak`.

Ruta recomendada:

```text
C:\SQLBackups\TiendaOnlineDb_BackupCompleto.bak
```

Comando principal:

```sql
BACKUP DATABASE TiendaOnlineDb
TO DISK = 'C:\SQLBackups\TiendaOnlineDb_BackupCompleto.bak'
WITH 
    FORMAT,
    INIT,
    NAME = 'Respaldo Completo - TiendaOnlineDb',
    CHECKSUM,
    STATS = 10;
```

Validación del respaldo:

```sql
RESTORE VERIFYONLY
FROM DISK = 'C:\SQLBackups\TiendaOnlineDb_BackupCompleto.bak'
WITH CHECKSUM;
```

---

# 🚀 Instrucciones de ejecución

## 1. Crear la base de datos y tablas

Ejecutar:

```text
scripts/01_creacion_base_datos_y_tablas.sql
```

Este script crea la base `TiendaOnlineDb`, sus tablas, llaves primarias, llaves foráneas, restricciones y campos calculados.

---

## 2. Crear roles y permisos

Ejecutar:

```text
scripts/02_seguridad_roles_permisos.sql
```

Este script crea los roles:

```text
RolGerente
RolVendedor
RolCliente
```

y asigna permisos según las responsabilidades de cada usuario.

---

## 3. Insertar datos de prueba

Ejecutar:

```text
scripts/03_insertar_datos_prueba.sql
```

Este script carga clientes, productos, categorías, inventario, pedidos, pagos y envíos.

---

## 4. Validar datos insertados

Ejecutar:

```text
scripts/08_validaciones.sql
```

Consultas rápidas:

```sql
SELECT COUNT(*) AS TotalClientes FROM dbo.Clientes;
SELECT COUNT(*) AS TotalProductos FROM dbo.Productos;
SELECT COUNT(*) AS TotalPedidos FROM dbo.Pedidos;
SELECT COUNT(*) AS TotalPagos FROM dbo.Pagos;
SELECT COUNT(*) AS TotalEnvios FROM dbo.Envios;
```

---

## 5. Ejecutar consultas complejas

Ejecutar:

```text
scripts/05_consultas_complejas.sql
```

Este script contiene consultas de análisis para validar el funcionamiento del modelo.

---

## 6. Optimizar consultas

Antes de crear índices:

```sql
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
```

Activar en SSMS:

```text
Query > Include Actual Execution Plan
```

o presionar:

```text
Ctrl + M
```

Luego ejecutar:

```text
scripts/06_optimizacion_indices.sql
```

Después, volver a ejecutar las consultas complejas y comparar los planes de ejecución.

---

## 7. Generar respaldo

Crear la carpeta:

```text
C:\SQLBackups
```

Ejecutar:

```text
scripts/07_respaldo_completo.sql
```

Luego validar:

```sql
RESTORE VERIFYONLY
FROM DISK = 'C:\SQLBackups\TiendaOnlineDb_BackupCompleto.bak'
WITH CHECKSUM;
```

---

## 8. Generar diagrama ER

En SQL Server Management Studio:

1. Expandir `TiendaOnlineDb`
2. Abrir `Database Diagrams`
3. Seleccionar `New Database Diagram`
4. Agregar todas las tablas principales
5. Organizar visualmente las relaciones
6. Guardar como `Diagrama_ER_TiendaOnlineDb`
7. Exportar con `Microsoft Print to PDF`

---

# ✅ Orden recomendado de ejecución

```text
1. 01_creacion_base_datos_y_tablas.sql
2. 02_seguridad_roles_permisos.sql
3. 03_insertar_datos_prueba.sql
4. 08_validaciones.sql
5. 05_consultas_complejas.sql
6. 06_optimizacion_indices.sql
7. 07_respaldo_completo.sql
```

Para reiniciar los datos de prueba:

```text
1. 04_eliminar_datos_prueba.sql
2. 03_insertar_datos_prueba.sql
```

---

# 🧾 Evidencias sugeridas

Para documentar correctamente el proyecto se recomienda incluir:

* Captura del diagrama ER
* Captura de tablas creadas en SSMS
* Captura de roles creados
* Captura de consultas complejas ejecutadas
* Captura de productos sin inventario
* Captura del plan de ejecución antes de índices
* Captura del plan de ejecución después de índices
* Captura del respaldo `.bak` generado
* Captura de validación `RESTORE VERIFYONLY`

---

# 🛠️ Notas importantes

## Corrección de nombre de tabla

Si la tabla de clientes fue creada como `Cliente` en singular, se recomienda corregirla a `Clientes`:

```sql
IF OBJECT_ID('dbo.Cliente', 'U') IS NOT NULL
   AND OBJECT_ID('dbo.Clientes', 'U') IS NULL
BEGIN
    EXEC sp_rename 'dbo.Cliente', 'Clientes';
END;
GO
```

Esto evita errores con las llaves foráneas que apuntan a `dbo.Clientes`.

---

## Permisos para backup

Si aparece el error:

```text
Operating system error 5(Access is denied.)
```

se recomienda usar una ruta como:

```text
C:\SQLBackups
```

y dar permisos al servicio de SQL Server sobre esa carpeta.

---

# 📌 Conclusión

El proyecto **TiendaOnlineDb** representa una solución completa para la administración de una tienda online. Su diseño permite controlar clientes, productos, inventario, pedidos, pagos y envíos de forma estructurada.

Además, incorpora seguridad mediante roles, datos de prueba transaccionales, consultas complejas, optimización por índices y respaldo completo de la base de datos.

Este proyecto demuestra el uso práctico de SQL Server en un escenario realista de comercio electrónico, aplicando buenas prácticas de diseño, administración, seguridad y rendimiento de bases de datos.


