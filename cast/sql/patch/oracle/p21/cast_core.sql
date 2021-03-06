CREATE TABLE CASTO_TICKET_MAPPING (
  PROFILE_ID VARCHAR2(40) NOT NULL,
  HOME_ID VARCHAR2(40),
  SOFINCO_ACCOUNT VARCHAR2(40),
  ACTIVE NUMBER(1,0) DEFAULT 0 NOT NULL,
  SOFINCO_NAME1 VARCHAR2(255),
  SOFINCO_NAME2 VARCHAR2(255)
);
ALTER TABLE CASTO_TICKET_MAPPING ADD CONSTRAINT CASTO_TICKET_MAPPING_PK PRIMARY KEY (PROFILE_ID);

CREATE TABLE CASTO_TICKET_HEADER (
  HEADER_ID VARCHAR2(40) NOT NULL,
  WDM_ID VARCHAR2(40),
  TICKET_ID VARCHAR2(40) NOT NULL,
  STORE_ID VARCHAR2(40) NOT NULL,
  TICKET_DATE DATE NOT NULL,
  HOME_ID VARCHAR2(40) NOT NULL,
  TILL_ID VARCHAR2(40),
  HOSTESS_ID VARCHAR2(40),
  TOTAL_QUANTITY INTEGER,
  TOTAL_PRICE_TTC NUMBER,
  TOTAL_HT NUMBER,
  LAST_MODIFIED DATE
);
ALTER TABLE CASTO_TICKET_HEADER ADD CONSTRAINT CASTO_TICKET_HEADER_PK PRIMARY KEY (HEADER_ID);

CREATE TABLE CASTO_TICKET_METHOD (
  HEADER_ID VARCHAR2(40) NOT NULL,
  METHOD_ID VARCHAR2(40) NOT NULL,
  PAYMENT_TYPE NUMBER,
  PAYMENT_AMMOUNT NUMBER
);
ALTER TABLE CASTO_TICKET_METHOD ADD CONSTRAINT CASTO_TICKET_METHOD_PK PRIMARY KEY (METHOD_ID);

CREATE TABLE CASTO_TICKET_LINE (
  HEADER_ID VARCHAR2(40) NOT NULL,
  LINE_ID VARCHAR2(40) NOT NULL,
  PRODUCT_ID VARCHAR2(40),
  PRODUCT_DATE DATE,
  PRODUCT_QUANTITY NUMBER,
  PRODUCT_LABEL VARCHAR2(255),
  UNIT_PRICE_HT NUMBER,
  UNIT_PRICE_TTC NUMBER,
  RATE_TVA NUMBER,
  DISCOUNT_AMOUNT NUMBER,
  DISCOUNT_LABEL VARCHAR2(255),
  LINE_NUMBER INTEGER
);
ALTER TABLE CASTO_TICKET_LINE ADD CONSTRAINT CASTO_TICKET_LINE_PK PRIMARY KEY (LINE_ID);

CREATE TABLE CASTO_TICKET_STATISTIC (
  ID VARCHAR2(40) NOT NULL,
  IMPORT_NAME VARCHAR2(1024),
  IMPORT_DATE DATE,
  IMPORT_TYPE NUMBER,
  SUCCESS_COUNT INTEGER,
  ERROR_COUNT INTEGER
);
ALTER TABLE CASTO_TICKET_STATISTIC ADD CONSTRAINT CASTO_TICKET_STATISTIC_PK PRIMARY KEY (ID);

CREATE INDEX CASTO_TICKET_HEADER_TK_IDX ON CASTO_TICKET_HEADER(TICKET_ID);
CREATE INDEX CASTO_TICKET_HEADER_HM_IDX ON CASTO_TICKET_HEADER(HOME_ID);
CREATE INDEX CASTO_TICKET_HEADER_ST_IDX ON CASTO_TICKET_HEADER(STORE_ID);
CREATE INDEX CASTO_TICKET_HEADER_TD_IDX ON CASTO_TICKET_HEADER(TICKET_DATE);

CREATE INDEX CASTO_TICKET_LINE_HD_IDX ON CASTO_TICKET_LINE(HEADER_ID);
CREATE INDEX CASTO_TICKET_LINE_PL_IDX ON CASTO_TICKET_LINE(PRODUCT_LABEL);

CREATE INDEX CASTO_TICKET_METHOD_HD_IDX ON CASTO_TICKET_METHOD(HEADER_ID);

ALTER TABLE CASTO_ORDER_BACKUP MODIFY (
  LOGIN varchar2(60)
);

-- patch 21.0.2
ALTER TABLE CASTO_TICKET_HEADER MODIFY (
  TOTAL_QUANTITY NUMBER
);

commit;