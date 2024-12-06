public class quick_queuable {
@InvocableMethod(Label='Quick Queuable')
    public static void setQueue(List<FlowInput> x){
            system.enqueueJob(new QueueClass('Test','Test'));
    }
    
    public class FlowInput{
        @InvocableVariable
        public String Name;
    }
}