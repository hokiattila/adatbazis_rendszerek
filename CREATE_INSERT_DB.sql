--Fuggoseg nelkuli tablak letrehozasa
CREATE TABLE BERLET_TIPUS (
  tipus VARCHAR2(20) PRIMARY KEY,
  ar INT
);

CREATE TABLE BERLET (
  berlet_szam INT PRIMARY KEY,
  vasarlasi_datum DATE,
  lejarati_datum DATE,
  tipus VARCHAR2(20),
  CONSTRAINT fk_berlet_tipus FOREIGN KEY (tipus) REFERENCES BERLET_TIPUS(tipus) ON DELETE CASCADE
);

CREATE TABLE SOFOR (
  sofor_id INT PRIMARY KEY,
  nev VARCHAR2(25),
  tel_szam VARCHAR2(25),
  lakcim VARCHAR2(50),
  szul_datum DATE,
  nem VARCHAR2(10) CHECK (nem IN ('ferfi', 'no')),
  jogositvany_tipus VARCHAR2(4)
);

CREATE TABLE MENETJEGY (
  jegyszam INT PRIMARY KEY,
  vasarlasi_datum DATE,
  lejarati_datum DATE,
  ar INT
);

CREATE TABLE GEPJARMUVEK (
  alvazszam VARCHAR2(20) PRIMARY KEY,
  tipus VARCHAR2(50),
  modell VARCHAR2(50),
  ferohely INT
);

--Kulso kulcsokra hivatkozo tablak letrehozasa
CREATE TABLE UTAS (
  utas_id INT PRIMARY KEY,
  nev VARCHAR2(25),
  tel_szam VARCHAR2(25),
  lakcim VARCHAR2(50),
  szul_datum DATE,
  nem VARCHAR2(10) CHECK (nem IN ('ferfi', 'no')),
  berlet_szam INT NULL,
  CONSTRAINT fk_utas_berlet FOREIGN KEY (berlet_szam) REFERENCES BERLET(berlet_szam) ON DELETE CASCADE
);

CREATE TABLE JARAT (
  sofor_id INT,
  alvazszam VARCHAR2(20),
  indulas DATE,
  erkezes DATE,
  kezdo_allomas VARCHAR2(50),
  veg_allomas VARCHAR2(50),
  CONSTRAINT pk_jarat PRIMARY KEY (sofor_id, alvazszam),
  CONSTRAINT fk_jarat_sofor FOREIGN KEY (sofor_id) REFERENCES SOFOR(sofor_id) ON DELETE CASCADE,
  CONSTRAINT fk_jarat_gepjarmu FOREIGN KEY (alvazszam) REFERENCES GEPJARMUVEK(alvazszam) ON DELETE CASCADE
);

CREATE TABLE UTAZAS (
  utas_id INT,
  alvazszam VARCHAR2(20),
  leszallas DATE,
  felszallas DATE,
  CONSTRAINT fk_utazas_utas FOREIGN KEY (utas_id) REFERENCES UTAS(utas_id) ON DELETE CASCADE,
  CONSTRAINT fk_utazas_gepjarmu FOREIGN KEY (alvazszam) REFERENCES GEPJARMUVEK(alvazszam) ON DELETE CASCADE
);

CREATE TABLE JEGYNYILVANTARTAS (
  utas_id INT,
  jegyszam INT,
  CONSTRAINT fk_jegynyilvantartas_utas FOREIGN KEY (utas_id) REFERENCES UTAS(utas_id) ON DELETE CASCADE,
  CONSTRAINT fk_jegynyilvantartas_menetjegy FOREIGN KEY (jegyszam) REFERENCES MENETJEGY(jegyszam) ON DELETE CASCADE
);

--Szukseges sequence-ek letrehozasa
CREATE SEQUENCE UTAS_SEQUENCE START WITH 1 INCREMENT BY 1 NOMAXVALUE;
CREATE SEQUENCE SOFOR_SEQUENCE START WITH 1 INCREMENT BY 1 NOMAXVALUE;


--Teruleti es idoformatum beallitasa
ALTER SESSION SET NLS_LANGUAGE = 'HUNGARIAN';
ALTER SESSION SET NLS_TERRITORY = 'HUNGARY';
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY. MM. DD';


--BERLET_TIPUS tabla feltoltese
INSERT INTO BERLET_TIPUS VALUES ('Havi', 9500);
INSERT INTO BERLET_TIPUS VALUES ('Hetiberlet', 4950);
INSERT INTO BERLET_TIPUS VALUES ('Nyugdijas', 4500);
INSERT INTO BERLET_TIPUS VALUES ('Diak', 5000);
INSERT INTO BERLET_TIPUS VALUES ('Iskolai', 3000);
INSERT INTO BERLET_TIPUS VALUES ('Felnott', 10000);
INSERT INTO BERLET_TIPUS VALUES ('Gyermek', 2500);
INSERT INTO BERLET_TIPUS VALUES ('Csoportos', 8000);


--BERLET tabla feltoltese
INSERT INTO BERLET VALUES (134222, SYSDATE-2, SYSDATE+30, 'Havi');
INSERT INTO BERLET VALUES (523234, SYSDATE-3, SYSDATE+73, 'Nyugdijas');
INSERT INTO BERLET VALUES (435343, SYSDATE-5, SYSDATE+33, 'Diak');
INSERT INTO BERLET VALUES (723123, SYSDATE, SYSDATE+55, 'Iskolai');
INSERT INTO BERLET VALUES (834343, SYSDATE, SYSDATE+22, 'Felnott');
INSERT INTO BERLET VALUES (934234, SYSDATE-10, SYSDATE+22, 'Gyermek');
INSERT INTO BERLET VALUES (102234, SYSDATE, SYSDATE+11, 'Csoportos');
INSERT INTO BERLET VALUES (122111, SYSDATE - 110, SYSDATE, 'Havi');
INSERT INTO BERLET VALUES (123232, SYSDATE - 15, SYSDATE + 15, 'Hetiberlet');
INSERT INTO BERLET VALUES (134345, SYSDATE - 3, SYSDATE + 27, 'Nyugdijas');
INSERT INTO BERLET VALUES (343416, SYSDATE - 7, SYSDATE + 23, 'Diak');
INSERT INTO BERLET VALUES (173434, SYSDATE - 44, SYSDATE + 28, 'Iskolai');
INSERT INTO BERLET VALUES (134348, SYSDATE - 20, SYSDATE + 10, 'Felnott');
INSERT INTO BERLET VALUES (134349, SYSDATE - 25, SYSDATE + 5, 'Gyermek');
INSERT INTO BERLET VALUES (234340, SYSDATE - 11, SYSDATE + 19, 'Csoportos');


--SOFOR tabla feltoltese
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Kovacs Bela', '06201234567', 'Budapest, Kossuth Lajos u. 44', SYSDATE-10000, 'ferfi', 'B');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Nagy Eva', '06207654321', 'Debrecen, Kalmar ter 33', SYSDATE-12000, 'no', 'B');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Toth Istvan', '06203456789', 'Szeged, Becsi krt. 2-4', SYSDATE-11000, 'ferfi', 'C');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Varga Marta', '06204567891', 'Pecs, Hollo Laszlo krt. 22', SYSDATE-13000, 'no', 'D');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Horvath Peter', '06205678912', 'Gyor, Kavics utca 42', SYSDATE-14000, 'ferfi', 'E');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Szabo Julia', '06206789123', 'Kecskemet, Kristaly ter 3', SYSDATE-9500, 'no', 'F');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Kiss Gabor', '06207891234', 'Nyiregyhaza, Nagybani ter 2', SYSDATE-8500, 'ferfi', 'G');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Farkas Anna', '06208912345', 'Zalaegerszeg, Radics Laszlo u. 22', SYSDATE-7500, 'no', 'H');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Balazs Laszlo', '06201231234', 'Veszprem, Szent Benedek ter 2', SYSDATE-6500, 'ferfi', 'I');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Nemes Maria', '06202342345', 'Szombathely, Gaal Kalman krt. 33', SYSDATE-5500, 'no', 'J');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Szucs Laszlo', '06205554444', 'Eger, Dobo ter 1.', SYSDATE - 9500, 'ferfi', 'B');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Torok Eva', '06206665555', 'Sopron, Varkerulet 2.', SYSDATE - 8700, 'no', 'B');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Meszaros Jozsef', '06207776666', 'Kaposvar, Fo u. 3.', SYSDATE - 9200, 'ferfi', 'C');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Olasz Renata', '06208887777', 'Siofok, Petofi setany 4.', SYSDATE - 10100, 'no', 'D');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Kertesz Aron', '06209998888', 'Balatonfured, Tagore setany 5.', SYSDATE - 8300, 'ferfi', 'E');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Feher Krisztina', '06201112222', 'Szekesfehervar, Kiraly u. 6.', SYSDATE - 7600, 'no', 'F');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Nagy Bence', '06202223333', 'Veszprem, Ovaros ter 7.', SYSDATE - 8100, 'ferfi', 'G');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Toth Gabriella', '06203334444', 'Zalaegerszeg, Deak ter 8.', SYSDATE - 7800, 'no', 'H');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Kovacs Mate', '06204445555', 'Nagykanizsa, Erzsebet ter 9.', SYSDATE - 7400, 'ferfi', 'I');
INSERT INTO SOFOR VALUES (SOFOR_SEQUENCE.nextval, 'Erdos Viktoria', '06205556666', 'Papa, Fo ter 10.', SYSDATE - 6900, 'no', 'J');


--MENETJEGY tabla feltoltese
INSERT INTO MENETJEGY VALUES (12341, SYSDATE, SYSDATE+1, 350);
INSERT INTO MENETJEGY VALUES (24321, SYSDATE, SYSDATE+1, 450);
INSERT INTO MENETJEGY VALUES (33241, SYSDATE, SYSDATE+1, 350);
INSERT INTO MENETJEGY VALUES (42342, SYSDATE, SYSDATE+1, 350);
INSERT INTO MENETJEGY VALUES (52342, SYSDATE, SYSDATE+1, 450);
INSERT INTO MENETJEGY VALUES (62342, SYSDATE, SYSDATE+1, 350);
INSERT INTO MENETJEGY VALUES (72341, SYSDATE, SYSDATE+1, 450);
INSERT INTO MENETJEGY VALUES (82341, SYSDATE, SYSDATE+1, 350);
INSERT INTO MENETJEGY VALUES (92321, SYSDATE, SYSDATE+1, 450);
INSERT INTO MENETJEGY VALUES (10232, SYSDATE, SYSDATE+1, 350);


--GEPJARMUVEK tabla feltoltese
INSERT INTO GEPJARMUVEK VALUES ('ABC123', 'Busz', 'Ikarus', 50);
INSERT INTO GEPJARMUVEK VALUES ('DEF456', 'Villamos', 'Siemens', 80);
INSERT INTO GEPJARMUVEK VALUES ('GHI789', 'Metro', 'Alstom', 100);
INSERT INTO GEPJARMUVEK VALUES ('JKL012', 'Trolibusz', 'Solaris', 70);
INSERT INTO GEPJARMUVEK VALUES ('MNO345', 'Busz', 'Mercedes', 55);
INSERT INTO GEPJARMUVEK VALUES ('PQR678', 'Villamos', 'Bombardier', 85);
INSERT INTO GEPJARMUVEK VALUES ('STU901', 'Metró', 'Hitachi', 95);
INSERT INTO GEPJARMUVEK VALUES ('VWX234', 'Trolibusz', 'Skoda', 75);
INSERT INTO GEPJARMUVEK VALUES ('YZA567', 'Busz', 'MAN', 60);
INSERT INTO GEPJARMUVEK VALUES ('BCD890', 'Villamos', 'CAF', 90);


--JARAT tabla feltoltese
INSERT INTO JARAT VALUES (1, 'ABC123', SYSDATE, SYSDATE+1/24, 'Keleti pu.', 'Nyugati pu.');
INSERT INTO JARAT VALUES (2, 'DEF456', SYSDATE, SYSDATE+2/24, 'Deli pu.', 'Keleti pu.');
INSERT INTO JARAT VALUES (3, 'GHI789', SYSDATE, SYSDATE+1/24, 'Nyugati pu.', 'Kobanya-Kispest');
INSERT INTO JARAT VALUES (4, 'JKL012', SYSDATE, SYSDATE+2/24, 'Moricz Zs.', 'Budaorsi ut');
INSERT INTO JARAT VALUES (5, 'MNO345', SYSDATE, SYSDATE+1/24, 'Astoria', 'Blaha Lujza ter');
INSERT INTO JARAT VALUES (6, 'PQR678', SYSDATE, SYSDATE+2/24, 'Corvin negyed', 'Ferenciek tere');
INSERT INTO JARAT VALUES (7, 'STU901', SYSDATE, SYSDATE+1/24, 'Oktogon', 'Dohany utca');
INSERT INTO JARAT VALUES (8, 'VWX234', SYSDATE, SYSDATE+2/24, 'Harminckettesek tere', 'Szell Kalman ter');
INSERT INTO JARAT VALUES (9, 'YZA567', SYSDATE, SYSDATE+1/24, 'Bosnyak ter', 'Ors vezer tere');
INSERT INTO JARAT VALUES (10, 'BCD890', SYSDATE, SYSDATE+2/24, 'Klinikak', 'Nagyvarad ter');


--UTAS tabla feltoltese
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Toth Anna', '06301234567', 'Szeged, Fo ter 1.', SYSDATE-9000, 'no', 134222);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Nagy Bela', '06307654321', 'Budapest, Kossuth ter 2.', SYSDATE-11000, 'ferfi', 523234);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Kiss Csaba', '06303456789', 'Debrecen, Petofi ter 3.', SYSDATE-10000, 'ferfi', 435343);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Varga Dora', '06304567891', 'Pecs, Szabadsag ter 4.', SYSDATE-12000, 'no', 723123);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Horvath Emese', '06305678912', 'Gyor, Arany Janos u. 5.', SYSDATE-13000, 'no', 834343);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Szabo Fanni', '06306789123', 'Kecskemet, Batthyany u. 6.', SYSDATE-14000, 'no', 934234);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Kis Gergo', '06307891234', 'Nyiregyhaza, Kossuth Lajos u. 7.', SYSDATE-8500, 'ferfi', 102234);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Farkas Hilda', '06308912345', 'Zalaegerszeg, Dozsa Gy. u. 8.', SYSDATE-7500, 'no', 122111);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Balogh Istvan', '06301231234', 'Veszprem, Wartha V. u. 9.', SYSDATE-6500, 'ferfi', 123232);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Nemeth Jozsef', '06302342345', 'Szombathely, Rakoczi F. u. 10.', SYSDATE-5500, 'ferfi', 134345);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Boros Marton', '06303452123', 'Salgotarjan, Szabadsag ter 11.', SYSDATE-4600, 'ferfi', 343416);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Kovacs Norbert', '06304563234', 'Szekszard, Garay u. 12.', SYSDATE-4700, 'ferfi', 173434);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Takacs Beatrix', '06305674345', 'Szekesfehervar, Kiraly u. 13.', SYSDATE-4800, 'no', 134348);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Molnar Cecilia', '06306785456', 'Siofok, Vitorlas u. 14.', SYSDATE-4900, 'no', 134349);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Papp Dominik', '06307896567', 'Tatabanya, Szent Borbala ter 15.', SYSDATE-5000, 'ferfi', 234340);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Vincze Alex', '06308907654', 'Esztergom, Batthyany u. 16.', SYSDATE-3200, 'ferfi', NULL);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Hegedus Rita', '06309876543', 'Baja, Duna u. 17.', SYSDATE-3300, 'no', NULL);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Tamas Gergo', '06301234567', 'Kaposvar, Fo u. 18.', SYSDATE-3400, 'ferfi', NULL);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Balogh David', '06302345678', 'Nagykanizsa, Erzsebet ter 19.', SYSDATE-3500, 'ferfi', NULL);
INSERT INTO UTAS VALUES (UTAS_SEQUENCE.nextval, 'Kovacs Monika', '06303456789', 'Sopron, Varkerulet 20.', SYSDATE-3600, 'no', NULL);


--UTAZAS tabla feltoltese
INSERT INTO UTAZAS VALUES (1, 'ABC123', SYSDATE+1/24, SYSDATE);
INSERT INTO UTAZAS VALUES (2, 'DEF456', SYSDATE+2/24, SYSDATE);
INSERT INTO UTAZAS VALUES (3, 'GHI789', SYSDATE+1/24, SYSDATE);
INSERT INTO UTAZAS VALUES (4, 'JKL012', SYSDATE+2/24, SYSDATE);
INSERT INTO UTAZAS VALUES (5, 'MNO345', SYSDATE+1/24, SYSDATE);
INSERT INTO UTAZAS VALUES (6, 'PQR678', SYSDATE+2/24, SYSDATE);
INSERT INTO UTAZAS VALUES (7, 'STU901', SYSDATE+1/24, SYSDATE);
INSERT INTO UTAZAS VALUES (8, 'VWX234', SYSDATE+2/24, SYSDATE);
INSERT INTO UTAZAS VALUES (9, 'YZA567', SYSDATE+1/24, SYSDATE);
INSERT INTO UTAZAS VALUES (10, 'BCD890', SYSDATE+2/24, SYSDATE);


--JEGYNYILVANTARTAS tabla feltoltese
INSERT INTO JEGYNYILVANTARTAS VALUES (1, 12341);
INSERT INTO JEGYNYILVANTARTAS VALUES (2, 24321);
INSERT INTO JEGYNYILVANTARTAS VALUES (3, 33241);
INSERT INTO JEGYNYILVANTARTAS VALUES (4, 42342);
INSERT INTO JEGYNYILVANTARTAS VALUES (5, 52342);
INSERT INTO JEGYNYILVANTARTAS VALUES (6, 62342);
INSERT INTO JEGYNYILVANTARTAS VALUES (7, 72341);
INSERT INTO JEGYNYILVANTARTAS VALUES (8, 82341);
INSERT INTO JEGYNYILVANTARTAS VALUES (9, 92321);
INSERT INTO JEGYNYILVANTARTAS VALUES (10, 10232);
