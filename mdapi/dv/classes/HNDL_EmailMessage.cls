public with sharing class HNDL_EmailMessage extends TriggerManager.TriggerHandler {

    public static String ClassName{
        get{
            return HNDL_EmailMessage.class.getName();       
        }
    }
    public HNDL_EmailMessage()
    {
        super( ClassName, EmailMessage.sObjectType);    
        
    }   
     
    public static void setFirstRun( Boolean setfirstRun)
	{
		firstRun = setFirstRun;		
	}
    private static boolean firstRun = true;
	
	public static boolean isFirstRun() {
        return firstRun;
    }

    public static void setFirstRunFalse(){
        firstRun = false;
    }

    // 12.01.2018 - Mohamed
    

    // 12.01.2018 - Mohamed
   
    public override void bulkAfter(List <SObject> soLst, Map<Id,sObject> oldMap, Map<Id,sObject> newMap)
    {
        
        if ( Trigger.isUndelete ){
            
        } else if ( Trigger.isUpdate)
        {
            // bulkAfterUpdate(soLst, oldMap, newMap);      
        } else if (Trigger.isInsert){
           
            bulkAfterInsert(soLst, oldMap, newMap);                   
        }          
     }
     
    public static void bulkAfterInsert(List <SObject> soLst, Map<Id,sObject> oldMap, Map<Id,sObject> newMap){      
          createContact(soLst);
    }   
    
   
    
    //public static void bulkAfterUndelete(List <SObject> soLst, Map<Id,sObject> oldMap, Map<Id,sObject> newMap){ /* Dont need to be executed */    } 
    
	/*
		function createBatchData responsible for Creating BatchData for batch process. This class is called from trigger
		@soLst: Collection of EmailMessage
		@oldMap: Map collection of old value 
		@newMap: Map collection of new value
	*/
    
      public static void createContact(List <SObject> soLst)  {
      
           List<EmailMessage> lsBatchData = new List<EmailMessage>();
           List<EmailMessage> lsEml = new List<EmailMessage>();
          system.debug('test3');
           system.debug('test4' +soLst);
            if( soLst != null ) lsEml = (List<EmailMessage>)soLst;
          system.debug('test' +lsEml);
        Database.UpsertResult [] upr ;
        try
        {
             system.debug('anil');
        	for( EmailMessage eml: lsEml){
                system.debug('name ' +eml.TextBody);
        		lsBatchData.Add(
		            new EmailMessage( 
		             
		              id = eml.id,
                      incoming = false  
            
            		));
            		
            		if( lsBatchData != null && lsBatchData.size() > 0 ) {
            		system.debug('lsBatchData ' +lsBatchData);
            		upr = Database.upsert(lsBatchData);
                    }
            		
            
          		
        	}
        	
        }catch(Exception E)
        {
            system.debug('wrong' +E.getMessage())	;		  
        } 
      }
    
   
         
}