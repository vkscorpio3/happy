ALTER TABLE CASTO_CATEGORY ADD IK_CATEGORY_TYPE	VARCHAR2(255);
ALTER TABLE CASTO_CATEGORY ADD IK_CATEGORY_TYPE_NAV NUMBER(2) DEFAULT 0;

CREATE TABLE CASTO_SKU_IK_CS_ASSOC (
	SKU_ID 									VARCHAR2(40)		NOT NULL REFERENCES DCS_SKU (SKU_ID), 
	SEQUENCE_NUM 							INTEGER	 			NOT NULL, 
	CROSS_ID 								VARCHAR2(40)		NULL REFERENCES CASTO_SKU_CROSS_SELLING (CROSS_ID),
	PRIMARY KEY (SKU_ID, SEQUENCE_NUM));	

CREATE TABLE CASTO_IK_CATEGORY_TYPE (
	TYPE_NAME								VARCHAR2(255)		NOT NULL,
	PRIMARY KEY (TYPE_NAME));

commit;