# Logger

A simple log system for Oracle to make logging easy.

## Advantages

- Accept parameter of multiple types

- Accept multiple parameters of same type

- Accept multiple parameters of mixed types

- One instance, one logger , create once
- Utilize autonomous transaction

## Deployment

Run `install_schema.bat` or `install_schema.sh` to deploy it.

## Usage

Log data is inserted into log table `t_log`. Check data in this table after running the procedures.

```
SELECT * FROM t_log t;
```

**Accept parameter of multiple types - VARCHAR2, NUMBER, DATE**

```
CALL t.log('Hello world!');
CALL t.log('NUMBER TEST 1',1);
CALL t.log('DATE TEST 1',sysdate);
```

**Accept parameter of multiple types - CLOB, BLOB**

```
DECLARE
  lc_clob CLOB;
BEGIN
  lc_clob := 'Long string....................';
  t.log('CLOB TEST',lc_clob);
END;
/
```

**Accept parameter of multiple types - VARCHAR2 Type**

```
DECLARE
  lt_varchar typ_varchar_array;
BEGIN
  lt_varchar := typ_varchar_array('VARCHAR 1','VARCHAR 2','VARCHAR 3','VARCHAR 4','VARCHAR 5');
  t.log('VARCHAR ARRAY TEST',lt_varchar);
END;
/
```

**Accept parameter of multiple types - NUMBER Type**

```
DECLARE
  lt_number typ_number_array;
BEGIN
  lt_number := typ_number_array(1,2,3,4,5);
  t.log('NUMBER ARRAY TEST',lt_number);
END;
/
```

**Accept parameter of multiple types - DATE Type**

```
DECLARE
  lt_date typ_date_array;
BEGIN
  lt_date := typ_date_array(sysdate-1,sysdate-2,sysdate-3,sysdate-4,sysdate-5);
  t.log('DATE ARRAY TEST',lt_date);
END;
/
```

**Accept multiple parameters of same type-VARCHAR2, NUMBER, DATE**

```
CALL t.log('STRING TEST','String A','String B','String C','String D','String E');
CALL t.log('NUMBER TEST 2',1,2,3,4,5);
CALL t.log('DATE TEST 2',sysdate-1,sysdate-2,sysdate-3,sysdate,sysdate);
```

**Accept multiple parameters of same type – CLOB, BLOB**

```
DECLARE
  lc_clob1 CLOB;
  lc_clob2 CLOB;
  lc_clob3 CLOB;
BEGIN
  lc_clob1 := 'Long string1....................';
  lc_clob2 := 'Long string2....................';
  lc_clob3 := 'Long string3....................';
  t.log('MULTIPLE CLOBS TEST',lc_clob1,lc_clob2,lc_clob3);
END;
/
```

**Accept multiple parameters of same type – VARCHAR2 Type**

```
DECLARE
  lt_varchar1 typ_varchar_array;
  lt_varchar2 typ_varchar_array;
  lt_varchar3 typ_varchar_array;
  lt_varchar4 typ_varchar_array;
  lt_varchar5 typ_varchar_array;
BEGIN
  lt_varchar1 := typ_varchar_array('VARCHAR 1','VARCHAR 2','VARCHAR 3','VARCHAR 4','VARCHAR 5');
  lt_varchar2 := typ_varchar_array('VARCHAR 1','VARCHAR 2','VARCHAR 3','VARCHAR 4','VARCHAR 5');
  lt_varchar3 := typ_varchar_array('VARCHAR 1','VARCHAR 2','VARCHAR 3','VARCHAR 4','VARCHAR 5');
  lt_varchar4 := typ_varchar_array('VARCHAR 1','VARCHAR 2','VARCHAR 3','VARCHAR 4','VARCHAR 5');
  lt_varchar5 := typ_varchar_array('VARCHAR 1','VARCHAR 2','VARCHAR 3','VARCHAR 4','VARCHAR 5');
  t.log('VARCHAR ARRAYS TEST',lt_varchar1,lt_varchar2,lt_varchar3,lt_varchar4,lt_varchar5);
END;
/
```

**Accept multiple parameters of same type – NUMBER Type**

```
DECLARE
  lt_number1 typ_number_array;
  lt_number2 typ_number_array;
  lt_number3 typ_number_array;
  lt_number4 typ_number_array;
  lt_number5 typ_number_array;
BEGIN
  lt_number1 := typ_number_array(1,2,3,4,5);
  lt_number2 := typ_number_array(1,2,3,4,5);
  lt_number3 := typ_number_array(1,2,3,4,5);
  lt_number4 := typ_number_array(1,2,3,4,5);
  lt_number5 := typ_number_array(1,2,3,4,5);
  t.log('NUMBER ARRAY TEST',lt_number1,lt_number2,lt_number3,lt_number4,lt_number5);
END;
/
```

**Accept multiple parameters of same type – DATE Type**

```
DECLARE
  lt_date1 typ_date_array;
  lt_date2 typ_date_array;
  lt_date3 typ_date_array;
  lt_date4 typ_date_array;
  lt_date5 typ_date_array;
BEGIN
  lt_date1 := typ_date_array(sysdate-1,sysdate-2,sysdate-3,sysdate-4,sysdate-5);
  lt_date2 := typ_date_array(sysdate-1,sysdate-2,sysdate-3,sysdate-4,sysdate-5);
  lt_date3 := typ_date_array(sysdate-1,sysdate-2,sysdate-3,sysdate-4,sysdate-5);
  lt_date4 := typ_date_array(sysdate-1,sysdate-2,sysdate-3,sysdate-4,sysdate-5);
  lt_date5 := typ_date_array(sysdate-1,sysdate-2,sysdate-3,sysdate-4,sysdate-5);
  t.log('DATE ARRAY TEST',lt_date1,lt_date2,lt_date3,lt_date4,lt_date5);
END;
/
```

**Accept multiple parameters of mixed types**

```
BEGIN
  t.log(
    pv_v1=>'MULTIPLE TYPES',
    pv_v2=>'String',
    pn_n1=>1,
    pn_n2=>2,
    pd_d1=>sysdate,
    pd_d2=>sysdate -1
  );
END;
/
```

**Log parameters of procedure**

```
CREATE OR REPLACE PROCEDURE test( pv_varchar VARCHAR2, pn_number NUMBER, pd_date DATE, pc_clob CLOB, pt_varchar typ_varchar_array, pt_number typ_number_array, pt_date typ_date_array)
IS
BEGIN
  t.log('PARAMETER 1',pv_varchar);
  t.log('PARAMETER 2',pn_number);
  t.log('PARAMETER 3',pd_date);
  t.log('PARAMETER 4',pc_clob);
  t.log('PARAMETER 5',pt_varchar);
  t.log('PARAMETER 6',pt_number);
  t.log('PARAMETER 7',pt_date);
  --other codes
END;
/
```