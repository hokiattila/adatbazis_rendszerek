-- Author: Hoki Attila
-- Created: 2024-04-20
-- Task 2: Trigger a SOFOR tablahoz tartozo DML operaciok logolasahoz.
-- Description:  A SOFOR_AUDIT_LOG tabla es a hozza tartozo szekvencia letrehozasat
--                az adatbazist letrehozo DML utasitasokba integraltam (CREATE_INSERT.sql).
--                Az alabbi trigger a SOFOR tablan vegzet muveleteket/operaciokat naploza az
--                emlitett log tabla segitsegevel.

CREATE OR REPLACE TRIGGER Sofor_Audit_Trigger
AFTER INSERT OR UPDATE OR DELETE ON SOFOR
FOR EACH ROW
DECLARE
  v_operation VARCHAR2(1000);
BEGIN
  -- Muvelet tipusanak meghatarozasa
  IF INSERTING THEN
    v_operation := 'INSERT: New sofor added with ID ' || :NEW.sofor_id;
  ELSIF UPDATING THEN
    v_operation := 'UPDATE: Sofor updated with ID ' || :NEW.sofor_id;
  ELSIF DELETING THEN
    v_operation := 'DELETE: Sofor deleted with ID ' || :OLD.sofor_id;
  END IF;

  -- Bejegyzes hozzaadasa
  INSERT INTO Sofor_Audit_Log (log_id,log_date, user_name, sofor_id, operation)
  VALUES (LOG_SEQUENCE.nextval,SYSDATE, USER, NVL(:NEW.sofor_id, :OLD.sofor_id), v_operation);
EXCEPTION
  WHEN OTHERS THEN
    -- Hibakezeles, problema eseten
    DBMS_OUTPUT.PUT_LINE('Error in Sofor_Audit_Trigger: ' || SQLERRM);
END Sofor_Audit_Trigger;


