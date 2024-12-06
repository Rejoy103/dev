trigger Check_Account_On_Standard on Contact (before insert,before update) {
    new ContactHelper().run();
}