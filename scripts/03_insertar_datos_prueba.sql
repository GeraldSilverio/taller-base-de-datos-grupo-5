USE TiendaOnlineDb;
GO

SET XACT_ABORT ON;
GO

BEGIN TRY
    BEGIN TRANSACTION;

    -- =====================================================
    -- INSERTAR CATEGORIAS
    -- =====================================================

    INSERT INTO dbo.Categorias
    (
        Nombre, 
        Slug, 
        Descripcion, 
        OrdenVisualizacion
    )
    VALUES
    ('Electronicos', 'electronicos', 'Productos tecnologicos y electronicos', 1),
    ('Computadoras', 'computadoras', 'Laptops, desktops y accesorios de computadora', 2),
    ('Telefonos', 'telefonos', 'Celulares y accesorios moviles', 3),
    ('Hogar', 'hogar', 'Productos para el hogar', 4),
    ('Accesorios', 'accesorios', 'Accesorios generales para diferentes productos', 5);

    -- =====================================================
    -- INSERTAR ALMACENES
    -- =====================================================

    INSERT INTO dbo.Almacenes
    (
        Nombre, 
        Ubicacion
    )
    VALUES
    ('Almacen Principal', 'Santo Domingo, Republica Dominicana'),
    ('Almacen Santiago', 'Santiago, Republica Dominicana');

    -- =====================================================
    -- INSERTAR CLIENTES
    -- =====================================================

    INSERT INTO dbo.Clientes
    (
        Nombre, 
        Apellido, 
        Correo, 
        Telefono, 
        FechaNacimiento
    )
    VALUES
    ('Carlos', 'Mendez', 'carlos.mendez@email.com', '809-555-1001', '1995-04-12'),
    ('Laura', 'Perez', 'laura.perez@email.com', '809-555-1002', '1998-09-25'),
    ('Miguel', 'Santos', 'miguel.santos@email.com', '809-555-1003', '1990-02-18'),
    ('Ana', 'Rodriguez', 'ana.rodriguez@email.com', '809-555-1004', '1997-07-30'),
    ('Jose', 'Ramirez', 'jose.ramirez@email.com', '809-555-1005', '1992-11-08');

    -- =====================================================
    -- INSERTAR DIRECCIONES
    -- =====================================================

    INSERT INTO dbo.DireccionesCliente
    (
        ClienteId,
        TipoDireccion,
        Direccion,
        Ciudad,
        Provincia,
        CodigoPostal,
        Pais,
        EsPrincipal
    )
    SELECT ClienteId, 'Envio', 'Av. Winston Churchill #25', 'Santo Domingo', 'Distrito Nacional', '10101', 'Republica Dominicana', 1
    FROM dbo.Clientes
    WHERE Correo = 'carlos.mendez@email.com';

    INSERT INTO dbo.DireccionesCliente
    (
        ClienteId,
        TipoDireccion,
        Direccion,
        Ciudad,
        Provincia,
        CodigoPostal,
        Pais,
        EsPrincipal
    )
    SELECT ClienteId, 'Envio', 'Calle Duarte #14', 'Santiago', 'Santiago', '51000', 'Republica Dominicana', 1
    FROM dbo.Clientes
    WHERE Correo = 'laura.perez@email.com';

    INSERT INTO dbo.DireccionesCliente
    (
        ClienteId,
        TipoDireccion,
        Direccion,
        Ciudad,
        Provincia,
        CodigoPostal,
        Pais,
        EsPrincipal
    )
    SELECT ClienteId, 'Envio', 'Calle Las Palmas #8', 'La Vega', 'La Vega', '41000', 'Republica Dominicana', 1
    FROM dbo.Clientes
    WHERE Correo = 'miguel.santos@email.com';

    INSERT INTO dbo.DireccionesCliente
    (
        ClienteId,
        TipoDireccion,
        Direccion,
        Ciudad,
        Provincia,
        CodigoPostal,
        Pais,
        EsPrincipal
    )
    SELECT ClienteId, 'Envio', 'Av. Espana #72', 'Santo Domingo Este', 'Santo Domingo', '11500', 'Republica Dominicana', 1
    FROM dbo.Clientes
    WHERE Correo = 'ana.rodriguez@email.com';

    INSERT INTO dbo.DireccionesCliente
    (
        ClienteId,
        TipoDireccion,
        Direccion,
        Ciudad,
        Provincia,
        CodigoPostal,
        Pais,
        EsPrincipal
    )
    SELECT ClienteId, 'Envio', 'Calle Restauracion #19', 'San Cristobal', 'San Cristobal', '91000', 'Republica Dominicana', 1
    FROM dbo.Clientes
    WHERE Correo = 'jose.ramirez@email.com';

    -- =====================================================
    -- INSERTAR PRODUCTOS
    -- SKU-001 HASTA SKU-010 TENDRAN INVENTARIO
    -- SKU-011 HASTA SKU-015 NO TENDRAN INVENTARIO
    -- =====================================================

    INSERT INTO dbo.Productos
    (
        CodigoProducto,
        Nombre,
        Slug,
        Descripcion,
        PrecioVenta,
        PrecioCosto,
        PorcentajeImpuesto,
        EstadoProducto
    )
    VALUES
    ('SKU-001', 'Laptop Lenovo IdeaPad 15', 'laptop-lenovo-ideapad-15', 'Laptop para trabajo, estudio y uso diario.', 38500.00, 32000.00, 18.00, 'Activo'),
    ('SKU-002', 'Mouse Logitech Inalambrico', 'mouse-logitech-inalambrico', 'Mouse inalambrico ergonomico.', 1250.00, 750.00, 18.00, 'Activo'),
    ('SKU-003', 'Teclado Mecanico Redragon', 'teclado-mecanico-redragon', 'Teclado mecanico con iluminacion RGB.', 2800.00, 1900.00, 18.00, 'Activo'),
    ('SKU-004', 'Monitor Samsung 24 Pulgadas', 'monitor-samsung-24', 'Monitor Full HD de 24 pulgadas.', 9800.00, 7900.00, 18.00, 'Activo'),
    ('SKU-005', 'Audifonos Bluetooth Sony', 'audifonos-bluetooth-sony', 'Audifonos inalambricos con microfono.', 4500.00, 3300.00, 18.00, 'Activo'),
    ('SKU-006', 'Smartphone Samsung Galaxy A35', 'smartphone-samsung-galaxy-a35', 'Telefono inteligente Samsung Galaxy A35.', 22500.00, 19000.00, 18.00, 'Activo'),
    ('SKU-007', 'Cargador USB-C Rapido', 'cargador-usb-c-rapido', 'Cargador rapido USB-C de 25W.', 950.00, 500.00, 18.00, 'Activo'),
    ('SKU-008', 'Silla Ergonomica Oficina', 'silla-ergonomica-oficina', 'Silla ergonomica para oficina o estudio.', 7800.00, 5900.00, 18.00, 'Activo'),
    ('SKU-009', 'Disco SSD Kingston 1TB', 'disco-ssd-kingston-1tb', 'Unidad de almacenamiento SSD de 1TB.', 5200.00, 4100.00, 18.00, 'Activo'),
    ('SKU-010', 'Impresora HP Multifuncional', 'impresora-hp-multifuncional', 'Impresora multifuncional para hogar y oficina.', 6900.00, 5400.00, 18.00, 'Activo'),

    -- Productos sin inventario
    ('SKU-011', 'Tablet Samsung Galaxy Tab A9', 'tablet-samsung-galaxy-tab-a9', 'Tablet Samsung para estudio, entretenimiento y trabajo ligero.', 14500.00, 11200.00, 18.00, 'Activo'),
    ('SKU-012', 'Camara Web Logitech C920', 'camara-web-logitech-c920', 'Camara web Full HD ideal para reuniones virtuales y clases en linea.', 4200.00, 3100.00, 18.00, 'Activo'),
    ('SKU-013', 'Router TP-Link Archer AX10', 'router-tplink-archer-ax10', 'Router WiFi 6 para mejor cobertura y velocidad en el hogar.', 5300.00, 3900.00, 18.00, 'Activo'),
    ('SKU-014', 'Power Bank Xiaomi 20000mAh', 'power-bank-xiaomi-20000mah', 'Bateria portatil de alta capacidad para celulares y dispositivos USB.', 2600.00, 1800.00, 18.00, 'Activo'),
    ('SKU-015', 'Microfono USB Fifine', 'microfono-usb-fifine', 'Microfono USB para grabacion, reuniones, streaming y podcast.', 3500.00, 2500.00, 18.00, 'Activo');

    -- =====================================================
    -- RELACIONAR PRODUCTOS CON CATEGORIAS
    -- =====================================================

    INSERT INTO dbo.ProductosCategorias
    (
        ProductoId,
        CategoriaId
    )
    SELECT p.ProductoId, c.CategoriaId
    FROM dbo.Productos p
    INNER JOIN dbo.Categorias c 
        ON c.Slug = 'computadoras'
    WHERE p.CodigoProducto IN 
    (
        'SKU-001', 'SKU-003', 'SKU-004', 'SKU-009', 'SKU-010',
        'SKU-011', 'SKU-012', 'SKU-013', 'SKU-015'
    );

    INSERT INTO dbo.ProductosCategorias
    (
        ProductoId,
        CategoriaId
    )
    SELECT p.ProductoId, c.CategoriaId
    FROM dbo.Productos p
    INNER JOIN dbo.Categorias c 
        ON c.Slug = 'telefonos'
    WHERE p.CodigoProducto IN ('SKU-006', 'SKU-007', 'SKU-014');

    INSERT INTO dbo.ProductosCategorias
    (
        ProductoId,
        CategoriaId
    )
    SELECT p.ProductoId, c.CategoriaId
    FROM dbo.Productos p
    INNER JOIN dbo.Categorias c 
        ON c.Slug = 'accesorios'
    WHERE p.CodigoProducto IN ('SKU-002', 'SKU-005', 'SKU-007', 'SKU-014', 'SKU-015');

    INSERT INTO dbo.ProductosCategorias
    (
        ProductoId,
        CategoriaId
    )
    SELECT p.ProductoId, c.CategoriaId
    FROM dbo.Productos p
    INNER JOIN dbo.Categorias c 
        ON c.Slug = 'hogar'
    WHERE p.CodigoProducto IN ('SKU-008', 'SKU-013');

    -- =====================================================
    -- INSERTAR INVENTARIO
    -- SOLO PARA SKU-001 HASTA SKU-010
    -- =====================================================

    INSERT INTO dbo.Inventario
    (
        ProductoId,
        AlmacenId,
        CantidadDisponible,
        CantidadReservada,
        NivelReorden
    )
    SELECT 
        p.ProductoId,
        a.AlmacenId,
        CASE p.CodigoProducto
            WHEN 'SKU-001' THEN 15
            WHEN 'SKU-002' THEN 80
            WHEN 'SKU-003' THEN 35
            WHEN 'SKU-004' THEN 20
            WHEN 'SKU-005' THEN 40
            WHEN 'SKU-006' THEN 25
            WHEN 'SKU-007' THEN 100
            WHEN 'SKU-008' THEN 12
            WHEN 'SKU-009' THEN 30
            WHEN 'SKU-010' THEN 18
        END AS CantidadDisponible,
        0 AS CantidadReservada,
        5 AS NivelReorden
    FROM dbo.Productos p
    CROSS JOIN dbo.Almacenes a
    WHERE a.Nombre = 'Almacen Principal'
      AND p.CodigoProducto IN 
      (
          'SKU-001', 'SKU-002', 'SKU-003', 'SKU-004', 'SKU-005',
          'SKU-006', 'SKU-007', 'SKU-008', 'SKU-009', 'SKU-010'
      );

    -- =====================================================
    -- INSERTAR PEDIDOS DE FORMA MAS LIMPIA
    -- =====================================================

    DECLARE @PedidosPrueba TABLE
    (
        NumeroPedido NVARCHAR(30),
        CorreoCliente NVARCHAR(255),
        EstadoPedido NVARCHAR(20),
        MetodoPago NVARCHAR(30),
        EstadoPago NVARCHAR(20),
        ReferenciaTransaccion NVARCHAR(100),
        CostoEnvio DECIMAL(18,2),
        EmpresaEnvio NVARCHAR(100),
        NumeroSeguimiento NVARCHAR(100),
        EstadoEnvio NVARCHAR(20),
        Notas NVARCHAR(500)
    );

    INSERT INTO @PedidosPrueba
    VALUES
    ('ORD-2026-0001', 'carlos.mendez@email.com', 'Pagado', 'Tarjeta', 'Aprobado', 'TXN-0001', 250.00, 'MetroPack', 'TRK-0001', 'EnTransito', 'Pedido pagado correctamente.'),
    ('ORD-2026-0002', 'laura.perez@email.com', 'Procesando', 'Transferencia', 'Aprobado', 'TXN-0002', 200.00, 'Caribe Express', 'TRK-0002', 'Pendiente', 'Pedido en proceso de preparacion.'),
    ('ORD-2026-0003', 'miguel.santos@email.com', 'Enviado', 'Tarjeta', 'Aprobado', 'TXN-0003', 300.00, 'MetroPack', 'TRK-0003', 'EnTransito', 'Pedido enviado al cliente.'),
    ('ORD-2026-0004', 'ana.rodriguez@email.com', 'Pendiente', 'Transferencia', 'Pendiente', 'TXN-0004', 250.00, NULL, NULL, 'Pendiente', 'Pedido pendiente de pago.'),
    ('ORD-2026-0005', 'jose.ramirez@email.com', 'Completado', 'Efectivo', 'Aprobado', 'TXN-0005', 200.00, 'Entrega Interna', 'TRK-0005', 'Entregado', 'Pedido completado satisfactoriamente.'),
    ('ORD-2026-0006', 'carlos.mendez@email.com', 'Pagado', 'Tarjeta', 'Aprobado', 'TXN-0006', 150.00, 'Caribe Express', 'TRK-0006', 'Pendiente', 'Compra de impresora multifuncional.'),
    ('ORD-2026-0007', 'laura.perez@email.com', 'Pagado', 'PayPal', 'Aprobado', 'TXN-0007', 180.00, 'MetroPack', 'TRK-0007', 'EnTransito', 'Pedido de accesorios tecnologicos.'),
    ('ORD-2026-0008', 'miguel.santos@email.com', 'Cancelado', 'Tarjeta', 'Rechazado', 'TXN-0008', 0.00, NULL, NULL, 'Cancelado', 'Pedido cancelado por solicitud del cliente.');

    DECLARE @DetallesPrueba TABLE
    (
        NumeroPedido NVARCHAR(30),
        CodigoProducto NVARCHAR(50),
        Cantidad INT
    );

    INSERT INTO @DetallesPrueba
    VALUES
    ('ORD-2026-0001', 'SKU-001', 1),
    ('ORD-2026-0001', 'SKU-002', 1),

    ('ORD-2026-0002', 'SKU-006', 1),
    ('ORD-2026-0002', 'SKU-007', 1),

    ('ORD-2026-0003', 'SKU-004', 1),
    ('ORD-2026-0003', 'SKU-003', 1),

    ('ORD-2026-0004', 'SKU-008', 1),

    ('ORD-2026-0005', 'SKU-009', 1),
    ('ORD-2026-0005', 'SKU-005', 1),

    ('ORD-2026-0006', 'SKU-010', 1),

    ('ORD-2026-0007', 'SKU-002', 1),
    ('ORD-2026-0007', 'SKU-005', 1),
    ('ORD-2026-0007', 'SKU-007', 1),

    ('ORD-2026-0008', 'SKU-001', 1),
    ('ORD-2026-0008', 'SKU-009', 1);

    DECLARE 
        @NumeroPedido NVARCHAR(30),
        @CorreoCliente NVARCHAR(255),
        @EstadoPedido NVARCHAR(20),
        @MetodoPago NVARCHAR(30),
        @EstadoPago NVARCHAR(20),
        @ReferenciaTransaccion NVARCHAR(100),
        @CostoEnvio DECIMAL(18,2),
        @EmpresaEnvio NVARCHAR(100),
        @NumeroSeguimiento NVARCHAR(100),
        @EstadoEnvio NVARCHAR(20),
        @Notas NVARCHAR(500),
        @PedidoId BIGINT,
        @ClienteId BIGINT,
        @DireccionId BIGINT,
        @Subtotal DECIMAL(18,2),
        @Impuesto DECIMAL(18,2),
        @Total DECIMAL(18,2);

    DECLARE CursorPedidos CURSOR FOR
        SELECT 
            NumeroPedido,
            CorreoCliente,
            EstadoPedido,
            MetodoPago,
            EstadoPago,
            ReferenciaTransaccion,
            CostoEnvio,
            EmpresaEnvio,
            NumeroSeguimiento,
            EstadoEnvio,
            Notas
        FROM @PedidosPrueba;

    OPEN CursorPedidos;

    FETCH NEXT FROM CursorPedidos INTO
        @NumeroPedido,
        @CorreoCliente,
        @EstadoPedido,
        @MetodoPago,
        @EstadoPago,
        @ReferenciaTransaccion,
        @CostoEnvio,
        @EmpresaEnvio,
        @NumeroSeguimiento,
        @EstadoEnvio,
        @Notas;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @ClienteId = ClienteId
        FROM dbo.Clientes
        WHERE Correo = @CorreoCliente;

        SELECT @DireccionId = DireccionId
        FROM dbo.DireccionesCliente
        WHERE ClienteId = @ClienteId
          AND EsPrincipal = 1;

        SELECT 
            @Subtotal = SUM(dp.Cantidad * p.PrecioVenta),
            @Impuesto = SUM((dp.Cantidad * p.PrecioVenta) * (p.PorcentajeImpuesto / 100))
        FROM @DetallesPrueba dp
        INNER JOIN dbo.Productos p
            ON p.CodigoProducto = dp.CodigoProducto
        WHERE dp.NumeroPedido = @NumeroPedido;

        SET @Total = @Subtotal + @Impuesto + @CostoEnvio;

        INSERT INTO dbo.Pedidos
        (
            NumeroPedido,
            ClienteId,
            DireccionFacturacionId,
            DireccionEnvioId,
            EstadoPedido,
            Subtotal,
            Descuento,
            CostoEnvio,
            Impuesto,
            Total,
            CodigoMoneda,
            Notas
        )
        VALUES
        (
            @NumeroPedido,
            @ClienteId,
            @DireccionId,
            @DireccionId,
            @EstadoPedido,
            @Subtotal,
            0,
            @CostoEnvio,
            @Impuesto,
            @Total,
            'DOP',
            @Notas
        );

        SET @PedidoId = SCOPE_IDENTITY();

        INSERT INTO dbo.DetallesPedido
        (
            PedidoId,
            ProductoId,
            CodigoProductoSnapshot,
            NombreProductoSnapshot,
            Cantidad,
            PrecioUnitario,
            Descuento,
            Impuesto
        )
        SELECT 
            @PedidoId,
            p.ProductoId,
            p.CodigoProducto,
            p.Nombre,
            dp.Cantidad,
            p.PrecioVenta,
            0,
            (dp.Cantidad * p.PrecioVenta) * (p.PorcentajeImpuesto / 100)
        FROM @DetallesPrueba dp
        INNER JOIN dbo.Productos p
            ON p.CodigoProducto = dp.CodigoProducto
        WHERE dp.NumeroPedido = @NumeroPedido;

        INSERT INTO dbo.Pagos
        (
            PedidoId,
            MetodoPago,
            EstadoPago,
            Monto,
            ReferenciaTransaccion,
            FechaPago
        )
        VALUES
        (
            @PedidoId,
            @MetodoPago,
            @EstadoPago,
            @Total,
            @ReferenciaTransaccion,
            CASE 
                WHEN @EstadoPago = 'Aprobado' THEN SYSUTCDATETIME()
                ELSE NULL
            END
        );

        INSERT INTO dbo.Envios
        (
            PedidoId,
            EmpresaEnvio,
            NumeroSeguimiento,
            EstadoEnvio,
            FechaEnvio,
            FechaEntrega
        )
        VALUES
        (
            @PedidoId,
            @EmpresaEnvio,
            @NumeroSeguimiento,
            @EstadoEnvio,
            CASE 
                WHEN @EstadoEnvio IN ('EnTransito', 'Entregado') THEN SYSUTCDATETIME()
                ELSE NULL
            END,
            CASE 
                WHEN @EstadoEnvio = 'Entregado' THEN SYSUTCDATETIME()
                ELSE NULL
            END
        );

        FETCH NEXT FROM CursorPedidos INTO
            @NumeroPedido,
            @CorreoCliente,
            @EstadoPedido,
            @MetodoPago,
            @EstadoPago,
            @ReferenciaTransaccion,
            @CostoEnvio,
            @EmpresaEnvio,
            @NumeroSeguimiento,
            @EstadoEnvio,
            @Notas;
    END;

    CLOSE CursorPedidos;
    DEALLOCATE CursorPedidos;

    -- =====================================================
    -- ACTUALIZAR INVENTARIO RESERVADO SEGUN PEDIDOS ACTIVOS
    -- NO SE RESERVAN PRODUCTOS DE PEDIDOS CANCELADOS
    -- =====================================================

    UPDATE i
    SET 
        i.CantidadReservada = x.CantidadVendida,
        i.FechaUltimaActualizacion = SYSUTCDATETIME()
    FROM dbo.Inventario i
    INNER JOIN
    (
        SELECT 
            dp.ProductoId,
            SUM(dp.Cantidad) AS CantidadVendida
        FROM dbo.DetallesPedido dp
        INNER JOIN dbo.Pedidos p
            ON p.PedidoId = dp.PedidoId
        WHERE p.EstadoPedido IN ('Pendiente', 'Pagado', 'Procesando', 'Enviado')
        GROUP BY dp.ProductoId
    ) x
        ON x.ProductoId = i.ProductoId
    INNER JOIN dbo.Almacenes a
        ON a.AlmacenId = i.AlmacenId
    WHERE a.Nombre = 'Almacen Principal';

    COMMIT TRANSACTION;

    PRINT 'Datos de prueba insertados correctamente.';

END TRY
BEGIN CATCH

    IF CURSOR_STATUS('global', 'CursorPedidos') >= -1
    BEGIN
        CLOSE CursorPedidos;
        DEALLOCATE CursorPedidos;
    END;

    IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRANSACTION;
    END;

    PRINT 'Ocurrio un error al insertar los datos de prueba.';
    PRINT 'Numero de error: ' + CAST(ERROR_NUMBER() AS NVARCHAR(20));
    PRINT 'Mensaje: ' + ERROR_MESSAGE();
    PRINT 'Linea: ' + CAST(ERROR_LINE() AS NVARCHAR(20));

END CATCH;
GO