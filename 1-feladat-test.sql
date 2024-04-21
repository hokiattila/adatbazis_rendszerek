-- Author: Hoki Attila
-- Created: 2024-04-18
-- Task 1 - TEST

-- Teszteles valid inputra
EXECUTE BerletFelvitel(BERLET_SEQUENCE.nextval, '2024-02-01', '2024-08-01', 'Havi');
EXECUTE BerletFelvitel(BERLET_SEQUENCE.nextval, '2024-04-01', '2024-05-01', 'Nyugdijas');

-- Teszteles invalid inputra (nem letezo berlettipus)
EXECUTE BerletFelvitel(BERLET_SEQUENCE.nextval, '2024-04-01', '2024-05-01', 'Nemletezo');
EXECUTE BerletFelvitel(BERLET_SEQUENCE.nextval, '2024-04-01', '2024-05-01', 'EzSem');