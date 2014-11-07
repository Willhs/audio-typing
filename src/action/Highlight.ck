// abstract
// causes text highlighting
public class Highlight extends Action {
	public static string TYPE(){ return "highlight"; }
	TYPE() @=> type;

	// how many chars are in each type of selection
	public static int CHAR(){ return 1; }
	public static int WORD(){ return 5; }
	public static int LINE(){ return 20; }
	public static int ALL(){ return 70; }

	// number of chars highlighted
	0 => int highlighted;

	public void setHighlighted(int highlighted){
		highlighted +=> this.highlighted;
		TYPE() + " " + Std.itoa(highlighted) @=> label;
	}

	public int getHighlighted(){
		return Std.abs(highlighted);
	}
}