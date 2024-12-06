public class Estimation_Helper {
    public static void Insert_Operation(List<Estimation__c> x){
        set<Id> accid_to_lookfor=new Set<Id>();
        for(Estimation__c i:x){
            accid_to_lookfor.add(i.Account__c);
        }
        List<AggregateResult> mae=[select Account__c ids,Min(Status_Mapping__c) m from Estimation__c where Account__c in :accid_to_lookfor group by Account__c];
        List<Account> acctoupdate=new List<Account>();
        for(AggregateResult i:mae){
            acctoupdate.add(new Account(Id=(Id)i.get('ids'),Current_Status_Map__c=(Decimal)i.get('m')));
        }
        update acctoupdate;            
    }
    public static void Update_Operation(map<Id,Estimation__c> oldmap,map<Id,Estimation__c> newmap){
        set<Id> accid=new set<Id>();
        for(Id i:oldmap.keySet()){
            if(oldmap.get(i).Status__c != newmap.get(i).Status__c){
                accid.add(oldmap.get(i).Account__c);
            }
        }
        List<AggregateResult> arr=[select Account__c ids,Min(Status_Mapping__c) m from Estimation__c where Account__c in :accid group by Account__c];
        List<Account> acctoup=new List<Account>();
        for(AggregateResult i: arr){
            acctoup.add(new Account(Id=(Id)i.get('ids'),Current_Status_Map__c=(Decimal)i.get('m')));
        }
        update acctoup;
    }
    
    public static void Delete_Operation(List<Estimation__c> x){
        set<Id> accid=new set<Id>();
        for(Estimation__c i:x){
            accid.add(i.Account__c);
        }
        map<Id,AggregateResult> arr=new map<Id,AggregateResult>([select Account__c ids,Min(Status_Mapping__c) m from Estimation__c where Account__c in :accid group by Account__c]);
        List<Account> acctoup=new List<Account>();
        for(Id i: accid){
            if(arr.keySet().contains(i)){
                acctoup.add(new Account(Id=i,Current_Status_Map__c=(Decimal)arr.get(i).get('m')));
            }else{
                acctoup.add(new Account(Id=i,Current_Status_Map__c=4));
            }

        }
        update acctoup;
    }
   
        public static void Check_For_Active_Update(map<Id,Estimation__c> oldmap,map<Id,Estimation__c> newmap){
            set<Id> accid=new set<Id>();
            for(Id i:oldmap.keySet()){// filter account id only for related estimate id change
                if(oldmap.get(i).Estimate_Id__c != newmap.get(i).Estimate_Id__c){
                    accid.add(oldmap.get(i).Account__c);
                }
            }
            //From filter account id, further filter by checking if its InActive 
            set<Id> resaccid=(set<Id>)new map<Id,Account>([select Id from Account where Id in :accid AND In_Active__c=true]).keySet();
            for(Estimation__c i:oldmap.values()){
                if(resaccid.contains(i.Account__c)){
                    i.Account__c.addError('In Active Account cannot edit Estimation ID');
                }
            }
        }
    }