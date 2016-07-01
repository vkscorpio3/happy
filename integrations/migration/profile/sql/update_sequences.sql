-- 	Expected
-- &1 DESTINATION SCHEMA NAME

UPDATE "&1".DAS_ID_GENERATOR 
   SET SEED = '200000', BATCH_SIZE = 100  
 WHERE ID_SPACE_NAME = 'group';
 
UPDATE "&1".DAS_ID_GENERATOR 
   SET SEED = '200000', BATCH_SIZE = 100  
 WHERE ID_SPACE_NAME = 'privilege';

UPDATE "&1".DAS_ID_GENERATOR A
   SET (SEED) = 
    (SELECT GREATEST(A.SEED, NVL(MAX(B.ID), A.SEED)) + A.BATCH_SIZE
       FROM "&1".DPS_USER B)  
 WHERE ID_SPACE_NAME = 'user';

UPDATE "&1".DAS_ID_GENERATOR A
   SET (SEED) = 
    (SELECT GREATEST(A.SEED, NVL(MAX(B.ID), A.SEED)) + A.BATCH_SIZE
       FROM "&1".DPS_CONTACT_INFO B)  
 WHERE ID_SPACE_NAME = 'contactInfo';

UPDATE "&1".DAS_ID_GENERATOR A
   SET (SEED) = 
    (SELECT GREATEST(A.SEED, NVL(MAX(B.ID), A.SEED)) + A.BATCH_SIZE
       FROM "&1".CASTO_SIPS_LOG B)  
 WHERE ID_SPACE_NAME = 'logsips';

UPDATE "&1".DAS_ID_GENERATOR A
   SET (SEED) = 
   (SELECT GREATEST(A.SEED, NVL(MAX(SUBSTR(B.ORDER_ID, 2)), A.SEED)) + A.BATCH_SIZE
       FROM "&1".DCSPP_ORDER B
      WHERE B.ORDER_ID LIKE 'C%')  
 WHERE ID_SPACE_NAME = 'order';

COMMIT; 

DISCONNECT;
quit;