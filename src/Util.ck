public class Util {
	public static void playSample(string name, Gain g){
		<<< "playing", name >>>;
		SndBuf sndbuf => g;
		me.dir() + "/../audio/" + name + ".wav" => sndbuf.read;
		sndbuf.length() => now;
	}

	public static void playSample(string name, Gain g, float rate){
		<<< "playing", name >>>;
		SndBuf sndbuf => g;
		me.dir() + "/../audio/" + name + ".wav" => sndbuf.read;
		rate => sndbuf.rate;
		sndbuf.length() => now;
	}

	public static void playSampleAtGain(string name, Gain g, float gain){
		<<< "playing", name >>>;
		SndBuf sndbuf => g;
		gain => sndbuf.gain;
		me.dir() + "/../audio/" + name + ".wav" => sndbuf.read;
		sndbuf.length() => now;
	}

	public static void playSampleAtGain(string name, Gain g, float gain, float rate){
		<<< "playing", name >>>;
		SndBuf sndbuf => g;
		gain => sndbuf.gain;
		me.dir() + "/../audio/" + name + ".wav" => sndbuf.read;
		rate => sndbuf.rate;
		sndbuf.length() => now;
	}
}