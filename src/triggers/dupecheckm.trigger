trigger dupecheckm on Merchandise__c (before insert, before update) {
    Map<String, Merchandise__c> mMap = new Map<String, Merchandise__c>();
    for(Merchandise__c objm : System.Trigger.New) {
        if((objm.Name != null) && (System.Trigger.isInsert || objm.Name != (System.Trigger.oldMap.get(objm.Id).Name))) {
            if(mMap.containsKey(objm.Name)) {
                objm.Name.addError('The item already exists');
            } else {
                mMap.put(objm.name, objm);
            }
        }
    }
    for( Merchandise__c objm : [SELECT Name FROM Merchandise__c WHERE Name IN :mMap.KeySet()]) {
        Merchandise__c newobjm = mMap.get(objm.Name);
        newobjm.Name.addError('The item already exists');
    }
}