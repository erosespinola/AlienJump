package com.powerflasher.SampleApp {
	/**
	 * @author Amiel Zuñiga
	 */

	import flash.display.MovieClip;
	import org.flixel.*;

	public class AnimationState extends FlxState {
		[Embed(source="img/Inicio.swf")]
		private static var Animacion : Class;
		// private var noFrames:Number = 30;
		private var animacion : MovieClip;

		override public function create() : void {
			animacion = new Animacion();
			FlxG.mouse.show();
			FlxG.stage.addChildAt(animacion, 1);
		}
        
		override public function update() : void {
			super.update();
			
			if(FlxG.mouse.pressed()){
				FlxG.stage.removeChild(animacion);
				FlxG.switchState(new HistoriaInicio());
			}
			if(FlxG.keys.pressed("ESCAPE")){
				 FlxG.stage.removeChild(animacion);
                 FlxG.switchState(new HistoriaInicio());
            }
		}
	}
}