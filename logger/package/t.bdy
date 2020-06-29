CREATE OR REPLACE PACKAGE body t
AS
  FUNCTION get_user
    RETURN VARCHAR2
  AS
    lv_user VARCHAR2(100);
    CURSOR cur_user
    IS
      --SELECT OSUSER FROM v$session WHERE audsid=userenv('sessionid');
      SELECT USER FROM dual;
  BEGIN
    OPEN cur_user;
    FETCH cur_user INTO lv_user;
    CLOSE cur_user;
    RETURN lv_user;
  END;
  FUNCTION get_str(
      pv_varchar VARCHAR2)
    RETURN VARCHAR2
  AS
  BEGIN
    IF pv_varchar IS NULL THEN
      RETURN '';
    ELSE
      RETURN pv_varchar||gv_separator;
    END IF;
  END;
  FUNCTION get_str(
      pn_number NUMBER)
    RETURN VARCHAR2
  AS
  BEGIN
    IF pn_number IS NULL THEN
      RETURN '';
    ELSE
      RETURN pn_number||gv_separator;
    END IF;
  END;
  FUNCTION get_str(
      pd_date DATE)
    RETURN VARCHAR2
  AS
  BEGIN
    IF pd_date IS NULL THEN
      RETURN '';
    ELSE
      RETURN TO_CHAR(pd_date,'YYYY-MM-DD HH24:MI:SS' )||gv_separator;
    END IF;
  END;
  FUNCTION get_str(
      pt_varchar typ_varchar_array)
    RETURN VARCHAR2
  AS
    lc_return CLOB := NULL;
  BEGIN
    IF pt_varchar IS NULL OR pt_varchar.count = 0 THEN
      RETURN '';
    ELSE
      FOR i IN pt_varchar.FIRST .. pt_varchar.LAST
      LOOP
        lc_return := lc_return||get_str(i)||gv_separator;
      END LOOP;
      lc_return := rtrim(lc_return,gv_separator);
      RETURN lc_return||gv_separator_enter;
    END IF;
  END;
  FUNCTION get_str(
      pt_number typ_number_array)
    RETURN VARCHAR2
  AS
    lc_return CLOB := NULL;
  BEGIN
    IF pt_number IS NULL OR pt_number.count = 0 THEN
      RETURN '';
    ELSE
      FOR i IN pt_number.FIRST .. pt_number.LAST
      LOOP
        lc_return := lc_return||get_str(i)||gv_separator;
      END LOOP;
      lc_return := rtrim(lc_return,gv_separator);
      RETURN lc_return||gv_separator_enter;
    END IF;
  END;
  FUNCTION get_str(
      pt_date typ_date_array)
    RETURN VARCHAR2
  AS
    lc_return CLOB := NULL;
  BEGIN
    IF pt_date IS NULL OR pt_date.count = 0 THEN
      RETURN '';
    ELSE
      FOR i IN pt_date.FIRST .. pt_date.LAST
      LOOP
        lc_return := lc_return||TO_CHAR(get_str(i),'YYYY-MM-DD HH24:MI:SS' )||gv_separator;
      END LOOP;
      lc_return := rtrim(lc_return,gv_separator);
      RETURN lc_return||gv_separator_enter;
    END IF;
  END;
  PROCEDURE log(
      pv_v1  VARCHAR2 ,
      pv_v2  VARCHAR2 DEFAULT NULL,
      pv_v3  VARCHAR2 DEFAULT NULL,
      pv_v4  VARCHAR2 DEFAULT NULL,
      pv_v5  VARCHAR2 DEFAULT NULL,
      pv_v6  VARCHAR2 DEFAULT NULL,
      pv_v7  VARCHAR2 DEFAULT NULL,
      pv_v8  VARCHAR2 DEFAULT NULL,
      pv_v9  VARCHAR2 DEFAULT NULL,
      pv_v10 VARCHAR2 DEFAULT NULL,
      pv_v11 VARCHAR2 DEFAULT NULL,
      pv_v12 VARCHAR2 DEFAULT NULL,
      pv_v13 VARCHAR2 DEFAULT NULL,
      pv_v14 VARCHAR2 DEFAULT NULL,
      pv_v15 VARCHAR2 DEFAULT NULL,
      pv_v16 VARCHAR2 DEFAULT NULL,
      pv_v17 VARCHAR2 DEFAULT NULL,
      pv_v18 VARCHAR2 DEFAULT NULL,
      pv_v19 VARCHAR2 DEFAULT NULL,
      pv_v20 VARCHAR2 DEFAULT NULL,
      pn_n1  NUMBER DEFAULT NULL,
      pn_n2  NUMBER DEFAULT NULL,
      pn_n3  NUMBER DEFAULT NULL,
      pd_d1  DATE DEFAULT NULL,
      pd_d2  DATE DEFAULT NULL,
      pd_d3  DATE DEFAULT NULL,
      pc_c1 CLOB DEFAULT NULL,
      pc_c2 CLOB DEFAULT NULL,
      pc_c3 CLOB DEFAULT NULL,
      pb_b1 BLOB DEFAULT NULL,
      pb_b2 BLOB DEFAULT NULL,
      pb_b3 BLOB DEFAULT NULL )
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
    lv_v2            VARCHAR2(4000);
    ln_error_code    INTEGER;
    lv_error_message VARCHAR2(4000);
  BEGIN
    lv_v2 := get_str(pv_v2)||get_str(pv_v3)||get_str(pv_v4)||get_str(pv_v5)||get_str(pv_v6)||get_str(pv_v7)||get_str(pv_v8)||get_str(pv_v9)||get_str(pv_v10)||get_str(pv_v11)||get_str(pv_v12)||get_str(pv_v13)||get_str(pv_v14)||get_str(pv_v15)||get_str(pv_v16)||get_str(pv_v17)||get_str(pv_v18)||get_str(pv_v19)||get_str(pv_v20);
    lv_v2 := rtrim(lv_v2,gv_separator);
    INSERT
    INTO t_log
      (
        v1,
        v2,
        v3,
        n1,
        n2,
        n3,
        d1,
        d2,
        d3,
        c1,
        c2,
        c3,
        b1,
        b2,
        b3
      )
      VALUES
      (
        pv_v1,
        lv_v2,
        get_user,
        pn_n1,
        pn_n2,
        pn_n3,
        pd_d1,
        pd_d2,
        pd_d3,
        pc_c1,
        pc_c2,
        pc_c3,
        pb_b1,
        pb_b2,
        pb_b3
      );
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    ln_error_code    := SQLCODE;
    lv_error_message := sqlerrm;
    INSERT
    INTO t_log
      (
        v1,
        v3,
        n1,
        v2
      )
      VALUES
      (
        pv_v1,
        get_user,
        ln_error_code,
        lv_error_message
      );
    COMMIT;
  END;
  PROCEDURE log
    (
      pv_v1  VARCHAR2 ,
      pn_n1  NUMBER ,
      pn_n2  NUMBER DEFAULT NULL,
      pn_n3  NUMBER DEFAULT NULL,
      pn_n4  NUMBER DEFAULT NULL,
      pn_n5  NUMBER DEFAULT NULL,
      pn_n6  NUMBER DEFAULT NULL,
      pn_n7  NUMBER DEFAULT NULL,
      pn_n8  NUMBER DEFAULT NULL,
      pn_n9  NUMBER DEFAULT NULL,
      pn_n10 NUMBER DEFAULT NULL,
      pn_n11 NUMBER DEFAULT NULL,
      pn_n12 NUMBER DEFAULT NULL,
      pn_n13 NUMBER DEFAULT NULL,
      pn_n14 NUMBER DEFAULT NULL,
      pn_n15 NUMBER DEFAULT NULL,
      pn_n16 NUMBER DEFAULT NULL,
      pn_n17 NUMBER DEFAULT NULL,
      pn_n18 NUMBER DEFAULT NULL,
      pn_n19 NUMBER DEFAULT NULL,
      pn_n20 NUMBER DEFAULT NULL
    )
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
    lv_v2 VARCHAR2(4000);
  BEGIN
    lv_v2 := get_str(pn_n1)||get_str(pn_n2)||get_str(pn_n3)||get_str(pn_n4)||get_str(pn_n5)||get_str(pn_n6)||get_str(pn_n7)||get_str(pn_n8)||get_str(pn_n9)||get_str(pn_n10)||get_str(pn_n11)||get_str(pn_n12)||get_str(pn_n13)||get_str(pn_n14)||get_str(pn_n15)||get_str(pn_n16)||get_str(pn_n17)||get_str(pn_n18)||get_str(pn_n19)||get_str(pn_n20);
    lv_v2 := rtrim(lv_v2,gv_separator);
    log( pv_v1 => pv_v1, pv_v2 => lv_v2, pv_v3 => get_user);
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    log( pv_v1 => pv_v1, pv_v3 => get_user, pn_n1 => SQLCODE, pv_v2 => SQLERRM);
    COMMIT;
  END;
  PROCEDURE log
    (
      pv_v1  VARCHAR2,
      pd_d1  DATE ,
      pd_d2  DATE DEFAULT NULL,
      pd_d3  DATE DEFAULT NULL,
      pd_d4  DATE DEFAULT NULL,
      pd_d5  DATE DEFAULT NULL,
      pd_d6  DATE DEFAULT NULL,
      pd_d7  DATE DEFAULT NULL,
      pd_d8  DATE DEFAULT NULL,
      pd_d9  DATE DEFAULT NULL,
      pd_d10 DATE DEFAULT NULL,
      pd_d11 DATE DEFAULT NULL,
      pd_d12 DATE DEFAULT NULL,
      pd_d13 DATE DEFAULT NULL,
      pd_d14 DATE DEFAULT NULL,
      pd_d15 DATE DEFAULT NULL,
      pd_d16 DATE DEFAULT NULL,
      pd_d17 DATE DEFAULT NULL,
      pd_d18 DATE DEFAULT NULL,
      pd_d19 DATE DEFAULT NULL,
      pd_d20 DATE DEFAULT NULL
    )
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
    lv_v2 VARCHAR2(4000);
  BEGIN
    lv_v2 := get_str(pd_d1)||get_str(pd_d2)||get_str(pd_d3)||get_str(pd_d4)||get_str(pd_d5)||get_str(pd_d6)||get_str(pd_d7)||get_str(pd_d8)||get_str(pd_d9)||get_str(pd_d10)||get_str(pd_d11)||get_str(pd_d12)||get_str(pd_d13)||get_str(pd_d14)||get_str(pd_d15)||get_str(pd_d16)||get_str(pd_d17)||get_str(pd_d18)||get_str(pd_d19)||get_str(pd_d20);
    lv_v2 := rtrim(lv_v2,gv_separator);
    log( pv_v1 => pv_v1, pv_v2 => lv_v2, pv_v3 => get_user);
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    log( pv_v1 => pv_v1, pv_v3 => get_user, pn_n1 => SQLCODE, pv_v2 => SQLERRM);
    COMMIT;
  END;
  PROCEDURE log
    (
      pv_v1 VARCHAR2 ,
      pc_c1 CLOB,
      pc_c2 CLOB DEFAULT NULL,
      pc_c3 CLOB DEFAULT NULL
    )
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    log( pv_v1 => pv_v1, pc_c1 => pc_c1, pc_c2 => pc_c2, pc_c3 => pc_c3, pv_v3 => get_user);
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    log( pv_v1 => pv_v1, pv_v3 => get_user, pn_n1 => SQLCODE, pv_v2 => SQLERRM);
    COMMIT;
  END;
  PROCEDURE log
    (
      pv_v1 VARCHAR2 ,
      pb_b1 BLOB,
      pb_b2 BLOB DEFAULT NULL,
      pb_b3 BLOB DEFAULT NULL
    )
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    log( pv_v1 => pv_v1, pb_b1 => pb_b1, pb_b2 => pb_b2, pb_b3 => pb_b3, pv_v3 => get_user);
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    log( pv_v1 => pv_v1, pv_v3 => get_user, pn_n1 => SQLCODE, pv_v2 => SQLERRM);
    COMMIT;
  END;
  PROCEDURE log
    (
      pv_v1 VARCHAR2 ,
      pt_v1 typ_varchar_array,
      pt_v2 typ_varchar_array DEFAULT NULL,
      pt_v3 typ_varchar_array DEFAULT NULL,
      pt_v4 typ_varchar_array DEFAULT NULL,
      pt_v5 typ_varchar_array DEFAULT NULL,
      pt_v6 typ_varchar_array DEFAULT NULL,
      pt_v7 typ_varchar_array DEFAULT NULL,
      pt_v8 typ_varchar_array DEFAULT NULL,
      pt_v9 typ_varchar_array DEFAULT NULL,
      pt_v10 typ_varchar_array DEFAULT NULL,
      pt_v11 typ_varchar_array DEFAULT NULL,
      pt_v12 typ_varchar_array DEFAULT NULL,
      pt_v13 typ_varchar_array DEFAULT NULL,
      pt_v14 typ_varchar_array DEFAULT NULL,
      pt_v15 typ_varchar_array DEFAULT NULL,
      pt_v16 typ_varchar_array DEFAULT NULL,
      pt_v17 typ_varchar_array DEFAULT NULL,
      pt_v18 typ_varchar_array DEFAULT NULL,
      pt_v19 typ_varchar_array DEFAULT NULL,
      pt_v20 typ_varchar_array DEFAULT NULL
    )
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
    lc_c1 CLOB;
  BEGIN
    lc_c1 := lc_c1|| get_str(pt_v1 )|| get_str(pt_v2 )|| get_str(pt_v3 )|| get_str(pt_v4 )|| get_str(pt_v5 )|| get_str(pt_v6 )|| get_str(pt_v7 )|| get_str(pt_v8 )|| get_str(pt_v9 )|| get_str(pt_v10 )|| get_str(pt_v11 )|| get_str(pt_v12 )|| get_str(pt_v13 )|| get_str(pt_v14 )|| get_str(pt_v15 )|| get_str(pt_v16 )|| get_str(pt_v17 )|| get_str(pt_v18 )|| get_str(pt_v19 )|| get_str(pt_v20 );
    lc_c1 := rtrim(lc_c1,gv_separator_enter);
    log( pv_v1 => pv_v1, pc_c1 => lc_c1, pv_v3 => get_user);
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    log( pv_v1 => pv_v1, pv_v3 => get_user, pn_n1 => SQLCODE, pv_v2 => SQLERRM);
    COMMIT;
  END;
  PROCEDURE log
    (
      pv_v1 VARCHAR2 ,
      pt_n1 typ_number_array,
      pt_n2 typ_number_array DEFAULT NULL,
      pt_n3 typ_number_array DEFAULT NULL,
      pt_n4 typ_number_array DEFAULT NULL,
      pt_n5 typ_number_array DEFAULT NULL,
      pt_n6 typ_number_array DEFAULT NULL,
      pt_n7 typ_number_array DEFAULT NULL,
      pt_n8 typ_number_array DEFAULT NULL,
      pt_n9 typ_number_array DEFAULT NULL,
      pt_n10 typ_number_array DEFAULT NULL,
      pt_n11 typ_number_array DEFAULT NULL,
      pt_n12 typ_number_array DEFAULT NULL,
      pt_n13 typ_number_array DEFAULT NULL,
      pt_n14 typ_number_array DEFAULT NULL,
      pt_n15 typ_number_array DEFAULT NULL,
      pt_n16 typ_number_array DEFAULT NULL,
      pt_n17 typ_number_array DEFAULT NULL,
      pt_n18 typ_number_array DEFAULT NULL,
      pt_n19 typ_number_array DEFAULT NULL,
      pt_n20 typ_number_array DEFAULT NULL
    )
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
    lc_c1 CLOB;
  BEGIN
    lc_c1 := lc_c1|| get_str(pt_n1 )|| get_str(pt_n2 )|| get_str(pt_n3 )|| get_str(pt_n4 )|| get_str(pt_n5 )|| get_str(pt_n6 )|| get_str(pt_n7 )|| get_str(pt_n8 )|| get_str(pt_n9 )|| get_str(pt_n10 )|| get_str(pt_n11 )|| get_str(pt_n12 )|| get_str(pt_n13 )|| get_str(pt_n14 )|| get_str(pt_n15 )|| get_str(pt_n16 )|| get_str(pt_n17 )|| get_str(pt_n18 )|| get_str(pt_n19 )|| get_str(pt_n20 );
    lc_c1 := rtrim(lc_c1,gv_separator_enter);
    log( pv_v1 => pv_v1, pc_c1 => lc_c1, pv_v3 => get_user);
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    log( pv_v1 => pv_v1, pv_v3 => get_user, pn_n1 => SQLCODE, pv_v2 => SQLERRM);
    COMMIT;
  END;
  PROCEDURE log
    (
      pv_v1 VARCHAR2 ,
      pt_d1 typ_date_array,
      pt_d2 typ_date_array DEFAULT NULL,
      pt_d3 typ_date_array DEFAULT NULL,
      pt_d4 typ_date_array DEFAULT NULL,
      pt_d5 typ_date_array DEFAULT NULL,
      pt_d6 typ_date_array DEFAULT NULL,
      pt_d7 typ_date_array DEFAULT NULL,
      pt_d8 typ_date_array DEFAULT NULL,
      pt_d9 typ_date_array DEFAULT NULL,
      pt_d10 typ_date_array DEFAULT NULL,
      pt_d11 typ_date_array DEFAULT NULL,
      pt_d12 typ_date_array DEFAULT NULL,
      pt_d13 typ_date_array DEFAULT NULL,
      pt_d14 typ_date_array DEFAULT NULL,
      pt_d15 typ_date_array DEFAULT NULL,
      pt_d16 typ_date_array DEFAULT NULL,
      pt_d17 typ_date_array DEFAULT NULL,
      pt_d18 typ_date_array DEFAULT NULL,
      pt_d19 typ_date_array DEFAULT NULL,
      pt_d20 typ_date_array DEFAULT NULL
    )
  AS
    PRAGMA AUTONOMOUS_TRANSACTION;
    lc_c1 CLOB;
  BEGIN
    lc_c1 := lc_c1|| get_str(pt_d1 )|| get_str(pt_d2 )|| get_str(pt_d3 )|| get_str(pt_d4 )|| get_str(pt_d5 )|| get_str(pt_d6 )|| get_str(pt_d7 )|| get_str(pt_d8 )|| get_str(pt_d9 )|| get_str(pt_d10 )|| get_str(pt_d11 )|| get_str(pt_d12 )|| get_str(pt_d13 )|| get_str(pt_d14 )|| get_str(pt_d15 )|| get_str(pt_d16 )|| get_str(pt_d17 )|| get_str(pt_d18 )|| get_str(pt_d19 )|| get_str(pt_d20 );
    lc_c1 := rtrim(lc_c1,gv_separator_enter);
    log( pv_v1 => pv_v1, pc_c1 => lc_c1, pv_v3 => get_user);
    COMMIT;
  EXCEPTION
  WHEN OTHERS THEN
    log( pv_v1 => pv_v1, pv_v3 => get_user, pn_n1 => SQLCODE, pv_v2 => SQLERRM);
    COMMIT;
  END;
END;
/
