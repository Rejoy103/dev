public class QueueClass implements Queueable{
	
    private List<String> Name;
    private Integer CurIndex;
    private String Email;
    
    public QueueClass(List<String> Name,String Email,Integer CurIndex){
        this.Name=Name;
        this.CurIndex=CurIndex;
        this.Email=Email;
    }
    
    public void Execute(QueueableContext context){
        System.debug(this.Name[this.CurIndex] + ' : '+this.Email);
        /*if(this.Name.size() > this.CurIndex +1){
            //Long start=DateTime.now().getTime();
            //while(DateTime.now().getTime()-start<30000);
           //system.enqueueJob(new QueueClass(this.Name,this.Email,this.CurIndex+1),1);
        }*/
    }
}