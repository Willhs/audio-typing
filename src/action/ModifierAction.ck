public class ModifierAction extends Action {
	public static string TYPE(){ return "modifier"; }
	TYPE() @=> type;
	
	public static string SHIFT() { return "shift"; }
	public static string CONTROL() { return "control"; }
	public static string ALT() { return "alt"; }

	Event stopEvent; // stopping event

	public void start(Gain g){
		if (String.equals(label, SHIFT())){
			startShift(g);
		}
		else if (String.equals(label, CONTROL())){
			startControl(g);
		}
		else if (String.equals(label, ALT())){
			startAlt(g);
		}
	}

	public void startShift(Gain g){
		SinOsc sine => NRev rev => g;
		0.1 => sine.gain;
		Std.mtof(40) => sine.freq;
		0.04 => rev.mix;

		stopEvent => now;
	}

	public void startControl(Gain g){
		SinOsc sine => NRev rev => g;
		0.1 => sine.gain;
		Std.mtof(45) => sine.freq;
		0.04 => rev.mix;

		stopEvent => now;	
	}

	public void startAlt(Gain g){
		SinOsc sine => NRev rev => g;
		0.1 => sine.gain;
		Std.mtof(50) => sine.freq;
		0.04 => rev.mix;
		
		stopEvent => now;	
	}

	public void stop(){
		stopEvent.signal();
	}
}