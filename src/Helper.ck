
// initialise keys
Config config;

config.getActionMap() @=> Action @ actionMap[];
// stores all actions which are currently in progress
ActionList startedActions;
// maps keys to actions
MultiKeyActionMap multiKeyActions;

// master gain with safety limiter to prevent clipping.
Gain g => Dyno safety => dac;

// open keyboard device
Hid hid;
HidMsg msg;
0 => int device;

if (hid.openKeyboard(device) == false){
    <<< "no keyboard found" >>>;
    me.exit();
}
// keyboard event based loop. Only advances when a keyboard action is detected.
while (true){ 
    // advance time until keyboard event happens.
    hid => now;
    
    while (hid.recv(msg)){
        
        msg.which => int keyCode;
                        
        if (msg.isButtonDown()){
            spork ~ dealWithKeyPress(keyCode);
        }
        else if (msg.isButtonUp()){
            dealWithKeyRelease(keyCode);
        }
        
    }
}

// deals with a keyboard key press.
fun void dealWithKeyPress(int keyCode){
    
    actionMap[keyCode] @=> Action action;

    if (action == NULL){ 
        <<< "Key not recognised" >>>; 
        return;
    }
    else { 
        <<< "p", action.getLabel() >>>;
    }
    
    if (startedActions.isEmpty()){
        // single key is pressed
        startAction(action);
    } 
    else { // multiple keys are pressed
        // if muliple keys make up a multi-key action
        if (keysInMultiKeyAction(startedActions, action)){
            startedActions.add(action);
            getMultiKeyAction(startedActions) @=> Action multiKeyAction;

            stopNonModifierActions();
            <<< "starting mk action: ", multiKeyAction.getLabel() >>>;
            startAction(multiKeyAction);
        }
        else { // if invalid multi-key action, replace started actions with this one.
            stopNonModifierActions();
            startAction(action); 
        }
    }
    
}

// deals with a key being released
fun void dealWithKeyRelease(int keyCode){
    actionMap[keyCode] @=> Action released;    
    if (released != null){
        <<< "r", released.getLabel() >>>;
        stopAction(released);
    }
    // check if this action's key is part of any multi-key actions
    for (0 => int i; i < startedActions.size(); i++){
        startedActions.get(i) @=> Action a;
        if (multiKeyActions.isMultiKeyAction(a)){
            if (multiKeyActions.isInMultiKeyAction(released, a)){
                stopAction(a);
            }
        }
    }
}

// starts an action
fun void startAction(Action action){
    startedActions.add(action);
    action.start(g);
}

// stops an action
fun void stopAction(Action action){
    startedActions.remove(action);
    action.stop();   
}

// stops all currently running actions
fun void stopNonModifierActions(){
    0 => int done;
    while (!done){
        for (0 => int i; i < startedActions.size(); i++){
            startedActions.get(i) @=> Action a;
            if (!String.equals(a.getType(), ModifierAction.TYPE())){
                stopAction(a);
                break;
            }
        }
        1 => done;
    }
}

// return 1 if the actions combine to make a multi-key action
fun int keysInMultiKeyAction(ActionList actions, Action action){
    int keys[startedActions.size()];
    for (0 => int i; i < keys.cap(); i++){
        config.keyCode(actions.get(i)) => keys[i];
    }
    keys << config.keyCode(action);
    return multiKeyActions.isMultiKeyAction(keys);
}

// returns a action which maps to a set of keys given by actions
fun Action getMultiKeyAction(ActionList actions){
    int keys[startedActions.size()];
    for (0 => int i; i < keys.cap(); i++){
        config.keyCode(actions.get(i)) => keys[i];
    }
    return multiKeyActions.getMultiKeyAction(keys);
}


// Not needed for now.
fun int isInsertion(Action action){
    return String.equals(action.getType(), Insertion.TYPE());
}
fun int isDeletion(Action action){
    return String.equals(action.getType(), Deletion.TYPE());
}