package com.powerflasher.SampleApp {
	import flash.display.MovieClip;
	/**
	 * @author Amiel Zuñiga
	 */
	import org.flixel.*;
	
	public class Animation_Level5 extends FlxState{
		
		[Embed(source="img/Jefe.swf")]private static var Animacion : Class;
		[Embed(source="musica/song 1.mp3")] public var Music:Class;
		private var animacion : MovieClip;
		private var t:Number;
		
		public function Animation_Level5(){
        	super();
        }
		
		override public function create():void{	
			t=0;
			FlxG.mouse.show();
			FlxG.play(Music, 0.8, true);
 			animacion = new Animacion();
			FlxG.stage.addChildAt(animacion, 1);
		}
		
		override public function update():void{
			super.update();
			t+=FlxG.elapsed;
			if(t>=9.1){
				FlxG.stage.removeChild(animacion);
				FlxG.switchState(new Nivel5_2());
			}
			if(FlxG.keys.pressed("ESCAPE")){
				 FlxG.stage.removeChild(animacion);
                 FlxG.switchState(new Nivel5_2());
            }
		}
		
	}
}