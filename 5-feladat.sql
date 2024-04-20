CREATE VIEW UtasBerletNevLejarat AS
SELECT U.nev AS UtasNev, B.lejarati_datum AS BerletLejarat
FROM UTAS U
JOIN BERLET B ON U.berlet_szam = B.berlet_szam;

