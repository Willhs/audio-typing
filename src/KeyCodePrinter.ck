Hid hid;
HidMsg msg;

0 => int device;

if (hid.openKeyboard(device) == false){
    me.exit();
}

BeeThree bee => NRev rev => dac; 
0.06 => rev.mix;
0.8 => bee.gain;

while (true){ 
    // advance time until event happens.
    hid => now;
    
    while ( hid.recv(msg)){
        if (msg.isButtonDown()){
            msg.ascii => int buttonPressed;
            //<<< "button down", buttonPressed>>>;
            <<< "key code", msg.which >>>;
            Std.mtof(buttonPressed) => bee.freq;    
            1 => bee.noteOn;
        }
        else if (msg.isButtonUp()){
            1 => bee.noteOff;
        }
    }
}