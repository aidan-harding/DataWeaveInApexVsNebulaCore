/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 03/03/2023
 */

@IsTest
private class NCJsonToSObjectsListTest {

    @IsTest
    static void jsonToSObjectManualMappingPositive10() {
        jsonToSObjectManualMappingPositiveN(10);
    }
    @IsTest
    static void jsonToSObjectManualMappingPositive100() {
        jsonToSObjectManualMappingPositiveN(100);
    }
    @IsTest
    static void jsonToSObjectManualMappingPositive1000() {
        jsonToSObjectManualMappingPositiveN(1000);
    }
    @IsTest
    static void jsonToSObjectManualMappingPositive1500() {
        jsonToSObjectManualMappingPositiveN(1500);
    }
    @IsTest
    static void jsonToSObjectManualMappingPositive2000() {
        jsonToSObjectManualMappingPositiveN(2000);
    }
    @IsTest
    static void jsonToSObjectManualMappingPositive2500() {
        jsonToSObjectManualMappingPositiveN(2500);
    }

    static void jsonToSObjectManualMappingPositiveN(Integer nRecords) {
        Map<String, String> mapping = DWJsonToSObjectsListTest.getManualMapping();
        List<Map<String, Object>> testData = new JsonTestData(mapping).getTestData(nRecords);

        Test.startTest();
        Timer timer = new Timer();
        List<Contact> contacts = new nebc.LazySObjectIterator(testData)
                .mapValues(new nebc.Transformation('JsonToSObjectsList', Contact.SObjectType.class))
                .toList(new List<Contact>());
        timer.stopAndLog('Complete test body time: {0}');
        Test.stopTest();

        for (Contact cont : contacts) {
            System.assertEquals(
                    null,
                    cont.Id,
                    'Expected the convert to ignore the ID field on the incoming object'
            );
            for (String mappingValues : mapping.values()) {
                System.assertNotEquals(
                        cont.get(mappingValues),
                        null,
                        'Expected the converted sObject to have a value for the mapped field ' + mappingValues
                );
            }
        }
    }
}