// maps multiple keys to an action
public class MultiKeyActionMap {

	Config conf;

	80 => int actionsCap;
	0 => int count; // how many actions are actually in the map
	3 => int maxKeys;

	int keys[actionsCap][maxKeys]; // key in this multi-key action
	Action a[actionsCap]; // actions 

	// initialise keyCode values
	for (0 => int i; i < actionsCap; i++){
		for (0 => int j; j < maxKeys; j++){
			Config.NOT_KEY() => keys[i][j];
		}
		NULL @=> a[i];
	}

	// --- add all multi-key functions to the map ---

	// ====== SHIFT MULTI-KEY ACTIONS (in order of left-right top-down on keyboard) ============

	// tilde
	addAltSymbol("`", "~");
	
    // alt symbols for digit keys
    ["!", "@", "#", "$", "%", "^", "&", "*", "(", ")"] @=> string digitKeySymbols[];
    for (0 => int i; i < 10; i++){
    	DigitAction da;
    	da.setLabel(Std.itoa((i+1)%10));
    	SymbolAction sa;
    	sa.setLabel(digitKeySymbols[i]);
    	addShiftAction(keyCode(da), sa);
    }

    // underscore and plus
    addAltSymbol("-", "_");
	addAltSymbol("=", "+");

    /// capital letters
	// alphabet
    ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", 
    "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", 
    "v", "w", "x", "y", "z"] @=> string alphabetChars[];


    for (0 => int i; i < alphabetChars.cap(); i++){
    	alphabetChars[i] @=> string letter;
    	LetterAction la;
    	la.setLabel(letter);
    	BigLetterAction bla;
    	bla.setLabel(letter.upper());
    	addShiftAction(keyCode(la), bla);
    }


    // other symbols next to letter keys
    addAltSymbol("[", "{");
    addAltSymbol("\\", "|");
    addAltSymbol("]", "}");
    addAltSymbol(";", ":");
    addAltSymbol("'", "\"");
    addAltSymbol(",", "<");
    addAltSymbol(".", ">");
    addAltSymbol("/", "?");

    // ========= FUNCTION MULTI-KEY ACTIONS (CTRL on windows keyboards) ==============
    addLetterFunction("w", "close_tab");
    addLetterFunction("r", "reload");
    addLetterFunction("t", "new_tab");
    addLetterFunction("y", "redo");
    addLetterFunction("p", "print");
    addLetterFunction("a", "select_all"); 
    addLetterFunction("s", "save");
    addLetterFunction("o", "open");
    addLetterFunction("d", "bookmark");
    addLetterFunction("f", "find");
    addLetterFunction("h", "find_replace");
    addLetterFunction("z", "undo");
    addLetterFunction("c", "copy");
    addLetterFunction("x", "cut");
    addLetterFunction("v", "paste");
    addLetterFunction("b", "build");

    WhitespaceAction tab;
    tab.setLabel(WhitespaceAction.TAB());
    FunctionAction nextTab;
    nextTab.setLabel(FunctionAction.NEXT_TAB());
    addControlAction(keyCode(tab), nextTab);

    FunctionAction prevTab;
    prevTab.setLabel(FunctionAction.PREV_TAB());
    addControlShiftAction(keyCode(tab), prevTab);

    // ======== HIGHLIGHTING ==================
    addNavigationHighlight("left", Highlight.CHAR(), 0);
    addNavigationHighlight("right", -Highlight.CHAR(), 0);
    addNavigationHighlight("up", Highlight.LINE(), 0);
    addNavigationHighlight("down", -Highlight.LINE(), 0);

    addNavigationHighlight("right", Highlight.WORD(), 1);
    addNavigationHighlight("left", -Highlight.WORD(), 1);

    // ======== ALT FUNCTIONS ===================


    // switch to previous window 
	FunctionAction switchPrevWindow;
    switchPrevWindow.setLabel(FunctionAction.SWITCH_PREV_WINDOW());
    addAltShiftAction(keyCode(tab), switchPrevWindow);

    // switch to next window 
    FunctionAction switchNextWindow;
    switchNextWindow.setLabel(FunctionAction.SWITCH_NEXT_WINDOW());
    addAltAction(keyCode(tab), switchNextWindow);

    // close window
    Action f4;
    f4.setLabel("f4");
    FunctionAction closeWindow;
    closeWindow.setLabel("close_window");
    addAltAction(keyCode(f4), closeWindow);

    // ctrl alt delete
    FunctionAction cad;
    cad.setLabel(FunctionAction.CTRL_ALT_DELETE());
    Deletion del;
    del.setLabel("delete");
    addControlAltAction(keyCode(del), cad);

    // print all keys in map
    //for (0 => int i; i < count; i++){
    //  	<<< keys[i][0] >>>;
    // 	<<< keys[i][1] >>>;
    // 	<<< keys[i][2] >>>;
    //	<<< a[i].getLabel() >>>;
    //}

    /*for (0 => int i; i < count; i++){
    	0 => int properKeys;
    	int current[maxKeys];
    	for (0 => int j; j < maxKeys; j++){
    		if (keys[i][j] != Config.NOT_KEY()){
    			properKeys++;    			
    		}
    		keys[i][j] => current[j];
    	}
    	if (properKeys < 2){
    		<<< a[i].getLabel(), current[0], current[1], current[2] >>>;
    	}
    }*/

	// for alterative symbol actions /(with shift key) like capatilised letters and misc symbols.  
	fun void addShiftAction(int k1, Action a){
		ModifierAction shift;
		shift.setLabel(ModifierAction.SHIFT());
		addActionToMap([keyCode(shift), k1], a);
	}

	fun void addShiftAction(int k1, int k2, Action a){
		ModifierAction shift;
		shift.setLabel(ModifierAction.SHIFT());
		addActionToMap([keyCode(shift), k1, k2], a);
	}

	// adds a alt symbol action to the map
	fun void addAltSymbol(string symbol, string altSymbol){
		SymbolAction original;
		original.setLabel(symbol);
		SymbolAction alt;
		alt.setLabel(altSymbol);
		addShiftAction(keyCode(original), alt);
	}

	// adds a highlight action to the map
	// fkeyPressed = 0 if function key is pressed. 
	// nav is the type of navigation performed in the selection
	fun void addNavigationHighlight(string dir, int highlighted, int fkeyPressed){
		int thirdKey;
		if (fkeyPressed){
			ModifierAction ctrl;
			ctrl.setLabel(ModifierAction.CONTROL());
			keyCode(ctrl) => thirdKey;
		} else { Config.NOT_KEY() => thirdKey; }
		
		Navigation direction;
	    direction.setLabel(dir);
	    Highlight hl;
	    highlighted => hl.setHighlighted;

	    addShiftAction(keyCode(direction), thirdKey, hl);
	}

	// for functions like copy, paste, undo (using CTRL on windows)
	fun void addControlAction(int k1, Action a){
		ModifierAction ctrl;
		ctrl.setLabel(ModifierAction.CONTROL());
		addActionToMap([keyCode(ctrl), k1] , a);
	}

	// adds a function which has a letter key
	fun void addLetterFunction(string letter, string functionName){
		LetterAction la;
		la.setLabel(letter);
		FunctionAction fa;
		fa.setLabel(functionName);
		addControlAction(keyCode(la), fa);
	}

	// adds an action which uses control and shift
	fun void addControlShiftAction(int k, Action a){
		ModifierAction ctrl;
		ctrl.setLabel(ModifierAction.CONTROL());
		ModifierAction shift;
		shift.setLabel(ModifierAction.SHIFT());

		addActionToMap([keyCode(ctrl), keyCode(shift), k], a);
	}

	// alterative functions (using ALT key on windows) , like switch windows (alt-tab), close window.
	fun void addAltAction(int k1, Action a){
		ModifierAction alt;
		alt.setLabel(ModifierAction.ALT());
		addActionToMap([keyCode(alt), k1], a);
	}

	fun void addAltShiftAction(int k, Action a){
		ModifierAction alt;
		alt.setLabel(ModifierAction.ALT());
		ModifierAction shift;
		shift.setLabel(ModifierAction.SHIFT());

		addActionToMap([keyCode(alt), keyCode(shift), k], a);
	}

	fun void addControlAltAction(int k, Action a){
		ModifierAction control;
		control.setLabel(ModifierAction.CONTROL());
		ModifierAction alt;
		alt.setLabel(ModifierAction.ALT());
		addActionToMap([keyCode(control), keyCode(alt), k], a);
	}

	// adds an action to the multi-key action map
	fun void addActionToMap(int newKeys[], Action action){
		// check input keys
		0 => int properKeys;
    	for (0 => int j; j < newKeys.cap(); j++){
    		if (newKeys[j] != Config.NOT_KEY()){
    			properKeys++;    			
    		}
    	}
    	if (properKeys < 2){
    		<<< action.getLabel(), newKeys[0], newKeys[1], newKeys[2] >>>;
    	}

    	// add to map
		for (0 => int i; i < newKeys.cap(); i++){
			newKeys[i] => keys[count][i];
		}
		action @=> a[count];
		count ++;
	}

	fun int keyCode(Action a){
		return conf.keyCode(a);
	}

	// ============== keys -> action retrieval methods ===========

	// get an action which maps to these keys, or null if no such action exists
	public Action getMultiKeyAction(int inputKeys[]){
		if (inputKeys.cap() < 2){
			<<< "not enough keys for a multi-key action!" >>>;
			return null;
		}
		if (inputKeys.cap() > 3){
			<<< "too many keys man, might not return correct action" >>>;
		}
		// go through all multi-key action to see if there is a match
		for (0 => int i; i < count; i++){
			maxKeys => int keyCount; // how many keys map to this multi-key action
			0 => int matches; // how many keys match
			for (0 => int j; j < maxKeys; j++){
				// reduce the number of keys which map to this multi-key action
				if (keys[i][j] == Config.NOT_KEY()){
					keyCount--;
					continue;
				}
				arrayContains(inputKeys, keys[i][j]) +=> matches;
			}

			if (matches == keyCount){
				return a[i];
			}
		}
		// no action which maps to these keys found
		return null;
	}

	// return 1 if the array contains the value
	fun int arrayContains(int array[], int value){
		for (0 => int i; i < array.cap(); i++){
			if (array[i] == value){
				return true;
			}
		}
		return false;
	}

	// returns true if keys map to multi-key action
	public int isMultiKeyAction(int inputKeys[]){
		if (getMultiKeyAction(inputKeys) == null){
			return false;
		}
		return true;
	}
	// returns true if this action is a multi-key action
	public int isMultiKeyAction(Action action){
		for (0 => int i; i < count; i++){
			if (a[i].equals(action)){
				return true;
			}
		}
		return false;
	}

	public int isInMultiKeyAction(Action singleKey, Action multiKey){
		keyCode(singleKey) => int keyCode;
		// look for multikey action
		for (0 => int i; i < count; i++){
			if (a[i].equals(multiKey)){
				// found action
				for (0 => int j; j < maxKeys; j++){
					if (keys[i][j] == keyCode){
						// if any of the keys for this action match singleKey
						return true;
					}
				}
				// singleKey wasn't any of the keys of the multi-key action
				return false;
			}
		}
	}

}