public class SymbolAction extends Insertion {
	
	public static string ALT_QUOTE(){ return "`"; }
	public static string TILDE(){ return "~"; }
	public static string EXCLAMATION_MARK(){ return "!"; }
	public static string AT(){ return "@"; }
	public static string HASH(){ return "#"; }
	public static string DOLLAR_SIGN(){ return "$"; }
	public static string PERCENT(){ return "%"; }
	public static string HAT(){ return "^"; }
	public static string AMPERSAND(){ return "&"; }
	public static string ASTERIX(){ return "*"; }
	public static string OPEN_PAREN(){ return "("; }
	public static string CLOSE_PAREN(){ return ")"; }
	public static string MINUS(){ return "-"; }
	public static string UNDERSCORE(){ return "_"; }
	public static string EQUALS(){ return "="; }
	public static string PLUS(){ return "+"; }
	public static string OPEN_SQR_BRACKET(){ return "["; }
	public static string OPEN_CURLY_BRACKET(){ return "{"; }
	public static string CLOSE_SQR_BRACKET(){ return "]"; }
	public static string CLOSE_CURLY_BRACKET(){ return "}"; }
	public static string BACK_SLASH() { return "\\"; }
	public static string PIPE() { return "|"; }
	public static string COLON() { return ":"; }
	public static string SEMICOLON() { return ";"; }
	public static string QUOTE() { return "'"; }
	public static string DOUBLE_QUOTE() { return "\""; }
	public static string COMMA() { return ","; }
	public static string LESS_THAN() { return "<"; }
	public static string PERIOD() { return "."; }
	public static string GREATER_THAN() { return ">"; }
	public static string FORWARD_SLASH() { return "/"; }
	public static string QUESTION_MARK() { return "?"; }

	public void start(Gain g){
		if (String.equals(label, ALT_QUOTE())){ startAltQuote(g); }
		else if (String.equals(label, TILDE())){ startTilde(g); }
		else if (String.equals(label, EXCLAMATION_MARK())){ startExclamationMark(g); }
		else if (String.equals(label, AT())){ startAt(g); }
		else if (String.equals(label, HASH())){ startHash(g); }
		else if (String.equals(label, DOLLAR_SIGN())){ startDollarSign(g); }
		else if (String.equals(label, PERCENT())){ startPercent(g); }
		else if (String.equals(label, HAT())){ startHat(g); }
		else if (String.equals(label, AMPERSAND())){ startAmpersand(g); }
		else if (String.equals(label, ASTERIX())){ startAsterix(g); }
		else if (String.equals(label, OPEN_PAREN())){ startOpenParen(g); }
		else if (String.equals(label, CLOSE_PAREN())){ startCloseParen(g); }
		else if (String.equals(label, MINUS())){ startMinus(g); }
		else if (String.equals(label, UNDERSCORE())){ startUnderScore(g); }
		else if (String.equals(label, EQUALS())){ startEquals(g); }
		else if (String.equals(label, PLUS())){ startPlus(g); }
		else if (String.equals(label, OPEN_SQR_BRACKET())){ startDefault(g); }
		else if (String.equals(label, OPEN_CURLY_BRACKET())){ startDefault(g); }
		else if (String.equals(label, CLOSE_SQR_BRACKET())){ startDefault(g); }
		else if (String.equals(label, CLOSE_CURLY_BRACKET())){ startDefault(g); }
		else if (String.equals(label, BACK_SLASH())){ startBackSlash(g); }
		else if (String.equals(label, PIPE())){ startPipe(g); }
		else if (String.equals(label, COLON())){ startColon(g); }
		else if (String.equals(label, SEMICOLON())){ startSemicolon(g); }
		else if (String.equals(label, QUOTE())){ startQuote(g); }
		else if (String.equals(label, DOUBLE_QUOTE())){ startDoubleQuote(g); }
		else if (String.equals(label, COMMA())){ startComma(g); }
		else if (String.equals(label, LESS_THAN())){ startLessThan(g); }
		else if (String.equals(label, PERIOD())){ startPeriod(g); }
		else if (String.equals(label, GREATER_THAN())){ startGreaterThan(g); }
		else if (String.equals(label, FORWARD_SLASH())){ startForwardSlash(g); }
		else if (String.equals(label, QUESTION_MARK())){ startQuestionMark(g); }
		else { <<< "unrecognised symbol", label >>>; }
	}
	// same as action
	fun void startDefault(Gain g){
	    BeeThree b3 => NRev rev => g;
	    0.05 => rev.mix;
	    //(30::ms, 100::ms, gain-0.1, 200::ms) => adsr.set;
	    gain => b3.gain;
	    80 => b3.freq;
	    1 => b3.noteOn;
	    //1 => adsr.keyOn;
	    
	    100::ms => now;
	    1 => b3.noteOff;
	    //1 => adsr.keyOff;
	    200::ms => now;
	}


	fun void startAltQuote(Gain g){
		Util.playSample("Click-01", g);
	}

	fun void startTilde(Gain g){
		// from listing 7.10 in ChucK book
		ModalBar bar => g;
		2 => bar.preset;
		1200 => bar.freq;
		0.9996 => bar.modeRadius;
		3::second => now;
	}

	fun void startExclamationMark(Gain g){
		Util.playSampleAtGain("coolsynth", g, 0.6);
	}

	fun void startAt(Gain g){
		ModalBar bar => g;
		4 => bar.preset; 
		880 => bar.freq;
		500::ms => now;
	}

	fun void startHash(Gain g){
		Util.playSample("NoiseSnare", g);
	}

	fun void startDollarSign(Gain g){
		Util.playSample("Coins Poured Out 01", g);
	}

	fun void startPercent(Gain g){
		Shakers shaker => g;
		0.9 => shaker.decay;
		400::ms => now;
	}

	fun void startHat(Gain g){
		Util.playSample("WOOD_BLOCK", g);
	}

	fun void startAmpersand(Gain g){
		Util.playSample("Synth Tom H", g);
	}

	fun void startAsterix(Gain g){
		Util.playSample("NoiseCrash", g);
	}

	fun void startOpenParen(Gain g){
		Util.playSample("Cowbell", g, 1.2);
	}

	fun void startCloseParen(Gain g){
		Util.playSample("Cowbell", g, 0.8);
	}

	fun void startUnderScore(Gain g){
		Util.playSample("Click-04", g);
	}

	fun void startMinus(Gain g){
		TriOsc t1 => g;
		0.4 => t1.gain;
		TriOsc t2 => g;
		0.4 => t2.gain;
		440 => t1.freq;
		660 => t2.freq;
		50::ms => now;	
	}

	fun void startPlus(Gain g){
		SawOsc t1 => g;
		0.6 => t1.gain;
		SawOsc t2 => g;
		0.6 => t2.gain;
		660 => t1.freq;
		880 => t2.freq;
		50::ms => now;	
	}

	fun void startEquals(Gain g){
		Sitar sit => g;
		Std.mtof(45) => sit.freq;
		sit.noteOn(1);
		1::second => now;
	}


	fun void startBackSlash(Gain g){
		Util.playSample("Switch 04", g);
	}

	fun void startPipe(Gain g){
		SqrOsc sqr1 => g;
		0.2 => sqr1.gain;
		120 => sqr1.freq; 
		50::ms => now;
	}

	fun void startSemicolon(Gain g){
		Util.playSample("Bassdrum3", g);
	}

	fun void startColon(Gain g){
		Util.playSample("Bassdrum3", g, 1.3);
	}

	fun void startQuote(Gain g){
		Util.playSample("Click-02", g);
	}

	fun void startDoubleQuote(Gain g){
		Util.playSample("Click-03", g);
	}

	fun void startPeriod(Gain g){
		Util.playSample("Tom1", g);
	}

	fun void startComma(Gain g){
		Util.playSample("Snarepop", g);
	}

	fun void startLessThan(Gain g){
		Util.playSample("CONGA_LOW", g);
	}

	fun void startGreaterThan(Gain g){
		Util.playSample("CONGA_HIGH", g);
	}

	fun void startForwardSlash(Gain g){
		Util.playSample("Switch 04", g);
	}

	fun void startQuestionMark(Gain g){
		Util.playSample("Water Drip 02", g);
	}
}