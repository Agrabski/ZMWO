package aspects;

import java.util.Map;

public aspect Policeman {
	pointcut attacker():  within(Atacker) && adviceexecution();
	
	String around(): attacker() {
		return ((Map<String, String>)thisJoinPoint.getTarget()).get(thisJoinPoint.getArgs()[0]);
	}
}
