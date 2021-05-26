package aspects;

import java.util.ArrayList;
import java.util.List;

import org.aspectj.lang.JoinPoint;


public aspect PerformanceLogging {

	pointcut methodcall(): within(telecom.*);
	
	Object around(): methodcall()
	{
		Timer t = new Timer();
		List<String> args = new ArrayList();
		for(int i = 0; i < thisJoinPoint.getArgs().length; i++) {
			if(thisJoinPoint.getArgs()[i] != null) {
				args.add(thisJoinPoint.getArgs()[i].toString());
			}
			else {
				args.add("null");
			}
			}
		
		System.out.println("CALLING " + thisJoinPoint.getSignature().toString() + " WITH ARGUMENTS: " +
		String.join(", ", args));
		t.start();
		
		
		
		Object result = proceed();
		
		t.stop();
		System.out.println("CALL TO " + thisJoinPoint.getSignature().toString() +" TOOK " + t.getTime() + " ms");
		if(result != null) {
			System.out.println("AND RETURNED: " + result.toString());
		}
		
		
		return result;
	}
}
