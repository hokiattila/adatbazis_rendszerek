-- Author: Hoki Attila
-- Created: 2024-04-18
-- Task 3 - TEST


-- Teszteles valid (letezo) inputra 
BEGIN
  DBMS_OUTPUT.PUT_LINE('A bérlet azonosítója: ' || BerletKeresesTelSzamAlapjan('06305678912'));
END;
/

BEGIN
  DBMS_OUTPUT.PUT_LINE('A bérlet azonosítója: ' || BerletKeresesTelSzamAlapjan('06302342345'));
END;
/



-- Teszteles invalid (nem letezo) inputra 
BEGIN
  DBMS_OUTPUT.PUT_LINE('A bérlet azonosítója: ' || BerletKeresesTelSzamAlapjan('1234567'));
END;
/

BEGIN
  DBMS_OUTPUT.PUT_LINE('A bérlet azonosítója: ' || BerletKeresesTelSzamAlapjan('2345678'));
END;
/
