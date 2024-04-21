-- Author: Hoki Attila
-- Created: 2024-04-21
-- Task 5 - TEST


-- INSTEAD OF INSERT trigger tesztelese valid inputra
INSERT INTO BerletInformacio (vasarlasi_datum, ar) VALUES (TO_DATE('2024-04-20', 'YYYY-MM-DD'), 3000);
INSERT INTO BerletInformacio (vasarlasi_datum, ar) VALUES (TO_DATE('2024-04-20', 'YYYY-MM-DD'), 9500);

-- INSTEAD OF INSERT trigger tesztelese invalid inputra
INSERT INTO BerletInformacio (vasarlasi_datum, ar) VALUES (TO_DATE('2024-03-10', 'YYYY-MM-DD'), 3423423423423423423);
INSERT INTO BerletInformacio (vasarlasi_datum, ar) VALUES (TO_DATE('2024-03-10', 'YYYY-MM-DD'), 232323);


-- INSTEAD OF INSERT trigger tesztelese valid inputra
UPDATE BerletInformacio
SET ar = 4950
WHERE TRUNC(vasarlasi_datum) = TO_DATE('2024. 04. 20', 'YYYY. MM. DD');


UPDATE BerletInformacio
SET ar = 4950
WHERE TRUNC(vasarlasi_datum) = TO_DATE('2024. 04. 11', 'YYYY. MM. DD');


-- INSTEAD OF INSERT trigger tesztelese invalid inputra
UPDATE BerletInformacio
SET ar = -44
WHERE TRUNC(vasarlasi_datum) = TO_DATE('2024. 04. 20', 'YYYY. MM. DD');

UPDATE BerletInformacio
SET ar = 22
WHERE TRUNC(vasarlasi_datum) = TO_DATE('2024. 04. 20', 'YYYY. MM. DD');