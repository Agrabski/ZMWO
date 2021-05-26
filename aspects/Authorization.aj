package aspects;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Dictionary;
import java.util.HashMap;
import java.util.Map;

import telecom.Customer;
import telecom.Call;

public aspect Authorization {
	pointcut connect(Customer f, Customer t): call(Call telecom.Customer.call(..)) && target(f) && args(t);
	
	Call around(Customer f, Customer to) :connect(f, to) {
		try {
			System.out.println("enter password");
			String readPassword = System.console().readLine();

			
			Map<String, String> pss = getPasswords();
			
			if(pss.get(f.toString()).equals(readPassword)) {
				return proceed(f, to);
			} else {
				return null;
			}
		} catch(Exception e) {
			System.out.println("xxxxxxxxxxxx");
			System.out.println(e.toString());
			return null;
		}
		
	}
	
	private Map<String, String> getPasswords() {
		BufferedReader a;
		try {
			a = Files.newBufferedReader(Path.of("d:\\passwords_super_secure_420_69.txt"));
			String line = a.readLine();
	
			Map<String, String> result = new HashMap<String, String>();
	        // loop until all lines are read
	        while (line != null) {
	        	result.put(line.split(" ")[0], line.split(" ")[1]);
	        	line = a.readLine();
	        }
	        return result;
		} catch (Exception e) {
			return null;
		}
	}
	
	
	
}
