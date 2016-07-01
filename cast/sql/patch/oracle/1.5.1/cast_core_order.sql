ALTER TABLE CASTO_ORDER ADD TRANSACTION_COUNT NUMBER(2,0) DEFAULT 0 NOT NULL;
ALTER TABLE CASTO_ORDER ADD PAYBOX_HANDLED NUMBER(1,0) DEFAULT 0 NOT NULL;

ALTER TABLE CASTO_ORDER ADD PAYMENT_SOURCE VARCHAR2(16);

ALTER TABLE CASTO_BILL_ADDR ADD (
  PHONE_NUMBER_2 VARCHAR2 (15),
  LOCALITY VARCHAR2 (100) );

ALTER TABLE CASTO_SHIP_ADDR ADD (
  PHONE_NUMBER_2 VARCHAR2 (15),
  LOCALITY VARCHAR2 (100) );

