alter table CASTO_ORDER modify COMMENTAIRE varchar2(400);

CREATE TABLE CASTO_SHOPPINGLIST 
(
	ID VARCHAR2(40 BYTE) NOT NULL ENABLE, 
	SEQ NUMBER(*,0) NOT NULL ENABLE, 
	SKU_ID VARCHAR2(40 BYTE) NOT NULL ENABLE, 
	PRIMARY KEY (ID, SEQ)
);

commit;
