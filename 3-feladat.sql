-- Author: Hoki Attila
-- Created: 2024-04-18
-- Task 3: Fuggvenydefinicio berletszam meghatarozasahoz telefonszam alapjan
-- Description:  Az UTAS es BERLET tablak kozotti kapcsolat alapjan letrehozunk egy tarolt
--               fuggvenyt, ami egy adott utas telefonszama alapjan keresi meg a hozza tartozo berleteket.
--               Hibakezeles soran ellenorizzuk, hogy:
--               * Letezik-e utas az adott telefonszammal
--               * Pontosan 1 utashoz tartozik-e a megadott telefonszam
--               * Ha letezik utas az adott telefonszammal akkor rendelkezik berlettel 
--               * Pontosan 1 berlettel tartozik

CREATE OR REPLACE FUNCTION BerletKeresesTelSzamAlapjan(p_tel_szam IN VARCHAR2) RETURN INT
IS
  v_utas_count INT;
  v_berlet_szam INT;
  v_berlet_count INT;

  e_no_utas_found EXCEPTION;
  e_multiple_utas_found EXCEPTION;
  e_no_berlet_found EXCEPTION;
  e_multiple_berlet_found EXCEPTION;

BEGIN
  -- Ellenorizzuk, hogy van-e ilyen telefonszammal rendelkezo utas
  SELECT COUNT(*), MAX(berlet_szam) INTO v_utas_count, v_berlet_szam FROM UTAS WHERE tel_szam = p_tel_szam;

  IF v_utas_count = 0 THEN
    RAISE e_no_utas_found;
  ELSIF v_utas_count > 1 THEN
    RAISE e_multiple_utas_found;
  END IF;

  -- Ellenorizzuk, hogy az utashoz hany berlet tartozik
  SELECT COUNT(*) INTO v_berlet_count FROM BERLET WHERE berlet_szam = v_berlet_szam;
  
  IF v_berlet_count = 0 THEN
    RAISE e_no_berlet_found;
  ELSIF v_berlet_count > 1 THEN
    RAISE e_multiple_berlet_found;
  END IF;

  -- Berlet azonositojanak visszaadasa
  RETURN v_berlet_szam;

EXCEPTION
  WHEN e_no_utas_found THEN
    DBMS_OUTPUT.PUT_LINE('Hiba: Nincs ilyen telefonszammal rendelkezo utas!');
    RETURN -1;
  WHEN e_multiple_utas_found THEN
    DBMS_OUTPUT.PUT_LINE('Hiba: Tobb utas is rendelkezik ezzel a telefonszammal!');
    RETURN -2;
  WHEN e_no_berlet_found THEN
    DBMS_OUTPUT.PUT_LINE('Hiba: Az utashoz nem tartozik berlet!');
    RETURN -3;
  WHEN e_multiple_berlet_found THEN
    DBMS_OUTPUT.PUT_LINE('Hiba: Az utashoz tobb berlet is tartozik!');
    RETURN -4;
END BerletKeresesTelSzamAlapjan;
