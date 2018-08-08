public class googlepost {
    
    public void basicAuthCallout()
    {
        HttpRequest req = new HttpRequest();
req.setMethod('POST');
req.setHeader('Content-Type','application/x-www-form-urlencoded');
req.setEndpoint('https://www.googleapis.com/oauth2/v4/token');

 String CLIENT_SECRET='enpvEINPbJKD_pURvOw2BNVc';//Fill as per your registered app settings in google console
 String CLIENT_ID='674274835358-n8btipgjkbujg4757tngto0nvs942c7o.apps.googleusercontent.com';//Fill as per your registered app settings in google console
 String REDIRECT_URL='urn:ietf:wg:oauth:2.0:oob';

 String OAUTH_TOKEN_URL='https://accounts.google.com/o/oauth2/token';
 String OAUTH_CODE_END_POINT_URL='https://accounts.google.com/o/oauth2/auth';

 
 String REFRESH_TOKEN ='1/J5Nbp_0fNskHXgUnbPhaRMJtFVrO1B-5bq2-6S_S2y8';
        String GRANT_TYPE=REFRESH_TOKEN;

//Scope URL as per oauth 2.0 guide of the google 
 //String SCOPE='https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile';
 String STATE='/profile';
        String SCOPE = 'authorization_code';
 String CODE='4%2FAAAcHzoo5v2zenXEZSuYyFnU5smun95HNZsR7UldCLfzMVLZj4n62gZFH3Li4U3qSURndTfawFB9TLaoiU1DgfE';

//Approval Prompt Constant
String APPROVAL_PROMPT='force';
//String x= 'code='+CODE+ '&redirect_uri='+EncodingUtil.urlEncode(REDIRECT_URL,'UTF-8')+'&client_id='+CLIENT_ID+'&client_secret='+CLIENT_SECRET+'&refresh_token='+REFRESH_TOKEN+'&scope='+SCOPE+'&grant_type='+GRANT_TYPE;
    
String x= '&client_id='+CLIENT_ID+'&client_secret='+CLIENT_SECRET+'&grant_type=refresh_token&grant_type='+REFRESH_TOKEN;
system.debug('token' +x); 
req.setBody(x);       



Http http = new Http();
HTTPResponse response = http.send(req);
System.debug('Body ' + response.getBody());
System.debug('Status ' + response.getStatus());
System.debug('Status code ' + response.getStatusCode());
    }    

}