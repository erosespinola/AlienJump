package com.powerflasher.SampleApp {
	/**
	 * @author Amiel Zuñiga
	 */

	import flash.display.MovieClip;
	import org.flixel.*;

	public class Historia extends FlxState {
		[Embed(source="img/Historia.swf")]
		private static var Animacion : Class;
		private var animacion : MovieClip;
		private var t:Number;
		[Embed(source = "img/esc.png")] public static var esc:Class;
		private var teclaESC:FlxSprite = new FlxSprite(540,700);
		
		override public function create() : void {
			t=0;
			FlxG.mouse.show();
			animacion = new Animacion();
			FlxG.stage.addChildAt(animacion, 1);
			teclaESC.loadGraphic(esc, true, true, 56, 53, true);
			add(teclaESC);
		}
        
		override public function update() : void {
			super.update();
			t+=FlxG.elapsed;
			if(t>=9){
				FlxG.stage.removeChild(animacion);
				FlxG.switchState(new HistoriaFin());
			}
			if(FlxG.keys.pressed("ESCAPE")){
				 FlxG.stage.removeChild(animacion);
                 FlxG.switchState(new HistoriaFin());
            }
		}
	}
}