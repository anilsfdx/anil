public  class TwitterProvider {
     public TwitterCalloutSetting__mdt TwitterCalloutSetting;
     public string accessToken;
     
     public TwitterProvider(){
     
       TwitterCalloutSetting  =[
       
           SELECT  EndPoint__c,ConsumerKey__c,ConsumerSecret__c
           FROM  TwitterCalloutSetting__mdt
           LIMIT 1
       ] ;
         
         accesstoken = this.GetToken();
       
        }
     
     
     
     public List<UserRecord> FetchUserFromServer (String screenName){
        HttpRequest req = new  HttpRequest();
        req.SetMethod('GET');
        req.SetEndpoint(TwitterCalloutSetting.EndPoint__c  +screenName);
         system.debug('bearer' +accessToken );
         system.debug('bearer' +TwitterCalloutSetting.EndPoint__c  +screenName);
        req.setHeader('Authorization' ,'Bearer '  + accessToken );
        HttpResponse res = new Http().send(req);
         system.debug('bearer' +res.getStatusCode() );
                if (res.getStatusCode()  == 200) {
                
                    system.debug('fetch ' +res.getBody());
                    String resData =  res.getBody();
   
               
                
                  List<UserRecord> userRecord = (List<UserRecord>) JSON.deserialize('['  +  res.getBody() + ']', List<UserRecord>.class);
                    for (UserRecord u : userRecord){
                        
                        system.debug('followers' + u.Description);
                        
                    }
                 return userRecord;
                    
                    
                }
                
                else {
                  return null;
                
                }
     
     
     }
     
      public  String getToken(){
          
          String consumerKey = Encodingutil.urlEncode(TwitterCalloutSetting.ConsumerKey__c,'UTF-8');
          String consumerSecret = Encodingutil.urlEncode(TwitterCalloutSetting.ConsumerSecret__c,'UTF-8');
          Blob  bearerToken = Blob.valueOf(consumerKey  + ':'  +consumerSecret );
         String AuthorizationHeader  = 'Basic '  + EncodingUtil.base64Encode(bearerToken);
          system.debug('access_token' +AuthorizationHeader );
       HttpRequest req = new  HttpRequest();
       req.SetEndpoint('https://api.twitter.com/oauth2/token');
        req.SetMethod('POST');
        req.setHeader('Authorization' ,AuthorizationHeader );
        req.setBody('grant_type=client_credentials');
          system.debug('access_token' +req );
        HttpResponse res = new Http().send(req);
       system.debug('access_token' +res.getStatusCode() );
        if (res.getStatusCode()  == 200) {
          JSONParser parser = JSON.createParser(res.getBody());
          while (parser.nextToken()  != null) {
          
              if (parser.getCurrentToken()   == JSONToken.FIELD_NAME) {
                  String fieldName = parser.getText();
                  parser.nextToken();
                   if (fieldName  == 'access_token') {
                       accessToken = parser.getText();
                     system.debug('access_token' +accessToken );
                   }
              
              
              }
          
          
          
          }
        
        return accessToken;
        }  else {
             
             return null;
             
        }
     
     }
     
     public virtual class UserRecord {
       public String Id {get ; set;} 
       public String Name {get ; set;} 
       public String Screen_Name {get ; set;} 
       public String Description {get ; set;} 
       public String Followers_Count {get ; set;} 
       public String Entities {get ; set;} 
     
     
     
     }
     
}