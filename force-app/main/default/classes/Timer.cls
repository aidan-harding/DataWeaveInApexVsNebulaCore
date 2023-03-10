/**
 * @author aidan@nebulaconsulting.co.uk
 * @date 03/03/2023
 * @description Allows timing of operations and printing out to debug
 */

public class Timer {

    private Long startTime;

    public Timer() {
        start();
    }

    public void start() {
        startTime = Datetime.now().getTime();
    }

    /**
     * @param message to be passed to String.format() where {0} will be the elapsed time in s
     */
    public void stopAndLog(String message) {
        System.debug(String.format(message, new List<String> { String.valueOf((Datetime.now().getTime() - startTime)/1000.0) + 's'} ));
    }
}