CREATE TABLE casto_doc_filter_tag_cats (
    ASSET_VERSION NUMBER(19,0) NOT NULL ENABLE,
	WORKSPACE_ID VARCHAR2(40 BYTE) NOT NULL ENABLE,
	BRANCH_ID VARCHAR2(40 BYTE) NOT NULL ENABLE,
	IS_HEAD NUMBER(1,0) NOT NULL ENABLE,
	VERSION_DELETED NUMBER(1,0) NOT NULL ENABLE,
	VERSION_EDITABLE NUMBER(1,0) NOT NULL ENABLE,
	PRED_VERSION NUMBER(19,0),
	CHECKIN_DATE DATE,
	tag_cat_id VARCHAR2(40) NOT NULL,
	tag_cat_title VARCHAR2(255) NOT NULL,
	tag_cat_image VARCHAR2(40),
	tag_cat_number NUMBER,
	PRIMARY KEY (tag_cat_id, ASSET_VERSION));

CREATE INDEX casto_doc_filter_tag_cats_cix ON casto_doc_filter_tag_cats (CHECKIN_DATE);
CREATE INDEX casto_doc_filter_tag_cats_wsx ON casto_doc_filter_tag_cats (WORKSPACE_ID);

CREATE TABLE casto_doc_filter_tags (
    ASSET_VERSION NUMBER(19,0) NOT NULL ENABLE,
	WORKSPACE_ID VARCHAR2(40 BYTE) NOT NULL ENABLE,
	BRANCH_ID VARCHAR2(40 BYTE) NOT NULL ENABLE,
	IS_HEAD NUMBER(1,0) NOT NULL ENABLE,
	VERSION_DELETED NUMBER(1,0) NOT NULL ENABLE,
	VERSION_EDITABLE NUMBER(1,0) NOT NULL ENABLE,
	PRED_VERSION NUMBER(19,0),
	CHECKIN_DATE DATE,
    tag_id VARCHAR2(40) NOT NULL,
    tag_title VARCHAR2(255) NOT NULL,
    tag_category VARCHAR2(40),
	tag_promo VARCHAR2(40),
	tag_number NUMBER,
    PRIMARY KEY (tag_id, ASSET_VERSION));

CREATE INDEX casto_doc_filter_tags_cix ON casto_doc_filter_tags (CHECKIN_DATE);
CREATE INDEX casto_doc_filter_tags_wsx ON casto_doc_filter_tags (WORKSPACE_ID);

CREATE TABLE cast_tag_docs (
    ASSET_VERSION NUMBER(19,0) NOT NULL ENABLE,
	tag_id VARCHAR2(40) NOT NULL ENABLE,
    document_id VARCHAR2(40) NOT NULL ENABLE,
	sequence_num INTEGER NOT NULL ENABLE,
    PRIMARY KEY (tag_id,sequence_num,ASSET_VERSION));

CREATE TABLE casto_doc_types (
    ASSET_VERSION NUMBER(19,0) NOT NULL ENABLE,
	WORKSPACE_ID VARCHAR2(40 BYTE) NOT NULL ENABLE,
	BRANCH_ID VARCHAR2(40 BYTE) NOT NULL ENABLE,
	IS_HEAD NUMBER(1,0) NOT NULL ENABLE,
	VERSION_DELETED NUMBER(1,0) NOT NULL ENABLE,
	VERSION_EDITABLE NUMBER(1,0) NOT NULL ENABLE,
	PRED_VERSION NUMBER(19,0),
	CHECKIN_DATE DATE,
    type_id VARCHAR2(40) NOT NULL,
	type_title VARCHAR2(255) NOT NULL,
	type_descr VARCHAR2(500),
	type_number NUMBER,
	type_def_promo VARCHAR2(40),
	PRIMARY KEY (type_id, ASSET_VERSION));

CREATE INDEX casto_doc_types_cix ON casto_doc_types (CHECKIN_DATE);
CREATE INDEX casto_doc_types_wsx ON casto_doc_types (WORKSPACE_ID);

CREATE TABLE casto_doc_subcats (
    ASSET_VERSION NUMBER(19,0) NOT NULL ENABLE,
	WORKSPACE_ID VARCHAR2(40 BYTE) NOT NULL ENABLE,
	BRANCH_ID VARCHAR2(40 BYTE) NOT NULL ENABLE,
	IS_HEAD NUMBER(1,0) NOT NULL ENABLE,
	VERSION_DELETED NUMBER(1,0) NOT NULL ENABLE,
	VERSION_EDITABLE NUMBER(1,0) NOT NULL ENABLE,
	PRED_VERSION NUMBER(19,0),
	CHECKIN_DATE DATE,
	subcat_id VARCHAR2(40) NOT NULL,
	subcat_title VARCHAR2(255) NOT NULL,
	PRIMARY KEY (subcat_id, ASSET_VERSION));

CREATE INDEX casto_doc_subcats_cix ON casto_doc_subcats (CHECKIN_DATE);
CREATE INDEX casto_doc_subcats_wsx ON casto_doc_subcats (WORKSPACE_ID);

CREATE TABLE casto_fast_lab_configs (
	ASSET_VERSION NUMBER(19,0) NOT NULL ENABLE,
	WORKSPACE_ID VARCHAR2(40 BYTE) NOT NULL ENABLE,
	BRANCH_ID VARCHAR2(40 BYTE) NOT NULL ENABLE,
	IS_HEAD NUMBER(1,0) NOT NULL ENABLE,
	VERSION_DELETED NUMBER(1,0) NOT NULL ENABLE,
	VERSION_EDITABLE NUMBER(1,0) NOT NULL ENABLE,
	PRED_VERSION NUMBER(19,0),
	CHECKIN_DATE DATE,
	id VARCHAR2(40) NOT NULL,
	fb_link_title VARCHAR2(255),
	fb_link_value VARCHAR2(255),
	fd_link_title VARCHAR2(255),
	fd_link_value VARCHAR2(255),
	eg_link_title VARCHAR2(255),
	eg_link_value VARCHAR2(255),
	dis_def_doc VARCHAR2(40),
	prod_dis_fb_link_title VARCHAR2(255),
	prod_dis_fd_link_title VARCHAR2(255),
	prod_dis_eg_link_title VARCHAR2(255),
	cf_enable_new NUMBER(1,0),
	cf_page_title VARCHAR2(255),
	cf_page_descr VARCHAR2(500),
	cf_def_bottom_banner VARCHAR2(40),
	cf_get_help_title VARCHAR2(255),
	cf_get_help_descr VARCHAR2(500),
	cf_get_help_home VARCHAR2(40),
	cf_get_help_filtered VARCHAR2(40),
	reinsurance_section VARCHAR2(40),
	reinsurance_section_flap VARCHAR2(40),
	PRIMARY KEY (id, ASSET_VERSION));

CREATE INDEX casto_fast_lab_configs_cix ON casto_fast_lab_configs (CHECKIN_DATE);
CREATE INDEX casto_fast_lab_configs_wsx ON casto_fast_lab_configs (WORKSPACE_ID);

ALTER TABLE cast_document ADD sub_type_id VARCHAR2(40);
ALTER TABLE cast_document ADD subcat_id VARCHAR2(40);
ALTER TABLE cast_document ADD cf_description VARCHAR2(2000);
ALTER TABLE cast_document ADD cf_r_col_dis_link_name VARCHAR2(255);

ALTER TABLE cast_category ADD dp_promo VARCHAR2(40);
ALTER TABLE cast_category ADD dp_promo_width NUMBER;
ALTER TABLE cast_category ADD dp_promo_height NUMBER;
ALTER TABLE cast_category ADD min_cat_number_per_col NUMBER;

ALTER TABLE cast_product ADD flag_bg VARCHAR2(30);

commit;