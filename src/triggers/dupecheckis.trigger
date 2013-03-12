trigger dupecheckis on Item_Serial__c (before insert, before update) {
    Map<String, Item_Serial__c> isMap = new Map<String, Item_Serial__c>();
    for(Item_Serial__c objis : System.Trigger.New) {
        if((objis.Name != Null) && (System.Trigger.isInsert || (objis.Name != System.Trigger.oldMap.get(objis.Id).Name))) {
            if(isMap.containsKey(objis.Name)) {
                objis.Name.addError('This serial number already exists');
            } else {
                isMap.put(objis.Name, objis);
            }
        }
    }
    for(Item_Serial__c objis : [SELECT Name from Item_Serial__c WHERE Name IN :isMap.KeySet()]) {
        Item_Serial__c newobjis = isMap.get(objis.Name);
        objis.Name.addError('This serial number already exists');
    }
}