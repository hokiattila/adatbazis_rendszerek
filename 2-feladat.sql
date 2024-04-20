CREATE OR REPLACE PROCEDURE BerletekVasarlasDatumSzerint(p_vasarlas_datum IN DATE)
IS
  v_count_berlet NUMBER;
  v_count_tipus NUMBER;
  e_no_berlet_found EXCEPTION;
  e_no_type_found EXCEPTION;

BEGIN
  -- Ellenőrizzük, hogy van-e bérlet a megadott vásárlási dátumon
  SELECT COUNT(*) INTO v_count_berlet FROM BERLET WHERE vasarlasi_datum = p_vasarlas_datum;
  IF v_count_berlet = 0 THEN
    RAISE e_no_berlet_found;
  END IF;

  -- Ellenőrizzük, hogy minden bérlethez van-e megfelelő típus
  SELECT COUNT(DISTINCT tipus) INTO v_count_tipus FROM BERLET WHERE vasarlasi_datum = p_vasarlas_datum;
  IF v_count_tipus = 0 THEN
    RAISE e_no_type_found;
  END IF;

  -- Kiírjuk a bérleteket a megadott vásárlási dátumon
  DBMS_OUTPUT.PUT_LINE(RPAD('Berlet szam', 15) || RPAD('Vasarlasi datum', 20) || RPAD('Lejarati datum', 20) || RPAD('Tipus', 20) || RPAD('Ar', 10));
  FOR r IN (SELECT berlet_szam, vasarlasi_datum, lejarati_datum, tipus, (SELECT ar FROM BERLET_TIPUS WHERE tipus = BERLET.tipus) AS ar
            FROM BERLET
            WHERE vasarlasi_datum = p_vasarlas_datum)
  LOOP
    DBMS_OUTPUT.PUT_LINE(RPAD(r.berlet_szam, 15) || RPAD(TO_CHAR(r.vasarlasi_datum, 'YYYY-MM-DD'), 20) ||
                         RPAD(TO_CHAR(r.lejarati_datum, 'YYYY-MM-DD'), 20) || RPAD(r.tipus, 20) || RPAD(r.ar, 10));
  END LOOP;

EXCEPTION
  WHEN e_no_berlet_found THEN
    DBMS_OUTPUT.PUT_LINE('Hiba: Nincsenek bérletek ezen a vásárlási dátumon!');
  WHEN e_no_type_found THEN
    DBMS_OUTPUT.PUT_LINE('Hiba: Az egyik vagy több bérlethez nem található megfelelő bérlettípus a rendszerben!');
END BerletekVasarlasDatumSzerint;
