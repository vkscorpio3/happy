ALTER TABLE CASTO_SKU RENAME COLUMN URL_PAGE TO EAN;
update CASTO_SKU set EAN = substr(EAN, 1, 13);
ALTER TABLE CASTO_SKU MODIFY EAN VARCHAR2(13);

ALTER TABLE CASTO_MAGASIN MODIFY STORE_ID VARCHAR2(40) NOT NULL;

commit;