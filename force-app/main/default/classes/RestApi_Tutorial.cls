@RestResource(urlMapping='/account/*')
global class RestApi_Tutorial {
	@HttpGet
    global static Account getAccount(){
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        String accid=req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account a=[select Id,Name from Account where Id=:accid][0];
        return a;
    }
    @HttpPost
    global static boolean postAccount(Account a){
        try{
            insert a;
        }catch(exception e){
            return false;
        }
        return true;
    }
}