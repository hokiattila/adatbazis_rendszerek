-- Author: Hoki Attila
-- Created: 2024-04-21
-- Task 5: Nezettabla es helyettesito triggerek letrehozasa
-- Description:  Letrehozunk egy nezettablat berletinformatio neven ami
--               az adott vasarlasi datumokhoz tartozo arakat fogja tarolni.
--               Eztuan letrehozzuk a BerletModositas helyettesito triggereket

ALTER SESSION SET NLS_LANGUAGE = 'HUNGARIAN';
ALTER SESSION SET NLS_TERRITORY = 'HUNGARY';
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY. MM. DD';


CREATE OR REPLACE VIEW BerletInformacio AS
SELECT b.vasarlasi_datum, bt.ar
FROM Berlet b
JOIN Berlet_Tipus bt ON b.tipus = bt.tipus;


-- Amikor a BerletInformacio nezetben ha egy adott sor frissitesre kerul, a trigger eloszor leellenorzi a Berlet_Tipus tablaban, hogy letezik-e az uj ar 
-- (amit a frissites soran kivannak beallitani) megfelelo berlettipust. Megszamolja, hogy hany ilyen aru berlettipus talalhato. Ha a lekerdezes eredmenye 0 
-- (vagyis nincs az adott aru berlettipus), akkor  TipusNemLetezik kivetelt dob. Ebben az esetben a trigger egy hibauzenetet jelenit meg, hogy a megadott aru 
-- berlettípus nem letezik, igy a modositas nem vegezheto el. Ha letezik ilyen aru berlettipus, a trigger frissiti a Berlet tabla megfelelo sorat. 
-- Az UPDATE muvelet a berlet tipusat allitja at az uj, a megadott aru berlettipushoz tartozo tipusra. 

CREATE OR REPLACE TRIGGER BerletModositasTrigger
INSTEAD OF UPDATE ON BerletInformacio
FOR EACH ROW
DECLARE
    TipusNemLetezik EXCEPTION;
    tipus_letezik INT;
BEGIN
    SELECT COUNT(*) INTO tipus_letezik FROM Berlet_Tipus WHERE ar = :NEW.ar;

    IF tipus_letezik = 0 THEN
        RAISE TipusNemLetezik;
    ELSE
        UPDATE Berlet SET tipus = (SELECT tipus FROM Berlet_Tipus WHERE ar = :NEW.ar)
        WHERE vasarlasi_datum = :OLD.vasarlasi_datum;
    END IF;
EXCEPTION
    WHEN TipusNemLetezik THEN
        RAISE_APPLICATION_ERROR(-20002, 'A megadott aru berlettipus nem letezik, igy nem modosithato!');
    WHEN OTHERS THEN
        RAISE;
END;
