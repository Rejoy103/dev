public class SendMail {
	private String Subject;
    private String Body;
    private String Footer;
    private String toa;

    public SendMail(String x,String y,String z,String t){
        Subject=x;
        Body=y;
        Footer=z;
        toa=t;
    }
    public void sendMail(){
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[]{toa});
        mail.setSubject(Subject);
        mail.setHtmlBody(Body + '<br><br><br>'+Footer);
        try{
            Messaging.sendEmail(new list<Messaging.SingleEmailMessage>{mail});
        }catch(exception e){
            System.debug('Failed to send email');
        }
        
    }
}