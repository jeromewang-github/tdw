drop table dest_j1;

CREATE TABLE dest_j1(key STRING, value STRING, val2 STRING) STORED AS TEXTFILE;

EXPLAIN EXTENDED
INSERT OVERWRITE TABLE dest_j1
SELECT /*+ MAPJOIN(x) */ x.key, x.value, subq1.value
FROM 
( SELECT x.key as key, x.value as value from src x where x.key < 20
     UNION ALL
  SELECT x1.key as key, x1.value as value from src x1 where x1.key > 100
) subq1
JOIN src1 x ON (x.key = subq1.key);

INSERT OVERWRITE TABLE dest_j1
SELECT /*+ MAPJOIN(x) */ x.key, x.value, subq1.value
FROM 
( SELECT x.key as key, x.value as value from src x where x.key < 20
     UNION ALL
  SELECT x1.key as key, x1.value as value from src x1 where x1.key > 100
) subq1
JOIN src1 x ON (x.key = subq1.key);

select * from dest_j1 x order by x.key;

drop table dest_j1;

