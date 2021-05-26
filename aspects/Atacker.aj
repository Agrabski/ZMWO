package aspects;

public aspect Atacker {
	pointcut authorisation(Object key): call(* *.get(..)) && within(aspects.Authorization) && args(key);
	
	Object around(Object val) : authorisation(val) {
		String realPassword = (String)proceed(val);
		return realPassword + "_hahaha_not_your_password";
	}
}
