--Kulso kulcsok eltavolitasa
ALTER TABLE JEGYNYILVANTARTAS DROP CONSTRAINT fk_jegynyilvantartas_utas;
ALTER TABLE JEGYNYILVANTARTAS DROP CONSTRAINT fk_jegynyilvantartas_menetjegy;
ALTER TABLE UTAZAS DROP CONSTRAINT fk_utazas_utas;
ALTER TABLE UTAZAS DROP CONSTRAINT fk_utazas_gepjarmu;
ALTER TABLE JARAT DROP CONSTRAINT fk_jarat_sofor;
ALTER TABLE JARAT DROP CONSTRAINT fk_jarat_gepjarmu;
ALTER TABLE UTAS DROP CONSTRAINT fk_utas_berlet;
ALTER TABLE BERLET DROP CONSTRAINT fk_berlet_tipus;

--Tablak torlese
DROP TABLE BERLET_TIPUS;
DROP TABLE BERLET;
DROP TABLE UTAS;
DROP TABLE SOFOR;
DROP TABLE MENETJEGY;
DROP TABLE GEPJARMUVEK;
DROP TABLE JARAT;
DROP TABLE UTAZAS;
DROP TABLE JEGYNYILVANTARTAS;
DROP TABLE SOFOR_AUDIT_LOG;

--Szekvenciak torlese
DROP SEQUENCE UTAS_SEQUENCE;
DROP SEQUENCE SOFOR_SEQUENCE;
DROP SEQUENCE LOG_SEQUENCE;
DROP SEQUENCE BERLET_SEQUENCE;

-- View torlese
DROP VIEW BerletInformacio;