CREATE TABLE CAST_STORE_GEOLOCATION (
	ID							VARCHAR2(40)		NOT NULL REFERENCES CASTO_MAGASIN(ID),
	LONGITUDE					NUMBER(12,7)		NULL,
	LATITUDE 					NUMBER(12,7)		NULL,	
	CONSTRAINT CAST_STORE_GEOLOCATION_P PRIMARY KEY (ID));
COMMIT;