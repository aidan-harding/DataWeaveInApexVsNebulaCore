@IsTest
public with sharing class LoggingTest {
    
    @IsTest
    public static void captureDataWeaveLogging() {
        String jsonPayload = '[{\"name\": \"Hare\",\"isWinner\": false},{\"name\": \"Turtles\",\"isWinner\": true}]';

        string scriptName = 'logFilter';
        DataWeave.Script dwscript = DataWeave.Script.createScript(scriptName);

        DataWeave.Result result = dwscript.execute(new Map<String, Object>{'payload' => jsonPayload});

        // While we can assert on the script outcome here, the key part is the logging that occurs 
        // to DATAWEAVE_USER_DEBUG
        // You will need to run the test with logging enabled or as anonymous Apex to see the output

        string jsonResult = result.getValueAsString();
        System.debug(jsonResult);

        /*[
        {
            "name": "Turtles",
            "isWinner": true
        }
        ]*/

        List<Object> jsonList = (List<Object>)JSON.deserializeUntyped(jsonResult);
        Map<String, Object> jsonMap = (Map<String, Object>) (jsonList[0]);
        Assert.areEqual('Turtles', jsonMap.get('name'));
        Assert.isTrue((Boolean)jsonMap.get('isWinner'));
    }
}
