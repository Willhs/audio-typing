// An action for a letter in the alphabet
public class LetterAction extends Insertion{
    0.8 => gain;
    // rate at which the sample will play
    0.15 => float variation;
    1 + Math.random2f(-variation, variation) => float rate;
    
    public void start(Gain g){    
        //Util.playSample("Switch 04", g, rate);
        Util.playSampleAtGain("Hat Closed-02", g, 0.8, rate);
    }
}