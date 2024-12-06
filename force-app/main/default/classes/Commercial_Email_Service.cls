Global class Commercial_Email_Service implements Messaging.InboundEmailHandler{
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.InboundEnvelope envelope){
        Messaging.InboundEmailResult result=new Messaging.InboundEmailResult();
        /*Messaging.SingleEmailMessage send=new Messaging.SingleEmailMessage();
        String[] tomessage=new String[]{'rejoykingston@gmail.com'};
        send.setToAddresses(tomessage);
        send.setSubject('fwd');
        send.setPlainTextBody(email.plainTextBody);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{send});*/
        String subject=email.subject;
        system.debug(subject);
        if(subject.contains('Product Information')){
            String projectnumber=subject.substring(subject.indexOf('[')+1, subject.indexOf(']'));
            Project__c project=[SELECT Id from Project__c where Project_Number__c=:projectnumber];
            system.debug(projectnumber);
            system.debug(email.plainTextBody);
            EmailMessage msg=new EmailMessage();
            msg.Subject=email.subject;
            for(Integer i=0;i<email.toAddresses.size();i++){
                if(i==0){
                    msg.ToAddress=email.toAddresses[i];
                }else{
                    msg.ToAddress= msg.ToAddress + ', '+email.toAddresses[i];
                }
            }
            msg.FromAddress=email.fromAddress;
            msg.TextBody=email.plainTextBody;
            msg.HtmlBody=email.htmlBody;
            msg.RelatedToId=project.Id;
            msg.MessageDate=system.now();
            insert msg;            
        }
        
        return result;
        
    }
}