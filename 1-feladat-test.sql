-- Author: Hoki Attila
-- Created: 2024-04-18
-- Task 1 - TEST

-- Teszteles valid inputra
EXECUTE BerletFelvitel(324542, '2024-02-01', '2024-08-01', 'Havi');
EXECUTE BerletFelvitel(653453, '2024-04-01', '2024-05-01', 'Nyugdijas');

-- Teszteles invalid inputra (nem letezo berlettipus)
EXECUTE BerletFelvitel(342345, '2024-04-01', '2024-05-01', 'Nemletezo');
EXECUTE BerletFelvitel(436315, '2024-04-01', '2024-05-01', 'EzSem');