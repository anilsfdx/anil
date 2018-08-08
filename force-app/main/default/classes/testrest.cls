public class testrest {
    public void basicAuthCallout()
    {
    Http h = new Http();
    HttpRequest req = new HttpRequest();
    req.setMethod('GET');
    req.setEndpoint('https://www.googleapis.com/gmail/v1/users/anil.boliset@gmail.com/profile');

 String   oauth_token = 'Fzy3h5VFFIr1ULyXHdz2XJvGOdV+bBBWIE8mXuICE8E=' ;
 String   oauth_consumer_key ='be8204f6-e529-4888-b96d-a28631d5d6f6';                  
	
Blob headerValue = Blob.valueOf(oauth_consumer_key +':' + oauth_token);
String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
req.setHeader('Authorization', authorizationHeader);

    HttpResponse res = h.send(req);
    string resData =  res.getBody();
    system.debug(' Respose' + resData );
}
                                }