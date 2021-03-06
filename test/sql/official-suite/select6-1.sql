-- original: select6.test
-- credit:   http://www.sqlite.org/src/tree?ci=trunk&name=test

BEGIN;
    CREATE TABLE t1(x, y);
    INSERT INTO t1 VALUES(1,1);
    INSERT INTO t1 VALUES(2,2);
    INSERT INTO t1 VALUES(3,2);
    INSERT INTO t1 VALUES(4,3);
    INSERT INTO t1 VALUES(5,3);
    INSERT INTO t1 VALUES(6,3);
    INSERT INTO t1 VALUES(7,3);
    INSERT INTO t1 VALUES(8,4);
    INSERT INTO t1 VALUES(9,4);
    INSERT INTO t1 VALUES(10,4);
    INSERT INTO t1 VALUES(11,4);
    INSERT INTO t1 VALUES(12,4);
    INSERT INTO t1 VALUES(13,4);
    INSERT INTO t1 VALUES(14,4);
    INSERT INTO t1 VALUES(15,4);
    INSERT INTO t1 VALUES(16,5);
    INSERT INTO t1 VALUES(17,5);
    INSERT INTO t1 VALUES(18,5);
    INSERT INTO t1 VALUES(19,5);
    INSERT INTO t1 VALUES(20,5);
    COMMIT;
    SELECT DISTINCT y FROM t1 ORDER BY y
;SELECT count(*) FROM (SELECT y FROM t1)
;SELECT count(*) FROM (SELECT DISTINCT y FROM t1)
;SELECT count(*) FROM (SELECT DISTINCT * FROM (SELECT y FROM t1))
;SELECT count(*) FROM (SELECT * FROM (SELECT DISTINCT y FROM t1))
;SELECT * 
    FROM (SELECT count(*),y FROM t1 GROUP BY y) AS a,
         (SELECT max(x),y FROM t1 GROUP BY y) as b
    WHERE a.y=b.y ORDER BY a.y
;SELECT a.y, a.[count(*)], [max(x)], [count(*)]
    FROM (SELECT count(*),y FROM t1 GROUP BY y) AS a,
         (SELECT max(x),y FROM t1 GROUP BY y) as b
    WHERE a.y=b.y ORDER BY a.y
;SELECT q, p, r
    FROM (SELECT count(*) as p , y as q FROM t1 GROUP BY y) AS a,
         (SELECT max(x) as r, y as s FROM t1 GROUP BY y) as b
    WHERE q=s ORDER BY s
;SELECT q, p, r, b.[min(x)+y]
    FROM (SELECT count(*) as p , y as q FROM t1 GROUP BY y) AS a,
         (SELECT max(x) as r, y as s, min(x)+y FROM t1 GROUP BY y) as b
    WHERE q=s ORDER BY s
;CREATE TABLE t2(a INTEGER PRIMARY KEY, b);
    INSERT INTO t2 SELECT * FROM t1;
    SELECT DISTINCT b FROM t2 ORDER BY b
;SELECT count(*) FROM (SELECT b FROM t2)
;SELECT count(*) FROM (SELECT DISTINCT b FROM t2)
;SELECT count(*) FROM (SELECT DISTINCT * FROM (SELECT b FROM t2))
;SELECT count(*) FROM (SELECT * FROM (SELECT DISTINCT b FROM t2))
;SELECT * 
    FROM (SELECT count(*),b FROM t2 GROUP BY b) AS a,
         (SELECT max(a),b FROM t2 GROUP BY b) as b
    WHERE a.b=b.b ORDER BY a.b
;SELECT a.b, a.[count(*)], [max(a)], [count(*)]
    FROM (SELECT count(*),b FROM t2 GROUP BY b) AS a,
         (SELECT max(a),b FROM t2 GROUP BY b) as b
    WHERE a.b=b.b ORDER BY a.b
;SELECT q, p, r
    FROM (SELECT count(*) as p , b as q FROM t2 GROUP BY b) AS a,
         (SELECT max(a) as r, b as s FROM t2 GROUP BY b) as b
    WHERE q=s ORDER BY s
;SELECT a.q, a.p, b.r
    FROM (SELECT count(*) as p , b as q FROM t2 GROUP BY q) AS a,
         (SELECT max(a) as r, b as s FROM t2 GROUP BY s) as b
    WHERE a.q=b.s ORDER BY a.q
;SELECT * FROM
      (SELECT a.q, a.p, b.r
       FROM (SELECT count(*) as p , b as q FROM t2 GROUP BY q) AS a,
            (SELECT max(a) as r, b as s FROM t2 GROUP BY s) as b
       WHERE a.q=b.s ORDER BY a.q)
    ORDER BY "a.q"
;SELECT a,b,a+b FROM (SELECT avg(x) as 'a', avg(y) as 'b' FROM t1)
;SELECT a,b,a+b FROM (SELECT avg(x) as 'a', avg(y) as 'b' FROM t1 WHERE y=4)
;SELECT x,y,x+y FROM (SELECT avg(a) as 'x', avg(b) as 'y' FROM t2 WHERE a=4)
;SELECT a,b,a+b FROM (SELECT avg(x) as 'a', avg(y) as 'b' FROM t1)
    WHERE a>10
;SELECT a,b,a+b FROM (SELECT avg(x) as 'a', avg(y) as 'b' FROM t1)
    WHERE a<10
;SELECT a,b,a+b FROM (SELECT avg(x) as 'a', avg(y) as 'b' FROM t1 WHERE y=4)
    WHERE a>10
;SELECT a,b,a+b FROM (SELECT avg(x) as 'a', avg(y) as 'b' FROM t1 WHERE y=4)
    WHERE a<10
;SELECT a,b,a+b FROM (SELECT avg(x) as 'a', y as 'b' FROM t1 GROUP BY b)
    ORDER BY a
;SELECT a,b,a+b FROM 
       (SELECT avg(x) as 'a', y as 'b' FROM t1 GROUP BY b)
    WHERE b<4 ORDER BY a
;SELECT a,b,a+b FROM 
       (SELECT avg(x) as 'a', y as 'b' FROM t1 GROUP BY b HAVING a>1)
    WHERE b<4 ORDER BY a
;SELECT a,b,a+b FROM 
       (SELECT avg(x) as 'a', y as 'b' FROM t1 GROUP BY b HAVING a>1)
    ORDER BY a
;SELECT [count(*)],y FROM (SELECT count(*), y FROM t1 GROUP BY y)
    ORDER BY [count(*)]
;SELECT [count(*)],y FROM (SELECT count(*), y FROM t1 GROUP BY y)
    ORDER BY y
;SELECT a,b,c FROM 
      (SELECT x AS 'a', y AS 'b', x+y AS 'c' FROM t1 WHERE y=4)
    WHERE a<10 ORDER BY a
;SELECT y FROM (SELECT DISTINCT y FROM t1) WHERE y<5 ORDER BY y
;SELECT DISTINCT y FROM (SELECT y FROM t1) WHERE y<5 ORDER BY y
;SELECT avg(y) FROM (SELECT DISTINCT y FROM t1) WHERE y<5 ORDER BY y
;SELECT avg(y) FROM (SELECT DISTINCT y FROM t1 WHERE y<5) ORDER BY y
;SELECT a,x,b FROM
      (SELECT x+3 AS 'a', x FROM t1 WHERE y=3) AS 'p',
      (SELECT x AS 'b' FROM t1 WHERE y=4) AS 'q'
    WHERE a=b
    ORDER BY a
;SELECT a,x,b FROM
      (SELECT x+3 AS 'a', x FROM t1 WHERE y=3),
      (SELECT x AS 'b' FROM t1 WHERE y=4)
    WHERE a=b
    ORDER BY a
;DELETE FROM t1 WHERE x>4;
    SELECT * FROM t1
;SELECT * FROM (
        SELECT x AS 'a' FROM t1 UNION ALL SELECT x+10 AS 'a' FROM t1
      ) ORDER BY a
;SELECT * FROM (
        SELECT x AS 'a' FROM t1 UNION ALL SELECT x+1 AS 'a' FROM t1
      ) ORDER BY a
;SELECT * FROM (
        SELECT x AS 'a' FROM t1 UNION SELECT x+1 AS 'a' FROM t1
      ) ORDER BY a
;SELECT * FROM (
        SELECT x AS 'a' FROM t1 INTERSECT SELECT x+1 AS 'a' FROM t1
      ) ORDER BY a
;SELECT * FROM (
        SELECT x AS 'a' FROM t1 EXCEPT SELECT x*2 AS 'a' FROM t1
      ) ORDER BY a
;SELECT * FROM (SELECT 1)
;SELECT c,b,a,* FROM (SELECT 1 AS 'a', 2 AS 'b', 'abc' AS 'c')
;SELECT c,b,a,* FROM (SELECT 1 AS 'a', 2 AS 'b', 'abc' AS 'c' WHERE 0)
;BEGIN;
    CREATE TABLE t3(p,q);
    INSERT INTO t3 VALUES(1,11);
    INSERT INTO t3 VALUES(2,22);
    CREATE TABLE t4(q,r);
    INSERT INTO t4 VALUES(11,111);
    INSERT INTO t4 VALUES(22,222);
    COMMIT;
    SELECT * FROM t3 NATURAL JOIN t4
;SELECT y, p, q, r FROM
       (SELECT t1.y AS y, t2.b AS b FROM t1, t2 WHERE t1.x=t2.a) AS m,
       (SELECT t3.p AS p, t3.q AS q, t4.r AS r FROM t3 NATURAL JOIN t4) as n
    WHERE  y=p
;SELECT DISTINCT y, p, q, r FROM
       (SELECT t1.y AS y, t2.b AS b FROM t1, t2 WHERE t1.x=t2.a) AS m,
       (SELECT t3.p AS p, t3.q AS q, t4.r AS r FROM t3 NATURAL JOIN t4) as n
    WHERE  y=p
;SELECT * FROM 
      (SELECT y, p, q, r FROM
         (SELECT t1.y AS y, t2.b AS b FROM t1, t2 WHERE t1.x=t2.a) AS m,
         (SELECT t3.p AS p, t3.q AS q, t4.r AS r FROM t3 NATURAL JOIN t4) as n
      WHERE  y=p) AS e,
      (SELECT r AS z FROM t4 WHERE q=11) AS f
    WHERE e.r=f.z
;SELECT a.x, b.x FROM t1 AS a, (SELECT x FROM t1 LIMIT 2) AS b
     ORDER BY 1, 2
;SELECT x FROM (SELECT x FROM t1 LIMIT 2)
;SELECT x FROM (SELECT x FROM t1 LIMIT 2 OFFSET 1)
;SELECT x FROM (SELECT x FROM t1) LIMIT 2
;SELECT x FROM (SELECT x FROM t1) LIMIT 2 OFFSET 1
;SELECT x FROM (SELECT x FROM t1 LIMIT 2) LIMIT 3
;SELECT x FROM (SELECT x FROM t1 LIMIT -1) LIMIT 3
;SELECT x FROM (SELECT x FROM t1 LIMIT -1)
;SELECT x FROM (SELECT x FROM t1 LIMIT -1 OFFSET 1)
;SELECT x, y FROM (SELECT x, (SELECT 10+x) y FROM t1 LIMIT -1 OFFSET 1)
;SELECT x, y FROM (SELECT x, (SELECT 10)+x y FROM t1 LIMIT -1 OFFSET 1)
;CREATE TABLE t(i,j,k);
  CREATE TABLE j(l,m);
  CREATE TABLE k(o)
;SELECT * FROM (SELECT * FROM t), j
;DROP TABLE IF EXISTS t1;
  CREATE TABLE t1(w INT, x INT);
  INSERT INTO t1(w,x)
   VALUES(1,10),(2,20),(3,30),
         (2,21),(3,31),
         (3,32);
  CREATE INDEX t1wx ON t1(w,x);

  DROP TABLE IF EXISTS t2;
  CREATE TABLE t2(w INT, y VARCHAR(8));
  INSERT INTO t2(w,y) VALUES(1,'one'),(2,'two'),(3,'three'),(4,'four');
  CREATE INDEX t2wy ON t2(w,y);

  SELECT cnt, xyz, (SELECT y FROM t2 WHERE w=cnt), '|'
    FROM (SELECT count(*) AS cnt, w AS xyz FROM t1 GROUP BY 2)
   ORDER BY cnt, xyz
;SELECT cnt, xyz, lower((SELECT y FROM t2 WHERE w=cnt)), '|'
    FROM (SELECT count(*) AS cnt, w AS xyz FROM t1 GROUP BY 2)
   ORDER BY cnt, xyz
;SELECT cnt, xyz, '|'
    FROM (SELECT count(*) AS cnt, w AS xyz FROM t1 GROUP BY 2)
   WHERE (SELECT y FROM t2 WHERE w=cnt)!='two'
   ORDER BY cnt, xyz
;SELECT cnt, xyz, '|'
    FROM (SELECT count(*) AS cnt, w AS xyz FROM t1 GROUP BY 2)
   ORDER BY lower((SELECT y FROM t2 WHERE w=cnt))
;SELECT cnt, xyz, 
         CASE WHEN (SELECT y FROM t2 WHERE w=cnt)=='two'
              THEN 'aaa' ELSE 'bbb'
          END, '|'
    FROM (SELECT count(*) AS cnt, w AS xyz FROM t1 GROUP BY 2)
   ORDER BY +cnt
;DROP TABLE t1;
  DROP TABLE t2;
  CREATE TABLE t1(x);
  CREATE TABLE t2(y, z);
  SELECT ( SELECT y FROM t2 WHERE z = cnt )
    FROM ( SELECT count(*) AS cnt FROM t1 );