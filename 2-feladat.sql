-- Author: Hoki Attila
-- Created: 2024-04-18
-- Task 2: Tarolt eljaras vasarlasi datum alapu formazott megjelenitesre, hibakezelessel.
-- Description:  Az 1. feladathoz hasonloan a tarolt eljaras a BERLET es BERLET_TIPUS tablakon 
--               vegez muveleteket. Parameterkent kap egy datumot, ellenorzi, hogy az adott datummal
--               van-e regisztralt berlet majd pedig azt is, hogy az adott berlethez van-e megfelelo
--               berlet tipus. A hibakezeleshez sajat kiveteleket definialunk. Ha minden feltetel adott
--               akkor formazottan kiirja az adott datumhoz tartozo berletek adatait.


ALTER SESSION SET NLS_LANGUAGE = 'HUNGARIAN';
ALTER SESSION SET NLS_TERRITORY = 'HUNGARY';
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY. MM. DD';


CREATE OR REPLACE PROCEDURE BerletekVasarlasDatumSzerint(p_vasarlas_datum IN DATE)
IS
  v_count_berlet NUMBER;
  v_count_tipus NUMBER;
  e_no_berlet_found EXCEPTION;
  e_no_type_found EXCEPTION;

BEGIN
  --Ellenorizzuk, hogy van-e berlet a megadott vasarlasi datumhoz
  SELECT COUNT(*) INTO v_count_berlet FROM BERLET WHERE TRUNC(vasarlasi_datum) = p_vasarlas_datum;
  IF v_count_berlet = 0 THEN
    RAISE e_no_berlet_found;
  END IF;

  --Ellenorizzük, hogy minden berlethez van-e megfelelo tipus
  SELECT COUNT(DISTINCT tipus) INTO v_count_tipus FROM BERLET WHERE TRUNC(vasarlasi_datum) = p_vasarlas_datum;
  IF v_count_tipus = 0 THEN
    RAISE e_no_type_found;
  END IF;

  --Formazottan kiirjuk a berleteket a megadott vasarlasi datumon
  DBMS_OUTPUT.PUT_LINE(RPAD('Berlet szam', 15) || RPAD('Vasarlasi datum', 20) || RPAD('Lejarati datum', 20) || RPAD('Tipus', 20) || RPAD('Ar', 10));
  FOR r IN (SELECT berlet_szam, vasarlasi_datum, lejarati_datum, tipus, (SELECT ar FROM BERLET_TIPUS WHERE tipus = BERLET.tipus) AS ar
            FROM BERLET
            WHERE TRUNC(vasarlasi_datum) = p_vasarlas_datum)
  LOOP
    DBMS_OUTPUT.PUT_LINE(RPAD(r.berlet_szam, 15) || RPAD(TO_CHAR(r.vasarlasi_datum, 'YYYY-MM-DD'), 20) ||
                         RPAD(TO_CHAR(r.lejarati_datum, 'YYYY-MM-DD'), 20) || RPAD(r.tipus, 20) || RPAD(r.ar, 10));
  END LOOP;

EXCEPTION
  WHEN e_no_berlet_found THEN
    DBMS_OUTPUT.PUT_LINE('Hiba: Nincsenek berletek ezen a vasarlasi datumon!');
  WHEN e_no_type_found THEN
    DBMS_OUTPUT.PUT_LINE('Hiba: Egy vagy tobb berlethez nem talalhato megfelelo berlettipus a rendszerben!');
END BerletekVasarlasDatumSzerint;
