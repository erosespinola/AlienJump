package com.powerflasher.SampleApp {
	/**
	 * @author Amiel Zuñiga
	 */

	import flash.display.MovieClip;
	import org.flixel.*;

	public class Animation_Level3 extends FlxState {
		[Embed(source="img/Nivel3_2.swf")]
		private static var Animacion : Class;
		[Embed(source="musica/win.mp3")] public var Music:Class;
		private var animacion : MovieClip;

		override public function create() : void {
			animacion = new Animacion();
			FlxG.play(Music, 0.05, false);
			FlxG.mouse.show();
			FlxG.stage.addChildAt(animacion, 1);
		}
        
		override public function update() : void {
			super.update();
			
			if(FlxG.mouse.pressed()){
				FlxG.stage.removeChild(animacion);
				FlxG.switchState(new Nivel4_1());
			}
			if(FlxG.keys.pressed("ESCAPE")){
				 FlxG.stage.removeChild(animacion);
                 FlxG.switchState(new Nivel4_1());
            }
		}
	}
}