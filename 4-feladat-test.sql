-- Author: Hoki Attila
-- Created: 2024-04-20
-- Task 4 - TEST

INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Kovacs Bence', '06202223333', 'Szombathely, Ovaros ter 7.', SYSDATE - 8100, 'ferfi', 'P');
UPDATE  SOFOR SET jogositvany_tipus = 'C' WHERE nev = 'Toth Gabriella';
DELETE FROM SOFOR WHERE nev = 'Kovacs Mate';


-- Futtatast kovetoen a log tablaban megjelennek a rekordok