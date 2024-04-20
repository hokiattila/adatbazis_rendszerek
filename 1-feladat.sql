-- Author: Hoki Attila
-- Created: 2024-04-18
-- Task 1: Beszuras es ellenorzes tarolt eljaras segitsegevel.
-- Description:  A BERLET_TIPUS tabla elsodleges kulcsa egyben a BERLET tabla kulso kulcs referenciaja is.
--               Az alabbi eljaras uj rekord felvetelet hajtra vegre a BERLET tablaba ellenorizve, hogy a 
--               a megadott berlet tipus valoban letezik, majd a beszurast kovetoen megadja adott tipusu 
--               berletek szamat. 


CREATE OR REPLACE PROCEDURE BerletFelvitel(
    p_berlet_szam IN BERLET.berlet_szam%TYPE,
    p_vasarlasi_datum IN BERLET.vasarlasi_datum%TYPE,
    p_lejarati_datum IN BERLET.lejarati_datum%TYPE,
    p_tipus IN BERLET.tipus%TYPE)
IS
    v_tipus_count NUMBER;
    v_count_tipus NUMBER;
BEGIN
    --Ellenorizzuk, hogy a megadott tipus letezik-e a BERLET_TIPUS tablaban
    SELECT COUNT(*)
    INTO v_tipus_count
    FROM BERLET_TIPUS
    WHERE tipus = p_tipus;
    IF v_tipus_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Hiba: Nincs ilyen tipus a BERLET_TIPUS tablaban.');
    ELSE
    --Beszurjuk az uj rekordot
        INSERT INTO BERLET (berlet_szam, vasarlasi_datum, lejarati_datum, tipus)
        VALUES (p_berlet_szam, p_vasarlasi_datum, p_lejarati_datum, p_tipus);
    --Megszamoljuk hany rekord van ezzel a tipussal 
        SELECT COUNT(*)
        INTO v_count_tipus
        FROM BERLET
        WHERE tipus = p_tipus;
        DBMS_OUTPUT.PUT_LINE('Sikeres beszuras. Ez az ' || v_count_tipus || '. berlet ezzel a tipussal.');
        COMMIT;
    END IF;
    --Kivetelkezeles
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Hiba tortent: ' || SQLERRM);
        ROLLBACK;
END;
/