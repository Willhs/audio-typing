// abstract
// an action which causes text deletion
public class Deletion extends Action{
	public static string TYPE(){
		return "deletion";
	}
	TYPE() @=> type;

	public static string BACK_SPACE(){ return "back_space"; }
	public static string DELETE(){ return "delete"; }
	public static string DELETE_MANY(){ return "delete_many"; }

	public void start(Gain g){
		if (String.equals(label, BACK_SPACE())){ startBackSpace(g); }
		else if (String.equals(label, DELETE())){ startDelete(g); }
		else if (String.equals(label, DELETE_MANY())){ startDeleteMany(g); }
		else { <<< "unrecognised deletion", label >>>; }
	}

	fun void startBackSpace(Gain g){
		Util.playSampleAtGain("Hat Pedal-01", g, 0.6);
	}

	fun void startDelete(Gain g){
		Util.playSampleAtGain("Hat Pedal-01", g, 0.6, 1.3);
	}

	fun void startDeleteMany(Gain g){
		Util.playSample("Hat Open-01", g, 1.3);	
	}
}