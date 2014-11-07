// General configuration (keys, audio files) tasks.
public class Config {
    // Reads keys from a file and maps key codes to Action objects.

    FileIO file;
    file.open("keys.txt", FileIO.READ);

    // establish all keycodes
    read("esc") => int esc;
    read("one") => int one;
    read("two") => int two;
    read("three") => int three;
    read("four") => int four;
    read("five") => int five;
    read("six") => int six;
    read("seven") => int seven;
    read("eight") => int eight;
    read("nine") => int nine;
    read("zero") => int zero;
    
    [one, two, three, four, five, six, seven, eight, nine, zero] @=> int digitCodes[];
    
    read("minus") => int minus;
    read("equals") => int equals;
    read("backspace") => int backspace;
    read("tab") => int tab;
    read("q") => int q;
    read("w") => int w;
    read("e") => int e;
    read("r") => int r;
    read("t") => int t;
    read("y") => int y;
    read("u") => int u;
    read("i") => int i;
    read("o") => int o;
    read("p") => int p;
    read("openSqrBrack") => int openSqrBrack;
    read("closeSqrBrack") => int closeSqrBrack;
    read("enter") => int enter;
    read("lCtrl") => int lCtrl;
    read("a") => int a;
    read("s") => int s;
    read("d") => int d;
    read("f") => int f;
    read("g") => int g;
    read("h") => int h;
    read("j") => int j;
    read("k") => int k;
    read("l") => int l;
    read("semicolon") => int semicolon;
    read("quote") => int quote;
    read("altQuote") => int altQuote;
    read("lShift") => int lShift;
    read("backSlash") => int backSlash;
    read("z") => int z;
    read("x") => int x;
    read("c") => int c;
    read("v") => int v;
    read("b") => int b;
    read("n") => int n;
    read("m") => int m;
    read("comma") => int comma;
    read("dot") => int dot;
    read("forwardSlash") => int forwardSlash;

    [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z] @=> int alphabetCodes[];
    
    read("rShift") => int rShift;
    read("lAlt") => int lAlt;
    read("space") => int space;
    read("caps") => int caps;
    read("f1") => int f1;
    read("f2") => int f2;
    read("f3") => int f3;
    read("f4") => int f4;
    read("f5") => int f5;
    read("f6") => int f6;
    read("f7") => int f7;
    read("f8") => int f8;
    read("f9") => int f9;
    read("f10") => int f10;
    read("rCtrl") => int rCtrl;
    read("rAlt") => int rAlt;
    read("home") => int home;
    read("upArrow") => int upArrow;
    read("pageUp") => int pageUp;
    read("leftArrow") => int leftArrow;
    read("rightArrow") => int rightArrow;
    read("end") => int end;
    read("downArrow") => int downArrow;
    read("pageDown") => int pageDown;
    read("delete") => int delete;

    // reads a value from file
    fun int read(string expected){
        file => string label;
        if (!String.equals(expected, label)){
            <<< "File error: expected: '", expected, "' found: '", label, "'" >>>;
        }
        file => int keyValue;
        return keyValue;
    }

    // Initialise key map
    Action keyMap[300];

    // Inserting every key into the keymap
    
    // alphabet
    ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", 
    "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", 
    "v", "w", "x", "y", "z"] @=> string alphabetChars[];
    
    for (0 => int i; i < alphabetCodes.cap(); i++){
        LetterAction action;
        action.setLabel(alphabetChars[i]);
        action @=> keyMap[alphabetCodes[i]];   
    }
    // digits
    for (0 => int i; i < digitCodes.cap(); i++){
        DigitAction action;
        action.setLabel(Std.itoa((i+1)%10)); // numbering starts at 1, ends at 0
        action @=> keyMap[digitCodes[i]];
    }

    // symbols
    addSymbol("`", altQuote);
    addSymbol("-", minus);
    addSymbol("=", equals);
    addSymbol("[", openSqrBrack);
    addSymbol("]", closeSqrBrack);
    addSymbol("\\", backSlash);
    addSymbol(";", semicolon);
    addSymbol("'", quote);
    addSymbol(",", comma);
    addSymbol(".", dot);
    addSymbol("/", forwardSlash);

    // whitespace keys
    addWhiteSpaceKey(WhitespaceAction.SPACE(), space);
    addWhiteSpaceKey(WhitespaceAction.TAB(), tab);
    addWhiteSpaceKey(WhitespaceAction.NEW_LINE(), enter);

    // modifier keys
    addModifierKey(ModifierAction.SHIFT(), lShift);
    addModifierKey(ModifierAction.SHIFT(), rShift);
    addModifierKey(ModifierAction.CONTROL(), lCtrl);
    addModifierKey(ModifierAction.CONTROL(), rCtrl);
    addModifierKey(ModifierAction.ALT(), lAlt);
    addModifierKey(ModifierAction.ALT(), rAlt);

    // navigation keys
    addNavigationKey("left", leftArrow);
    addNavigationKey("right", rightArrow);
    addNavigationKey("up", upArrow);
    addNavigationKey("down", downArrow);
    addNavigationKey("home", home);
    addNavigationKey("end", end);
    addNavigationKey("page_up", pageUp);
    addNavigationKey("page_down", pageDown);

    // deletion keys
    addDeletionKey("back_space", backspace);
    addDeletionKey("delete", delete);

    // function keys
    addFunctionKey(FunctionAction.HELP(), f1);
    addFunctionKey(FunctionAction.RENAME(), f2);
    addFunctionKey(FunctionAction.F3(), f3);
    addFunctionKey(FunctionAction.F4(), f4);
    addFunctionKey(FunctionAction.REFRESH(), f5);
    addFunctionKey(FunctionAction.CAPS_LOCK(), caps);
    addFunctionKey(FunctionAction.ESCAPE(), esc);

    fun void addSymbol(string symbol, int code){
        SymbolAction symbolAct;
        symbolAct.setLabel(symbol);
        symbolAct @=> keyMap[code];
    }

    fun void addWhiteSpaceKey(string name, int code){
        WhitespaceAction wsa;
        name => wsa.setLabel;
        wsa @=> keyMap[code];
    }

    fun void addModifierKey(string name, int code){
        ModifierAction ma;
        name => ma.setLabel;
        ma @=> keyMap[code];
    }

    fun void addNavigationKey(string name, int code){
        Navigation nav;
        name => nav.setLabel;
        nav @=> keyMap[code];
    }

    fun void addDeletionKey(string name, int code){
        Deletion del;
        name => del.setLabel;
        del @=> keyMap[code];
    }

    fun void addFunctionKey(string name, int code){
        FunctionAction fa;
        name => fa.setLabel;
        fa @=> keyMap[code];
    }

    // ========= PUBLIC ============

    public Action[] getActionMap(){
        return keyMap;
    }

    // gets the keyCode (if there is one) for this action
    public int keyCode(Action action){
        for (0 => int i; i < keyMap.cap(); i++){
            if (keyMap[i].equals(action)){
                return i;
            }
        }
        return NOT_KEY();
    }

    // returns a number which represents an invalid key
    public static int NOT_KEY(){
        return Math.INT_MAX;
    }

}
