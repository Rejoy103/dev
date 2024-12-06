trigger AccountTest on Account (After update,Before update) {
        if(Trigger.isUpdate){
        	new AccountTestClass().run();
        }
}