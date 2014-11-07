public class WhitespaceAction extends Insertion {
	public static string TAB(){ return "tab"; }
	public static string SPACE(){ return "space"; }
	public static string NEW_LINE(){ return "newLine"; }

	public void start(Gain g){
		if (String.equals(label, TAB())){ startTab(g); }
		else if (String.equals(label, SPACE())){ startSpace(g); }
		else if (String.equals(label, NEW_LINE())){ startNewLine(g); }
		else {<<< "unrecognised WhitespaceAction ", label >>>;}
	}

	public void startTab(Gain g){

	}

	public void startSpace(Gain g){
		//Util.playSample("Rimshot-07", g);
		Shakers shakers => g;
		0.9 => shakers.energy;
		10 => shakers.objects;
		11 => shakers.preset; // 5
		0.9 => shakers.gain;
		shakers.noteOn(1);
		1::second => now;
	}

	public void startNewLine(Gain g){

	}
}