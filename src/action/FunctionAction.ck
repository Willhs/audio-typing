public class FunctionAction extends Action {
	public static string TYPE(){ return "function"; }
	TYPE() @=> type;	

	public static string COPY(){ return "copy"; }
	public static string CUT(){ return "cut"; }
	public static string PASTE(){ return "paste"; }
	public static string UNDO(){ return "undo"; }
	public static string REDO(){ return "redo"; }
	public static string SELECT_ALL(){ return "select_all"; }
	public static string CLOSE_TAB(){ return "close_tab"; }
	public static string NEW_TAB(){ return "new_tab"; }
	public static string NEXT_TAB(){ return "next_tab"; }
	public static string PREV_TAB(){ return "prev_tab"; }
	public static string PRINT(){ return "print"; }
	public static string BOOKMARK(){ return "bookmark"; }
	public static string SAVE(){ return "save"; }
	public static string OPEN(){ return "open"; }
	public static string FIND(){ return "find"; }
	public static string FIND_REPLACE(){ return "find_replace"; }
	public static string BUILD(){ return "build"; }
	public static string ESCAPE(){  return "escape"; }
	public static string REFRESH(){ return "refresh"; }
	public static string HELP(){ return "help"; }
	public static string RENAME(){ return "rename"; }
	public static string F3(){ return "f3"; }
	public static string F4(){ return "f4"; }
	public static string CAPS_LOCK(){ return "caps_lock"; }
	public static string SWITCH_NEXT_WINDOW(){ return "switch_next_window"; }
	public static string SWITCH_PREV_WINDOW(){ return "switch_prev_window"; }
	public static string CLOSE_WINDOW(){ return "close_window"; }
	public static string CTRL_ALT_DELETE(){ return "ctrl_alt_delete"; }

	public void start(Gain g){
		if (String.equals(label, COPY())){ startCopy(g); }
		else if (String.equals(label, CUT())){ startCut(g); }
		else if (String.equals(label, PASTE())){ startPaste(g); }
		else if (String.equals(label, UNDO())){ startUndo(g); }
		else if (String.equals(label, REDO())){ startRedo(g); }
		else if (String.equals(label, CLOSE_TAB())){ startCloseTab(g); }
		else if (String.equals(label, NEW_TAB())){ startNewTab(g); }
		else if (String.equals(label, NEXT_TAB())){ startPrevTab(g); }
		else if (String.equals(label, PREV_TAB())){ startNextTab(g); }
		else if (String.equals(label, PRINT())){ startPrint(g); }
		else if (String.equals(label, SAVE())){ startSave(g); }
		else if (String.equals(label, OPEN())){ startOpen(g); }
		else if (String.equals(label, BOOKMARK())){ startBookmark(g); }
		else if (String.equals(label, FIND())){ startFind(g); }
		else if (String.equals(label, FIND_REPLACE())){ startFindReplace(g); }
		else if (String.equals(label, BUILD())){ startBuild(g); }
		else if (String.equals(label, ESCAPE())){ startEscape(g); }
		else if (String.equals(label, REFRESH())){ startRefresh(g); }
		else if (String.equals(label, HELP())){ startHelp(g); }
		else if (String.equals(label, RENAME())){ startRename(g); }
		else if (String.equals(label, F3())){ startF3(g); }
		else if (String.equals(label, F4())){ startF4(g); }
		else if (String.equals(label, CAPS_LOCK())){ startCapsLock(g); }
		else if (String.equals(label, SWITCH_NEXT_WINDOW())){ startSwitchNextWindow(g); }
		else if (String.equals(label, SWITCH_PREV_WINDOW())){ startSwitchPrevWindow(g); }
		else if (String.equals(label, CLOSE_WINDOW())){ startCloseWindow(g); }
		else if (String.equals(label, CTRL_ALT_DELETE())){ startCtrlAltDel(g); }
		else { <<< "function not recognised: \"", label, "\"" >>>; }
	}

	fun void startCopy(Gain g){ 
		Util.playSample("Woodblock2", g);
	}
	fun void startCut(Gain g){ 
		Util.playSample("Woodblock1", g);
	}
	fun void startPaste(Gain g){ 
		Util.playSampleAtGain("Snare-1", g, 0.8);
	}
	fun void startUndo(Gain g){
		Util.playSampleAtGain("Synth Tom L", g, 0.8);
	}
	fun void startRedo(Gain g){ 
		Util.playSampleAtGain("Synth Tom H", g, 0.8);
	}
	fun void startCloseTab(Gain g){ 
		Util.playSample("BDHigh1", g);
	}
	fun void startNewTab(Gain g){ 
		Util.playSample("BDHigh5", g);
	}
	fun void startPrevTab(Gain g){ 
		Util.playSample("BDHigh3", g);
	}
	fun void startNextTab(Gain g){
		Util.playSample("BDHigh2", g);
	}
	
	fun void startPrint(Gain g){ }
	fun void startSave(Gain g){
		Shakers shakers => g;
		0.9 => shakers.energy;
		10 => shakers.objects;
		5 => shakers.preset; // 5
		0.9 => shakers.gain;
		shakers.noteOn(1);
		1::second => now;
	}
	fun void startOpen(Gain g){
		Util.playSample("Conga-01", g);
	}
	fun void startBookmark(Gain g){
		Util.playSample("keyboard22", g);
	}
	fun void startFind(Gain g){
		Util.playSampleAtGain("guitarlick138", g, 1.3);
	}
	fun void startFindReplace(Gain g){
		Util.playSampleAtGain("guitarlick139", g, 1.2);
	}
	fun void startBuild(Gain g){ }
	fun void startEscape(Gain g){
		NRev rev;
		0.04 => rev.mix;
		SqrOsc s1 => rev => g;
		SqrOsc s2 => rev => g;
		0.04 => s1.gain;
		0.04 => s2.gain;
		Std.mtof(30) => s1.freq;
		Std.mtof(42) => s2.freq;

		100::ms => now; 
	}
	fun void startRefresh(Gain g){
		Util.playSample("Splash", g);
	}
	fun void startHelp(Gain g){
		Util.playSample("keyboard29", g);
	}
	fun void startRename(Gain g){
		Util.playSample("keyboard23", g);
	}	
	fun void startF3(Gain g){
		Util.playSample("keyboard31", g);
	}
	fun void startF4(Gain g){
		Util.playSample("keyboard32", g);
	}
	fun void startCapsLock(Gain g){
		Util.playSample("keyboard38", g);
	}
	fun void startCloseWindow(Gain g){
		Util.playSample("BDHigh1", g);
	}
	fun void startSwitchNextWindow(Gain g){
		Util.playSampleAtGain("gamecubeFlip", g, 0.8);
	}
	fun void startSwitchPrevWindow(Gain g){
		Util.playSampleAtGain("gamecubeFlipBack", g, 0.8);
	}

	fun void startCtrlAltDel(Gain g){
		Util.playSampleAtGain("gamecubeMenuStart", g, 0.6);
	}
}