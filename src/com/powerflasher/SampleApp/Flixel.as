package com.powerflasher.SampleApp {
	import org.flixel.*;
	[SWF(width="640", height="800", backgroundColor="0x000000")]
	
	public class Flixel extends FlxGame {
		public function Flixel() {
			super(640,2560,AnimationState,1,60,30,false);
		}
	}
}