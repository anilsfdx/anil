public class googletest {
    public void basicAuthCallout()
    {
    Http h = new Http();
    HttpRequest req = new HttpRequest();
    req.setMethod('GET');
    req.setEndpoint('https://www.googleapis.com/gmail/v1/users/anil.boliset@gmail.com/messages');

 String   oauth_token = 'ya29.GlsJBqs-tqGjHsIxJpPaFNmC-QyVvODnlqSnCNlvhBeDRsZxRhBT-YZbfE4L4T0AblzkOJy0tR23OrM7MwTjp-3KY015NIrA6vPjAR4ilcbA48J8Swhm0T_9oIEU' ;
                 
	
Blob headerValue = Blob.valueOf(oauth_token);
String authorizationHeader = 'Bearer ' + oauth_token;
system.debug(' authorizationHeader' + authorizationHeader );
req.setHeader('Authorization', authorizationHeader);

    HttpResponse res = h.send(req);
    string resData =  res.getBody();
    system.debug(' Respose' + resData );
Map<String, Object> data = (Map<String, Object>)JSON.deserializeUntyped(resData);
String lwin11 = (String)data.get('emailAddress');
Integer theCurrency = (Integer)data.get('threadsTotal');
system.debug('email ' +lwin11 );
system.debug('threads ' +theCurrency );

}
                                }