// default action. Made to be overridden by actions with specific functions.
// This class defines the static properties and some default behaviour of Action subclasses.
public class Action {
    me.dir() + "/../../audio/" @=> string AUDIO_PATH;
    // the type of action - not aware of how to access supertype any other way
    GENERIC_TYPE() @=> string type;
    // name/label of the action
    "generic" @=> string label;
    // default gain of sound when the action is on
    0.99 => float gain;
    
    public void start(Gain g){
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
    
    // trigger action to stop (unless it has already stopped, or has a set stop time)
    public void stop(){}
    
    // Sub-classes can use this to more effect
    public int equals(Action o){
        // by default, not equal
        return String.equals(this.label, o.getLabel());
    }
    
    public float getGain(){
        return gain;
    }
    public void setLabel(string label){
        label @=> this.label;
    }
    public string getLabel(){
        return label;
    }    
    public string getType(){
        return type;
    }
    public static string GENERIC_TYPE(){
        return "generic";
    }
}
// 
class Function extends Action {}
class WhitespaceAction extends Action {}
class Deletion extends Action {}
class PunctuationAction extends Action {}
class Navigate extends Action {}

class ArrowKeyAction extends Navigate {}