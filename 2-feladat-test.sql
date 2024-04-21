-- Author: Hoki Attila
-- Created: 2024-04-18
-- Task 2 - TEST

-- Teszteles valid inputra
EXECUTE BerletekVasarlasDatumSzerint('2024-04-18');
EXECUTE BerletekVasarlasDatumSzerint('2024-03-27');



-- Teszteles invalid inputra
EXECUTE BerletekVasarlasDatumSzerint('2010-03-22');
EXECUTE BerletekVasarlasDatumSzerint('2011-11-11');