public class Navigation extends Action {
	public static string TYPE(){ return "navigation"; }
	TYPE() @=> type;

	public static string LEFT(){ return "left"; }
	public static string RIGHT(){ return "right"; }
	public static string UP(){ return "up"; }
	public static string DOWN(){ return "down"; }
	public static string HOME(){ return "home"; }
	public static string END(){ return "end"; }

	public void start(Gain g){
		if (String.equals(label, LEFT())){ startDirection(g); }
		else if (String.equals(label, RIGHT())){ startDirection(g); }
		else if (String.equals(label, UP())){ startDirection(g); }		
		else if (String.equals(label, DOWN())){ startDirection(g); }		
		else if (String.equals(label, HOME())){ startHome(g); }		
		else if (String.equals(label, END())){ startEnd(g); }		
		else { <<< "unrecognised navigation: ", label >>>; }
	}

	public void startDirection(Gain g){
		NRev rev;
		0.05 => rev.mix;
		TriOsc s1 => rev => g;
		TriOsc s2 => rev => g;

		0.04 => s1.gain;
		0.04 => s2.gain;
		Std.mtof(60) => s1.freq;
		Std.mtof(72) => s2.freq;

		50::ms => now;
	}

	public void startHome(Gain g){
	}
	public void startEnd(Gain g){

	}
}