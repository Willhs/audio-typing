public class DigitAction extends Insertion {
    0.99 => gain;
    20 => static int MIN_NOTE;
    440 => float freq; // default value until digit is set
    // stopping action
    Event e;
    
    public void setLabel(string label){
        label @=> this.label;
        // goes up in perfect 4ths
        Std.mtof(MIN_NOTE + (Std.atoi(label)*5)) => freq;
    }
    
    public void start(Gain g){
        BeeThree b3 => ADSR adsr => NRev rev => g;
        0.04 => rev.mix;
        (100::ms, 100::ms, gain-0.1, 200::ms) => adsr.set;
        gain => b3.gain;
        freq => b3.freq;
        1 => b3.noteOn;
        1 => adsr.keyOn;
        
        e => now;
        1 => b3.noteOff;
        1 => adsr.keyOff;
        200::ms => now;
    }
    
    public void stop(){
        e.signal();
    }
}