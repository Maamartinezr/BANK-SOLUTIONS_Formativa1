
-- Actividad Fromativa 1: Creando mi primer bloque PL/SQL anónimo simple.
-- Caso BANK SOLUTIONS.

-- CASO 1: Programa de Pesos TODOSUMA
/*Para las pruebas iniciales, ejecutar el proceso para los siguientes clientes:
    • KAREN SOFIA PRADENAS MANDIOLA
    • SILVANA MARTINA VALENZUELA DUARTE
    • DENISSE ALICIA DIAZ MIRANDA
    • AMANDA ROMINA LIZANA MARAMBIO
    • LUIS CLAUDIO LUNA JORQUERA
*/

-- 1- CLIENTE KAREN SOFIA PRADENAS MANDIOLA
DECLARE

-- PARAMETROS DE ENTRADA
    p_run_cliente  VARCHAR2(15) := '21.242.003-4';   -- RUT formato 11.111.111-1
    p_tramo1       NUMBER := 1000000;
    p_tramo2       NUMBER := 3000000;
    p_peso_base    NUMBER := 1200;
    p_extra1       NUMBER := 100;
    p_extra2       NUMBER := 300;
    p_extra3       NUMBER := 550;

-- VARIABLES DE PROCESO
    v_nro_cliente    CLIENTE.nro_cliente%TYPE;
    v_nombre_cliente VARCHAR2(60);
    v_tipo_cliente   TIPO_CLIENTE.nombre_tipo_cliente%TYPE;
    v_monto_total    NUMBER := 0;
    v_tramo          NUMBER := 0;
    v_pesos_normales NUMBER := 0;
    v_pesos_extra    NUMBER := 0;
    v_total_pesos    NUMBER := 0;

-- Año anterior al de ejecución (SBIF)
    v_anio NUMBER := EXTRACT(YEAR FROM SYSDATE) - 1;

BEGIN
-- 1. Obtener datos del cliente desde CLIENTE y TIPO_CLIENTE
    SELECT c.nro_cliente,
           c.pnombre || ' ' || c.appaterno || ' ' || NVL(c.apmaterno,''),
           t.nombre_tipo_cliente
    INTO v_nro_cliente, v_nombre_cliente, v_tipo_cliente
    FROM cliente c
    JOIN tipo_cliente t ON c.cod_tipo_cliente = t.cod_tipo_cliente
    WHERE TO_CHAR(c.numrun, 'FM99G999G999') || '-' || c.dvrun = p_run_cliente;

-- 2. Sumar créditos solicitados el año anterior
    SELECT NVL(SUM(monto_solicitado),0)
    INTO v_monto_total
    FROM credito_cliente
    WHERE nro_cliente = v_nro_cliente
      AND EXTRACT(YEAR FROM fecha_solic_cred) = v_anio;

-- 3. Calcular cantidad de bloques de $100.000
    v_tramo := FLOOR(v_monto_total / 100000);

-- 4. Calcular pesos normales ($1.200 por cada $100.000)
    v_pesos_normales := v_tramo * p_peso_base;

-- 5. Calcular pesos extras (solo trabajadores independientes)
    IF v_tipo_cliente = 'Trabajadores independientes' THEN

        IF v_monto_total < p_tramo1 THEN
            v_pesos_extra := v_tramo * p_extra1;

        ELSIF v_monto_total <= p_tramo2 THEN
            v_pesos_extra := v_tramo * p_extra2;

        ELSE
            v_pesos_extra := v_tramo * p_extra3;
        END IF;

    ELSE
        v_pesos_extra := 0;
    END IF;

-- 6. Total de pesos TODOSUMA
    v_total_pesos := v_pesos_normales + v_pesos_extra;

-- 7. Insertar resultado en CLIENTE_TODOSUMA
    INSERT INTO cliente_todosuma
    (
        nro_cliente,
        run_cliente,
        nombre_cliente,
        tipo_cliente,
        monto_solic_creditos,
        monto_pesos_todosuma
    )
    VALUES
    (
        v_nro_cliente,
        p_run_cliente,
        v_nombre_cliente,
        v_tipo_cliente,
        v_monto_total,
        v_total_pesos
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Cliente procesado correctamente: ' || v_nombre_cliente);

END;
/



-- Verificacion de existencia de cliente KAREN
/*SELECT
   c.nro_cliente,
   c.pnombre,
   c.appaterno,
   c.apmaterno,
   t.nombre_tipo_cliente,
   TO_CHAR(c.numrun,'FM99G999G999') || '-' || c.dvrun AS rut_formateado
FROM cliente c
JOIN tipo_cliente t ON c.cod_tipo_cliente = t.cod_tipo_cliente
WHERE c.numrun = 21242003;*/

---------------------------------------------------------------------------------

-- 2- CLIENTE SILVANA MARTINA VALENZUELA DUARTE
DECLARE

-- PARAMETROS DE ENTRADA
    p_run_cliente  VARCHAR2(15) := '22.176.845-2';   -- RUT formato 11.111.111-1
    p_tramo1       NUMBER := 1000000;
    p_tramo2       NUMBER := 3000000;
    p_peso_base    NUMBER := 1200;
    p_extra1       NUMBER := 100;
    p_extra2       NUMBER := 300;
    p_extra3       NUMBER := 550;

-- VARIABLES DE PROCESO
    v_nro_cliente    CLIENTE.nro_cliente%TYPE;
    v_nombre_cliente VARCHAR2(60);
    v_tipo_cliente   TIPO_CLIENTE.nombre_tipo_cliente%TYPE;
    v_monto_total    NUMBER := 0;
    v_tramo          NUMBER := 0;
    v_pesos_normales NUMBER := 0;
    v_pesos_extra    NUMBER := 0;
    v_total_pesos    NUMBER := 0;

-- Año anterior al de ejecución (SBIF)
    v_anio NUMBER := EXTRACT(YEAR FROM SYSDATE) - 1;

BEGIN
-- 1. Obtener datos del cliente desde CLIENTE y TIPO_CLIENTE
    SELECT c.nro_cliente,
           c.pnombre || ' ' || c.appaterno || ' ' || NVL(c.apmaterno,''),
           t.nombre_tipo_cliente
    INTO v_nro_cliente, v_nombre_cliente, v_tipo_cliente
    FROM cliente c
    JOIN tipo_cliente t ON c.cod_tipo_cliente = t.cod_tipo_cliente
    WHERE TO_CHAR(c.numrun, 'FM99G999G999') || '-' || c.dvrun = p_run_cliente;

-- 2. Sumar créditos solicitados el año anterior
    SELECT NVL(SUM(monto_solicitado),0)
    INTO v_monto_total
    FROM credito_cliente
    WHERE nro_cliente = v_nro_cliente
      AND EXTRACT(YEAR FROM fecha_solic_cred) = v_anio;

-- 3. Calcular cantidad de bloques de $100.000
    v_tramo := FLOOR(v_monto_total / 100000);

-- 4. Calcular pesos normales ($1.200 por cada $100.000)
    v_pesos_normales := v_tramo * p_peso_base;

-- 5. Calcular pesos extras (solo trabajadores independientes)
    IF v_tipo_cliente = 'Trabajadores independientes' THEN

        IF v_monto_total < p_tramo1 THEN
            v_pesos_extra := v_tramo * p_extra1;

        ELSIF v_monto_total <= p_tramo2 THEN
            v_pesos_extra := v_tramo * p_extra2;

        ELSE
            v_pesos_extra := v_tramo * p_extra3;
        END IF;

    ELSE
        v_pesos_extra := 0;
    END IF;

-- 6. Total de pesos TODOSUMA
    v_total_pesos := v_pesos_normales + v_pesos_extra;

-- 7. Insertar resultado en CLIENTE_TODOSUMA
    INSERT INTO cliente_todosuma
    (
        nro_cliente,
        run_cliente,
        nombre_cliente,
        tipo_cliente,
        monto_solic_creditos,
        monto_pesos_todosuma
    )
    VALUES
    (
        v_nro_cliente,
        p_run_cliente,
        v_nombre_cliente,
        v_tipo_cliente,
        v_monto_total,
        v_total_pesos
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Cliente procesado correctamente: ' || v_nombre_cliente);

END;
/

---------------------------------------------------------------------------------

-- 3- CLIENTE DENISSE ALICIA DIAZ MIRANDA
DECLARE

-- PARAMETROS DE ENTRADA
    p_run_cliente  VARCHAR2(15) := '18.858.542-6';   -- RUT formato 11.111.111-1
    p_tramo1       NUMBER := 1000000;
    p_tramo2       NUMBER := 3000000;
    p_peso_base    NUMBER := 1200;
    p_extra1       NUMBER := 100;
    p_extra2       NUMBER := 300;
    p_extra3       NUMBER := 550;

-- VARIABLES DE PROCESO
    v_nro_cliente    CLIENTE.nro_cliente%TYPE;
    v_nombre_cliente VARCHAR2(60);
    v_tipo_cliente   TIPO_CLIENTE.nombre_tipo_cliente%TYPE;
    v_monto_total    NUMBER := 0;
    v_tramo          NUMBER := 0;
    v_pesos_normales NUMBER := 0;
    v_pesos_extra    NUMBER := 0;
    v_total_pesos    NUMBER := 0;

-- Año anterior al de ejecución (SBIF)
    v_anio NUMBER := EXTRACT(YEAR FROM SYSDATE) - 1;

BEGIN
-- 1. Obtener datos del cliente desde CLIENTE y TIPO_CLIENTE
    SELECT c.nro_cliente,
           c.pnombre || ' ' || c.appaterno || ' ' || NVL(c.apmaterno,''),
           t.nombre_tipo_cliente
    INTO v_nro_cliente, v_nombre_cliente, v_tipo_cliente
    FROM cliente c
    JOIN tipo_cliente t ON c.cod_tipo_cliente = t.cod_tipo_cliente
    WHERE TO_CHAR(c.numrun, 'FM99G999G999') || '-' || c.dvrun = p_run_cliente;

-- 2. Sumar créditos solicitados el año anterior
    SELECT NVL(SUM(monto_solicitado),0)
    INTO v_monto_total
    FROM credito_cliente
    WHERE nro_cliente = v_nro_cliente
      AND EXTRACT(YEAR FROM fecha_solic_cred) = v_anio;

-- 3. Calcular cantidad de bloques de $100.000
    v_tramo := FLOOR(v_monto_total / 100000);

-- 4. Calcular pesos normales ($1.200 por cada $100.000)
    v_pesos_normales := v_tramo * p_peso_base;

-- 5. Calcular pesos extras (solo trabajadores independientes)
    IF v_tipo_cliente = 'Trabajadores independientes' THEN

        IF v_monto_total < p_tramo1 THEN
            v_pesos_extra := v_tramo * p_extra1;

        ELSIF v_monto_total <= p_tramo2 THEN
            v_pesos_extra := v_tramo * p_extra2;

        ELSE
            v_pesos_extra := v_tramo * p_extra3;
        END IF;

    ELSE
        v_pesos_extra := 0;
    END IF;

-- 6. Total de pesos TODOSUMA
    v_total_pesos := v_pesos_normales + v_pesos_extra;

-- 7. Insertar resultado en CLIENTE_TODOSUMA
    INSERT INTO cliente_todosuma
    (
        nro_cliente,
        run_cliente,
        nombre_cliente,
        tipo_cliente,
        monto_solic_creditos,
        monto_pesos_todosuma
    )
    VALUES
    (
        v_nro_cliente,
        p_run_cliente,
        v_nombre_cliente,
        v_tipo_cliente,
        v_monto_total,
        v_total_pesos
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Cliente procesado correctamente: ' || v_nombre_cliente);

END;
/

---------------------------------------------------------------------------------

-- 4- CLIENTE AMANDA ROMINA LIZANA MARAMBIO
DECLARE

-- PARAMETROS DE ENTRADA
    p_run_cliente  VARCHAR2(15) := '21.300.628-2';   -- RUT formato 11.111.111-1
    p_tramo1       NUMBER := 1000000;
    p_tramo2       NUMBER := 3000000;
    p_peso_base    NUMBER := 1200;
    p_extra1       NUMBER := 100;
    p_extra2       NUMBER := 300;
    p_extra3       NUMBER := 550;

-- VARIABLES DE PROCESO
    v_nro_cliente    CLIENTE.nro_cliente%TYPE;
    v_nombre_cliente VARCHAR2(60);
    v_tipo_cliente   TIPO_CLIENTE.nombre_tipo_cliente%TYPE;
    v_monto_total    NUMBER := 0;
    v_tramo          NUMBER := 0;
    v_pesos_normales NUMBER := 0;
    v_pesos_extra    NUMBER := 0;
    v_total_pesos    NUMBER := 0;

-- Año anterior al de ejecución (SBIF)
    v_anio NUMBER := EXTRACT(YEAR FROM SYSDATE) - 1;

BEGIN
-- 1. Obtener datos del cliente desde CLIENTE y TIPO_CLIENTE
    SELECT c.nro_cliente,
           c.pnombre || ' ' || c.appaterno || ' ' || NVL(c.apmaterno,''),
           t.nombre_tipo_cliente
    INTO v_nro_cliente, v_nombre_cliente, v_tipo_cliente
    FROM cliente c
    JOIN tipo_cliente t ON c.cod_tipo_cliente = t.cod_tipo_cliente
    WHERE TO_CHAR(c.numrun, 'FM99G999G999') || '-' || c.dvrun = p_run_cliente;

-- 2. Sumar créditos solicitados el año anterior
    SELECT NVL(SUM(monto_solicitado),0)
    INTO v_monto_total
    FROM credito_cliente
    WHERE nro_cliente = v_nro_cliente
      AND EXTRACT(YEAR FROM fecha_solic_cred) = v_anio;

-- 3. Calcular cantidad de bloques de $100.000
    v_tramo := FLOOR(v_monto_total / 100000);

-- 4. Calcular pesos normales ($1.200 por cada $100.000)
    v_pesos_normales := v_tramo * p_peso_base;

-- 5. Calcular pesos extras (solo trabajadores independientes)
    IF v_tipo_cliente = 'Trabajadores independientes' THEN

        IF v_monto_total < p_tramo1 THEN
            v_pesos_extra := v_tramo * p_extra1;

        ELSIF v_monto_total <= p_tramo2 THEN
            v_pesos_extra := v_tramo * p_extra2;

        ELSE
            v_pesos_extra := v_tramo * p_extra3;
        END IF;

    ELSE
        v_pesos_extra := 0;
    END IF;

-- 6. Total de pesos TODOSUMA
    v_total_pesos := v_pesos_normales + v_pesos_extra;

-- 7. Insertar resultado en CLIENTE_TODOSUMA
    INSERT INTO cliente_todosuma
    (
        nro_cliente,
        run_cliente,
        nombre_cliente,
        tipo_cliente,
        monto_solic_creditos,
        monto_pesos_todosuma
    )
    VALUES
    (
        v_nro_cliente,
        p_run_cliente,
        v_nombre_cliente,
        v_tipo_cliente,
        v_monto_total,
        v_total_pesos
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Cliente procesado correctamente: ' || v_nombre_cliente);

END;
/

---------------------------------------------------------------------------------

-- 5- CLIENTE LUIS CLAUDIO LUNA JORQUERA
DECLARE

-- PARAMETROS DE ENTRADA
    p_run_cliente  VARCHAR2(15) := '22.558.061-8';   -- RUT formato 11.111.111-1
    p_tramo1       NUMBER := 1000000;
    p_tramo2       NUMBER := 3000000;
    p_peso_base    NUMBER := 1200;
    p_extra1       NUMBER := 100;
    p_extra2       NUMBER := 300;
    p_extra3       NUMBER := 550;

-- VARIABLES DE PROCESO
    v_nro_cliente    CLIENTE.nro_cliente%TYPE;
    v_nombre_cliente VARCHAR2(60);
    v_tipo_cliente   TIPO_CLIENTE.nombre_tipo_cliente%TYPE;
    v_monto_total    NUMBER := 0;
    v_tramo          NUMBER := 0;
    v_pesos_normales NUMBER := 0;
    v_pesos_extra    NUMBER := 0;
    v_total_pesos    NUMBER := 0;

-- Año anterior al de ejecución (SBIF)
    v_anio NUMBER := EXTRACT(YEAR FROM SYSDATE) - 1;

BEGIN
-- 1. Obtener datos del cliente desde CLIENTE y TIPO_CLIENTE
    SELECT c.nro_cliente,
           c.pnombre || ' ' || c.appaterno || ' ' || NVL(c.apmaterno,''),
           t.nombre_tipo_cliente
    INTO v_nro_cliente, v_nombre_cliente, v_tipo_cliente
    FROM cliente c
    JOIN tipo_cliente t ON c.cod_tipo_cliente = t.cod_tipo_cliente
    WHERE TO_CHAR(c.numrun, 'FM99G999G999') || '-' || c.dvrun = p_run_cliente;

-- 2. Sumar créditos solicitados el año anterior
    SELECT NVL(SUM(monto_solicitado),0)
    INTO v_monto_total
    FROM credito_cliente
    WHERE nro_cliente = v_nro_cliente
      AND EXTRACT(YEAR FROM fecha_solic_cred) = v_anio;

-- 3. Calcular cantidad de bloques de $100.000
    v_tramo := FLOOR(v_monto_total / 100000);

-- 4. Calcular pesos normales ($1.200 por cada $100.000)
    v_pesos_normales := v_tramo * p_peso_base;

-- 5. Calcular pesos extras (solo trabajadores independientes)
    IF v_tipo_cliente = 'Trabajadores independientes' THEN

        IF v_monto_total < p_tramo1 THEN
            v_pesos_extra := v_tramo * p_extra1;

        ELSIF v_monto_total <= p_tramo2 THEN
            v_pesos_extra := v_tramo * p_extra2;

        ELSE
            v_pesos_extra := v_tramo * p_extra3;
        END IF;

    ELSE
        v_pesos_extra := 0;
    END IF;

-- 6. Total de pesos TODOSUMA
    v_total_pesos := v_pesos_normales + v_pesos_extra;

-- 7. Insertar resultado en CLIENTE_TODOSUMA
    INSERT INTO cliente_todosuma
    (
        nro_cliente,
        run_cliente,
        nombre_cliente,
        tipo_cliente,
        monto_solic_creditos,
        monto_pesos_todosuma
    )
    VALUES
    (
        v_nro_cliente,
        p_run_cliente,
        v_nombre_cliente,
        v_tipo_cliente,
        v_monto_total,
        v_total_pesos
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Cliente procesado correctamente: ' || v_nombre_cliente);

END;
/

-- Verificacion de los 5 clientes incluidos en la Tabla CLIENTE_TODOSUMA. Bloque ejecutado 5 veces, 1 vez para cada cliente.
SELECT * FROM CLIENTE_TODOSUMA;

COMMIT;

-------------------------------------------------------------------------------------------------------------------------------------

--CASO 2: Creditos y rfinanciacion de clientes.
/*Para las pruebas iniciales, ejecutar el proceso para los siguientes clientes:
Nombre cliente	                            Número solicitud crédito	Cantidad cuotas a postergar
SEBASTIAN PATRICIO QUINTANA BERRIOS	                    2001	                     2
KAREN SOFIA PRADENAS MANDIOLA	                        3004	                     1
JULIAN PAUL ARRIAGADA LUJAN	                            2004	                     1
*/

    v_nro_solic_credito := &nro_solic_credito;  -- Ej: 2001
    v_cant_cuotas := &cant_cuotas;              -- Ej: 1 o 2
    SELECT nro_cuota, fecha_venc_cuota, valor_cuota
    INTO v_ultima_cuota, v_fecha_ultima, v_valor_cuota
    FROM cuota_credito_cliente
    WHERE nro_solic_credito = v_nro_solic_credito
    ORDER BY nro_cuota DESC
    FETCH FIRST 1 ROWS ONLY;
    
    -- Tasa de interés según tipo de crédito
    SELECT CASE cr.nombre_credito
               WHEN 'Crédito Hipotecario' THEN 0.005
               WHEN 'Crédito de Consumo'  THEN 0.01
               WHEN 'Crédito Automotriz'  THEN 0.02
               ELSE 0
           END
    INTO v_tasa_interes
    FROM credito_cliente cc
    JOIN credito cr ON cc.cod_credito = cr.cod_credito
    WHERE cc.nro_solic_credito = v_nro_solic_credito;
    
    -- Generar nuevas cuotas postergadas
    FOR i IN 1..v_cant_cuotas LOOP
        v_ultima_cuota := v_ultima_cuota + 1;
        v_fecha_nueva  := ADD_MONTHS(v_fecha_ultima, i);
        v_valor_cuota  := v_valor_cuota * (1 + v_tasa_interes);
        INSERT INTO cuota_credito_cliente (
            nro_solic_credito, nro_cuota, fecha_venc_cuota,
            valor_cuota, fecha_pago_cuota, monto_pagado,
            saldo_por_pagar, cod_forma_pago
        )
        VALUES (
            v_nro_solic_credito,
            v_ultima_cuota,
            v_fecha_nueva,
            v_valor_cuota,
            NULL,
            NULL,
            NULL,
            NULL
        );
        
        DBMS_OUTPUT.PUT_LINE('CASO 2 ? Nueva cuota ' || v_ultima_cuota ||
                             ' | Fecha: ' || TO_CHAR(v_fecha_nueva,'DD/MM/YYYY') ||
                             ' | Valor: ' || TO_CHAR(v_valor_cuota,'999,999.99'));
    END LOOP;
    COMMIT;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('?? No se encontraron registros para el cliente o crédito indicado.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('? Error: ' || SQLERRM);
        ROLLBACK;
END;
/



















