/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 10/03/2023
 * @description Generate some test data
 */

public with sharing class JsonTestData {

    private Map<String, String> mapping;

    public JsonTestData(Map<String, String> mapping) {
        this.mapping = mapping;
    }

    public List<Map<String, Object>> getTestData(Integer nRecords) {
        List<Map<String, Object>> testData = new List<Map<String, Object>>();
        for(Integer i=0; i < nRecords; i++) {
            Map<String, Object> testDatum = new Map<String, Object>();
            for (String mappingKey : mapping.keySet()) {
                testDatum.put(mappingKey, String.valueOf(Crypto.getRandomLong()));
            }
            testData.add(testDatum);
        }
        return testData;
    }
}