public class SkillBasedRouting {
    @InvocableMethod
    public static void routingCase(List<String> caseId){
        List<Case> cases=[SELECT Id,Subject from Case where Id in :caseId];
        List<PendingServiceRouting> psrlist=new List<PendingServiceRouting>();
        List<Skill> allskill=[SELECT id,MasterLabel FROM Skill];
        List<SkillRequirement> sr=new List<SkillRequirement>();
        Map<Id,List<Id>> skillmap=new Map<Id,List<Id>>();
        for(Case c:cases){ //n
            PendingServiceRouting psr=new PendingServiceRouting();
            psr.workItemId=c.Id;
            psr.RoutingType='SkillsBased';
            psr.RoutingPriority=1;
            psr.ServiceChannelId='0N95j0000008mOKCAY';
            psr.CapacityWeight=1;
            psr.RoutingModel='MostAvailable';
            psr.IsReadyForRouting=false;
            psrlist.add(psr);
            for(Skill s:allskill){ //s
                if(c.Subject.contains(s.MasterLabel)){
                    if(skillmap.keySet().contains(c.Id)){
                        skillmap.get(c.Id).add(s.Id);
                    }else skillmap.put(c.Id,new List<Id>{s.Id});
                }
            }
        }
        insert psrlist;
        for(PendingServiceRouting psr:psrlist){
            for(Id i:skillmap.get(psr.WorkItemId)){
                SkillRequirement srq=new SkillRequirement();
                srq.SkillId=i;
                srq.RelatedRecordId=psr.Id;
                srq.SkillLevel=5;
                sr.add(srq);
            }
            psr.IsReadyForRouting=true;
        }
        insert sr;
        update psrlist;
    }
}