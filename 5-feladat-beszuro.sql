-- Author: Hoki Attila
-- Created: 2024-04-21
-- Task 5: Nezettabla es helyettesito triggerek letrehozasa
-- Description:  Letrehozunk egy nezettablat berletinformatio neven ami
--               az adott vasarlasi datumokhoz tartozo arakat fogja tarolni.
--               Eztuan letrehozzuk a BerletBeszuras helyettesito triggereket

ALTER SESSION SET NLS_LANGUAGE = 'HUNGARIAN';
ALTER SESSION SET NLS_TERRITORY = 'HUNGARY';
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY. MM. DD';


CREATE OR REPLACE VIEW BerletInformacio AS
SELECT b.vasarlasi_datum, bt.ar
FROM Berlet b
JOIN Berlet_Tipus bt ON b.tipus = bt.tipus;


-- Amikor egy uj sor beszurasra kerul a BerletInformacio nezetbe, a trigger eloszor ellenorzi, hogy az adott aru berlettípus letezik-e 
-- a Berlet_Tipus tablaban. Ha nem letezik ilyen aru berlettípus (TipusNemLetezik kivetel), akkor hibauzenetet general, jelezve, hogy a 
-- megadott aru berlet tipus nem letezik. Ha letezik, akkor a trigger beszur egy uj sort a Berlet tablaba a megfelelo adatokkal, beleertve 
-- a berletszamot (amit egy szekvenciabol kap), a vasarlasi es lejarati datumot (utobbi 30 nappal kesobbi), valamint a megfelelo berlettípust az ar alapjan.

CREATE OR REPLACE TRIGGER BerletBeszurasTrigger
INSTEAD OF INSERT ON BerletInformacio
FOR EACH ROW
DECLARE
    TipusNemLetezik EXCEPTION;
    TipusMarLetezik EXCEPTION;
    tipus_letezik INT;
BEGIN
    SELECT COUNT(*) INTO tipus_letezik FROM Berlet_Tipus WHERE ar = :NEW.ar;

    IF tipus_letezik = 0 THEN
        RAISE TipusNemLetezik;
    ELSE
        -- Eredeti berlet tablaba szuras
        INSERT INTO Berlet (berlet_szam, vasarlasi_datum, lejarati_datum, tipus)
        VALUES (BERLET_SEQUENCE.nextval, :NEW.vasarlasi_datum, :NEW.vasarlasi_datum + 30 ,(SELECT tipus FROM Berlet_Tipus WHERE ar = :NEW.ar));
    END IF;
EXCEPTION
    WHEN TipusNemLetezik THEN
        RAISE_APPLICATION_ERROR(-20001, 'A megadott aru berlettipus nem letezik!');
    WHEN OTHERS THEN
        RAISE;
END;