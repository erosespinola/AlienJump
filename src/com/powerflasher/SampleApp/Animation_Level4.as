package com.powerflasher.SampleApp {
	/**
	 * @author Amiel Zuñiga
	 */

	import flash.display.MovieClip;
	import org.flixel.*;

	public class Animation_Level4 extends FlxState {
		[Embed(source="img/Nivel4_2.swf")]
		private static var Animacion : Class;
		private var animacion : MovieClip;
		[Embed(source="musica/win.mp3")] public var Music:Class;

		override public function create() : void {
			animacion = new Animacion();
			FlxG.play(Music, 0.05, false);
			FlxG.stage.addChildAt(animacion, 1);
			FlxG.mouse.show();
		}
        
		override public function update() : void {
			super.update();
			
			if(FlxG.mouse.pressed()){
				FlxG.stage.removeChild(animacion);
				FlxG.switchState(new Nivel5_1());
			}
			if(FlxG.keys.pressed("ESCAPE")){
				 FlxG.stage.removeChild(animacion);
                 FlxG.switchState(new Nivel5_1());
            }
		}
	}
}