@isTest
public class DWJsonToSObjectsListTest {

    @isTest
    static void jsonToSObjectManualMappingPositive10() {
        jsonToSObjectManualMappingPositiveN(10);
    }
    @isTest
    static void jsonToSObjectManualMappingPositive100() {
        jsonToSObjectManualMappingPositiveN(100);
    }
    @isTest
    static void jsonToSObjectManualMappingPositive1000() {
        jsonToSObjectManualMappingPositiveN(1000);
    }
    @isTest
    static void jsonToSObjectManualMappingPositive1500() {
        jsonToSObjectManualMappingPositiveN(1500);
    }
    @isTest
    static void jsonToSObjectManualMappingPositive2000() {
        jsonToSObjectManualMappingPositiveN(2000);
    }
    @isTest
    static void jsonToSObjectManualMappingPositive2500() {
        jsonToSObjectManualMappingPositiveN(2500);
    }

    static void jsonToSObjectManualMappingPositiveN(Integer nRecords) {
        Map<String, String> mapping = getManualMapping();
        String testDataString = JSON.serialize(new JsonTestData(mapping).getTestData(nRecords));

        DWJsonToSObjectsList converter = new DWJsonToSObjectsList(
                testDataString,
                JSON.serialize(mapping)
        );
        Test.startTest();
        Timer timer = new Timer();
        List<Contact> contacts = (List<Contact>) converter.translateToSObjects(
                'Contact'
        );
        timer.stopAndLog('Complete test body time: {0}');
        Test.stopTest();

        System.assertEquals(
                nRecords,
                contacts.size(),
                'Expected a fixed json array of two contacts to be converted to two contact sObjects'
        );
        for (Contact cont : contacts) {
            System.assertEquals(
                    null,
                    cont.id,
                    'Expected the convert to ignore the ID field on the incoming object'
            );
            for (String mappingValues : mapping.values()) {
                System.assertNotEquals(
                        cont.get(mappingValues),
                        null,
                        'Expected the converted sObject to have a value for the mapped field'
                );
            }
        }
    }

//    @isTest
//    static void jsonToSObjectCustomMetadataPositive() {
//        Dataweave_Mapping__mdt mapping = new Dataweave_Mapping__mdt();
//        mapping.masterLabel = 'test';
//        mapping.developerName = 'test';
//        mapping.sObject_type__c = 'account';
//
//        DWJsonToSObjectsList converter = new DWJsonToSObjectsList(
//            DWJsonToSObjectsListTest.JSONTESTBODY,
//            mapping
//        );
//        Test.startTest();
//        List<Contact> contacts = (List<Contact>) converter.translateToSObjects(
//            'Contact'
//        );
//        Test.stopTest();
//
//        System.assertEquals(
//            2,
//            contacts.size(),
//            'Expected a fixed json array of two contacts to be converted to two contact sObjects'
//        );
//        for (Contact cont : contacts) {
//            System.assertEquals(
//                null,
//                cont.id,
//                'Expected the convert to ignore the ID field on the incoming object'
//            );
//            for (String mappingValues : getManualMapping().values()) {
//                System.assertNotEquals(
//                    cont.get(mappingValues),
//                    null,
//                    'Expected the converted sObject to have a value for the mapped field'
//                );
//            }
//        }
//    }

    /// Helper methods
    public static Map<String, String> getManualMapping() {
        Map<String, String> mapping = new Map<String, String>();
        mapping.put('first_name', 'firstName');
        mapping.put('last_name', 'lastName');
        mapping.put('email', 'email');
        mapping.put('country', 'mailingCountry');
        mapping.put('StreetAddress', 'mailingStreet');
        mapping.put('city', 'mailingCity');
        mapping.put('state', 'mailingState');
        mapping.put('postalCode', 'mailingPostalCode');
        return mapping;
    }
}