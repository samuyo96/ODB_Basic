--Funciones de seguridad

--Verifica si la contraseña tiene más de 10 carácteres y si contiene letras y números
CREATE OR REPLACE FUNCTION Verificar_Contraseña (
    Username VARCHAR2,
    Password VARCHAR2,
    Old_password VARCHAR2)
RETURN BOOLEAN IS
BEGIN
    IF LENGTH(Password) < 10 THEN
        RETURN FALSE;
    ELSIF NOT REGEXP_LIKE(Password, '[A-Za-z]') OR REGEXP_LIKE(Password, '[0-9]') THEN
        RETURN FALSE;
    END IF;
    RETURN TRUE;
END;

--Perfiles de seguridad

CREATE PROFILE perf_seg_bajo
LIMIT
    PASSWORD_VERIFY_FUNCTION Verificar_Contraseña
    PASSWORD_LIFE_TIME UNLIMITED;
    
CREATE PROFILE perf_seg_alto
LIMIT
    PASSWORD_VERIFY_FUNCTION Verificar_Contraseña
    PASSWORD_LIFE_TIME 90;
    
--Roles

CREATE ROLE Administrador IDENTIFIED BY contraseña
GRANT ALL PRIVILEGES TO Administrador

CREATE ROLE Usuario IDENTIFIED BY contraseña
GRANT SELECT ON DB_Samurai TO Usuario
GRANT EXECUTE ON DB_Samurai.ACTUALIZARCLIENTE TO Usuario
GRANT EXECUTE ON DB_Samurai.ACTUALIZARPEDIDO TO Usuario
GRANT EXECUTE ON DB_Samurai.INSERTARCLIENTE TO Usuario
GRANT EXECUTE ON DB_Samurai.INSERTARPEDIDO TO Usuario
GRANT EXECUTE ON DB_Samurai.LEER_PEDIDOS_Y_CLIENTES_POR_COSTE TO Usuario

--Encriptación mediante TDE (Transparent Data Encrypter)

ALTER SYSTEM SET ENCRYPTION KEY IDENTIFIED BY 'Contraseña12AB90';

ALTER TABLE Clientes MODIFY (Cl_name ENCRYPT);
ALTER TABLE Clientes MODIFY (P_COST ENCRYPT);

    


    
