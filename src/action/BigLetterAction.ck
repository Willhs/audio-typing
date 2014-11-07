public class BigLetterAction extends LetterAction {
	0.9 => gain;
	public void start(Gain g){
		<<< "big letter action" >>>;
		//spork ~ Util.playSample("Switch 04", g, rate);
		spork ~ Util.playSampleAtGain("Hat Closed-02", g, 0.7, rate);
		spork ~ Util.playSampleAtGain("Bassdrum4", g, 0.5);
		1::second => now;
	}
}