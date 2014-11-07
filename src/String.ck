// helper methods for strings 
public class String {
	// returns true if the strings are equal, false otherwise
	public static int equals(string s1, string s2){
		// if the strings have non-equal length or s2 is not a (improper) subset of s1, the strings aren't equal.
		if (s1.length() != s2.length() || s1.find(s2) == -1){
			return false;
		}
		return true;
	}
}