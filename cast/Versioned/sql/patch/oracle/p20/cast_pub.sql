CREATE TABLE CAST_CATALOG_ADDITION_PROP (
  ASSET_VERSION NUMBER(19,0) NOT NULL ENABLE,
  CATALOG_ID VARCHAR2(40 BYTE) NOT NULL ENABLE, 
  SEARCH_BY_PRODUCT NUMBER(1,0) DEFAULT 1, 
  SEARCH_BY_PIVOT NUMBER(1,0) DEFAULT 1, 
  SEARCH_BY_REGULAR NUMBER(1,0) DEFAULT 1, 
  BODYSTYLE VARCHAR2(500),
  PRIMARY KEY (CATALOG_ID, ASSET_VERSION), 
  FOREIGN KEY (CATALOG_ID, ASSET_VERSION)  REFERENCES DCS_CATALOG (CATALOG_ID, ASSET_VERSION) ENABLE
);

ALTER TABLE CAST_PRODUCT ADD CAST_PRIORITY NUMBER(*,0);

ALTER TABLE CAST_CATEGORY ADD FREE_TEXT VARCHAR2(1000 BYTE);