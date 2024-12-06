public class StringArrayTest {
    public static String[] generateStringArray(Integer n){
        String[] res=new String[n];
        for(Integer i=0;i<n;i++){
            res[i]='Test '+i;
        }
        return res;
    }
}