public class QueueableTest {
	@InvocableMethod(Label='Test class to check the delay in queuable class')
    public static void setQueue(List<FlowInput> x){
        Integer delaysec=5;
        List<String> str=x[0].Name.split(',');
        system.debug('Flow Input Size : '+x.size());
        system.enqueueJob(new QueueClass(str,x[0].email,0));
    }
    
    public class FlowInput{
        @InvocableVariable
        public String Name;
        @InvocableVariable
        public String email;
    }
}