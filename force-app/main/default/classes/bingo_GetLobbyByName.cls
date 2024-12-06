public class bingo_GetLobbyByName {
    
    @AuraEnabled()
    public static boolean isLobbyExist(String Name){
        List<Lobby__c> lob=[SELECT id FROM Lobby__c where Name__c=:Name];
        if(lob.size() > 0){
            return true;
        }else{
            return false;
        }
    }
    
    @AuraEnabled()
    public static List<Player__c> getPlayerByLobbyId(Id lid){
        List<Player__c> player=[SELECT id,Username__c,isHost__c FROM Player__c where Lobby__c=:lid];
        return player;
    }
    
    @AuraEnabled()
    public static Lobby__c getLobbyById(Id lid){
        Lobby__c lobby=[SELECT id,Name__c,Max_Player__c,Total_Player__c FROM Lobby__c where id=:lid];
        return lobby;
    }
    
    @AuraEnabled()
    public static List<Lobby__c> getLobby(){
        list<Lobby__c> lobby=[SELECT id,Name__c,Max_Player__c,Total_Player__c FROM Lobby__c];
        return lobby;
    }
}