ALTER TABLE CASTO_USER DROP (
  CURRENT_LOCAL_STORE
  );

ALTER TABLE CASTO_ORDER DROP (
  DELIVERY_TYPE,
  MAGASIN_ID 
  );

/* 
	start rollback improvement for mail sender functionality
*/ 
drop index CASTO_MAILSUIVICOMMANDE_IDX1;
drop index CASTO_MAILSUIVICOMMANDE_IDX2;
drop index CASTO_SIPS_LOG_IDX1;

drop index SRCH_UPDATE_QUEUE_IDX1;
drop index INDEX_PROFILE_ID;
/* 
	end rollback improvement for mail sender functionality
*/   
drop index SCD_CONTACT_INDEX1;

ALTER TABLE CASTO_ORDER DROP (
  PROCESSING_FEE_NICE_WORD
  );

ALTER TABLE CASTO_ABONNEMENT_NEWSLETTER DROP (
  ACCEPT_RECONTACT
  );

ALTER TABLE CASTO_USER DROP (
  LOCAL_PRICE_LIST
);
COMMIT;
