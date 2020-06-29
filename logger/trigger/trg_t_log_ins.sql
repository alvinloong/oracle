CREATE OR REPLACE TRIGGER trg_t_log_ins
BEFORE INSERT ON t_log
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  IF (:NEW.log_id IS NULL) THEN
    SELECT seq_t_log.NEXTVAL INTO :NEW.log_id FROM dual;
  END IF;
END;
/