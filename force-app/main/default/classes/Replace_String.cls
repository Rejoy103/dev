public class Replace_String {
	@InvocableMethod(Label='Replace Q')
    public static List<String> replaceq(List<String> x){
        List<String> res=new List<String>();
        for(String i:x){
            i=i.replace('Q','');
            res.add(i);
        }
        return res;
    }
}