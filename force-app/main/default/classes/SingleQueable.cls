public class SingleQueable implements Queueable{
    
	private String Name;
    private String Email;
    
    public SingleQueable(String Name,String Email){
        this.Name=Name;
        this.Email=Email;
    }
    
    public void Execute(QueueableContext context){
        System.debug(this.Name + ' : '+this.Email);
        /*if(this.Name.size() > this.CurIndex +1){
            //Long start=DateTime.now().getTime();
            //while(DateTime.now().getTime()-start<30000);
           //system.enqueueJob(new QueueClass(this.Name,this.Email,this.CurIndex+1),1);
        }*/
    }
}