CREATE TABLE t_log
  (
    log_id NUMBER PRIMARY KEY,
    v1     VARCHAR2(4000),
    v2     VARCHAR2(4000),
    v3     VARCHAR2(4000),
    n1     NUMBER,
    n2     NUMBER,
    n3     NUMBER,
    d1     DATE,
    d2     DATE,
    d3     DATE,
    c1 CLOB,
    c2 CLOB,
    c3 CLOB,
    b1 BLOB,
    b2 BLOB,
    b3 BLOB,
    create_date DATE DEFAULT SYSDATE,
    update_date DATE DEFAULT SYSDATE
  ); 